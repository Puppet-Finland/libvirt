#
# == Class: libvirt::packetfilter
#
# Manage packet filtering for libvirt
#
class libvirt::packetfilter
(
    $allow_port
)
{
    Firewall {
        chain  => 'INPUT',
        proto  => 'tcp',
        action => 'accept',
        port   => $allow_port,
    }

    firewall { '020 ipv4 accept libvirt vnc': provider => 'iptables',  }
    firewall { '020 ipv6 accept libvirt vnc': provider => 'ip6tables', }

}
