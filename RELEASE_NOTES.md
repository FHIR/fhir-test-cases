* Add Narrative test cases for the CodeSystem language table: it shows translated displays, not translated definitions, including a language that only has a translated definition, and a table with a single extra language (R5 and R6)
* Add Conversion test case for R5 Requirements with actor keys in both the 6.0 cross-version extension and the tools extension, and an actor with no key (IG publisher #1449)
* Add validator test cases:
  * for invariants of the referenced element on an expanded content reference (cmp-1 on an empty Composition subsection, against the base resource and against a profile)
  * for a supplement with no language (CodeSystem.language), whose displays and designations with no language are taken as displays in all languages (warning), and for a designation with no use and no language
  * for an extension-codes supplement that nests codes from the base code system's reserved code space, where no hierarchy is defined (warning at any depth)
  * for a StructureMap import with no value (only a data-absent-reason extension) and a dependent call to a group input with no mode: must not crash, and reports the problem
  * for a ValueSet.expansion.parameter with no name or that is empty, and a valueset-parameter extension whose name has no value: must not crash, and reports the missing name
* Update validator expected outcomes for the new warning on supplements with no language
* Update Snapshot expected output: expanded content references keep the invariants of the referenced element (cmp-* on Composition subsections and their slices, exs-5 on ExampleScenario.process.step.process, inv-1 on Parameters.parameter.part, ele-1/ext-1 on an Extension.extension that references #Extension) (R5 and R6)
