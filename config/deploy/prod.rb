server 'sul-slack.stanford.edu', user: 'slack', roles: %{app}

Capistrano::OneTimeKey.generate_one_time_key!

set :ssh_options, {
  keys: [Capistrano::OneTimeKey.temporary_ssh_private_key_path],
  forward_agent: true,
  auth_methods: %w(publickey password)
}
