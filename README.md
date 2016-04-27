# libvirt

A Puppet module for managing libvirt

# Module usage

Example Hiera usage in an environment where virtual machines are attached to and 
existing bridge (e.g. br0) on which an external DHCP servers listens on:

    classes:
      - libvirt
    
    libvirt::service_ensure: 'running'
    
    # Allow John and Jane to connect to libvirtd,
    # e.g. using virt-manager
    libvirt::allow_user:
      - 'john'
      - 'jane'
    
    # Disable the default network and thus
    # the integrated dnsmasq dhcp/dns service
    libvirt::networks:
      default:
        ensure: 'absent'
    
    # Allow VNC connections to a port range from
    # any address.
    libvirt::vnc_listen: '0.0.0.0'
    libvirt::allow_port: '5900-5920'

Usage details:

* [Class: libvirt](manifests/init.pp)
* [Define: libvirt::network](manifests/network.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Debian 7 and 8
* CentOS 7

Any *NIX-style operating system should work out of the box or with small
modifications.

For details see [params.pp](manifests/params.pp).
