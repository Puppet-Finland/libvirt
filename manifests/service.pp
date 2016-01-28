#
# == Class: libvirt::service
#
# Manage the libvirtd service
#
class libvirt::service
(
    $service_ensure,
    $service_enable

) inherits libvirt::params
{
    service { $::libvirt::params::service_name:
        ensure  => $service_ensure,
        enable  => $service_enable,
        require => Class['libvirt::install'],
    }
}
