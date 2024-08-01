This set of packages tests a subtle but important test case
around package versioning. 

The tests relate to a profile that binds Observation.code to 
a value set http://hl7.org/fhir/test/ValueSet/vs-diff-test

* In package hl7.fhir.test.versions#0.1.0, this value set binds to SCT codes
* In package hl7.fhir.test.versions#0.2.0, this value set binds to LOINC codes 

The profile exists in both versions of the value set, but doesn't specify a 
value set version. 

Then, we have a profile that inherits from the base profile (and does nothing).
But which profile it inherits from depends on which package(s) are loaded. 

Package 0.1.0: binds to SCT codes 
Package 0.2.0: binds to LOINC codes 

Test cases:

* package-versioning-simple-0.1.0-good: check that an observation with an SCT code is valid against 0.1.0 value set 
* package-versioning-simple-0.1.0-bad: check that an observation with a LOINC code is invalid against 0.1.0 value set 
* package-versioning-simple-0.2.0-good: check that an observation with a LOINC code is valid against 0.2.0 value set 
* package-versioning-simple-0.2.0-bad: check that an observation with an SCT code is invalid against 0.2.0 value set 

But wait, there's more - that was just getting going: 
* What if these references are inside packages referred to from other packages? 
* What if both packages are in scope?

To test that out, we define another pair of packages:

* In package hl7.fhir.test.versions.other#0.1.0 depends on hl7.fhir.test.versions#0.1.0
* In package hl7.fhir.test.versions.other#0.2.0 depends on hl7.fhir.test.versions#0.2.0

Now we have a whole set of combinations that we can test

* package-versioning-wrapped-0.1.0-good: check that an observation with an SCT code is valid against 0.1.0 value set, loaded via the wrapper 
* package-versioning-wrapped-0.1.0-bad: check that an observation with a LOINC code is invalid against 0.1.0 value set, loaded via the wrapper 
* package-versioning-wrapped-0.2.0-good: check that an observation with a LOINC code is valid against 0.2.0 value set, loaded via the wrapper 
* package-versioning-wrapped-0.2.0-bad: check that an observation with an SCT code is invalid against 0.2.0 value set, loaded via the wrapper 

Those are really straightforward - should pass easy. Now we step up and test a profile that depends on a value set in a different package

* package-versioning-wrapped2-0.1.0-good: check that an observation with an SCT code is valid against 0.1.0 value set, loaded via the wrapper 
* package-versioning-wrapped2-0.1.0-bad: check that an observation with a LOINC code is invalid against 0.1.0 value set, loaded via the wrapper 
* package-versioning-wrapped2-0.2.0-good: check that an observation with a LOINC code is valid against 0.2.0 value set, loaded via the wrapper 
* package-versioning-wrapped2-0.2.0-bad: check that an observation with an SCT code is invalid against 0.2.0 value set, loaded via the wrapper 

