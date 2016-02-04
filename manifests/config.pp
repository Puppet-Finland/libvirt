#
# == Class: libvirt::config
#
# Configure libvirt
#
class libvirt::config
(
    $vnc_listen,
    $allow_user

) inherits libvirt::params
{
    # This is a hack, but a necessary one. We cannot add the user to the libvirt 
    # group in the User resource, because that may get created before libvirt is 
    # installed. If we require libvirt class in the User resource, then the User 
    # resource is tied to libvirt, and can't be used on any node where libvirt 
    # is not installed. We cannot create the User resource here, because that 
    # makes no sense, and other classes might need to similarly add users to the 
    # group. So circumventing Puppet User resource(s) with Execs is the least 
    # horrible thing to do. That said, this Exec could be made into a real 
    # function (e.g. ensure_user_in_group) instead.
    #
    if $allow_user {
        $users = any2array($allow_user)
        $users.each |$user| {
            exec { "cobblerlocal-add-${user}-to-libvirt-group":
                command => "usermod -a -G libvirt ${user}",
                path    => ['/bin', '/usr/bin', '/usr/bin', '/usr/sbin'],
                unless  => "groups ${user}|grep libvirt",
                require => [ User[$user], Class['libvirt::install'], ]
            }
        }
    }

    file { 'libvirt-qemu.conf':
        ensure  => present,
        name    => '/etc/libvirt/qemu.conf',
        content => template('libvirt/qemu.conf.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        require => Class['libvirt::install'],
        notify  => Class['libvirt::service'],
    }
}
