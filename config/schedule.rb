job_type :app_command, '(cd :path && (:task)) :output'

every 1.day, :at => '4:30 am', :roles => [:app] do
  app_command %{ ./bin/roster2csv -c "Rubygems email" | ./bin/add_rubygem_owners -v}
end
