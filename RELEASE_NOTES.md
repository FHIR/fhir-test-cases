* Add FHIRPath test cases for join() on an empty collection, collection functions on split(), hasValue()/getValue() on complex types, and =/!= on mismatched types
* Add Snapshot test cases
  * for migrating datatype profile root constraints (including bindings) into the referencing element
  * for the revised slicer/slice handling and for type slicing with type-specific constraints
  * for obligation bindings, mapping identity collisions, a slice group that ends the snapshot, additional-base merges, and slices on an empty base
* Add validator test cases:
  * for an unversioned CodeSystem reference when hl7.fhir.uv.xver-r5.r4 brings an R5 version of a core CodeSystem into an R4 context (context copy in the Java validator)
  * for StructureDefinition checks: root ElementDefinition, slicing cardinality/range consistency, and type slicing
  * for constraint.source naming an imposed profile
  * for Questionnaire variables (SDC, including launch context) and answer constraints
  * for usage context on additional bindings
  * for whitespace in base64Binary
  * for SPDX extension codes
* Update validator expected outcomes for improved CodeableConcept validation, code/system missing handling, internal version handling, improved constraint error messages, and message string fixes
* Add narrative test cases for the new Endpoint, Group, HealthcareService, Location, Organization, OrganizationAffiliation, Practitioner, PractitionerRole, RelatedPerson and Provenance generators, and for additional resources
* Update narrative and comparison expected output for accessibility fixes, ConceptMap relationship anchors and null link handling
* Add R6 variants of the StructureMap test cases, and update StructureMap expected results for improved validation locations
* Update R6 test collateral for the new R6 release
* Refresh SQL on FHIR test cases from sql-on-fhir.js and remove the duplicate R6 copy
