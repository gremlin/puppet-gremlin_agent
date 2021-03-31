# @summary Main class, includes all other classes.
#
# This class installs and configures the gremlin agent plus dependencies.
#
# @example
#   include gremlin_agent
#
# @param package_manage
#   Whether the gremlin agent installation is managed by this module or not, along with the version. Default value: true
#
# @param package_ensure
#   Which version of the gremlin agent to install. Default value: 'latest'
#
# @param daemon_package_manage
#   Whether the gremlin daemon installation is managed by this module or not, along with the version. Default value: true
#
# @param daemon_package_ensure
#   Which version of the gremlin daemon to install. Default value: 'latest'
#
# @param repo
#   A hash containing at minimum a `url` and `key` where the gremlin software is located.
#   On Debian systems, you may also provide `release`, `apt_repo`, and an `apt_keyserver`.
#   Default value: See Hiera files.
#
# @param dependent_packages
#   An array of packages that are required to be installed for some attacks to work. Default Value ['apt-transport-https', 'dirmngr']
#
# @param service
#   Name of the gremlin daemon service. Default value: 'gremlind'
#
# @param gremlin_team_id
#   The team id for the gremlin agent to authenticate with the control plane.
#
# @param agent_root_dir
#   Directory where the config and other agent related files are located. Default value: '/etc/gremlin/'
#
# @param package_provider
#   Which package provider will install the software. Main purpose is for Windows to support chocolatey. Default value: undef
#
# @param identifier
#   Gremlin Identifier; uniquely identifies this machine with Gremlin. Default value: undef
#
# @param gremlin_client_tags
#   Gremlin Client Tags; Tag your machine with key-value pairs that help you target this machine during attacks. Default value: undef
#
# @param gremlin_team_secret
#   Gremlin Team Secret, should not be set when using `team_certificate`+`team_private_key`. Default value: undef
#
# @param gremlin_team_certificate_or_file
#   Gremlin Team Certificate, should not be set when using `team_secret`. Supports file (with `file://` prefix) or full cert. Default value: undef
#
# @param gremlin_team_private_key_or_file
#   Gremlin Team Certificate, should not be set when using `team_secret`. Supports file (with `file://` prefix) or full cert. Default value: undef
#
# @param https_proxy
#   HTTPS Proxy, set this when routing outbound Gremlin HTTPS traffic through a proxy. Default value: undef
#
# @param ssl_cert_file
#   Set this when using a https proxy with a self-signed certificate. Supports file (with `file://` prefix) or full cert. Default value: undef
class gremlin_agent (
  Boolean $package_manage,
  String $package_ensure,
  Boolean $daemon_package_manage,
  String $daemon_package_ensure,
  Hash[Enum['url','key','release','apt_repo','apt_keyserver'], String, 2, 5] $repo,
  Array[String] $dependent_packages,
  String $service,
  String $gremlin_team_id,
  Stdlib::Absolutepath $agent_root_dir,
  Optional[String] $package_provider = undef,
  Optional[String] $identifier = undef,
  Optional[Array[Hash]] $gremlin_client_tags = undef,
  Optional[String] $gremlin_team_secret = undef,
  Optional[String] $gremlin_team_certificate_or_file = undef,
  Optional[String] $gremlin_team_private_key_or_file = undef,
  Optional[String] $https_proxy = undef,
  Optional[String] $ssl_cert_file = undef,
){


  # Check to make sure at least one of the two configuration parameters for authentication is specified.
  if $gremlin_team_secret and ($gremlin_team_certificate_or_file or $gremlin_team_private_key_or_file) {
    fail('You must specify ONLY a team secret or certificate and private key for daemon configuration.')
  } elsif !$gremlin_team_secret and !($gremlin_team_certificate_or_file and $gremlin_team_private_key_or_file) {
    fail('You must specify a gremlin team secret or certificate and private key for daemon configuration.')
  }
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
