The validator test cases

These are a set of test cases that test out a validator and ensure it is functioning correctly.
The java tests use the development terminology server (tx-dev.fhir.org, unless your fhir-settings.json says otherwise), and the expected outcomes assume what it knows.

# Introduction

Notes about the tests:
* each test provides an example that will be validated, and specifies the acceptable outcome from the validator
* different validators work slightly differently. There's no need that the different validators produce the same error messages, or even that they produce the same number of errors. Because of this, each test has a separate expected outcome for each validator. But the validators should agree about what is and isn't valid
* all tests validate the provided example against the base specification (except for logical model tests, which validate it against the logical model instead)
* in addition, a test may validate the example against a profile, compare it to a matchetype, or score it against a profile

# manifest.json

The tests are listed in manifest.json, a json object with these properties:

* ```documentation``` - documents the manifest, including every property a test can have. **This is the reference for the test properties** - it is kept up to date with the java test runner (ValidationTests in core), so it's not repeated here
* ```versions``` - the versions of the terminology (```terminology```, i.e. hl7.terminology) and extensions (```extensions```, i.e. hl7.fhir.uv.extensions) packages that the tests are validated with
* ```suites``` - the tests, grouped into suites

Each suite groups related tests, so that a validator can choose which suites it runs. A suite has:

* ```name``` - the name of the suite
* ```description``` - what the tests in the suite are about (optional)
* ```suites``` - one sub-suite for each FHIR version that the suite has tests for, so that version specific validators can just pick the sub-suites for their version(s). A sub-suite has:
  * ```version``` - the FHIR version (major.minor - 1.0, 1.4, 3.0, 4.0, 4.3, 5.0 or 6.0) that the tests are validated against
  * ```tests``` - an array of the tests in the sub-suite

Each test has a ```name``` (unique for a given FHIR version) and a ```file``` - the name of the file to validate (relative to this directory), along with whatever is needed to set up the validation and the expected outcomes (see the documentation in the manifest).

# Expected Outcomes

The expected outcome of each validation step (base, profile, matchetype, logical) is an OperationOutcome in a file in the outcomes folder. The test (or the step's sub-object) names the file for each validator:

* ```java``` - the validator maintained as part of HAPI Core (outcomes/java)
* ```firely-sdk-current``` and ```firely-sdk-wip``` - the Firely SDK, current release and work in progress (outcomes/firely-sdk-current, outcomes/firely-sdk-wip)
* ```brianpos``` - Brian Postlethwaite's .NET validator (outcomes/brianpos)

If there's no entry for a validator, the test doesn't apply to it, and whether it supports the functionality isn't known.

The java entry is mandatory, and must be ```java/<id>-<step>.json```, where id is ```<version>.<name>``` (version is R2, R2B, R3, R4, R4B, R5 or R6, and any ```/``` in the name becomes ```-```) and step is base, profile, matchetype or logical. The java tests check that the file exists, and compare the issues the validator produces to it.

When the java tests run, they write what the validator actually produced to [tmp]/validator/validation-output, in the same format, and their copy of the manifest to [tmp]/validator-produced-manifest.json.

# Tags

A test can have ```tags``` - an array of strings that allow for the selective execution of tests. These follow the [syntax rules](https://docs.junit.org/6.0.3/running-tests/tags.html#syntax-rules) for the JUnit framework. The java tests use the system properties ```includedValidationTags``` and ```excludedValidationTags``` (comma separated) to choose which tests run. Most tags just group the tests for a feature, so they can be run together. These ones matter:

* ```infoway-auth-required``` - tests that use the Infoway terminology server and require authorization to be set up
* ```fhir-validator-cli``` - tests targeting features of the HL7 FHIR CLI Validator tool
