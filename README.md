# gremlin_agent

This module installs and configures the gremlin agent on a variety of
operating systems.

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with gremlin_agent](#setup)
    * [What gremlin_agent affects](#what-gremlin_agent-affects)
    * [Beginning with gremlin_agent](#beginning-with-gremlin_agent)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

In order to better streamline and standardize the Gremlin agent installation
and configuration, this module provides a supported method to manage
and maintain the gremlin agent on your systems.

## Setup

### What gremlin_agent affects

The configuration follows the steps documented on the [Gremlin docs](https://www.gremlin.com/docs/infrastructure-layer/installation/)

* It installs the dependencies required based on the host OS.
* It installs the gremlin repository, the agent, and the daemon.
* It configures the daemon via `config.yaml`, and manages the service.

### Beginning with gremlin_agent

You need to provide the `gremlin_team_id` and either `gremlin_team_secret` or the `gremlin_team_certificate_or_file` and `gremlin_team_private_key_or_file`

These can either come from Hiera or called directly as the below example:

```puppet
class { 'gremlin_agent':
  gremlin_team_id     => '11111111-1111-1111-1111-111111111111',
  gremlin_team_secret => '11111111-1111-1111-1111-111111111111'
}
```

```yaml
gremlin_agent::gremlin_team_id: '11111111-1111-1111-1111-111111111111'
gremlin_agent::gremlin_team_secret: '11111111-1111-1111-1111-111111111111'
```


## Usage

If you wish to use the certificate pair instead of the team secret, you can provide either the filepath (prefixed with `file://`) or the whole certificate.

```puppet
class { 'gremlin_agent':
  gremlin_team_id                  => '11111111-1111-1111-1111-111111111111',
  gremlin_team_certificate_or_file => 'file://var/lib/gremlin/key.cert',
  gremlin_team_private_key_or_file => 'file://var/lib/gremlin/key.pem',
}
```

Additional parameters that can be set can be viewed in the [REFERENCE.md](https://github.com/gremlin/puppet-gremlin_agent/blob/main/REFERENCE.md)

## Reference

See [REFERENCE.md](https://github.com/gremlin/puppet-gremlin_agent/blob/main/REFERENCE.md)

## Limitations

This module has had limited testing and doesn't currently support all features.  Please open an issue for any bugs discovered.

## Development

Feel free to open a PR for suggested changes or improvements.

TODO:
* Finish fleshing out Windows support.
* Add tasks to trigger gremlin checks.
* Add some additional config validation to confirm agent is successfully talking to control plane.
