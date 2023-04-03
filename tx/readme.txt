What's in here

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

To use these tests, load the dependencies, execute the operations with the provided 
parameters, and conpare the outcomes. Some notes about comparisons:

* for the purposes of comparison *for these tests*, array order never matters (nor does property order, of course)
* Some fields are never the same between iterations. These fields contina $<{type}$ and get compared to the regex for the type instead 
* We may consider adding additional json metadata/use of $$ to deal with reasonable variations between different tx servers
