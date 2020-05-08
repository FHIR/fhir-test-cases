---
title: FHIR Test Cases Release Notes
---

# FHIR Test Cases Release Notes

## Current (not released yet)

* Start adding test cases for Conformance resource comparisons

## v1.1.13 (2020-05-06)

* Add test case to check proper use of urn:ietf:rfc:3986 identifiers

## v1.1.12 (2020-05-02)

* update for release of new FHIR version

## v1.1.11 (2020-05-02)


* Add test cases for profile slicing by type as an example
* Add FHIRPath test cases for invalid use of and

## v1.1.10 (2020-04-29)

* add more tests around questionnaire enableWhen

## v1.1.9 (2020-04-29)


* add new test case for ICD-9-CM

## v1.1.8 (2020-04-28)

(no changes yet)

## v1.1.7 (2020-04-21)


* add test case for FHIRPath contexts for an extension in a Bundle

## v1.1.6 (2020-04-09)


* Add test case for partial version reference

## v1.1.5 (2020-04-06)


* Re-organise supporting collateral for tests
* More test cases for Measure/MeasureReport validation
* Add additional questionnaire test cases
* More tests around duplicate ids

## v1.1.4 (2020-04-02)


* Add test case for bad JSON
* Add test cases for Measure/MeasureReport validation

## v1.1.3 (2020-03-31)

* Test case for bundle reference validation
* Test cases for extension context 
* Test cases for required questionnaire items


## v1.1.2 (2020-03-28)

* Test case for R3 Extension context

## v1.1.1 (2020-03-26)


* Add test cases for XML header and syntax issues
* Add test cases for URL character correctness in HTML ```a``` and ```img``` elements

## v1.1.0 (2020-03-17)


* add test case for cross version snapshot test case - 1.4.0 extension profiling issue

## v1.0.48 (2020-03-12)


* add test for Document missing meta.lastUpdated in R2/R3

## v1.0.47 (2020-03-07)


* Add new test case for checking that a Json Primitive is actually a list when it should be

## v1.0.46 (2020-03-05)

* Add tests for FHIRPath exists([crieria])
* Add test for invariant that has a source 

## v1.0.45 (2020-03-03)

* Test for tim-9 bug in FHIRPath (Currently wrong outcome specified)
* Slicing on patternCoding
* Improve Code System property rendering

## v1.0.44 (2020-02-28)

* Update R4 and R5 FHIR Path Patch tests per https://chat.fhir.org/#narrow/stream/179166-implementers/topic/FHIRPath.20Patch.20Test.20Cases

## v1.0.43 (2020-02-19)

* Update tests for generating lang as well as xml:lang
* Add test case for search references in transactions

## v1.0.42 (2020-02-13)

* Add a test case for a differential that caused an NPE in the snapshot-generator
* Adjust test cases around lang/xml:lang (see https://www.w3.org/TR/i18n-html-tech-lang/#langvalues)
* Fix validator tests around xhtml language to cover both lang and xml:lang (see https://www.w3.org/TR/i18n-html-tech-lang/#langvalues)
* Add an additional validator test for multiple enableWhen conditions on a questionnaire item

## v1.0.41 (2020-02-08)

* rename R5 FHIRPath tests to actually say R5, and add a test for doing is on empty collections

## v1.0.40 (2020-02-07)

* R5/snapshot-generation: Add a new test case for walking into a resource contained in a bundle 
* R5/snapshot-generation: add a new test case for walking into a slice in an extension
* validator: Add a test case for search parameter type validation in CapabilityStatement
* validator: Add test cases from HAPI 

## v1.0.39  (2020-02-02)

* This release