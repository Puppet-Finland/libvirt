#
# == Class: libvirt::install
#
# Install libvirt
#
class libvirt::install
(
    $virt_install_ensure

) inherits libvirt::params {

    # Install a basic set of packages
    package { $::libvirt::params::packages:
        ensure => installed,
    }

    # Install the specified version of virt-install. This is required when 
    # virt-install has to be downgraded, for example in the Cobbler module
    package { $::libvirt::params::virt_install_package_name:
        ensure => $virt_install_ensure,
    }

}
