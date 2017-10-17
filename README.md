RPMBUILD for tmux
=========================

Consul and Consul-template rpm

How to Build
=========
    git clone https://github.com/allanhung/rpm_tmux
    cd rpm_tmux
    docker run --name=tmux_build --rm -ti -v $(pwd)/rpms:/root/rpmbuild/RPMS/x86_64 -v $(pwd)/rpms:/root/rpmbuild/RPMS/noarch -v $(pwd)/scripts:/usr/local/src/build centos /bin/bash -c "/usr/local/src/build/build_tmux.sh"

# check
    docker run --name=tmux_check --rm -ti -v $(pwd)/rpms:/root/rpmbuild/RPMS centos /bin/bash -c "yum localinstall -y /root/rpmbuild/RPMS/tmux-*.rpm"


Reference
=========
[tmux-misc](https://github.com/ryanwoodsmall/tmux-misc)
[powerline source rpm](https://rpmfind.net/linux/fedora/linux/development/rawhide/Everything/source/tree/Packages/p/powerline-2.6-4.fc27.src.rpm)
