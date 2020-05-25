
| CI Status | Current Release |
| --- | --- |
| [![Build Status][Badge-AzurePipeline]][Link-AzurePipeline] | ![Release Artifacts][Badge-SonatypeReleases]|

FHIR Test Cases
===================================

# Building this Project

This project uses [Apache Maven](http://maven.apache.org) to build. To build:

```
mvn install
```

Note: there's no java code in here. The fact that maven is used is just to make it easy to book up
other maven dependencies to the test cases 

Releases are also posted to https://fhir.github.io/latest-ig-publisher/, where the release notes 
can be found

== Contents ==

This repository contains the following content:

* r5: r5 test cases (actively maintained)
* r4: r4 test cases (not maintained)
* cda: test case CDA for roundtripping/validation based on FHIR definition of CDA
* ucum: source for ucum 
* validator - test cases for the cross-version validation
* target - maven administrative stuff

== Maintenance

This project is maintained by the FHIR community to help implementations test their functionality

[Link-AzurePipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_build/latest?definitionId=12&branchName=master
[Link-SonatypeReleases]: https://oss.sonatype.org/content/repositories/releases/dev/org.hl7.fhir.testcases/fhir-test-cases/ "Sonatype Releases"
[Link-SonatypeSnapshots]: https://oss.sonatype.org/content/repositories/snapshots/dev/org.hl7.fhir.testcases/fhir-test-cases/ "Sonatype Snapshots"

[Badge-AzurePipeline]: https://dev.azure.com/fhir-pipelines/fhir-test-cases/_apis/build/status/FHIR.fhir-test-cases?branchName=master
[Badge-SonatypeReleases]: https://img.shields.io/nexus/r/https/oss.sonatype.org/org.hl7.fhir.testcases/fhir-test-cases.svg "Sonatype Releases"
[Badge-SonatypeSnapshots]: https://img.shields.io/nexus/s/https/oss.sonatype.org/org.hl7.fhir.testcases/fhir-test-cases.svg "Sonatype Snapshots"
