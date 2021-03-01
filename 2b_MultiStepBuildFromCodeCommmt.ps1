# Taken from https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tutorial-build-task

# Set up vars
$acrName = Read-Host "Acr name?"
$gitUser = Read-Host "GH username?"
$gitPat = Read-Host -Prompt "gitPat?"

# show the existing ACR
az acr show --name $acrName --query name

# Create the ACR task
<#
This task specifies that any time code is committed to the main branch in the repository specified by --context,
    ACR Tasks will run the multi-step task from the code in that branch.
    The YAML file specified by --file from the repository root defines the steps.
#>
"az acr task create --registry $acrName --name taskhelloworld2 --context https://github.com/$gitUser/acr-build-helloworld-node.git#main --file taskmulti.yaml --git-access-token $gitPat"

# az acr task delete --registry $acrName --name taskhelloworld  
# show task
az acr task list -r $acrName

# run the task
# This runs the docker build, tag and push
az acr task run -r $acrName --name taskhelloworld

# List the task runs
az acr task list-runs -r $acrName --query [].name

az acr task logs -r $acrName