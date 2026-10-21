* Add FHIRPath test cases (R4, R4B, R5 and R6):
  * for calendar duration equivalence and equality (year vs UCUM a, month vs mo, year vs day) and toQuantity() of '1 month' and '1 year'
  * for equality and equivalence of quantities with no UCUM code: by unit text, with no unit, and with a unit on only one side
  * for lowBoundary() and highBoundary() on decimals where rounding carries or borrows across digits, and on values written with an exponent (9.5e2, 1.5e-3, -9.5e2, 1.5E2)
* Add Snapshot test cases for sliced datatype content references: a new extension under Composition.section.section must not recurse into its already processed parent or lose child constraints, with controls for datatype reslices and the redirection stack (Core #2738) (R5 and R6)
* Add validator test cases:
  * for resourceDefinition when an additional resource (ViewDefinition) is validated against a profile, a derived profile, or with the value absent or wrong, and for a Patient with a resourceDefinition naming a profile
  * for canonical elements targeting a resource that is a canonical resource through an implemented interface (ViewDefinition → MetadataResource → CanonicalResource), including multiple interfaces, non-canonical targets, and interface cycles
  * for CodeSystems with hierarchyMeaning = classified-with that do not set versionNeeded = true (warning)
  * for the xml-namespace (and elementdefinition-namespace) extensions, whose values are XML namespace names, not references to be resolved
* Update validator expected outcomes: extensible binding messages now say a code SHALL come from the value set unless it has no suitable code, rather than 'should'
