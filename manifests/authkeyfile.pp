# == Defined type ssh_authorized_keys::authkeyfile
#
# == Parameters
# $roles array containing the groups to lookup after in hiera
# $home OS user homedire
define ssh_authorized_keys::authkeyfile ($roles,$home='',$keyprefix)
{
  validate_array($roles)
  validate_string($home,$keyprefix)
  $homedir = $home ? {'' => "/home/${title}", default => $home}
  @user { $title: ensure => present, purge_ssh_keys => true, home=>$homedir } 
  ssh_authorized_keys::sshkey { $roles: user => $title, keyprefix => $keyprefix }
}
