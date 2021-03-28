# @summary
#    Configures the service for the gremlin agent.
#
# @api private
#
class gremlin_agent::service {

  service { $gremlin_agent::service:
    ensure => 'running',
    enable => 'true',
  }
}
