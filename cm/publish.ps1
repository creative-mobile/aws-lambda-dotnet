#!/usr/bin/env pwsh
param (
    [switch]$deploy = $false
)

$packageName = "CM.Lambda.TestTool"
$configuration = "Release"
$outPath = "$PSScriptRoot/../Deployment/nuget-packages"
$packageNupkgFilter = "$packageName.*.nupkg"

Remove-Item "$outPath/$packageNupkgFilter" -ErrorAction Ignore

pushd "$PSScriptRoot/../Tools/LambdaTestTool/"
dotnet build -c $configuration --no-incremental aws-lambda-test-tool-netcore.sln
dotnet pack --no-build -c $configuration -o $outPath src/Amazon.Lambda.TestTool.BlazorTester/CM.Lambda.TestTool.BlazorTester-pack.csproj
popd

if($deploy) {
    $packedName = (Get-ChildItem -Path "$outPath" -Filter "$packageNupkgFilter").Name
    dotnet nuget push "$outPath/$packedName" -s CM
}