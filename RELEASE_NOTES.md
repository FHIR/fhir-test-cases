FHIRPath Tests

* update string startswith, endswith and contains focus tests to more accurately catch the bug
* include potential outputs that could be returned if the engine processed the results (and didn't throw the semantic issue)
* renumber test to make the name unique
* update tests that handle the focus of parameters incorrectly
* add tests for math/comparison handling and empty arguments
* date/time based addition corrections
* annotate output types, and add descriptions to some tests
* Additional test cases covering focus/parameters being empty, and correct multiple resolve misc test expression 
* Include the expected output type in the precision tests
* Additional tests for string functions to check the focus has been processed correctly
* Fix duplicate test number
* Annotate the expected output type for the results
* Fix invalid test data that doesn't conform to FHIR R5
* Rollover Time values past/under the 24 hour boundary

Validator Tests 

* fix error processing tx errors
* More work on signature test case
* ValueSet.filter.value test case
* Updates for using batch validation code
* xhtml test cases
* Corrected test cases to reflect corrections to opdef parameter cross-checking
* fix matchetype error message

Snapshot Tests

* Add test case for specializing logical models and adding target profiles

Rendering Tests

* fix up new line handling for rendering communication resources
* Add photo rendering test
