<!---
 ____________________
|                    |
|  N  O  T  I  C  E  |
|____________________|

Please maintain this README.md as a linkable document, as other documentation may link back to it. The following sections should appear consistently in all updates to this document to maintain linkability:

## Building this Project
## Releases
## CI/CD
## Maintenance

--->

# fhir-test-cases

| CI Status (master) | Release Pipeline | Current Release | Latest SNAPSHOT |
| :---: | :---: | :---: | :---: |
| [![Build Status][Badge-AzurePipeline]][Link-AzureMasterPipeline] | [![Build Status][Badge-AzureReleasePipeline]][Link-AzureReleasePipeline] | [![Release Artifacts][Badge-SonatypeReleases]][Link-GithubZipRelease] | [![Snapshot Artifact][Badge-SonatypeSnapshots]][Link-SonatypeSnapshots] |

## Contents

This repository contains:

* r5: r5 test cases (actively maintained)
* r4: r4 test cases (not maintained)
* cda: test case CDA for roundtripping/validation based on FHIR definition of CDA
* ucum: source for ucum 
* validator - test cases for the cross-version validation
* target - maven administrative stuff

## Accessing the test cases

You can access the test cases via Maven. If using Maven doesn't suit, then 
another option is to download the test cases directly from 
https://github.com/FHIR/fhir-test-cases/releases/latest/download/testcases.zip


## Building this Project

You can find detailed instructions on setting up this project in your IDE [here](https://hl7.github.io/docs/fhir-test-cases/getting-started).

This project uses [Apache Maven](http://maven.apache.org) to build. To build:

```
mvn install
```

Note: there's no java code in here. The fact that maven is used is just to make it easy to book up
other maven dependencies to the test cases 

## Download

#### Maven
```xml
<dependency>
    <groupId>org.hl7.fhir.testcases</groupId>
    <artifactId>fhir-test-cases</artifactId>
    <version>(latest version)</version>
</dependency>
```

#### Gradle
```groovy
compile group: 'org.hl7.fhir.testcases', name: 'fhir-test-cases', version: '(latest version)'
```

## Releases
Releases and release notes are published to [GitHub][Link-GitHubReleases], and can also be downloaded from [Maven Central][Link-MavenCentralReleases].

## CI/CD

This project has pipelines hosted on [Azure Pipelines][Link-AzurePipelines]. 

* **Pull Request Pipeline** is automatically run for every Pull Request to ensure that the project can be built via maven. [[Azure Pipeline]][Link-AzurePullRequestPipeline] [[source]](pull-request-pipeline.yml)
* **Master Branch Pipeline** is automatically run whenever code is merged to the master branch and builds the SNAPSHOT binaries distributed to OSSRH [[Azure Pipeline]][Link-AzureMasterPipeline][[source]](master-branch-pipeline.yml)
* **Release Branch Pipeline** is run manually whenever a release is ready to be made. It builds the [release binaries](#releases), distributes them to artifact repositories and sends release notifications. [[Azure Pipeline]][Link-AzureReleasePipeline][[source]](release-branch-pipeline.yml)

A brief overview of our publishing process is [here][Link-Publishing].

For more detailed instructions on cutting a release, please read [the wiki][Link-PublishingRelease]


## Maintenance
This project is maintained by the FHIR community to help implementations test their functionality.

[Link-MavenCentralReleases]: https://mvnrepository.com/artifact/org.hl7.fhir.testcases/fhir-test-cases
[Link-GitHubReleases]: https://github.com/FHIR/fhir-test-cases/releases

[Link-AzurePipelines]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_build
[Link-AzureMasterPipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_build/latest?definitionId=27&branchName=master
[Link-AzurePullRequestPipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_build?definitionId=26
[Link-AzureReleasePipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_build/latest?definitionId=28&branchName=master
[Link-GithubZipRelease]: https://github.com/FHIR/fhir-test-cases/releases/latest/download/testcases.zip "Sonatype Releases"
[Link-SonatypeSnapshots]: https://oss.sonatype.org/service/local/artifact/maven/redirect?r=snapshots&g=org.hl7.fhir.testcases&a=fhir-test-cases&v=LATEST "Sonatype Snapshots"

[Link-PublishingRelease]: https://hl7.github.io/docs/ci-cd-building-release
[Link-Publishing]: https://hl7.github.io/docs/ci-cd-publishing-binaries

[Badge-AzureReleasePipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_apis/build/status/Release%20Branch%20Pipeline?branchName=master
[Badge-AzurePipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_apis/build/status/Master%20Branch%20Pipeline?branchName=master
[Badge-SonatypeReleases]: https://img.shields.io/nexus/r/https/oss.sonatype.org/org.hl7.fhir.testcases/fhir-test-cases.svg "Sonatype Releases"
[Badge-SonatypeSnapshots]: https://img.shields.io/nexus/s/https/oss.sonatype.org/org.hl7.fhir.testcases/fhir-test-cases.svg "Sonatype Snapshots"
