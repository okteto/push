# ⚠️ CAUTION: DEPRECATED GITHUB ACTION ⚠️

## Important Notice

### 🚨 This GitHub Action is Deprecated

This GitHub Action is now **deprecated** and will no longer receive updates or maintenance. Please consider the following points before continuing to use this action:

1. **No Future Updates:** There will be no further updates, improvements, or bug fixes.
2. **Potential Security Risks:** Without updates, this action may become vulnerable to security risks.
3. **Compatibility Issues:** Future changes to GitHub Actions or dependencies may cause this action to break or function improperly.
4. **No Support:** We will no longer provide support for any issues or questions related to this action.

Learn more about our support for GitHub Actions [in our documentation](https://www.okteto.com/docs/reference/supported-github-actions/#available-actions).

# GitHub Actions for Okteto Cloud

## Automate your development workflows using Github Actions and Okteto Cloud
GitHub Actions gives you the flexibility to build an automated software development workflows. With GitHub Actions for Okteto Cloud you can create workflows to build, deploy and update your applications in [Okteto Cloud](https://cloud.okteto.com).

Get started today with a [free Okteto Cloud account](https://cloud.okteto.com)!

# Github Action for Pushing your Changes to Okteto Cloud

You can use this action to automatically build your container, push it to the Okteto Registry and deploy it into Okteto Cloud. This is a great way to create preview environments for your pull requests.

[This document](https://okteto.com/docs/reference/cli/index.html#push) has more information on this workflow.

## Inputs

### `namespace`

The Okteto namespace to use. If not specified it will use the namespace specified by the `namespace` action.

### `name`

The name of the deployment. If not specified it will use the one in your `okteto.yml` file.

### `deploy` 

Create the deployment if it doesn't exist. If not specified the action will fail if the deployment doesn't exist.

### `working-directory`

The working directory of the action. Defaults to the root folder of the repo.

# Example usage

This example runs the context action, activates a namespace, deploys a kubernetes application and then pushes your changes.

```yaml
# File: .github/workflows/workflow.yml
on: [push]

name: example

jobs:

  devflow:
    runs-on: ubuntu-latest
    steps:
    
    - uses: okteto/context@latest
      with:
        token: ${{ secrets.OKTETO_TOKEN }}
    
    - name: "Activate Namespace"
      uses: okteto/namespace@latest
      with:
        name: cindylopez
    
    - name: "Deploy application"
      uses: okteto/apply@latest
      with:
        namespace: cindylopez
        manifest: k8s.yaml

    - name: "Push changes"
      uses: okteto/push@latest
      with:
        namespace: cindylopez
        name: hello-world
```

## Advanced usage

 ### Custom Certification Authorities or Self-signed certificates

 You can specify a custom certificate authority or a self-signed certificate by setting the `OKTETO_CA_CERT` environment variable. When this variable is set, the action will install the certificate in the container, and then execute the action. 

 Use this option if you're using a private Certificate Authority or a self-signed certificate in your [Okteto Enterprise](http://okteto.com/enterprise) instance.  We recommend that you store the certificate as an [encrypted secret](https://docs.github.com/en/actions/reference/encrypted-secrets), and that you define the environment variable for the entire job, instead of doing it on every step.


 ```yaml
 # File: .github/workflows/workflow.yml
 on: [push]

 name: example

 jobs:
   devflow:
     runs-on: ubuntu-latest
     env:
       OKTETO_CA_CERT: ${{ secrets.OKTETO_CA_CERT }}
     steps:
     
     - uses: okteto/context@latest
       with:
         token: ${{ secrets.OKTETO_TOKEN }}
     
   - name: "Activate Namespace"
      uses: okteto/namespace@latest
      with:
        name: cindylopez
    
    - name: "Deploy application"
      uses: okteto/apply@latest
      with:
        namespace: cindylopez
        manifest: k8s.yaml

    - name: "Push changes"
      uses: okteto/push@latest
      with:
        namespace: cindylopez
        name: hello-world
 ```
