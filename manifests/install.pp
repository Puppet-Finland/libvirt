#
# == Class: libvirt::install
#
# Install libvirt
#
class libvirt::install {

    package { 'libvirt':
        name => 'libvirt-bin',
        ensure => installed,
    }
}
