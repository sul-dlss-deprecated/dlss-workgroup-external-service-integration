dlss-workgroup-external-service-integration
===========================================

Synchronize DLSS workgroups with external services.


## Usage 

Retrieving the DLSS roster:

```console
$ bin/roster2csv
```

Retrieving a single column from the roster:

```console
$ bin/roster2csv -c "Rubygems email"
```

Mirror access from one rubygems.org owner to a list (given by STDIN) of additional owners:

```console
$ cat list-of-rubygems-emails | bin/add_rubygem_owners --user sul-devops-team --password $SUL_DEVOPS_PASSWORD
```

Putting it together:

```console
$ bin/roster2csv -c "Rubygems email"| bin/add_rubygem_owners --user sul-devops-team --password $SUL_DEVOPS_PASSWORD
```
