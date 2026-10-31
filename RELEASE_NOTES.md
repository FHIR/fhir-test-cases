* Add FHIRPath test cases (R4, R4B, R5 and R6):
  * for the document functions section(), entry(), entryIn(), resources(), resourcesIn(), sameSubject() and hasCoding() (a custom group, not part of FHIRPath or FHIR), against a new IPS document bundle, including how they treat empty and multi-item parameters, and reference resolution aligned with how the validator resolves references in a Bundle
  * for substring() with a zero, negative, very large or empty length, and an empty start (a zero or negative length now gives '' rather than empty)
  * for skip() and take() with an empty count, skip() with a negative count or index, and division by zero
  * for unescape('json') of quotes and unicode escapes, and for a unicode escape in a delimited identifier and an invalid unicode escape
  * for equality, union and arithmetic on minute-precision dateTimes, and that a dateTime comparison doesn't change the compared value
  * for ordering quantities with different units
* Add Snapshot test cases for inherited reslicing order: reslices declared before their parent, reordered, constrained and unconstrained, at the top level, without a slicer and nested (R5 and R6)
* Add Narrative test cases:
  * for contentReferenceProfile on nested sections and items, including canonical-only values, and the differential dictionary of an element that inherits its type (R6)
  * for CodeSystem property links, the no-link hint, and suppressing CodeSystem properties when rendering (cs-properties="false") (R5 and R6)
  * for a slicer that only sets max = 0 (R5 and R6)
  * for Provenance, including a Provenance with a contained resource (R5 and R6)
  * for an R4 Consent with the R5 decision modifierExtension and a root provision without a type, and an R4 Reference with the alternate-reference extension (rX)
* Add validator test cases:
  * for contentReferenceProfile on nested Composition sections and Questionnaire items: unresolvable values, the referencing element's constraints applying alongside the referenced ones, shared invariants reported once, alternative profiles, reference cycles, and profile validation with and without a stored snapshot
  * for IPS documents (NZ and US) checked against a clinical profile whose invariants use the document FHIRPath functions
  * for FHIRPath conformsTo() naming an implementation guide (by url or package id, optionally versioned)
  * for a code bound to version-independent-all-resource-types with no terminology server (Core #2769)
  * for a logical model with no baseDefinition or derivation (Core #2770)
  * for a meta.profile repetition with no value, only a data-absent-reason extension (Core #2767)
  * for strings consisting of a single whitespace, in JSON and XML
* Update validator expected outcomes:
  * extensible binding messages say a code SHALL come from the value set (the outcomes were missed in 1.8.2)
  * LOINC 2.83 (version numbers and revised display capitalisation)
  * revised handling of THO resources (v2-0203 version mismatch messages)
  * revised whitespace hints and warnings
  * type slicer binding/maxLength notes are now information rather than warnings
  * IPS NZ example no longer reports SNOMED CT codes as not in the IPS free set
  * CDS Hooks logical models are now version 1.3.0
  * example.com fetch failures use a placeholder error, so outcomes don't depend on what example.com returns
* Update Narrative expected outputs for accessibility changes in the renderers, and for dependency changes (CodeSystem property value set link, measure-type 4.0.0 in the vocab tests)
