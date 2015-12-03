#
# == Class: libvirt::params
#
# Defines some variables based on the operating system
#
class libvirt::params {

    case $::osfamily {
        'Debian': {
            $packages = [ 'libvirt0', 'libvirt-daemon', 'libvirt-daemon-system', 'libvirt-clients', 'virtinst', 'qemu', 'qemu-kvm' ]
        }
        'RedHat': {
            $packages = [ 'libvirt', 'libvirt-daemon', 'libvirt-daemon-kvm', 'libvirt-client', 'virt-install', 'qemu', 'qemu-kvm' ]
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
