# Taken from https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tutorial-quick-task

$acrName = Read-Host "Acr name?"

# show the existing ACR
az acr show --name $acrName

# Perform the quick build
# This ingests the current folder, uploads to ACR, does a docker build & tag and pushes to the ACR
# Build maintains a list of dependencies so it can know if it needs to rebuild if base image changes 
az acr build --registry $acrName --image helloacrtasks:v1 .

<#
Packing source code into tar to upload...
...
2021/03/01 18:03:34 Successfully pushed image: arwacr.azurecr.io/helloacrtasks:v1
2021/03/01 18:03:34 Step ID: build marked as successful (elapsed time in seconds: 10.607770)
2021/03/01 18:03:34 Populating digests for step ID: build...
2021/03/01 18:03:35 Successfully populated digests for step ID: build
2021/03/01 18:03:35 Step ID: push marked as successful (elapsed time in seconds: 19.948214)
2021/03/01 18:03:35 The following dependencies were found:
2021/03/01 18:03:35
- image:
    ...
  runtime-dependency:
    registry: registry.hub.docker.com
    repository: library/node
    tag: 15-alpine
    digest: sha256:9893caff951dd701298d7404b424e34eeaabe7751b9997399ed7b24daa274403
  git: {}
#>
