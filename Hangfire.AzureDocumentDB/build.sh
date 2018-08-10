$ErrorActionPreference = "Stop"

$tmacBaseImage = "tmacomms/evs-inbound:latest"
#$tmacRegistryPath = "registry.tmacomms.com"
$tmacAzureRegistryPath = "tmacregistry-tmacomms.azurecr.io"
$tmacFullPath = "$tmacAzureRegistryPath/$tmacBaseImage"
$curpath = Get-Location

echo "Setting up base image $tmacBaseImage"
dotnet build .
dotnet pack

echo "Restore packages $curpath"
dotnet restore src/evs.inbound/evs.inbound.csproj -f
dotnet publish src/evs.inbound/evs.inbound.csproj -c Debug -o $curpath\publish -f netcoreapp2.1 -r linux-x64
echo "Building image $tmacBaseImage"
docker build --force-rm --file Dockerfile -t $tmacBaseImage .

echo "Done to start the image run docker run -it --rm $tmacBaseImage"