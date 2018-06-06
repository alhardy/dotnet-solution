# dotnet Solution

Creates a new visual studio solution including directory structure and common files.

## How to use

### Prepare a new directory for the solution and clone the source

```console
mkdir MyNewSolution
cd MyNewSolution
git init .
git remote add origin git@github.com:alhardy/dotnet-solution.git
git pull origin master
```

### Run the setup script in a new Powershell shell

```powershell
.\run.ps1 "MyNewSolution"
```

### Use the dotnet cli to attach project templates to the solution

Create a new API under the `src` directory

```powershell
cd src
dotnet new webapi -n "MyNew.API"
```

Add the new API to the solution

```powershell
cd ..
dotnet sln add .\src\MyNew.API\MyNew.API.csproj
```