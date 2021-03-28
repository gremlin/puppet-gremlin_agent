# @summary
#    Configures the repository for the gremlin agent.
#
# @api private
#
class gremlin_agent::repo {


  case $facts['os']['family'] {
    'RedHat','CentOS','Fedora','Amazon': {
      yumrepo { 'gremlin-release':
          ensure        => present,
          baseurl       => $gremlin_agent::repo['url'],
          enabled       => 1,
          gpgcheck      => 1,
          repo_gpgcheck => 1,
          gpgkey        => $gremlin_agent::repo['key'],
        }
    }
    'Ubuntu','Debian': {

      apt::source { 'gremlin':
        location => $gremlin_agent::repo['url'],
        release  => $gremlin_agent::repo['release'],
        repos    => $gremlin_agent::repo['apt_repo'],
      }
      apt::key { $gremlin_agent::repo['key']:
        id     => $gremlin_agent::repo['key'],
        server => $gremlin_agent::repo['apt_keyserver'],
      }
    }
    'Windows': {
      # Chocolatey package will go here.
    }

    default: { fail("The OS ${facts['operatingsystem']} isn't supported by this module. Please check https://www.gremlin.com/docs/quick-starts/compatibility/#matrix to confirm your OS is valid.")}
  }
}
