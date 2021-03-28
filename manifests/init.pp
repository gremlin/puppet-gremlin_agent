# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include gremlin_agent
class gremlin_agent (
  Boolean $package_manage,
  String $package_ensure,
  Boolean $daemon_package_manage,
  String $daemon_package_ensure,
  Hash $repo,
  Array $dependent_packages,
  String $service,
  String $gremlin_team_id,
  Stdlib::Absolutepath $agent_root_dir,
  Optional[String] $identifier = undef,
  Optional[Array[Hash]] $gremlin_client_tags = undef,
  Optional[String] $gremlin_team_secret = undef,
  Optional[String] $gremlin_team_certificate_or_file = undef,
  Optional[String] $gremlin_team_private_key_or_file = undef,
  Optional[String] $https_proxy = undef,
  Optional[String] $ssl_cert_file = undef,
){

  contain gremlin_agent::repo
  contain gremlin_agent::dependencies
  contain gremlin_agent::install
  contain gremlin_agent::config
  contain gremlin_agent::service

  Class['gremlin_agent::repo']
  -> Class['gremlin_agent::dependencies']
  -> Class['gremlin_agent::install']
  -> Class['gremlin_agent::config']


}
