./dotnet --version

./dotnet new globaljson --force

$workloadArchive = "./downloads/not-signed-package.zip"
if (-not (Test-Path $workloadArchive -PathType Leaf)) {
	if (Test-Path "~/Downloads/not-signed-package.zip" -PathType Leaf) {
		Write-Output "Using not-signed-package.zip from ~/Downloads"
		$workloadArchive = "~/Downloads/not-signed-package.zip"
	}
 else {
		Write-Error "not-signed-package.zip not found"
		return
	}
}

$workloadRollbackArchive = "./downloads/WorkloadRollback.zip"
if (-not (Test-Path $workloadRollbackArchive -PathType Leaf)) {
	if (Test-Path "~/Downloads/WorkloadRollback.zip" -PathType Leaf) {
		Write-Output "Using WorkloadRollback.zip from ~/Downloads"
		$workloadRollbackArchive = "~/Downloads/WorkloadRollback.zip"
	} else {
		Write-Error "WorkloadRollback.zip not found"
		return
	}
}

Write-Output "Extracting workload archives"
unzip $workloadArchive -d ./downloads/extracted 
Write-Output "Extracting workload rollback file"
unzip $workloadRollbackArchive -d ./downloads/extracted 

Get-ChildItem ./downloads/extracted/not-signed-package/*.nupkg | ForEach-Object { Copy-Item $_ -Destination ./.nuget/workloads }
Copy-Item -Path ./downloads/extracted/WorkloadRollback/WorkloadRollback.json -Destination ./.nuget/rollback

# restore the workloads
./dotnet workload install ios tvos macos maccatalyst --from-rollback-file ./.nuget/rollback/WorkloadRollback.json

./dotnet workload list

./dotnet new ios -o ./src/ios
./dotnet new tvos -o ./src/tvos
./dotnet new macos -o ./src/macos 
./dotnet new maccatalyst -o ./src/maccatalyst