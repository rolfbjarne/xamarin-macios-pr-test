param(
	[switch]$All
)

rm -r ./downloads/extracted/*
rm -r ./.nuget
rm -r ./src

if ($All) {
	rm -r ./cli-tools
	rm -r ./downloads
	rm /symlink ./dotnet
} else {
	New-Item -Type "directory" -Path "./.nuget/packages"	
	New-Item -Type "directory" -Path "./.nuget/workloads"
	New-Item -Type "directory" -Path "./.nuget/rollback"
}