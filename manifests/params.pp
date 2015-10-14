#
# == Class: libvirt::params
#
# Defines some variables based on the operating system
#
class libvirt::params {

    case $::osfamily {
        'Debian': {
            $package_name = 'libvirt-bin'
        }
        'RedHat': {
            $package_name = 'libvirt-daemon-kvm'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
