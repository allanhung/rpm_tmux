export RPMBUILDROOT=/root/rpmbuild

yum -y install gcc rpm-build rpmdevtools make epel-release

mkdir -p $RPMBUILDROOT/SOURCES && mkdir -p $RPMBUILDROOT/SPECS && mkdir -p $RPMBUILDROOT/SRPMS
# fix rpm marcos
sed -i -e "s#.centos##g" /etc/rpm/macros.dist

# tmux
/bin/cp -f /usr/local/src/build/tmux.spec $RPMBUILDROOT/SPECS/
spectool -g -R $RPMBUILDROOT/SPECS/tmux.spec
yum-builddep -y $RPMBUILDROOT/SPECS/tmux.spec
rpmbuild -bb $RPMBUILDROOT/SPECS/tmux.spec
yum install -y $RPMBUILDROOT/RPMS/x86_64/tmux-*.rpm

# powerline
yum install -y python-pip
yes | pip install sphinx --upgrade
/bin/cp -f /usr/local/src/build/powerline.spec $RPMBUILDROOT/SPECS/
spectool -g -R $RPMBUILDROOT/SPECS/powerline.spec
yum-builddep -y $RPMBUILDROOT/SPECS/powerline.spec
rpmbuild -bb $RPMBUILDROOT/SPECS/powerline.spec

# tmux top
TMUXTOPVER=${1:-'0.0.2'}
RPMVER="${TMUXTOPVER/-/_}"
export GOPATH=/usr/share/gocode
export PATH=$GOPATH/bin:$PATH
# go repo
rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO
curl -s https://mirror.go-repo.io/centos/go-repo.repo | tee /etc/yum.repos.d/go-repo.repo
yum -y install golang git

go get github.com/codegangsta/cli
go get github.com/TomasTomecek/tmux-top
rm -rf $GOPATH/src/github.com/TomasTomecek/tmux-top
cd $GOPATH/src/github.com/TomasTomecek
git clone --depth=10 -b $TMUXTOPVER https://github.com/TomasTomecek/tmux-top.git
cd tmux-top
make
/bin/cp -f /usr/local/src/build/tmux-top.spec $RPMBUILDROOT/SPECS/
rpmbuild -bb $RPMBUILDROOT/SPECS/tmux-top.spec --define "_version $RPMVER"
