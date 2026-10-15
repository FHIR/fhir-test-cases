* Add FHIRPath test cases:
  * for type checking under 'is' guards (is / .is() narrowing through implies, and, or, xor, not, iif, ofType and as), in R4, R4B, R5 and R6
  * for decimal equality where only zeros after the decimal point are insignificant
  * for toString() on complex types (R6)
  * for isDistinct() and distinct() across string-like, numeric, boolean, date/time and mixed collections, including which item distinct() keeps (R5 and R6)
* Add Snapshot test cases for using a type specific name (e.g. valueQuantity) where the base restricts but doesn't type slice a choice element (IG publisher 2.3.5 regression, AU Core blood pressure): in inherited, new and added slices and at the root, with explicit, untyped, reused and tightened slice controls (R5 and R6)
* Add validator test cases:
  * for ConceptMap mapping quality checks: reverse map consistency (missing, narrower, broader, unrelated, scope mismatch) and subsumption checks on sources and targets, including versioned maps, maps from a code system to itself, and fragment code systems
  * for children of elements with abstract vs concrete types (anonymous extension of named types)
  * for THO cross-version handling on tx.fhir.org (v3-MaritalStatus fixed to versions 1.0.0, 2018-08-12 and 3.0.0), and update the terminology test version to 7.4.0
* Update validator expected outcomes for improved error messages
* Add narrative test cases for fixed and pattern value presentation in StructureDefinition views (choice and type slices, sliced, must-support, min/max, primitives, intermediate patterns, and fixed values on a profile's own children) (R5 and R6)
* Add narrative test cases for Bundle entry heading levels in nested documents, and for ConceptMaps between StructureDefinitions (R5 and R6)
* Update narrative and comparison expected output for the hierarchical table generator moving to CSS classes, the revised fixed/pattern value presentation, CodeSystem parent properties (actcode), Bundle entry headings starting at h3, and inlined patient photos
