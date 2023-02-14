#!/usr/bin/env pwsh
$packageName = "CM.Lambda.TestTool"
$outPath = "$PSScriptRoot/../Deployment/nuget-packages"

dotnet tool update -g --add-source $outPath $packageName