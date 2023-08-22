## Terminology Service Tests
* Many changes driven by Ontoserver testing and reconciliation
* Add tests for circular dependency in value sets
* Add tests for proper handling of supplements when validating
* Start moving from 'version' to 'used-XXX' parameters but keep version parameter as an optional element
* Support for external strings for tx test error messages in test cases + change the way ordering works in OO issues for ease of handling
* Update old vocab tests as well
* change from invalid to code-invalid when the code is wrong
* fix missing x-system-unknown warnings
* add test cases for status warnings
* rename implySystem to inferSystem
* fix tests to allow code/system to be returned in more cases (optional)
* Allow for Ontoserver to always return flat expansions
* change how inactive codes are handled
* change return pattern for value set exceptions validating

## Validation Test Cases
* Add tests for CodeSystem count and content implied rules
* Add new tests for consistency between status and standards status
* Add test cases for checking for deprecated resources
* Add tests around code status, and report warnings from terminology server

## Comparison and Rendering
* update tests for improvements in rendering
* More work on comparison accuracy
* upgrade comparison tests to cover rendering

## FHIRPath
* add tests for combine context
