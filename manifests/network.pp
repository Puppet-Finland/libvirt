#
# == Define: libvirt::network
#
# Manage a libvirt network
#
# Currently only disabling a network is supported.
#
# == Parameters
#
# [*ensure*]
#   The status of this network. Currently the default value, and the only 
#   acceptable value is 'absent'.
# [*title*]
#   The resource $title defines the name of the network. The name of the network 
#   definition (xml) file is constructed by appending ".xml" to the resource 
#   $title.
# [*autostart*]
#   Whether to autostart the network or no. Valid values are true and false 
#   (default).
#
define libvirt::network
(
    Enum['absent'] $ensure = 'absent',
    Boolean $autostart = false
)
{
    $network = "${title}.xml"
    $xmlfile = "${::libvirt::params::networks}/${network}"

    include ::libvirt::params

    File {
        notify  => Class['libvirt::service'],
        require => Class['libvirt::install'],
    }

    file { "libvirt-network-${title}":
        ensure => $ensure,
        name   => $xmlfile,
        owner  => $::os::params::adminuser,
        group  => $::os::params::admingroup,
        mode   => '0600',
    }

    if ( $autostart ) and ( $ensure == 'present' ) {
        $autostart_ensure = 'link'
    } else {
        $autostart_ensure = 'absent'
    }

    file { "libvirt-network-${title}-autostart":
        ensure => $autostart_ensure,
        name   => "${::libvirt::params::networks}/autostart/${network}",
        target => $xmlfile,
    }
}
