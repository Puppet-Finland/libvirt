#
# == Class: libvirt
#
# Install and configure libvirt
#
# == Parameters
#
# [*manage*]
#   Manage libvirt with Puppet. Valid values are true (default) and false.
# [*manage_config*]
#   Manage libvirt config with Puppet. Valid values are true (default) and 
#   false.
# [*virt_install_ensure*]
#   Status of the virt-install package. Valid values are 'present' (default) and 
#   'absent'.
# [*service_ensure*]
#   Status of the libvirtd service. Valid values are undef (default), 'running' 
#   and 'stopped'.
# [*service_enable*]
#   Enable libvirtd service. Valid values are true (default) and false.
# [*vnc_listen*]
#   The interface to listen for VNC connections. Defaults to '127.0.0.1'. Use
#   '0.0.0.0' to listen on all interfaces.
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
    $manage = true,
    $manage_config = true,
    $virt_install_ensure = 'present',
    $service_ensure = undef,
    $service_enable = true,
    $vnc_listen = '127.0.0.1'
)
{
    if $manage {

        validate_re("${virt_install_ensure}", '^(present|absent)$')
        $bool_params = [ $manage, $manage_config, $service_enable ]
        $bool_params.each |$param| {
            validate_bool($param)
        }
        if $service_ensure {
            validate_re("${service_ensure}", '^(running|stopped)$')
        }
        validate_string($vnc_listen)

        class { '::libvirt::install':
            virt_install_ensure => $virt_install_ensure,
        }

        if $manage_config {
            class { '::libvirt::config':
                vnc_listen => $vnc_listen,
            }
        }

        class { '::libvirt::service':
            service_ensure => $service_ensure,
            service_enable => $service_enable,
        }
    }
}
