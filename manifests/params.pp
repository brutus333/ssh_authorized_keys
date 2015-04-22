# == Class ssh_authorized_keys::params
#
# This class is meant to be called from ssh_authorized_keys
# It sets variables according to platform
#
class ssh_authorized_keys::params {
  $keyprefix = "ADGroup"
}
