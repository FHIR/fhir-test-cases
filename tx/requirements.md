
These tests are a particular implementation of the requirements for a terminology 
server that can be used by the validator and IG publisher. 

# Test cases 

The tests assume that the server can accept code systems on the fly.
If servers do not accept code systems on the fly, server authors will have to 
adapt these tests by rewriting them for their own actual support code systems. 
Either way, servers that do SHOULD pass all the tests, but the FHIR product director 
will review the test outcomes in order to approve a server. 

All systems, need to conform to the following requirements:

# Metadata

* the server SHALL return a CapabilityStatement from {root}/metadata
* This SHALL be returned without authentication (note: it may include more information when returned to an authenticated client)
* It SHALL populate the CapabilityStatement.fhirVersion and CapabilityStatement.rest[mode = server].security.service properties
* It SHALL include a CapabilityStatement.instantiates value of http://hl7.org/fhir/CapabilityStatement/terminology-server
* The server SHALL return a TerminologyCapabilities statement from {root}/metadata?mode=terminology
* The TerminologyCapabilities SHALL list all the code systems that the server supports in TerminologyCapabilities.codeSystem.uri, and all the versions in TerminologyCapabilities.codeSystem.version.code. Code systems SHALL be listed here whether or not they are available through code system search 

# Reading Code Systems and Value Sets

* The server SHOULD make all the code systems and value sets it supports available through the /CodeSystem and /ValueSet endpoints.
* CodeSystems MAY have content = not-present; the tools will not consider this when choosing whether to try using the code system (uses TerminologyCapabilities.codeSystem.uri)
* Note that server does not *have to* make all the code systems it supports available in this fashion
* the server SHOULD ensure that all code systems and value sets conform to the Shareable* Profiles
* The server need not support history or track or report version tags on the resources (Resource.meta.version)
* Servers SHOULD generally allow multiple resources for the same canonical URL with different Resource.version, but this is subject to business rules on the server 
* The server does not need to support PUT/POST for any resources, but it can choose to do so 
  * if it allows PUT/POST, it SHOULD only do so for authenticated clients. However it does, it SHALL ensure that it only sends correct results for the code systems for which it is registered as 'authoritative' (see https://github.com/FHIR/ig-registry/blob/master/tx-registry-doco.md)

# Accessing code systems and value sets 

All code systems and value sets SHALL have a web representation that is appropriate for a human to look at.  The content on that page MAY be static or active; it is at the discretion of the server to decide what's on the page, but it SHOULD be more than just the json/xml for the resource (and it isn't limited to information in the resource either e.g. the server MAY choose to make additional process/provenance/context information available)

The server MAY choose to make this content available at the end-point for the relevant resource. e.g. aa request for {root}/CodeSystem/123 with an ```Accept``` header of 'application/fhir+json' returns the resource, and the same URL with an ```Accept``` header of 'text/html' returns a web page suitable for human consumption. Servers are not required to do this; they MAY choose to make the content available elsewhere.

If the server chooses to make them available elsewhere, it SHALL populate the extension ```http://hl7.org/fhir/tools/StructureDefinition/web-source``` in any resources it makes available with a valueUrl where the web view can be found. This SHALL be populated when the CodeSystem and ValueSet are read, and also in any $expand of the value set (just for the root valueset in this case).

# Code system support

* Servers do not need to support any code systems but the ones that they are provisioned to serve internally (including in the txResources parameter - see below)
* Servers SHALL support code system supplements. Servers SHALL not ignore supplements, though they MAY choose to return errors rather than process them correctly
* Servers SHALL support the following properties:
  * CodeSystem.caseSensitive 
  * CodeSystem.valueSet 
  * CodeSystem.hierarchyMeaning 
  * CodeSystem.compositional 
  * CodeSystem.versionNeeded
  * CodeSystem.content
  * CodeSystem.supplements
* Note that servers can choose to not support all the implied features in that list, but if it does not, it SHALL correctly indicate that it has not by returning appropriate errors or warnings when the features are relevant
* 
   




... 	Σ	0..1	boolean	If code comparison is case sensitive
... 	Σ	0..1	canonical(ValueSet)	Canonical reference to the value set with entire code system
... 	ΣC	0..1	code	grouped-by | is-a | part-of | classified-with
Binding: Code System Hierarchy Meaning (Required)
... 	Σ	0..1	boolean	If code system defines a compositional grammar
... versionNeeded	Σ	0..1	boolean	If definitions are not stable
... content	ΣC	1..1	code	not-present | example | fragment | complete | supplement
Binding: Code System Content Mode (Required)
... supplements	ΣCTU	0..1	canonical(CodeSystem)	Canonical URL of Code System this adds designations and properties to


# Common Parameters ($expand and $validate-code)

* The server SHALL support the [tx-resource](https://jira.hl7.org/browse/FHIR-33944) parameter for passing related 
  value sets, concept maps, naming systems, code system supplements and code systems
* All servers SHALL 'support' all four kinds of resources being passed in the ```tx-resource``` parameter:
  * All servers SHALL support value sets fully
  * All servers SHALL support concept maps fully
  * All servers SHALL support code system supplements to at least recognising them (see below)
  * All servers SHALL support code systems to at least recognising them

* The server SHOULD support the [cache-id](https://jira.hl7.org/browse/FHIR-33946) parameter. If it does, it SHALL report so in TerminologyCapabilities.expansion.parameter.name (this parameter makes a big difference to performance for clients - reduces network utilization very much)

* The server SHALL support supplements for the purposes of designations in different languages
  * Clarification: Servers SHALL not ignore supplements; if they don't support a relevant supplement, they SHALL return an error that they cannot process the supplement (e.g. if it is passed in a tx-resource parameter)
  * Whether servers actually accept and use supplements for the purposes of designations is a matter for negotiation with the server's relevant user base and whether there are other arrangements in place for supporting translation (e.g. SNOMED CT, LOINC)

* Servers MAY choose whether or not to accept new code systems they don't know about in tx-resource parameters
  * if they do not accept new code systems, they SHALL return an error when such code systems are passed to them
  * if they accept such code systems, they SHALL process them properly for the purpose of the call to which they are attached 
  * Support for additional code systems is **required** for a general purpose server that supports the validator or the ig-publisher, but not required for servers that register through the [registered ecosystem](https://github.com/FHIR/ig-registry/blob/master/tx-registry-doco.md) to provide services for particular code systems

* For the expand operation:
  * The server SHALL support the count parameter (offset is used, but will always be 0)
  * The server SHOULD return hierarchical expansions when possible (this is not a technical requirement, but comes up as important to authors)
  * The server SHALL support system-version, check-system-version, and force-system-version
  * The server SHALL echo all parameters (including assumed values) in the expansion parameters
  * The server SHALL report with all versions of code systems used (in 'used-*')
  * The server SHALL Support language correctly (both displayLanguage parameter and Accept-Language header, as specified on [[languages.md]])
  * The server SHALL support the excludeNested, includeDesignations, activeOnly, includeDefinition, property, designation parameters

* For the validate-code operation:
  * The server SHALL support validating code+system(+version)(+display), Coding, and CodeableConcept
  * The server SHALL support the [mode/valueSetMode](https://jira.hl7.org/browse/FHIR-41229) parameter
  * The server SHALL support language correctly (same locations/ruless for $expand)
  * The server SHALL support the [inferSystem](https://jira.hl7.org/browse/FHIR-41431) parameter
  * The server SHALL return an issues parameter when there are issues to return 
  * The server SHALL return system, code and display for the code that it considered valid, along with the version if this is known
  * The server SHOULD return a x-caused-by-unknown-system parameter for each code system it did not support
  * The server SHOULD return a normalized-code parameter where appropriate (e.g. case insensitive code systems, code systems with complex grammars)
  * The server SHOULD return an issue with tx issue type ```processing-note``` when it has not fully validated the code e.g. an SCT expression against the MRCM 

The following extensions should be supported:
* http://hl7.org/fhir/StructureDefinition/codesystem-alternate - if code system has alternate codes (TODO: this is subject to further discussion)
* http://hl7.org/fhir/StructureDefinition/codesystem-conceptOrder - if code system has order, then this SHOULD be echoed (nothing else needed)
* http://hl7.org/fhir/StructureDefinition/codesystem-label - if code system supports 'labels', then this SHOULD be echoed (nothing else needed)
* http://hl7.org/fhir/StructureDefinition/coding-sctdescid - if sct is in scope (exact use cases need discussion)
* http://hl7.org/fhir/StructureDefinition/itemWeight - echo in value set if defined in code system or value set
* http://hl7.org/fhir/StructureDefinition/rendering-style -  echo in value set if defined in code system or value set
* http://hl7.org/fhir/StructureDefinition/rendering-xhtml -  echo in value set if defined in code system or value set
* http://hl7.org/fhir/StructureDefinition/valueset-concept-definition - populate if requested in expansion request
* http://hl7.org/fhir/StructureDefinition/valueset-deprecated - populate in the response if code system concept is deprecated
* http://hl7.org/fhir/StructureDefinition/valueset-supplement - check for this, blow up if supplement is properly supported
* http://hl7.org/fhir/StructureDefinition/valueset-label - echo in value set if defined in code system or value set
* http://hl7.org/fhir/StructureDefinition/valueset-conceptOrder - echo in value set if defined in code system or value set

Note that some of these extensions may be supported by rejecting instances that contain them, depending on the 
specific use cases that the server supports. E.g. if the server does not support externally derived code systems 
then the code system extensions are not relevant.