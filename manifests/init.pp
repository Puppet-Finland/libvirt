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
#   include libvirt
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class libvirt {
    include libvirt::install
}
