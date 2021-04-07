## aws terraform deployment repo

## Introduction
This has been deployed and tested using Terraform v0.12.7 which is available [here](https://releases.hashicorp.com/terraform/0.12.7/)
Newer versions should work, if there are any issues please let me know or raise a PR. 


## Bootstrapping
Firstly the terraform needs to be bootstrapped, this can be done in `bootstrap/`

this requires a `main.auto.tfvars` or something to that effect with possible values as follows:

```
region       = "eu-west-1"
name         = "<project_name>"
```

to run this in please run the following:

```
terraform init

terraform plan
```

Please check the output of the plan, if all looks good then please run:

```
terraform apply
```

This should build the necessary terraform backends required (namely the dynamodb table and s3 bucket)


## Building Infrastructure
The various components need to be run in order, after the bootstrapping step above is complete the iam components should be added, next the mgmt components so that the various vpc's, subnets and security groups can be built finally the services should be built.

Please note you will need to create main.auto.tfvars (or something to this effect) with all of the various variable values you need in each sub-directory
you will also need to create a backend.tfvars which contains backed configuration information for all of the deployments after bootstrapping. 

An example backend.tfvars:

```
region = "eu-west-1"
bucket = "terraform-state-<project_name>-<aws_account>"
key = "eu-west-1/iam/terraform.tfstate"
dynamodb_table = "terraform-state-<project_name>-<aws_account>"
```


Please visit a sub-directory for example mgmt/iam and then run:

```
terraform init --backend-config=backend.tfvars
```

This will use the backend.tfvars to initialise the repo and create the state file, which will reside in the s3 bucket mentioned, with the path that matches the key value provided in backend.tfvars. This allows to maintain independant state files for the various components and to easily destroy and rebuild components without effecting anything else. 

After the initialisation is complete a main.auto.tfvars is required for the various variable values you wish to set for example for iam you will only need something similar to this:

```
region = "eu-west-1"
```

In the main.auto.tfvars, once this has been configured, terraform can be planned and applied and the infrastructure components will be built

