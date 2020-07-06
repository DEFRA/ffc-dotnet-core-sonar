# .NET Core SonarClound Analysis
Docker image for analysing .NET Core applications with SonarCloud.

## Overview
The analysis works by mounting a local .NET Core working directory as a Docker volume.  

The image will build the solution attaching an instance of SonarScanner to MSBuild to allow analysis to complete.  

## Prerequisites
- SonarCloud project
- SonarCloud authentication token
- `.sln` file must exist in root workspace folder as it is a dependency of SonarScanner
- if code coverage is required, then unit test project must include [coverlet.msbuild](https://www.nuget.org/packages/coverlet.msbuild) Nuget package

## Usage
### Main branch analysis
To analyse the main branch of a repository run the following command in the working directory of the solution.

```
docker run \
-v $(pwd)/:/home/dotnet/project \
-e SONAR_PROJECT_KEY=MY_PROJECT_KEY \
-e SONAR_TOKEN=MY_TOKEN \
defradigital/ffc-dotnet-core-sonar
```

### Pull Request analysis
The image supports branch and Pull Request (PR) analysis for GitHub hosted repositories.  To analyse a PR run the following command in the working directory of the solution.

```
docker run \
-v $(pwd)/:/home/dotnet/project \
-e SONAR_PROJECT_KEY=MY_PROJECT_KEY \
-e SONAR_TOKEN=MY_TOKEN \
-e SONAR_PR_BASE=MY_MAIN_BRANCH_NAME \
-e SONAR_PR_BRANCH=MY_PR_BRANCH_NAME \
-e SONAR_PR_KEY=MY_PR_NUMBER \
-e SONAR_PR_REPOSITORY=MY_GITHUB_REPO \
defradigital/ffc-dotnet-core-sonar
```

### Code coverage
By default, the image will assume that there is an existing `coverage.opencover.xml` file in the working directory, `./test-output`.  The image will use this file to report coverage to SonarCloud.  

If it is safe for your service to run tests within the container as part of the analysis, this can be done by passing in the following additional environment variables to the `docker run` commands above.  

```
-e RUN_TESTS=true
-e FIX_COVERAGE_REPORT=false
```

**Note** in order to successfully keep the relationship between an existing coverage report and the SonarScanner analysis results, the analysis process will remap file locations within this report.  If there is no existing coverage report or you wish to run your own tests this should be disabled by setting the `FIX_COVERAGE_REPORT` value to `false`.

### About the licence
The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
