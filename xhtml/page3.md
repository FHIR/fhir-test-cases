# Writing Vital Signs - US Core Implementation Guide v8.0.0

* [**Table of Contents**](toc.md)
* [**Looking Ahead**](looking-ahead.md)
* **Writing Vital Signs**

## Writing Vital Signs

| |
| :--- |
| *Page standards status:*[Informative](http://hl7.org/fhir/R4/versions.html#std-process) |

### Examples

Patient-facing

* A provider creates an order in an EHR for patient home monitoring. Then, the patient's blood pressure cuff sends data to an app on their phone that writes it into their record. The EHR automatically associates the blood pressure data with the appropriate order.
* A patient uses an app to retrieve their vital signs from the EHR, which were recorded during a specialist visit, and they write them to the EHR used by their primary care provider. The provider can review the vital signs within the EHR and incorporate them into the record.

Provider-facing

* A blood pressure cuff sends readings to an app on a practice tablet that a clinical user uses to write the data to a patient's record in the EHR.
* A patient app saves data to a repository controlled by the app developer. Then, the patient uses a "share with provider" function to enable the provider to access this data with an app installed in the provider's EHR. The provider writes some or all of the observations into the patient's record in the EHR.

### Configuration

Servers **SHALL** document support for writing Observation resources in their Capability Statements by including a `CapabilityStatement.rest.resource[type=Observation].interaction` with a `code` of `create`. Servers that support the ability to update Observation resources **SHALL** also include an `interaction` with a `code` of `update`.

### SMART Scopes

#### Patient-facing apps

Servers providing the ability to write FHIR vital sign Observation resources from patient-facing apps **SHALL** support the registration and authorization of apps with the `patient/Observation.c?category=http://terminology.hl7.org/CodeSystem/observation-category|vital-signs` SMART scope or a broader version of this scope such as `patient/Observation.c`. Note that `read` and `search` capabilities are already implied by [US Core Vital Signs profile](http://build.fhir.org/ig/HL7/US-Core/StructureDefinition-us-core-vital-signs.html).

Servers providing the ability to write FHIR vital sign Observation resources from patient-facing apps **SHOULD** also support the registration and authorization of apps with the `patient/Observation.u?category=http://terminology.hl7.org/CodeSystem/observation-category|vital-signs` SMART scope or a broader version of this scope such as `patient/Observation.u`. Note that systems can support only limited [update](#updating-previously-submitted-observations) capabilities.

When offering a patient write capability, health systems may choose to enable or disable this capability based on factors such as the provider, patient, payer, app, and vital type, or may choose to enable the capability broadly. If patients and apps attempting to write data are not enabled, and this can be discerned during the authorization process, the Server **SHALL** omit these unsupported scopes from the resulting access token. If an app uses an access token without the required scopes to submit an `Observation` or the patient is not enabled to write data, the Server **SHALL** return an error and **SHOULD** include an `OperationOutcome` in the response body.

#### Provider-facing apps

Servers providing the ability to write FHIR vital sign Observation resources from provider-facing apps **SHALL** support the registration and authorization of apps with the `user/Observation.c?category=http://terminology.hl7.org/CodeSystem/observation-category|vital-signs` and `system/Observation.c?category=http://terminology.hl7.org/CodeSystem/observation-category|vital-signs` SMART scopes or broader versions of these scopes such as `user/Observation.c` and `system/Observation.c`. Note that `read` and `search` capabilities are already implied by [US Core Vital Signs profile](http://build.fhir.org/ig/HL7/US-Core/StructureDefinition-us-core-vital-signs.html).

Servers providing the ability to write FHIR vital sign Observation resources from provider-facing apps **SHOULD** also support the registration and authorization of apps with either `user/Observation.u?category=http://terminology.hl7.org/CodeSystem/observation-category|vital-signs` and `system/Observation.u?category=http://terminology.hl7.org/CodeSystem/observation-category|vital-signs` SMART scopes, or broader versions of these scopes such as `user/Observation.u` and `system/Observation.u`. Note that systems can support only limited [update](#updating-previously-submitted-observations) capabilities.

#### Configuration

Servers **SHALL** document supported scopes in the `scopes_supported` section of a `.well-known/smart-configuration` [capabilities array](https://build.fhir.org/ig/HL7/smart-app-launch/conformance.html#launch-context-for-standalone-launch).

### Resource Submission

Servers **SHALL** support the submission of Observation resources that **are not** the result of a calculation and validate against a [US Core Vital Sign Profile](https://build.fhir.org/ig/HL7/US-Core/profiles-and-extensions.html#observation) that corresponds to a version used by the Server for vital sign Observation read requests.

Servers **MAY** support the submission of Observation resources that **are** the result of a calculation (such as the "US Core Pediatric BMI for Age Observation Profile") and validate against a [US Core Vital Sign Profile](https://build.fhir.org/ig/HL7/US-Core/profiles-and-extensions.html#observation) that corresponds to a version used by the Server for vital sign Observation read requests.

Servers **SHALL** respond to supported and valid vital sign Observation creation requests with a status code of `200 OK` and a content location header, or with a status code of `202 Accepted`. If a content location header is provided, the resources **SHALL** be visible in subsequent read API calls and accessible within the system in the same manner as other patient-submitted data. If a content location header is not provided, and the Server does not subsequently make the resource accessible in read API calls, the Server **SHALL** have a documented and discoverable reason why it was discarded (e.g., a log entry describing rejection during a review workflow or the applicability of a condition in the "Discarding" section below).

Servers **SHALL** support the creation of a single vital sign through a FHIR `create` operation, and **MAY** support the creation of multiple vital signs by submitting a FHIR `Batch` bundle. When batch creation is supported, Clients **MAY** use this approach to indicate that a set of Observation resources should be reviewed as a group, and systems **MAY** use this information when sending notifications or displaying the data.

Systems may choose to segregate data that originated from a patient from other vital sign data for the patient (for example, showing it on a separate patient flow sheet).

The workflow for submitted Observations is the responsibility of the receiving system and is out of scope for this version of the guide (e.g., requiring provider review for patient-submitted resources before fully integrating them in the chart).

#### Observation Elements

`meta.tag`

* Client - When writing patient-mediated data into the Server, provider-facing apps **SHALL** include a `Meta.tag` with a system of `http://hl7.org/fhir/us/core/CodeSystem/us-core-tags` and a value of `patient-supplied` to indicate that the data was supplied by a patient or patient designee (such as a parent or spouse) rather than by a healthcare provider.
* Server - Systems **SHALL** associate the `patient-supplied` tag with vital signs provided by a patient written through this API, and **MAY** associate the tag with vital signs supplied by a patient regardless of how they arrive in the system. Provider-facing apps writing data supplied by a patient **SHALL** include this tag in the submitted Observation resources. The Server **MAY** subsequently dissociate the tag from the data through an explicit reconciliation process.

An alternate way to tag any patient-generated data would be to use the code "PATAST" in the `meta.security` element of the resource:

> 

| | |
| :--- | :--- |
| PATAST | patient asserted: Security provenance metadata observation value used to indicate that an IT resource (data, information object, service, or system capability. was asserted by a patient.) |


We are seeking feedback from the community on whether this more compact approach from the FHIR standard could be adopted and supported.

`encounter`

* Client - If populating this element, apps **SHALL** use a reference to an Encounter resource in the Server, and **MAY** use the value returned by the `launch/encounter` SMART scope.
* Server - Systems **SHOULD** document whether the `encounter` element is required to create a vital sign. When not required, Servers **MAY** determine this value based on context if it is omitted.

`subject`

* Client - Apps **SHALL** populate the `subject` reference with a reference to a Patient resource in the Server. Patient-facing apps **SHOULD** populate this element based on the value returned as part of the `launch/patient` SMART scope.

`device`

* Client - Apps **MAY** populate the `device` reference with a reference to the Device resource in the Server or a contained Device resource within the Observation. This is the device used to measure the vital sign (e.g., a BP cuff), not the device used to transmit the data (e.g., a phone). Contained device resources **SHALL** populate at least one `deviceName` element.
* Server - When this value is populated with a reference to a Device resource on the Server, Servers **SHALL** return this reference in subsequent reads operations of the resource that was created. When this value is populated with a reference to a valid contained Device resource, Servers **MAY** ignore the contained Device, return the contained Device as part of subsequent read operations, or create a Device resource in the system and return a reference to it in subsequent read operations. Servers **SHALL** not return an error due to the presence of a valid contained Device resource. Servers **SHOULD** document their behavior with regard to contained Device resources.

`performer`

* Client - Apps **SHOULD** populate the `performer` element with a reference to a resource in the Server when the resource exists, or the app can create it. For patient-facing apps, if the app knows that a patient collected this data, the app **SHALL** set the `performer` to a reference to the patient based on the SMART launch context (this should also match the `Observation.subject`). If the relevant resource does not exist and the app cannot create it, the app **SHOULD** populate `performer.display`.
* Server - When this value is populated in a successful create operation, systems **SHALL** return it in subsequent read operations of the resource that was created. Note that `performer` is not currently required in the US Core vital signs profile.

### Discarding Observations

For a given vital sign type, if many Observations are submitted with `effectiveDateTime` or `effectivePeriod` values that are close in time, a Server **MAY** choose to discard a portion of these Observations or **MAY** reject submitted Observations with an appropriate OperationOutcome. Systems **SHALL** clearly document this behavior or the ways in which health systems may customize this behavior in the API documentation.

If a Server determines that a vital sign is a duplicate of one it has already stored, the Server **MAY** ignore the Observation or **MAY** reject the submitted Observation with an appropriate OperationOutcome. Systems **SHALL** clearly document this behavior or the ways in which health systems may customize this behavior in the API documentation.

### Updating Previously Submitted Observations

Servers **SHOULD** support the ability for patients-facing apps to update the `status` element of a vital sign resource the user previously wrote to the system from any app to `entered-in-error` through an `update` interaction. This capability **SHOULD** only be used by apps to address data mistakes in data submission.

### Including Provenance Information

Servers **MAY** ignore contained Provenance resources in an Observation being submitted but **SHALL** not return an error due to their presence.

#### Resource retrieved from an external organization

**Figure 1: Resources retrieved from an external organization**
![](fhir-write1.svg)

When writing an Observation that was retrieved from an external organization (e.g., a health system's EHR or a device manufacturer's cloud data store):

* Apps **SHALL** pass through any Provenance resources received from the source system, unaltered (except for references, as described below), as contained resources on the Observation. A source system compliant with the US Core FHIR profiles **SHOULD** include a Provenance resource with `agent.type = author` that the app can pass through. The app **SHALL** also pass through resources referenced in elements that are labeled as "Must Support" in the USCDI Provenance profile and populated in the Provenance resources, including them as contained resources in the Observation and updating the references to them.
* When a Provenance resource with `agent.type = author` is not received from the source system, apps **SHALL** generate a contained Provenance resource with: 
* `recorded` set to date and time recorded
* `agent.type = author` that has `agent.who` set to the organization/provider that authored the content, with at least the `who.display` element populated. 
* When available, a `who.identifier.value` should be set to the URL where that data was retrieved, and `who.identifier.system` should be set to `urn:ietf:rfc:3986`
 
 
* Apps **MAY** include a Provenance resource with `agent.type = transmitter` with information on the entity that submitted the data. Systems **MAY** store and display this information and **MAY** populate this information based on the SMART context associated with the write.

Example:

```
{
  "resourceType": "Observation",
  "contained": [{
    "resourceType": "Provenance",
    "id": "contained_1",
    "target": [{"reference": "#"}],
    "recorded": "2019-07-09T15:26:23.217+00:00",
    "agent": [{
      "type": {
        "coding": [{
          "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
          "code": "author",
          "display": "Author"
        }]
      },
      "who": {
        "display": "Saint Luke \'s Hospital of Kansas City",
        // identifier could be a URL, as in Patient Access Brands
        "identifier": {
          "system": "urn:ietf:rfc:3986",
          "value": "https://stlukes.example.org"
        }  
      }
    },{
      "type": {
        "coding": [{
          "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
          "code": "transmitter",
          "display": "Transmitter"
        }]
      },
      "who": {
        //this is the user submitting the data
        //can be populated by the EHR based on the SMART context if omitted
        "reference": "Patient/123"
      }
    }]
  }]
  // ... other Observation elements
}

```

#### Resources not retrieved from an external organization

**Figure 2: Resources not retrieved from an external organization**
![](fhir-write2.svg)

When writing an Observation that was not retrieved from an external organization (e.g., transmitted by a home blood pressure cuff or manually entered by a patient):

* Apps **MAY** include a contained Provenance resource with `agent.type = author` containing information on the party that wrote the data. Systems **MAY** store and display this information and **MAY** populate it based on the SMART context associated with the write.
* Apps **MAY** include one or more contained Provenance resources with `agent.type = composer` and `agent.type = assembler` with information on the device, app, or apps that captured or passed along the data.

Example:

```
[{
  "resourceType": "Provenance",
  "target": [{"reference": "#"}],
  "recorded": "2019-07-08",
  "agent": [{
    "type": {
      "coding": [{
        "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
        "code": "composer",
        "display": "Composer"
      }]
    },
    "who": {
      //this is the app that provided the original data
      "display": "OMRON for iOS"
    }
  },{
    "type": {
      "coding": [{
        "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
        "code": "author",
        "display": "Author"
      }]
    },
    "who": {
      "reference": "Patient/123"
    }
  }]
},{
  "resourceType": "Provenance",
  "target": [{"reference": "#"}],
  "recorded": "2019-07-09T10:26:23.217+00:00",
  "agent": [{
    "type": {
      "coding": [{
        "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
        "code": "assembler",
        "display": "Assembler"
      }]
    },
    "who": {
      //this is the app that transmits the data
      "display": "Healthkit" 
    }
  }]
}]

```

