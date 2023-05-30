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

* The server SHALL support the txResource parameter for passing related 
  value sets, concept maps, naming systems, code system supplements and if relevant, code systems

* The server SHOULD support the cache-id parameter 

* The server SHALL support supplements for the purposes of designations in different langauges

* For the expand operation:
** The server SHALL support the count parameter (offset is used, but will always be 0)
** The server SHOULD return heirarchical expansions when possible (this is not a technical requirement, but comes up as important to authors)
** The server SHALL support system-version, check-system-version, and force-system-version
** The server SHALL echo all parameters (including assumed values) in the expansion parameters, along with all versions of code systems used (in 'version')
** The server SHALL Support language correctly (both displayLanguage and accept-language header)
** The server SHALL support the excludeNested, includeDesignations, activeOnly, includeDefinition, property parameters


* For the validate-code operation:
** The server SHALL support validating code+system(+version)(+display), Coding, and CodeableConcept
** The server SHALL support the mode/valueSetMode parameter
** The server SHALL Support language correctly (both displayLanguage and accept-language header)
** The server SHALL support the implySystem parameter
** The server SHALL return an issues parameter 
** The server SHALL return system, code and display for the code that it considered valid, along with the version if this is known
** The server SHOULD return a x-caused-by-unknown-system parameter for each code system it did not support

The following extensions should be supported:
* http://hl7.org/fhir/StructureDefinition/valueset-deprecated - populate if code system concept is deprecated
* http://hl7.org/fhir/StructureDefinition/codesystem-alternate - if code system has alternate codes
* http://hl7.org/fhir/StructureDefinition/codesystem-conceptOrder - if code system has order
* http://hl7.org/fhir/StructureDefinition/codesystem-label - if code system supports 'labels'
* http://hl7.org/fhir/StructureDefinition/coding-sctdescid - 
* http://hl7.org/fhir/StructureDefinition/itemWeight - 
* http://hl7.org/fhir/StructureDefinition/rendering-style - 
* http://hl7.org/fhir/StructureDefinition/rendering-xhtml - 
* http://hl7.org/fhir/StructureDefinition/valueset-concept-definition - 
* http://hl7.org/fhir/StructureDefinition/valueset-deprecated - 
* http://hl7.org/fhir/StructureDefinition/valueset-supplement - 
* http://hl7.org/fhir/StructureDefinition/valueset-label - 
* http://hl7.org/fhir/StructureDefinition/valueset-conceptOrder - 
