ssh-interview
=============

## First run
Run `ssh-agent`, then create file `.tfvars` with the following content:

```
do_token = "DIGITAL_OCEAN_TOKEN"
ssh_key = "PATH_TO_YOUR_SSH"
user_name = "USER_NAME"
```

Then:
```
terraform init
```

## Running
```
terraform apply -var-file=.tfvars
```

It will spit out `IP` and `password` for created user

After you are done with the machine run:
```
terraform destroy -var-file=.tfvars
```

## TODO
Allow to pass what should be installed to decrease amount of time needed for
droplet creation.
