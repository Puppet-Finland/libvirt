#
# == Class: libvirt::params
#
# Defines some variables based on the operating system
#
class libvirt::params {

    case $::osfamily {
        'Debian': {
            $packages = [ 'libvirt0', 'libvirt-daemon', 'libvirt-daemon-system', 'libvirt-clients', 'qemu', 'qemu-kvm' ]
            $virt_install_package_name = 'virtinst'
        }
        'RedHat': {
            $packages = [ 'libvirt', 'libvirt-daemon', 'libvirt-daemon-kvm', 'libvirt-client', 'qemu', 'qemu-kvm' ]
            $virt_install_package_name = 'virt-install'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
