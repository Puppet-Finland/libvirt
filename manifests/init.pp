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
# [*manage_packetfilter*]
#   Manage libvirt packetfilter with Puppet. Valid values are true (default) and 
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
# [*allow_port*]
#   Port or port range to open for VNC access. If you're using autoport on the 
#   virtual machines, then the first VM will get assigned port 5900 for VNC, the 
#   next one will get 5901 and so on. Default value is '5900-5920'], which is 
#   probably reasonable for most setups. Other examples: '5900', 
#   ['5900','5901'].
# [*allow_user*]
#   A single username or an array of usernames that are allowed to connect to 
#   libvirtd, e.g. using virt-manager.
# [*networks*]
#   A hash of libvirt::network to realize. Currently the resources can only 
#   remove networks, not create them. The primary use-case for libvirt::network 
#   define is, for now, to remove the default network, which disables libvirt- 
#   integrated dnsmasq.
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
    $manage_packetfilter = true,
    $virt_install_ensure = 'present',
    $service_ensure = undef,
    $service_enable = true,
    $vnc_listen = '127.0.0.1',
    $allow_port = '5900-5920',
    $allow_user = undef,
    $networks = {}
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
                allow_user => $allow_user,
            }
        }

        class { '::libvirt::service':
            service_ensure => $service_ensure,
            service_enable => $service_enable,
        }

        if $manage_packetfilter {
            class { '::libvirt::packetfilter':
                allow_port => $allow_port,
            }
        }
        create_resources('libvirt::network', $networks)
    }
}
