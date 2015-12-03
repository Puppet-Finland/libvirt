#
# == Class: libvirt::install
#
# Install libvirt
#
class libvirt::install inherits libvirt::params {

    package { $::libvirt::params::packages:
        ensure => installed,
    }
}
