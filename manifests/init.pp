#
# == Class: libvirt
#
# Install and configure libvirt
#
# == Parameters
#
# [*virt_install_ensure*]
#   Status of the virt-install package. Valid values are 'present' (default) and 
#   'absent'.
# [*service_ensure*]
#   Status of the libvirtd service. Valid values are undef (default), 'running' 
#   and 'stopped'.
# [*service_enable*]
#   Enable libvirtd service. Valid values are true (default) and false.
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class libvirt
(
    $virt_install_ensure = 'present',
    $service_ensure = undef,
    $service_enable = true
)
{
    validate_re("${virt_install_ensure}", '^(present|absent)$')
    validate_bool($service_enable)
    if $service_ensure {
        validate_re("${service_ensure}", '^(running|stopped)$')
    }

    class { '::libvirt::install':
        virt_install_ensure => $virt_install_ensure,
    }

    class { '::libvirt::service':
        service_ensure => $service_ensure,
        service_enable => $service_enable,
    }
}
