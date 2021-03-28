# @summary
#    Configures the package for the gremlin agent.
#
# @api private
#
class gremlin_agent::install {

  # Installs the base gremlin client.
  if $gremlin_agent::package_manage {

    package { 'gremlin':
      ensure => $gremlin_agent::package_ensure,
    }
  }

  # Installs the gremlin daemon for attacks from the control plane.
  if $gremlin_agent::daemon_package_manage {

    package { 'gremlind':
      ensure => $gremlin_agent::daemon_package_ensure,
    }
  }

}
