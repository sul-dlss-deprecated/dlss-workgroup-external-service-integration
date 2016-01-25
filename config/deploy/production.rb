server 'sul-slack.stanford.edu', user: 'slack', roles: %{app}

Capistrano::OneTimeKey.generate_one_time_key!
