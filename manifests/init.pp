# == Class: ssh_authorized_keys
#
# This class is distributing ssh keys based on a hash containing the OS user as key and another hash as value.
# The class expects to find the actual SSH keys in an external backend (hiera) at the following locations: ADGroup::Group as an arrays of keys hashes
# === Parameters
#
# $rolesusers Hash containing the OS users and corresponding groups
#
# Example:
#  
#    root:
#      home: "/root"
#      roles:
#        - RootGroup
#        - PowerDBA

class ssh_authorized_keys (
$rolesusers) inherits ssh_authorized_keys::params {

# validate parameters here

  validate_hash($rolesusers)
  
  $defaults = {
    keyprefix => $::ssh_authorized_keys::params::keyprefix
  }

  create_resources(ssh_authorized_keys::authkeyfile, $rolesusers, $defaults)

  User<||> -> Ssh_authorized_key<||>
}
