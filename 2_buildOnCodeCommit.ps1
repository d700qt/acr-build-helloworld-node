# Taken from https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tutorial-build-task

$acrName = Read-Host "Acr name?"
$gitUser = Read-Host "GH username?"
$gitPat = Read-Host -Message "pat?"

# show the existing ACR
az acr show --name $acrName --query name

# Create the ACR task
<#
This task specifies that any time code is committed to the main branch in the repository specified by --context,
  ACR Tasks will build the container image from the code in that branch.
  The Dockerfile specified by --file from the repository root is used to build the image.
  The --image argument specifies a parameterized value of {{.Run.ID}} for the version portion of the image's tag
     ensuring the built image correlates to a specific build, and is tagged uniquely.
#>
"az acr task create --registry $acrName --name taskhelloworld --image helloworld:{{.Run.ID}} --context https://github.com/$gitUser/acr-build-helloworld-node.git#main --file Dockerfile --git-access-token $gitPat" | Set-Clipboard

# show task
az acr task list -r $acrName

# run the task
# This runs the docker build, tag and push
az acr task run -r $acrName --name taskhelloworld

# List the task runs
az acr task list-runs -r $acrName --query [].name