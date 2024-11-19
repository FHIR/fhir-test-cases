# What's in here

This folder contains a set of Version independent test cases for R3 - R5 that test:

* simple expansion and validation against value set + code system
* testing out versions
* expansion and validation with inactive codes 
* expansion with various expansion parameters 
* expansion and validation with various extensions and special case properties as defined in R5 (pre-adopt in earlier versions)
* multi-language support (including errors)

The tests are detailed in test-cases.json, which defines a set of suites, where each suite has a 
set of code systems and value sets that the interactions depend on. In addition, each suite 
contains a set of tests, where each test:
* has a name and optionally a description
* the operation type (expand or validate-code)
* a parameters resource that has the inputs to the resource 
* a valueset, a parameters, or an operation outcome resource that has the output from the operation 

# Running the tests

The simplest way to execute these is to use the java validator:

java -jar {validator} -txtests -source {root folder for this repo} -tx {server to test}

Other command line parameters for ```-txtests```:

* ```-output {folder}```: A folder in witch to place the output of failing tests. Note that the output is in R5 format irrespective of the version of the server running, and mimics the folder structure of the input, so that you can diff the input and output to see the differences
* ```-version {v}```: The version of the server. R3, R4, and R5 are supported. 
* ```-externals {file}``` : The file in which external strings are found. Different servers have slightly different error messages. In the absence of external strings, only the pattern is tested
* ```-filter {string}```: If this is provided, only test names that include this string will be executed (to make testing faster)
* ```-modes {string(,string)}```:  If this is provided, the tests with the specified mode (in the suite in test-case.json) will be executed
* ```-api-key {string}```: An API Key that is passed to the server in the ```Authorization``` header

If the tests pass, the final output is a statement of compliance in the correct form to be used in the tested products release notes.

##  Modes

Modes can be specified in the tests at one of the following levels:
* suite - the entire suite will only be run if the the mode is turned on by the modes parameter
* test - the test will only be run if the the mode is turned on by the modes parameter
* header - defines a custom header to be passed with the test if the mode is turned on by the modes parameter

The following modes are defined:
* ```flat```: this is used to indicate that the server does not - and can not - return a heirachical expansion. tx.fhir.org does in some circumstances, and editors like this, but terminology servers are not required to do so, and if they don't, this mode must be specified in the tests
* ```ontoserver```: This is used to cause the test engine to pass a special header to Ontoserver to inform the ontoserver that it is being tested. Ontoserver behaves slightly differently to it's normal behavior in this case - this was to make the test easier to write/run 
* ```tx.fhir.org```: this is used for tests that are intended to be and written specifically for tx.fhir.org - internal QA. There is no need for other servers to pass these tests

# FHIR Version

Note that the test cases are in R5 format, and these are authoritative, though the tests can be executed 
against either an r3, r4, or r5 server. But since many users are interested in the tests in R4 format, 
a copy of the test cases are also maintained in /R4 in R4 format  for perusal of the tests in R4

## Tech details

To use these tests, load the dependencies, execute the operations with the provided 
parameters, and conpare the outcomes. Some notes about comparisons:

* for the purposes of comparison *for these tests*, array order never matters (nor does property order, of course)
* Some fields are never the same between iterations. These fields contain $<{type}$ or similar and get compared to the regex for the type instead 
* There is additional $control$ words to allow for additional sophistication in the tests


