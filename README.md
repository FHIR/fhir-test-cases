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

[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/FHIR/fhir-test-cases/badge)](https://scorecard.dev/viewer/?uri=github.com/FHIR/fhir-test-cases) [![CodeQL](https://github.com/FHIR/fhir-test-cases/actions/workflows/codeql.yml/badge.svg)](https://github.com/FHIR/fhir-test-cases/actions/workflows/codeql.yml) [![OWASP Security Scans](https://github.com/FHIR/fhir-test-cases/actions/workflows/owasp.yml/badge.svg)](https://github.com/FHIR/fhir-test-cases/actions/workflows/owasp.yml) [![Trivy Security Scans](https://github.com/FHIR/fhir-test-cases/actions/workflows/trivy.yml/badge.svg)](https://github.com/FHIR/fhir-test-cases/actions/workflows/trivy.yml)


|                        CI Status (master)                        |                    Current Release                     |      Latest SNAPSHOT       |
|:----------------------------------------------------------------:|:------------------------------------------------------:|:--------------------------:|
| [![Build Status][Badge-AzurePipeline]][Link-AzureMasterPipeline] | [![Badge-MavenCentralReleases]][Link-GithubZipRelease] | ![Badge-SonatypeSnapshots] |

## Contents

This repository contains:

* r5: r5 test cases (actively maintained)
* r4: r4 test cases (not maintained)
* cda: test case CDA for round-tripping/validation based on FHIR definition of CDA
* ucum: source for ucum 
* validator - test cases for the cross-version validation
* target - maven administrative stuff


## FHIR Foundation Project Statement

* Maintainers: Grahame Grieve
* Issues / Discussion: Various, but primarily https://chat.fhir.org/#narrow/stream/179239-tooling
* License: The contents in here are covered by Creative Commons Public Domain
* Contribution Policy: See below
* Security Information: There shouldn't be any security issues, since this is all static content, but if there are any, use the standard GitHub [security reporting framework](SECURITY.md) 

## Contribution Policy

* Contributions are welcome, but are almost always tied to contributions made to the repositories that use this material as part of their test regime. 
* All contributions must be made in public through this GitHub as a PR, or as comments on other GitHub repositories, or on a public zulip channel

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

[Link-PublishingRelease]: https://hl7.github.io/docs/ci-cd-building-release
[Link-Publishing]: https://hl7.github.io/docs/ci-cd-publishing-binaries

[Badge-AzureReleasePipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_apis/build/status/Release%20Branch%20Pipeline?branchName=master
[Badge-AzurePipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_apis/build/status/Master%20Branch%20Pipeline?branchName=master
<!-- Badges -->
[Badge-MavenCentralReleases]: https://img.shields.io/maven-metadata/v?metadataUrl=https%3A%2F%2Frepo1.maven.org%2Fmaven2%2Forg%2Fhl7%2Ffhir%2Ftestcases%2Ffhir-test-cases%2Fmaven-metadata.xml "Maven Central Releases"
[Badge-SonatypeSnapshots]:https://img.shields.io/maven-metadata/v?metadataUrl=https%3A%2F%2Fcentral.sonatype.com%2Frepository%2Fmaven-snapshots%2Forg%2Fhl7%2Ffhir%2Ftestcases%2Ffhir-test-cases%2Fmaven-metadata.xml "Sonatype Snapshots"