These tests are a particular implementation of the requirements for a terminology 
server that can be used by the validator and IG publisher. 

The tests make a number of assumptions about how the terminology server works 
in order to test the API, but these assumptions are not actually necessary. 
In particular, the tests assume that the server accepts code systems on the 
fly. This is absolutely a requirement for a general purpose terminology server
that supports the validator/publisher, but *is not* a requirement for a server
that provides support for a specific set of code systems. 

All systems, whether they only support a their own code systems or not, 
need to conform to the following requirements:

# Metadata

* the server SHALL return a CapabilityStatement from {root}/metadata
* This SHALL be returned without authentication (note: it may include more information when returned to an authenticated client)
* It SHALL populate the CapabilityStatement.fhirVersion and CapabilityStatement.rest[mode = server].security.service properties
* It SHALL include CapabilityStatement.instantiates value of http://hl7.org/fhir/CapabilityStatement/terminology-server
* The server SHALL return a TerminologyCapabilities statement from {root}/metadata?mode=terminology
* The TerminologyCapabilities SHALL list all the code systems that the server supports in TerminologyCapabilities.codeSystem.uri, and all the versions in TerminologyCapabilities.codeSystem.version.code. Code systems SHALL be listed here whether or not they are available through code system search 

# Reading Code Systems and Value Sets

* The server SHOULD make all the code systems and value sets it supports available through the /CodeSystem and /ValueSet endpoints.
* CodeSystems MAY have content = not-present; the tools will not consider this when choosing whether to try using the code system (uses TerminologyCapabilities.codeSystem.uri)
* Note that server does not have to make them all available in this fashion
* the server SHOULD ensure that all code systems and value sets conform to the Shareable* Profiles
* The server need not support history or track or report version tags on the resources (Resource.meta.version)
* Servers SHOULD generally allow multiple resources for the same canonical URL with different Resourve.version, but this is subject to business rules on the server 

# Accessing code systems and value sets 

All code systems and value sets SHALL have a web representation that is appropriate for a human to look at. 
The content on that page MAY be static or active; it is at the discretion of the server to decide what's on the page, but it SHOULD be more than just the json/xml for the resource (and it isn't limited to information in the resource either e.g. the server MAY choose to make additional process/provenance/context information available)

The server MAY choose to make this content available at the end-point for the relevant resource. e.g. aa request for {root}/CodeSystem/123 with an ```Accept``` header of 'application/fhir+json' returns the resource, and the same URL with an ```Accept``` header of 'text/html' returns a web page suitable for human consumption. Servers are not required to do this; they MAY choose to make the content available elsewhere.

If the server chooses to make them available elsewhere, it SHALL populate the extension ```http://hl7.org/fhir/tools/StructureDefinition/web-source``` with a valueUrl where the web view can be found. This SHALL be populated when the CodeSystem and ValueSet are read, and also in any $expand of the value set (just for the root valueset).

# Common Parameters ($expand and $validate-code)

* The server SHALL support the [tx-resource](https://jira.hl7.org/browse/FHIR-33944) parameter for passing related 
  value sets, concept maps, naming systems, code system supplements and if relevant, code systems
  * Which kind of resources the server accepts in this parameter depends on which other kind of functionality that the server implements, but at a minimum, the server SHALL support passing value sets in this parameter, for passing related valuesets using ValueSet.compose.include.valueSet

* The server SHOULD support the [cache-id](https://jira.hl7.org/browse/FHIR-33946) parameter. If it does, it SHALL report so in TerminologyCapabilities.expansion.parameter.name


* The server SHALL support supplements for the purposes of designations in different languages
  * Clarification: Servers SHALL not ignore supplements; if they don't support a relevant supplement, they SHALL return an error. 
  * Whether servers actually accept supplements for the purposes of designations is a matter for negotiation with the server's relevant user base and whether there are other arrangements in place for supporting translation (e.g. SNOMED CT, LOINC)

* For the expand operation:
  * The server SHALL support the count parameter (offset is used, but will always be 0)
  * The server SHOULD return hierarchical expansions when possible (this is not a technical requirement, but comes up as important to authors)
  * The server SHALL support system-version, check-system-version, and force-system-version
  * The server SHALL echo all parameters (including assumed values) in the expansion parameters
  * The server SHALL report with all versions of code systems used (in 'version') (this may be renamed)
  * The server SHALL Support language correctly (both displayLanguage and accept-language header)
  * The server SHALL support the excludeNested, includeDesignations, activeOnly, includeDefinition and property parameters


* For the validate-code operation:
  * The server SHALL support validating code+system(+version)(+display), Coding, and CodeableConcept
  * The server SHALL support the [mode/valueSetMode](https://jira.hl7.org/browse/FHIR-41229) parameter
  * The server SHALL Support language correctly (both displayLanguage and accept-language header)
  * The server SHALL support the [implySystem](https://jira.hl7.org/browse/FHIR-41431) parameter
  * The server SHALL return an issues parameter 
  * The server SHALL return system, code and display for the code that it considered valid, along with the version if this is known
  * The server SHOULD return a x-caused-by-unknown-system parameter for each code system it did not support

The following extensions should be supported:
* http://hl7.org/fhir/StructureDefinition/codesystem-alternate - if code system has alternate codes
* http://hl7.org/fhir/StructureDefinition/codesystem-conceptOrder - if code system has order
* http://hl7.org/fhir/StructureDefinition/codesystem-label - if code system supports 'labels'
* http://hl7.org/fhir/StructureDefinition/coding-sctdescid - if sct is in scope (exact use cases need discussion)
* http://hl7.org/fhir/StructureDefinition/itemWeight - echo in value set if defined in code system or value set
* http://hl7.org/fhir/StructureDefinition/rendering-style -  echo in value set if defined in code system or value set
* http://hl7.org/fhir/StructureDefinition/rendering-xhtml -  echo in value set if defined in code system or value set
* http://hl7.org/fhir/StructureDefinition/valueset-concept-definition - populate if requested in expansion request
* http://hl7.org/fhir/StructureDefinition/valueset-deprecated - populate if code system concept is deprecated
* http://hl7.org/fhir/StructureDefinition/valueset-supplement - check for this, blow up if supplement is properly supported
* http://hl7.org/fhir/StructureDefinition/valueset-label - echo in value set if defined in code system or value set
* http://hl7.org/fhir/StructureDefinition/valueset-conceptOrder - echo in value set if defined in code system or value set

Note that some of these extensions may be supported by rejecting instances that contain them, depending on the 
specific use cases that the server supports. E.g. if the server does not support externally derived code systems 
then the code system extensions are not relevant.