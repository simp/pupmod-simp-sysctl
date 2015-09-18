Summary: Sysctl Puppet Module
Name: pupmod-sysctl
Version: 4.1.0
Release: 5
License: Apache License, Version 2.0
Group: Applications/System
Source: %{name}-%{version}-%{release}.tar.gz
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires: puppet >= 3.3.0
Buildarch: noarch
Requires: pupmod-augeasproviders_sysctl >= 2.0.1
Requires: simp-bootstrap >= 4.2.0
Provides: pupmod-puppet-sysctl
Obsoletes: pupmod-puppet-sysctl
Obsoletes: pupmod-sysctl-test

Prefix: /etc/puppet/environments/simp/modules

%description
This Puppet module is an extension of one of the modules from the reductivelabs
web site that provides the ability to manage /etc/sysctl settings.

%prep
%setup -q

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/sysctl

dirs='files lib manifests templates'
for dir in $dirs; do
  test -d $dir && cp -r $dir %{buildroot}/%{prefix}/sysctl
done

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/sysctl

%files
%defattr(0640,root,puppet,0750)
%{prefix}/sysctl

%post
#!/bin/sh

if [ -d %{prefix}/sysctl/plugins ]; then
  /bin/mv %{prefix}/sysctl/plugins %{prefix}/sysctl/plugins.bak
fi

%postun
# Post uninstall stuff

%changelog
* Wed Sep 2 2015 Nick Miller <nick.miller@onyxpoint.com> - 4.1.0-5
- Moved the configuration file from /etc/sysctl.conf to /etc/sysctl.d/20-simp.conf
  to avoid conflict with packages.

* Wed Feb 18 2015 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-4
- Updated to use new simp environment
- Now use the augeasprovider sysctl native type for managing sysctl entries.

* Fri Jan 16 2015 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-3
- Changed puppet-server requirement to puppet

* Wed Aug 27 2014 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-2
- Updated sysctl::set_value to sysctl::value to match the other open
  source offerings. Added a deprecation notice to sysctl::set_value
  and passed through the call to sysctl::value.

* Thu Jun 26 2014 Trevor Vaughan <tvaughan@onyxpoint.com> - 4.1.0-1
- Removed the insync? method from the set_sysctl_value native type to
  allow Puppet to self correct in Ruby2.

* Thu Mar 13 2014 Kendall Moore <kmoore@keywcorp.com> - 4.1.0-0
- Updated version number for consistency.

* Thu Jan 09 2014 Nick Markowski <nmarkowski@keywcorp.com> - 2.1.0-0
- Updated module for puppet3/hiera compatibility, and optimized code for lint tests,
  and puppet-rspec.

* Fri Nov 30 2012 Maintenance
2.0.0-5
- Created a Cucumber test to ensure that sysctl is configured properly when installed
  on the puppet server.
- Created a Cucumber test which changes the kernel.msgmax variable using the sysctl::set_value
  definition and checks to make sure the change has taken effect after a puppet run.

* Tue May 29 2012 Maintenance
2.0.0-4
- If you set the 'value' to 'nil' when calling sysctl::set_value, then it will
  remove the targeted key from the sysctl.conf file. Note, it will *not* un-set
  the value on the running system since there is no way to know what the
  default used to be.
- Moved mit-tests to /usr/share/simp...
- Updated pp files to better meet Puppet's recommended style guide.

* Fri Mar 02 2012 Maintenance
2.0.0-3
- Improved test stubs.

* Mon Dec 26 2011 Maintenance
2.0.0-2
- Updated the spec file to not require a separate file list.

* Fri Aug 12 2011 Maintenance
2.0.0-1
- The module now properly checks the values of all runtime entries and sets
  them as appropriate.

* Tue Jan 11 2011 Maintenance
2.0.0-0
- Refactored for SIMP-2.0.0-alpha release

* Mon Nov 08 2010 Maintenance - 1.0-2
- Provides and Obsoletes lines were wrong.

* Tue Oct 26 2010 Maintenance - 1.0-1
- Converting all spec files to check for directories prior to copy.

* Wed Jun 02 2010 Maintenance
1.0-0
- Fixed a problem with multi-valued sysctl arguments and sysctl::set_value.
- Renamed RPM and module to just 'sysctl' for proper module loading.

* Thu Feb 18 2010 Maintenance
0.1-8
- Fixed a typo that was leaving off the last ' in the sysctl command.

* Thu Jan 28 2010 Maintenance
0.1-7
- This function now automatically quotes values so you no longer have to do a
  crazy quote dance.
- Capabilites were included to ensure that existing double quoted values will
  continue to function properly.

* Thu Nov 02 2009 Maintenance
0.1-6
- Simple change from require to subscribe.
