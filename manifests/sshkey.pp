# == Defined type ssh_authorized_keys::sshkey
#
# == Parameters
# $user OS user
# $keyprefix prefix for external data search (appended in front of group)

define ssh_authorized_keys::sshkey (
$user,
$keyprefix,
)
{
validate_string($user)
$sshkeyhash = hiera_hash("$keyprefix::$title",{})
$defaults = {
  'user' => $user,
}
create_resources("@ssh_authorized_key",$sshkeyhash,$defaults)
}
