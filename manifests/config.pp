# @summary
#    Configures the post installation settings for the gremlin agent.
#
# @api private
#
class gremlin_agent::config {
  # The resources below here are currently configured by the package installation.
  # These resources help gremlin auto-heal if something modifies it. 
  file_capability { '/usr/bin/gremlin':
    ensure     => present,
    capability => 'cap_kill,cap_net_admin,cap_sys_boot,cap_sys_time+ep',
  }

  file { "${gremlin_agent::agent_root_dir}config.yaml":
    ensure  => file,
    owner   => 'gremlin',
    group   => 'gremlin',
    mode    => '0640',
    content => epp('gremlin_agent/config.yaml.epp'),
  }
}
