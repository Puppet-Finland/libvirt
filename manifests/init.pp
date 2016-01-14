#
# == Class: libvirt
#
# Install and configure libvirt
#
# == Parameters
#
# None at the moment
#
# == Examples
#
#   include ::libvirt
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
    $virt_install_ensure = present
)
{
    include ::libvirt::prequisites

    class { '::libvirt::install':
        virt_install_ensure => $virt_install_ensure,
    }
}
