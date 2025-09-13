CRD Device Request - Da Vinci - Coverage Requirements Discovery v2.2.0-ballot

h2{--heading-prefix:"15.1.31"} h3,h4,h5,h6{--heading-prefix:"15.1.31"}

* [**Table of Contents**](toc.md)
* [**FHIR Artifacts**](allartifacts.md)
* [**Artifact List**](artifacts.md)
* **CRD Device Request**

Da Vinci - Coverage Requirements Discovery - Local Development build (v2.2.0-ballot) built by the FHIR (HL7® FHIR® Standard) Build Tools. See the [Directory of published versions](http://hl7.org/fhir/us/davinci-crd/history.html)

* [Content](#)
* [Detailed Descriptions](StructureDefinition-profile-devicerequest-definitions.md)
* [Mappings](StructureDefinition-profile-devicerequest-mappings.md)
* [Examples](StructureDefinition-profile-devicerequest-examples.md)
* [XML](StructureDefinition-profile-devicerequest.profile.xml.md)
* [JSON](StructureDefinition-profile-devicerequest.profile.json.md)
* [TTL](StructureDefinition-profile-devicerequest.profile.ttl.md)

## Resource Profile: CRD Device Request 

| | | |
| :--- | :--- | :--- |
| *Official URL*:http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-devicerequest | *Version*:2.2.0-ballot | |
| *Standards status:*[Trial-use](http://hl7.org/fhir/R4/versions.html#std-process) | [Maturity Level](http://hl7.org/fhir/versions.html#maturity): 4 | *Computable Name*:CRDDeviceRequest |
| *Other Identifiers:*OID:2.16.840.1.113883.4.642.40.18.42.9 | | |

 
This profile specifies extensions and constraints on the DeviceRequest resource to support coverage requirements discovery. 

### Usage

 CRD Clients **SHALL** use this profile to [resolve references](foundation.md#additional-data-retrieval) to DeviceRequest resources passed to CRD Servers (e.g. ```selections```**selections** context references) and to populate ```draftOrders```**draftOrders** context objects when invoking the following CDS Hooks:

* [order-select](hooks.md#order-select)
* [order-sign](hooks.md#order-sign)
* [order-dispatch](hooks.md#order-dispatch)

Information provided in [Must Support](http://hl7.org/fhir/R4/profiling.html#mustsupport) elements will commonly be required for CRD Servers to perform coverage requirements discovery. 

**Usages:**

* Use this Profile:[CRD CDSHooks Additional Orders Response (Logical Definition)](StructureDefinition-CRDHooksResponse-additionalOrders.md),[CRD CDSHooks Alternate Request Response (Logical Definition)](StructureDefinition-CRDHooksResponse-alternateRequest.md),[CRD CDSHooks Coverage Information Response (Logical Definition)](StructureDefinition-CRDHooksResponse-coverageInformation.md)and[CRD Bundle of Request Resources](StructureDefinition-profile-bundle-request.md)
* Refer to this Profile:[Coverage Information](StructureDefinition-ext-coverage-information.md)
* CapabilityStatements using this Profile:[CRD Client USCDI 1](CapabilityStatement-crd-client3.1.md),[CRD Client USCDI 3](CapabilityStatement-crd-client6.1.md)and[CRD Client USCDI 4](CapabilityStatement-crd-client7.0.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/hl7.fhir.us.davinci-crd|current/StructureDefinition/profile-devicerequest)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

* [Key Elements Table](#tabs-key)
* [Differential Table](#tabs-diff)
* [Snapshot Table](#tabs-snap)
* [Statistics/References](#tabs-summ)
* [All](#tabs-all)

#### Terminology Bindings

**Path**: DeviceRequest.status
  **Conformance**: [required](http://hl7.org/fhir/R4/terminologies.html#required)
  **ValueSet**: [RequestStatus](http://hl7.org/fhir/R4/valueset-request-status.html)```http://hl7.org/fhir/ValueSet/request-status|4.0.1```**http://hl7.org/fhir/ValueSet/request-status|4.0.1**From the FHIR Standard
**Path**: DeviceRequest.intent
  **Conformance**: [required](http://hl7.org/fhir/R4/terminologies.html#required)
  **ValueSet**: [RequestIntent](http://hl7.org/fhir/R4/valueset-request-intent.html)```http://hl7.org/fhir/ValueSet/request-intent|4.0.1```**http://hl7.org/fhir/ValueSet/request-intent|4.0.1**From the FHIR Standard
**Path**: DeviceRequest.code[x]
  **Conformance**: [extensible](http://hl7.org/fhir/R4/terminologies.html#extensible)
  **ValueSet**: [CRDDeviceRequests](ValueSet-deviceRequest.md)```http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest```**http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest**From this IG
**Path**: DeviceRequest.code[x]:codeCodeableConcept
  **Conformance**: [example](http://hl7.org/fhir/R4/terminologies.html#example)
  **ValueSet**: [FHIRDeviceTypes](http://hl7.org/fhir/R4/valueset-device-kind.html)```http://hl7.org/fhir/ValueSet/device-kind|4.0.1```**http://hl7.org/fhir/ValueSet/device-kind|4.0.1**From the FHIR Standard
**Path**: DeviceRequest.reasonCode
  **Conformance**: [example](http://hl7.org/fhir/R4/terminologies.html#example)
  **ValueSet**: [Condition/Problem/DiagnosisCodes](http://hl7.org/fhir/R4/valueset-condition-code.html)```http://hl7.org/fhir/ValueSet/condition-code|4.0.1```**http://hl7.org/fhir/ValueSet/condition-code|4.0.1**From the FHIR Standard

#### Constraints

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| **Id** | **Grade** | **Path(s)** | **Details** | **Requirements** |
| crd-ci-q1 | error | DeviceRequest.extension:Coverage-Information | Questionnaire is only allowed when doc-needed exists: extension.where(url='questionnaire').exists() implies extension.where(url = 'doc-needed').exists() |  |
| crd-ci-q2 | error | DeviceRequest.extension:Coverage-Information | If covered is set to 'not-covered', then 'pa-needed' must not exist.: extension.where(url = 'covered' and value = 'not-covered').exists() implies extension.where(url = 'pa-needed').exists().not() |  |
| crd-ci-q3 | error | DeviceRequest.extension:Coverage-Information | 'info-needed' SHALL exist if and only if at least one of 'covered', 'pa-needed', or 'doc-needed' is set to 'conditional'.: extension.where((url = 'covered' or url = 'pa-needed' or url = 'doc-needed') and value = 'conditional').count() >= 1 implies extension.where(url = 'info-needed').exists() |  |
| crd-ci-q4 | error | DeviceRequest.extension:Coverage-Information | If 'pa-needed' is 'satisfied', 'noauth', or 'not-covered', then 'Doc-purpose' can't be 'withpa'.: extension.where(url = 'pa-needed' and (value = 'satisfied' or value = 'noauth' or value = 'not-covered')) and extension.where(url = 'doc-purpose').exists() implies extension.where(url = 'doc-purpose').all(value != 'withpa') |  |
| crd-ci-q5 | error | DeviceRequest.extension:Coverage-Information | 'satisfied-pa-id' must exist if and only if 'pa-needed' is set to 'satisfied'.: extension.where(url = 'pa-needed' and value = 'satisfied').exists() = extension.where(url = 'satisfied-pa-id').exists() |  |
| crd-ci-q6 | error | DeviceRequest.extension:Coverage-Information | If 'info-needed' is OTH, then reason must be specified: extension.where(url = 'info-needed' and value = 'OTH').exists() implies extension.where(url = 'reason').exists() |  |
| crd-ci-q7 | error | DeviceRequest.extension:Coverage-Information | If reason.coding is present and is not from the extensible value set, then reason.text must be present: extension.where(url = 'reason').empty() or extension.where(url = 'reason').value.text.exists() or extension.where(url = 'reason').value.memberOf('http://hl7.org/fhir/us/davinci-crd/ValueSet/coverageAssertionReasons') |  |
| crd-ci-q8 | error | DeviceRequest.extension:Coverage-Information | If doc-purpose is present with a value other than 'conditional', then reason must be present: extension.where(url = 'doc-purpose' and value != 'conditional').exists() implies extension.where(url = 'reason').exists() |  |
| dom-2 | error | DeviceRequest | If the resource is contained in another resource, it SHALL NOT contain nested Resources: contained.contained.empty() |  |
| dom-3 | error | DeviceRequest | If the resource is contained in another resource, it SHALL be referred to from elsewhere in the resource or SHALL refer to the containing resource: contained.where((('#'+id in (%resource.descendants().reference | %resource.descendants().as(canonical) | %resource.descendants().as(uri) | %resource.descendants().as(url))) or descendants().where(reference = '#').exists() or descendants().where(as(canonical) = '#').exists() or descendants().where(as(canonical) = '#').exists()).not()).trace('unmatched', id).empty() |  |
| dom-4 | error | DeviceRequest | If a resource is contained in another resource, it SHALL NOT have a meta.versionId or a meta.lastUpdated: contained.meta.versionId.empty() and contained.meta.lastUpdated.empty() |  |
| dom-5 | error | DeviceRequest | If a resource is contained in another resource, it SHALL NOT have a security label: contained.meta.security.empty() |  |
| dom-6 | best practice | DeviceRequest | A resource should have narrative for robust management: text.`div`.exists() |  |
| ele-1 | error | ****ALL** elements** | All FHIR elements must have a @value or children: hasValue() or (children().count() > id.count()) |  |
| ext-1 | error | ****ALL** extensions** | Must have either extensions or value[x], not both: extension.exists() != value.exists() |  |

This structure is derived from [DeviceRequest](http://hl7.org/fhir/R4/devicerequest.html) 

#### Terminology Bindings (Differential)

| | | | |
| :--- | :--- | :--- | :--- |
| **Path** | **Conformance** | **ValueSet** | **URI** |
| DeviceRequest.code[x] | [extensible](http://hl7.org/fhir/R4/terminologies.html#extensible) | [CRDDeviceRequests](ValueSet-deviceRequest.md)```http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest```**http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest**From this IG | |

#### Terminology Bindings

| | | | |
| :--- | :--- | :--- | :--- |
| **Path** | **Conformance** | **ValueSet** | **URI** |
| DeviceRequest.language | [preferred](http://hl7.org/fhir/R4/terminologies.html#preferred) | [CommonLanguages](http://hl7.org/fhir/R4/valueset-languages.html)```http://hl7.org/fhir/ValueSet/languages|4.0.1```**http://hl7.org/fhir/ValueSet/languages|4.0.1**From the FHIR Standard
| | |
| :--- | :--- |
| **Additional Bindings** | Purpose |
| [AllLanguages](http://hl7.org/fhir/R4/valueset-all-languages.html) | [Max Binding](http://hl7.org/fhir/R4/extension-elementdefinition-maxvalueset.html) |
 | |
| DeviceRequest.status | [required](http://hl7.org/fhir/R4/terminologies.html#required) | [RequestStatus](http://hl7.org/fhir/R4/valueset-request-status.html)```http://hl7.org/fhir/ValueSet/request-status|4.0.1```**http://hl7.org/fhir/ValueSet/request-status|4.0.1**From the FHIR Standard | |
| DeviceRequest.intent | [required](http://hl7.org/fhir/R4/terminologies.html#required) | [RequestIntent](http://hl7.org/fhir/R4/valueset-request-intent.html)```http://hl7.org/fhir/ValueSet/request-intent|4.0.1```**http://hl7.org/fhir/ValueSet/request-intent|4.0.1**From the FHIR Standard | |
| DeviceRequest.priority | [required](http://hl7.org/fhir/R4/terminologies.html#required) | [RequestPriority](http://hl7.org/fhir/R4/valueset-request-priority.html)```http://hl7.org/fhir/ValueSet/request-priority|4.0.1```**http://hl7.org/fhir/ValueSet/request-priority|4.0.1**From the FHIR Standard | |
| DeviceRequest.code[x] | [extensible](http://hl7.org/fhir/R4/terminologies.html#extensible) | [CRDDeviceRequests](ValueSet-deviceRequest.md)```http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest```**http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest**From this IG | |
| DeviceRequest.code[x]:codeCodeableConcept | [example](http://hl7.org/fhir/R4/terminologies.html#example) | [FHIRDeviceTypes](http://hl7.org/fhir/R4/valueset-device-kind.html)```http://hl7.org/fhir/ValueSet/device-kind|4.0.1```**http://hl7.org/fhir/ValueSet/device-kind|4.0.1**From the FHIR Standard | |
| DeviceRequest.parameter.code | [example](http://hl7.org/fhir/R4/terminologies.html#example) |  | |
| DeviceRequest.performerType | [example](http://hl7.org/fhir/R4/terminologies.html#example) | [ParticipantRoles](http://hl7.org/fhir/R4/valueset-participant-role.html)```http://hl7.org/fhir/ValueSet/participant-role|4.0.1```**http://hl7.org/fhir/ValueSet/participant-role|4.0.1**From the FHIR Standard | |
| DeviceRequest.reasonCode | [example](http://hl7.org/fhir/R4/terminologies.html#example) | [Condition/Problem/DiagnosisCodes](http://hl7.org/fhir/R4/valueset-condition-code.html)```http://hl7.org/fhir/ValueSet/condition-code|4.0.1```**http://hl7.org/fhir/ValueSet/condition-code|4.0.1**From the FHIR Standard | |

#### Constraints

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| **Id** | **Grade** | **Path(s)** | **Details** | **Requirements** |
| crd-ci-q1 | error | DeviceRequest.extension:Coverage-Information | Questionnaire is only allowed when doc-needed exists: extension.where(url='questionnaire').exists() implies extension.where(url = 'doc-needed').exists() |  |
| crd-ci-q2 | error | DeviceRequest.extension:Coverage-Information | If covered is set to 'not-covered', then 'pa-needed' must not exist.: extension.where(url = 'covered' and value = 'not-covered').exists() implies extension.where(url = 'pa-needed').exists().not() |  |
| crd-ci-q3 | error | DeviceRequest.extension:Coverage-Information | 'info-needed' SHALL exist if and only if at least one of 'covered', 'pa-needed', or 'doc-needed' is set to 'conditional'.: extension.where((url = 'covered' or url = 'pa-needed' or url = 'doc-needed') and value = 'conditional').count() >= 1 implies extension.where(url = 'info-needed').exists() |  |
| crd-ci-q4 | error | DeviceRequest.extension:Coverage-Information | If 'pa-needed' is 'satisfied', 'noauth', or 'not-covered', then 'Doc-purpose' can't be 'withpa'.: extension.where(url = 'pa-needed' and (value = 'satisfied' or value = 'noauth' or value = 'not-covered')) and extension.where(url = 'doc-purpose').exists() implies extension.where(url = 'doc-purpose').all(value != 'withpa') |  |
| crd-ci-q5 | error | DeviceRequest.extension:Coverage-Information | 'satisfied-pa-id' must exist if and only if 'pa-needed' is set to 'satisfied'.: extension.where(url = 'pa-needed' and value = 'satisfied').exists() = extension.where(url = 'satisfied-pa-id').exists() |  |
| crd-ci-q6 | error | DeviceRequest.extension:Coverage-Information | If 'info-needed' is OTH, then reason must be specified: extension.where(url = 'info-needed' and value = 'OTH').exists() implies extension.where(url = 'reason').exists() |  |
| crd-ci-q7 | error | DeviceRequest.extension:Coverage-Information | If reason.coding is present and is not from the extensible value set, then reason.text must be present: extension.where(url = 'reason').empty() or extension.where(url = 'reason').value.text.exists() or extension.where(url = 'reason').value.memberOf('http://hl7.org/fhir/us/davinci-crd/ValueSet/coverageAssertionReasons') |  |
| crd-ci-q8 | error | DeviceRequest.extension:Coverage-Information | If doc-purpose is present with a value other than 'conditional', then reason must be present: extension.where(url = 'doc-purpose' and value != 'conditional').exists() implies extension.where(url = 'reason').exists() |  |
| dom-2 | error | DeviceRequest | If the resource is contained in another resource, it SHALL NOT contain nested Resources: contained.contained.empty() |  |
| dom-3 | error | DeviceRequest | If the resource is contained in another resource, it SHALL be referred to from elsewhere in the resource or SHALL refer to the containing resource: contained.where((('#'+id in (%resource.descendants().reference | %resource.descendants().as(canonical) | %resource.descendants().as(uri) | %resource.descendants().as(url))) or descendants().where(reference = '#').exists() or descendants().where(as(canonical) = '#').exists() or descendants().where(as(canonical) = '#').exists()).not()).trace('unmatched', id).empty() |  |
| dom-4 | error | DeviceRequest | If a resource is contained in another resource, it SHALL NOT have a meta.versionId or a meta.lastUpdated: contained.meta.versionId.empty() and contained.meta.lastUpdated.empty() |  |
| dom-5 | error | DeviceRequest | If a resource is contained in another resource, it SHALL NOT have a security label: contained.meta.security.empty() |  |
| dom-6 | best practice | DeviceRequest | A resource should have narrative for robust management: text.`div`.exists() |  |
| ele-1 | error | ****ALL** elements** | All FHIR elements must have a @value or children: hasValue() or (children().count() > id.count()) |  |
| ext-1 | error | ****ALL** extensions** | Must have either extensions or value[x], not both: extension.exists() != value.exists() |  |

This structure is derived from [DeviceRequest](http://hl7.org/fhir/R4/devicerequest.html) 

**Summary**

Mandatory: 3 elements
 Must-Support: 16 elements

**Structures**

This structure refers to these other structures:

* [CRD Device(http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-device)](StructureDefinition-profile-device.md)
* [CRD Patient(http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-patient)](StructureDefinition-profile-patient.md)
* [CRD Encounter(http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-encounter)](StructureDefinition-profile-encounter.md)
* [US Core Practitioner Profile(http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-practitioner.html)
* [HRex PractitionerRole Profile(http://hl7.org/fhir/us/davinci-hrex/StructureDefinition/hrex-practitionerrole)](http://hl7.org/fhir/us/davinci-hrex/STU1.1/StructureDefinition-hrex-practitionerrole.html)
* [US Core Condition Problems and Health Concerns Profile(http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-problems-health-concerns|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-condition-problems-health-concerns.html)
* [US Core Condition Encounter Diagnosis Profile(http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-encounter-diagnosis|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-condition-encounter-diagnosis.html)
* [US Core DiagnosticReport Profile for Laboratory Results Reporting(http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-diagnosticreport-lab.html)
* [US Core DiagnosticReport Profile for Report and Note Exchange(http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-diagnosticreport-note.html)
* [US Core DocumentReference Profile(http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-documentreference.html)

**Extensions**

This structure refers to these extensions:

* [http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information](StructureDefinition-ext-coverage-information.md)
* [http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options](StructureDefinition-ext-billing-options.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the value of DeviceRequest.code[x]

**[Maturity](http://hl7.org/fhir/versions.html#maturity)**: 4

 **Key Elements View** 

#### Terminology Bindings

| | | | |
| :--- | :--- | :--- | :--- |
| **Path** | **Conformance** | **ValueSet** | **URI** |
| DeviceRequest.status | [required](http://hl7.org/fhir/R4/terminologies.html#required) | [RequestStatus](http://hl7.org/fhir/R4/valueset-request-status.html)```http://hl7.org/fhir/ValueSet/request-status|4.0.1```**http://hl7.org/fhir/ValueSet/request-status|4.0.1**From the FHIR Standard | |
| DeviceRequest.intent | [required](http://hl7.org/fhir/R4/terminologies.html#required) | [RequestIntent](http://hl7.org/fhir/R4/valueset-request-intent.html)```http://hl7.org/fhir/ValueSet/request-intent|4.0.1```**http://hl7.org/fhir/ValueSet/request-intent|4.0.1**From the FHIR Standard | |
| DeviceRequest.code[x] | [extensible](http://hl7.org/fhir/R4/terminologies.html#extensible) | [CRDDeviceRequests](ValueSet-deviceRequest.md)```http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest```**http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest**From this IG | |
| DeviceRequest.code[x]:codeCodeableConcept | [example](http://hl7.org/fhir/R4/terminologies.html#example) | [FHIRDeviceTypes](http://hl7.org/fhir/R4/valueset-device-kind.html)```http://hl7.org/fhir/ValueSet/device-kind|4.0.1```**http://hl7.org/fhir/ValueSet/device-kind|4.0.1**From the FHIR Standard | |
| DeviceRequest.reasonCode | [example](http://hl7.org/fhir/R4/terminologies.html#example) | [Condition/Problem/DiagnosisCodes](http://hl7.org/fhir/R4/valueset-condition-code.html)```http://hl7.org/fhir/ValueSet/condition-code|4.0.1```**http://hl7.org/fhir/ValueSet/condition-code|4.0.1**From the FHIR Standard | |

#### Constraints

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| **Id** | **Grade** | **Path(s)** | **Details** | **Requirements** |
| crd-ci-q1 | error | DeviceRequest.extension:Coverage-Information | Questionnaire is only allowed when doc-needed exists: extension.where(url='questionnaire').exists() implies extension.where(url = 'doc-needed').exists() |  |
| crd-ci-q2 | error | DeviceRequest.extension:Coverage-Information | If covered is set to 'not-covered', then 'pa-needed' must not exist.: extension.where(url = 'covered' and value = 'not-covered').exists() implies extension.where(url = 'pa-needed').exists().not() |  |
| crd-ci-q3 | error | DeviceRequest.extension:Coverage-Information | 'info-needed' SHALL exist if and only if at least one of 'covered', 'pa-needed', or 'doc-needed' is set to 'conditional'.: extension.where((url = 'covered' or url = 'pa-needed' or url = 'doc-needed') and value = 'conditional').count() >= 1 implies extension.where(url = 'info-needed').exists() |  |
| crd-ci-q4 | error | DeviceRequest.extension:Coverage-Information | If 'pa-needed' is 'satisfied', 'noauth', or 'not-covered', then 'Doc-purpose' can't be 'withpa'.: extension.where(url = 'pa-needed' and (value = 'satisfied' or value = 'noauth' or value = 'not-covered')) and extension.where(url = 'doc-purpose').exists() implies extension.where(url = 'doc-purpose').all(value != 'withpa') |  |
| crd-ci-q5 | error | DeviceRequest.extension:Coverage-Information | 'satisfied-pa-id' must exist if and only if 'pa-needed' is set to 'satisfied'.: extension.where(url = 'pa-needed' and value = 'satisfied').exists() = extension.where(url = 'satisfied-pa-id').exists() |  |
| crd-ci-q6 | error | DeviceRequest.extension:Coverage-Information | If 'info-needed' is OTH, then reason must be specified: extension.where(url = 'info-needed' and value = 'OTH').exists() implies extension.where(url = 'reason').exists() |  |
| crd-ci-q7 | error | DeviceRequest.extension:Coverage-Information | If reason.coding is present and is not from the extensible value set, then reason.text must be present: extension.where(url = 'reason').empty() or extension.where(url = 'reason').value.text.exists() or extension.where(url = 'reason').value.memberOf('http://hl7.org/fhir/us/davinci-crd/ValueSet/coverageAssertionReasons') |  |
| crd-ci-q8 | error | DeviceRequest.extension:Coverage-Information | If doc-purpose is present with a value other than 'conditional', then reason must be present: extension.where(url = 'doc-purpose' and value != 'conditional').exists() implies extension.where(url = 'reason').exists() |  |
| dom-2 | error | DeviceRequest | If the resource is contained in another resource, it SHALL NOT contain nested Resources: contained.contained.empty() |  |
| dom-3 | error | DeviceRequest | If the resource is contained in another resource, it SHALL be referred to from elsewhere in the resource or SHALL refer to the containing resource: contained.where((('#'+id in (%resource.descendants().reference | %resource.descendants().as(canonical) | %resource.descendants().as(uri) | %resource.descendants().as(url))) or descendants().where(reference = '#').exists() or descendants().where(as(canonical) = '#').exists() or descendants().where(as(canonical) = '#').exists()).not()).trace('unmatched', id).empty() |  |
| dom-4 | error | DeviceRequest | If a resource is contained in another resource, it SHALL NOT have a meta.versionId or a meta.lastUpdated: contained.meta.versionId.empty() and contained.meta.lastUpdated.empty() |  |
| dom-5 | error | DeviceRequest | If a resource is contained in another resource, it SHALL NOT have a security label: contained.meta.security.empty() |  |
| dom-6 | best practice | DeviceRequest | A resource should have narrative for robust management: text.`div`.exists() |  |
| ele-1 | error | ****ALL** elements** | All FHIR elements must have a @value or children: hasValue() or (children().count() > id.count()) |  |
| ext-1 | error | ****ALL** extensions** | Must have either extensions or value[x], not both: extension.exists() != value.exists() |  |

 **Differential View** 

This structure is derived from [DeviceRequest](http://hl7.org/fhir/R4/devicerequest.html) 

#### Terminology Bindings (Differential)

| | | | |
| :--- | :--- | :--- | :--- |
| **Path** | **Conformance** | **ValueSet** | **URI** |
| DeviceRequest.code[x] | [extensible](http://hl7.org/fhir/R4/terminologies.html#extensible) | [CRDDeviceRequests](ValueSet-deviceRequest.md)```http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest```**http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest**From this IG | |

 **Snapshot View** 

#### Terminology Bindings

| | | | |
| :--- | :--- | :--- | :--- |
| **Path** | **Conformance** | **ValueSet** | **URI** |
| DeviceRequest.language | [preferred](http://hl7.org/fhir/R4/terminologies.html#preferred) | [CommonLanguages](http://hl7.org/fhir/R4/valueset-languages.html)```http://hl7.org/fhir/ValueSet/languages|4.0.1```**http://hl7.org/fhir/ValueSet/languages|4.0.1**From the FHIR Standard
| | |
| :--- | :--- |
| **Additional Bindings** | Purpose |
| [AllLanguages](http://hl7.org/fhir/R4/valueset-all-languages.html) | [Max Binding](http://hl7.org/fhir/R4/extension-elementdefinition-maxvalueset.html) |
 | |
| DeviceRequest.status | [required](http://hl7.org/fhir/R4/terminologies.html#required) | [RequestStatus](http://hl7.org/fhir/R4/valueset-request-status.html)```http://hl7.org/fhir/ValueSet/request-status|4.0.1```**http://hl7.org/fhir/ValueSet/request-status|4.0.1**From the FHIR Standard | |
| DeviceRequest.intent | [required](http://hl7.org/fhir/R4/terminologies.html#required) | [RequestIntent](http://hl7.org/fhir/R4/valueset-request-intent.html)```http://hl7.org/fhir/ValueSet/request-intent|4.0.1```**http://hl7.org/fhir/ValueSet/request-intent|4.0.1**From the FHIR Standard | |
| DeviceRequest.priority | [required](http://hl7.org/fhir/R4/terminologies.html#required) | [RequestPriority](http://hl7.org/fhir/R4/valueset-request-priority.html)```http://hl7.org/fhir/ValueSet/request-priority|4.0.1```**http://hl7.org/fhir/ValueSet/request-priority|4.0.1**From the FHIR Standard | |
| DeviceRequest.code[x] | [extensible](http://hl7.org/fhir/R4/terminologies.html#extensible) | [CRDDeviceRequests](ValueSet-deviceRequest.md)```http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest```**http://hl7.org/fhir/us/davinci-crd/ValueSet/deviceRequest**From this IG | |
| DeviceRequest.code[x]:codeCodeableConcept | [example](http://hl7.org/fhir/R4/terminologies.html#example) | [FHIRDeviceTypes](http://hl7.org/fhir/R4/valueset-device-kind.html)```http://hl7.org/fhir/ValueSet/device-kind|4.0.1```**http://hl7.org/fhir/ValueSet/device-kind|4.0.1**From the FHIR Standard | |
| DeviceRequest.parameter.code | [example](http://hl7.org/fhir/R4/terminologies.html#example) |  | |
| DeviceRequest.performerType | [example](http://hl7.org/fhir/R4/terminologies.html#example) | [ParticipantRoles](http://hl7.org/fhir/R4/valueset-participant-role.html)```http://hl7.org/fhir/ValueSet/participant-role|4.0.1```**http://hl7.org/fhir/ValueSet/participant-role|4.0.1**From the FHIR Standard | |
| DeviceRequest.reasonCode | [example](http://hl7.org/fhir/R4/terminologies.html#example) | [Condition/Problem/DiagnosisCodes](http://hl7.org/fhir/R4/valueset-condition-code.html)```http://hl7.org/fhir/ValueSet/condition-code|4.0.1```**http://hl7.org/fhir/ValueSet/condition-code|4.0.1**From the FHIR Standard | |

#### Constraints

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| **Id** | **Grade** | **Path(s)** | **Details** | **Requirements** |
| crd-ci-q1 | error | DeviceRequest.extension:Coverage-Information | Questionnaire is only allowed when doc-needed exists: extension.where(url='questionnaire').exists() implies extension.where(url = 'doc-needed').exists() |  |
| crd-ci-q2 | error | DeviceRequest.extension:Coverage-Information | If covered is set to 'not-covered', then 'pa-needed' must not exist.: extension.where(url = 'covered' and value = 'not-covered').exists() implies extension.where(url = 'pa-needed').exists().not() |  |
| crd-ci-q3 | error | DeviceRequest.extension:Coverage-Information | 'info-needed' SHALL exist if and only if at least one of 'covered', 'pa-needed', or 'doc-needed' is set to 'conditional'.: extension.where((url = 'covered' or url = 'pa-needed' or url = 'doc-needed') and value = 'conditional').count() >= 1 implies extension.where(url = 'info-needed').exists() |  |
| crd-ci-q4 | error | DeviceRequest.extension:Coverage-Information | If 'pa-needed' is 'satisfied', 'noauth', or 'not-covered', then 'Doc-purpose' can't be 'withpa'.: extension.where(url = 'pa-needed' and (value = 'satisfied' or value = 'noauth' or value = 'not-covered')) and extension.where(url = 'doc-purpose').exists() implies extension.where(url = 'doc-purpose').all(value != 'withpa') |  |
| crd-ci-q5 | error | DeviceRequest.extension:Coverage-Information | 'satisfied-pa-id' must exist if and only if 'pa-needed' is set to 'satisfied'.: extension.where(url = 'pa-needed' and value = 'satisfied').exists() = extension.where(url = 'satisfied-pa-id').exists() |  |
| crd-ci-q6 | error | DeviceRequest.extension:Coverage-Information | If 'info-needed' is OTH, then reason must be specified: extension.where(url = 'info-needed' and value = 'OTH').exists() implies extension.where(url = 'reason').exists() |  |
| crd-ci-q7 | error | DeviceRequest.extension:Coverage-Information | If reason.coding is present and is not from the extensible value set, then reason.text must be present: extension.where(url = 'reason').empty() or extension.where(url = 'reason').value.text.exists() or extension.where(url = 'reason').value.memberOf('http://hl7.org/fhir/us/davinci-crd/ValueSet/coverageAssertionReasons') |  |
| crd-ci-q8 | error | DeviceRequest.extension:Coverage-Information | If doc-purpose is present with a value other than 'conditional', then reason must be present: extension.where(url = 'doc-purpose' and value != 'conditional').exists() implies extension.where(url = 'reason').exists() |  |
| dom-2 | error | DeviceRequest | If the resource is contained in another resource, it SHALL NOT contain nested Resources: contained.contained.empty() |  |
| dom-3 | error | DeviceRequest | If the resource is contained in another resource, it SHALL be referred to from elsewhere in the resource or SHALL refer to the containing resource: contained.where((('#'+id in (%resource.descendants().reference | %resource.descendants().as(canonical) | %resource.descendants().as(uri) | %resource.descendants().as(url))) or descendants().where(reference = '#').exists() or descendants().where(as(canonical) = '#').exists() or descendants().where(as(canonical) = '#').exists()).not()).trace('unmatched', id).empty() |  |
| dom-4 | error | DeviceRequest | If a resource is contained in another resource, it SHALL NOT have a meta.versionId or a meta.lastUpdated: contained.meta.versionId.empty() and contained.meta.lastUpdated.empty() |  |
| dom-5 | error | DeviceRequest | If a resource is contained in another resource, it SHALL NOT have a security label: contained.meta.security.empty() |  |
| dom-6 | best practice | DeviceRequest | A resource should have narrative for robust management: text.`div`.exists() |  |
| ele-1 | error | ****ALL** elements** | All FHIR elements must have a @value or children: hasValue() or (children().count() > id.count()) |  |
| ext-1 | error | ****ALL** extensions** | Must have either extensions or value[x], not both: extension.exists() != value.exists() |  |

This structure is derived from [DeviceRequest](http://hl7.org/fhir/R4/devicerequest.html) 

**Summary**

Mandatory: 3 elements
 Must-Support: 16 elements

**Structures**

This structure refers to these other structures:

* [CRD Device(http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-device)](StructureDefinition-profile-device.md)
* [CRD Patient(http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-patient)](StructureDefinition-profile-patient.md)
* [CRD Encounter(http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-encounter)](StructureDefinition-profile-encounter.md)
* [US Core Practitioner Profile(http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-practitioner.html)
* [HRex PractitionerRole Profile(http://hl7.org/fhir/us/davinci-hrex/StructureDefinition/hrex-practitionerrole)](http://hl7.org/fhir/us/davinci-hrex/STU1.1/StructureDefinition-hrex-practitionerrole.html)
* [US Core Condition Problems and Health Concerns Profile(http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-problems-health-concerns|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-condition-problems-health-concerns.html)
* [US Core Condition Encounter Diagnosis Profile(http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-encounter-diagnosis|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-condition-encounter-diagnosis.html)
* [US Core DiagnosticReport Profile for Laboratory Results Reporting(http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-diagnosticreport-lab.html)
* [US Core DiagnosticReport Profile for Report and Note Exchange(http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-diagnosticreport-note.html)
* [US Core DocumentReference Profile(http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference|7.0.0)](http://hl7.org/fhir/us/core/STU7/StructureDefinition-us-core-documentreference.html)

**Extensions**

This structure refers to these extensions:

* [http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information](StructureDefinition-ext-coverage-information.md)
* [http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options](StructureDefinition-ext-billing-options.md)

**Slices**

This structure defines the following [Slices](http://hl7.org/fhir/R4/profiling.html#slices):

* The element 1 is sliced based on the value of DeviceRequest.code[x]

**[Maturity](http://hl7.org/fhir/versions.html#maturity)**: 4

 

Other representations of profile: [CSV](StructureDefinition-profile-devicerequest.csv), [Excel](StructureDefinition-profile-devicerequest.xlsx), [Schematron](StructureDefinition-profile-devicerequest.sch) 

