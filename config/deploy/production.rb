server 'sulstats.stanford.edu', user: 'lyberadmin', roles: %{app}

Capistrano::OneTimeKey.generate_one_time_key!
