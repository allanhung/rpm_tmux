%if 0%{?_version:1}
%define         _verstr      %{_version}
%else
%define         _verstr      0.0.2
%endif

Name:           tmux-top
Version:        %{_verstr}
Release:        1%{?dist}
Summary:        Monitoring information for your tmux status line.
License:        GPLv2+
URL:            https://github.com/allanhung/tmux-top


%description
Monitoring information for your tmux status line.

tmux-top allows you to see your:

 * load
 * memory usage
 * network information
 * I/O

%prep
export GOPATH=/usr/share/gocode
export PATH=$GOPATH/bin:$PATH

%build

%install
cd $GOPATH/src/github.com/allanhung/tmux-top
mkdir -p %{buildroot}/%{_bindir}
cp tmux-top %{buildroot}/%{_bindir}

%clean
rm -rf %{buildroot}


%files
%attr(755, root, root) %{_bindir}/tmux-top


%changelog
* Fri Oct 18 2017 allan hung.allan@gmail.com
- version 0.0.2
