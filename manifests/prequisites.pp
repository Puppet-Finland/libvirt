#
# == Class: libvirt::prequisites
#
# Setup prequisites for libvirt
#
class libvirt::prequisites inherits libvirt::params {

    if $::osfamily == 'RedHat' {
        # Qemu comes from the EPEL repository
        include ::epel
    }
}
