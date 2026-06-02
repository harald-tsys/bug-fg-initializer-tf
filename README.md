# bug-fg-initializer-tf

Sample code for https://github.com/opentelekomcloud/terraform-provider-opentelekomcloud/issues/3403


Following environment variables must be set:

| Environment variable | description                                     |
| -------------------- | ----------------------------------------------- |
| OTC_SDK_AK           | Access key                                      |
| OTC_SDK_SK           | Secret key                                      |
| OTC_SDK_DOMAIN_NAME  | Domain name eg. OTC-EU-DE-000000000010000XXXXX" | 
| OTC_SDK_PROJECTNAME  | Project name e.g. eu_de                         |
| OTC_IAM_ENDPOINT     | https://iam.eu-de.otc.t-systems.com/v3          |


# Terraform provider version
1.36.66

# Affected Resource(s)

- opentelekomcloud_fgs_function_v2

# Terraform Configuration Files

Full code see: https://github.com/harald-tsys/bug-fg-initializer-tf in folder terraform.

# Debug Output/Panic Output

none

# Steps to Reproduce

1. Set environment variables according to README.md
2. change folder to terraform
3. `terraform init`
4. `terraform apply`
```
opentelekomcloud_fgs_function_v2.myfunction: Creating...
opentelekomcloud_fgs_function_v2.myfunction: Creation complete after 2s [id=urn:fss:eu-de:d52e41d2434941b194ce3f91b1b12f8a:function:default:myfunction:latest]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
5.  Now in functiongraph console, function is created with initializing enabled.
6. in  terraform/main.tf change
```
    initializer_handler = null
    initializer_timeout = null
```

7. `terraform apply`
```
opentelekomcloud_fgs_function_v2.myfunction: Refreshing state... [id=urn:fss:eu-de:d52e41d2434941b194ce3f91b1b12f8a:function:default:myfunction:latest]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

8. Now in functiongraph console, initialization is not disabled
     

# Expected Behavior

Function initialization is disabled.

![initializer_disabled](initializer_disabled.png)

# Actual Behavior
Function initialization is not disabled.

![initializer_enabled](initializer_enabled.png)

# Important Factoids


# References
Using FG Enpoint
```
https://functiongraph.eu-de.otc.t-systems.com/v2/${OTC_PROJECT_ID}/fgs/functions/${function_urn}/config
```

with payload

```json
{
  "func_name" : "myfunction",
  "runtime" : "Python3.10",
  "handler" : "index.handler",
  "memory_size" : 128,
  "timeout" : 30,
  "initializer_handler" : null,
  "initializer_timeout": null
}
```
disables initializing (both initializer_handler and initializer_timeout must be set to null).
