#
# == Class: libvirt::install
#
# Install libvirt
#
class libvirt::install inherits libvirt::params {

    package { 'libvirt':
        ensure => installed,
        name   => $::libvirt::params::package_name,
    }
}
