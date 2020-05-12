[![Build Status](https://dev.azure.com/markiantorno/FHIR/_apis/build/status/FHIR.fhir-test-cases?branchName=master)](https://dev.azure.com/markiantorno/FHIR/_build/latest?definitionId=12&branchName=master)

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

