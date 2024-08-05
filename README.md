This repository is used to validate [xamarin-macios](https://github.com/xamarin/xamarin-macios) pull request artifacts

# Instructions for use:
1. Clone the respoitory locally.
1. Run the `./init.ps1` script<br/>
	[optional] Use the `-Version` parameter to specifyt the version of .NET to install e.g. "8.0", defaults to "9.0"
1. Download the `not-signed-package` artifact from the PR Build to validate<br/> 
	[optional] copy it into the `downloads` folder of the repository
1. Download the `WorkloadRollback` artifact from the PR Build to validate<br/>
	[optional] copy it into the `downloads` folder of the repository
1. Run the `./restore.ps1` to install the workloads and create the test projects using the new workloads
1. Add commands the `./test.ps1` to test the changes in the workloads
1. Use `./dotnet` to run commands using the installed SDK and workloads

## NOTES:

- All scripts are meant to be run from the root of the repository.

- If the artifacts are downloaded into `~/Downloads` the `./restore.ps1` script will find and use them if they are not found in the `./downloads` folder of the repository

- No additional checking of the artifacts to the installed SDK is doneoutside of what `dotnet worklooad install` willk do.

- Use the `./clean.ps1` script to clean the repository, the `-All` script will also additionally remove the `./downloads` and `./cli-tools` folders 