# Foundational Requirements - Da Vinci - Coverage Requirements Discovery v2.2.0-ballot

* [**Table of Contents**](toc.md)
* **Foundational Requirements**

## Foundational Requirements

| |
| :--- |
| *Page standards status:*[Trial-use](http://hl7.org/fhir/R4/versions.html#std-process) |

This foundational page defines general context, considerations, and core requirements that apply to use of this implementation guide, regardless of which portions of the IG are implemented. It includes base conformance expectations, security and privacy rules, etc.

The requirements and expectations described here are not intended to be exhaustive. The purpose of this implementation guide is to establish a baseline of expected behavior that communication partners can rely on and then build upon. Future versions of this specification will evolve based on implementer feedback. Therefore, CRD servers and CRD clients **MAY** mutually agree to support additional hooks, additional card patterns, additional resources, additional extensions, etc. not found in this specification. Although CRD servers and CRD clients are not required to support any capabilities defined beyond this specification, the intent is to support innovations that extend the specification in a manner that allows payers and providers to adopt those extensions in a mutually agreeable way.

### Pre-reading

Before reading this formal specification, implementers are encouraged to first familiarize themselves with some of the key background portions of this implementation guide:

* The [Reading this IG](background.md) page, which provides guidance for those who may be new to FHIR, reading FHIR IGs, or understanding some of the other key technologies used in this guide.
* The [Use Cases](usecases.md) page, which provides context for what this formal specification is trying to accomplish and will give a sense of both the business context and general process flow enabled by the formal specification below.
* The [Burden Reduction](burden.md) page, which provides information about how this guide works together with other Da Vinci guides in the burden reduction space.

### Performance

Depending on their location within the workflow, CDS Hooks may be processed in a synchronous manner. This means that the user who is performing the business action that triggers the hook might be blocked from continuing the action until cards have been returned by the CDS service. For example, a CRD client might not allow progress of an 'order sign' business action until the decision support has been returned from all order-sign services and the user has had a chance to interact with any cards they deem relevant. The corollary to this is that services must respond to hook invocations quickly to avoid impeding clinician workflow - and turning the intended benefit of CRD into a detriment.

This specification sets a target duration in which CRD services are expected to return their CDS Hooks response after being invoked. CRD services **SHALL** return responses for all supported hooks and **SHALL** respond within the required time 90% of the time. (That is, all [primary](hooks.md#hook-categories) hooks and any [supporting](hooks.md#hook-categories) hooks where they opt to support the hook.) For most hooks, this target time is 5 seconds. It extends to 10 seconds for [Appointment Book](hooks.md#appointment-book) and for [Order Dispatch](hooks.md#order-dispatch) and [Order Sign](hooks.md#order-sign) hooks that are sent at least 24 hours after the last hook invocation for the same order(s) because there is no opportunity to cache data in those cases.

The authors of this IG acknowledge that this may limit the payer from providing full responses to all calls where a response is theoretically possible. Systems should provide the best information they can in a timely fashion and rely on other layers of the payment and adjudication process to catch issues that require longer processing. For example, if a system is able to provide a response on eligibility within the time window, but not on whether prior authorization is needed, it can return cards indicating the service is covered, but that DTR is needed (to determine prior authorization requirements). Where a payer responds with a coverage information extension indicating `doc-needed` of 'clinical', 'admin', or 'patient' and the payer supports DTR, they **SHOULD** support gathering the additional information via DTR. This expectation is intended to change to **SHALL** in a future release.

The expectation of CRD is that CRD services **SHOULD** query all data necessary to make their coverage determination decisions if that data is available for query in the EHR and that data is not returned in prefetch. Coverage determination decisions are whether the service is covered, whether prior authorization is required, and whether additional information needs to be gathered. It is not acceptable for a CRD service to rely exclusively on DTR as a mechanism to retrieve data. DTR is for data retrieval that requires human intervention or review. There may be circumstances where time constraints prevent all needed data from being retrieved, in which case DTR retrieval of data that would not typically need human review may be necessary. However, this should never be the design objective. This query requirement may be tightened to 'SHALL' in a future release.

CRD services are encouraged to leverage hooks fired earlier in the workflow (even if they do not provide decision support in response to those hooks) as an opportunity to begin caching relevant information for use when providing responses to later hooks. For example, when an 'Encounter Start' hook fires, the CRD service can retrieve and cache the patient's current coverage information and details about their specific plans, limits, etc. When an 'Order Select' fires, the service can cache information about coverage and authorization rules associated with the ordered service. Potentially relevant information such as past labs, prior therapies, or relevant diagnoses can also be retrieved from the EHR. As a result, when an 'Order Sign' or 'Order Dispatch' hook fires, the CRD service should have almost all information needed to render an immediate decision, allowing response times to be met much more easily.

A determination that additional information is needed (e.g., via DTR) is considered to be a valid response. Where a payer responds with a coverage information `doc-needed` code of 'clinical', 'admin', or 'patient' and the payer supports DTR, they **SHOULD** support gathering the additional information via DTR. This expectation is intended to change to **SHALL** in a future release.

CRD clients **SHALL** provide a mechanism for providers to bypass a CRD process that is taking longer than the aforementioned time limit to ensure users are not blocked from proceeding with their business flow. Where a CRD client opts to not block users from proceeding for responses that come back in a period of time shorter than the target time window in this guide (i.e., 5s or 10s), the client must ensure that users are made aware of the information when it is available. For responses that come back in a time period that exceeds this duration, CRD clients **MAY** ignore the resulting cards and/or system actions.

> Payers and healthcare IT system vendors are both encouraged to provide feedback around whether this timing expectation strikes the appropriate balance between allowing appropriate decision support and allowing timely progress of workflow. This evaluation should consider what systems will need to be involved in the decision support process, what external calls might be needed, what caching strategies are viable, etc. 

### Accuracy

CDS services **SHALL** ensure that the guidance returned with respect to coverage and prior authorizations (e.g., assertions that a service is covered, or prior authorization is not necessary) is as accurate as guidance that would be provided by other means (e.g., portals, phone calls). Also, such guidance should allow for possible variances in coding and submission. (See [Impact on payer processes](implementation.md#impact-on-payer-processes) on the Implementation Considerations page.)

### Terminology

When invoking CDS Hooks, resources reflecting the clinical/business representation of the order, appointment, encounter, etc. will be transmitted to the CRD server. These data representations will generally make use of codes to describe the type of service or product being ordered, booked, or performed. These codes will draw from the code systems used at this stage of the business process and will typically be clinical codes rather than billing codes. That said, it is always possible to send multiple codings within a CodeableConcept. Where the selected code is not already a billing code and CRD clients are able to automatically determine what the corresponding billing code is, they **SHOULD** send a Coding with the billing code alongside the clinical code to reduce the risk of the receiving payer making a different translation.

### Appropriate use of hooks

CDS Hooks are intended to improve healthcare provider care-planning processes by allowing relevant and useful information to be inserted into provider workflows. At the same time, inserting additional information into a provider's workflow will add cognitive load, even if the information is not acted upon, and therefore must be done judiciously.

Payers and service providers **SHALL** ensure that CDS Hooks return only messages and information relevant and useful to the intended recipient.

### CRD Servers

Payers may have multiple back-end functions that handle different types of decision support and/or different types of services. If a payer supports [endpoint discovery](http://hl7.org/fhir/us/davinci-hrex/STU1.1/endpoint-discovery.html), they **SHALL** have at most a single endpoint for each coverage (e.g., Medicare, Medicaid, or commercial) they provide coverage under. In FHIR, a coverage instance essentially corresponds with the identification information on an insurance card, irrespective of the types of coverage available under that card. If a payer does not support endpoint discovery, they **SHALL** expose only one CRD endpoint capable of handling all coverages. All CRD requests for patient coverage, irrespective of type of service, will be sent to a single endpoint. CRD servers are free to route the information from their endpoint(s) to back-end services as needed. This routing may evolve over time and should have no impact on CRD client calls.

Initial setup of connectivity between client and payer will have a manual component to establish security credentials and a trust relationship (unless both parties are part of a shared trust network). Dynamic endpoint discovery allows for the potential for the use of different endpoints for different coverages and/or evolution of what endpoints are used for different coverage over time without changing security credential or legal agreement expectations.

In the early stages of CRD adoption, CRD clients and services are likely to manually coordinate the rollout of new features. However, the long-term goal is that, through QHINs or other trust networks, and/or certification, manual coordination will not be necessary.

When the connection between a particular client and server has evolved to an automated configuration approach, CRD Clients **SHOULD** perform the discovery process on the CRD server at least once per day to detect any changes to supported hooks, prefetch requirements, and/or configuration options. A, if a CRD client encounters an error when invoking a hook, they **SHOULD** re-run the discovery process before failing. NOTE: Changes to CRD server capabilities will not necessarily be taken advantage of dynamically by the CRD client - i.e. manual steps might be necessary.

### Enabling a CRD Server

When a CRD client configures itself to support a payer's CRD service, it will need to identify which payer(s) the service supports. This is needed to ensure that the CRD client only sends CRD calls to services that the patient has current coverage for. The CRD service is responsible for any internal routing based on which processing organization handles the decisions. For this purpose, 'payer' means the organization listed on the member's insurance card.

Provider and EHR vendor organizations **MAY** leverage the [payer registry](http://hl7.org/fhir/us/davinci-pdex-plan-net) developed by PDex (which will eventually fold into the [national directory under FAST](https://confluence.hl7.org/display/FAST/National+Healthcare+Directory)) as a means of determining which endpoints exist for which payers as candidates for configuration. Once plans are in the national directory, CRD clients **SHOULD** include that plan identifier to uniquely identify that plan.

All CRD clients will need to be configured to support communicating with a particular CRD server. This configuration process includes the following:

* Confirming that the CRD server can legitimately act on behalf of one or more payers
* Confirming that the CRD server can be trusted to receive and handle PHI
* Determining which hook(s) to enable for that CRD server
* Determining what scopes to provide the CRD server for access tokens issued to the service

To initiate this process, the payer responsible for a given CRD server must communicate with the relevant CRD client software vendor or provider organization and share the following information:

* The URL of their server
* Which hook types it supports
* What scopes it needs to perform its full function (and why)

### CRD Access Tokens

When a CRD client invokes a CRD server via CDS Hooks, it **SHALL** provide an access token that allows the CRD server to retrieve additional patient information. The base rules for this token are defined in the [CDS Hooks specification](http://cds-hooks.hl7.org/STU2/index.html#passing-the-access-token-to-the-cds-service). This specification imposes some additional constraints:

* The CRD client **SHALL** limit the scopes provided in their access token as narrowly as feasible to reflect the data requirements identified by the CRD service as necessary to perform their decision support.
* Such access tokens **SHOULD** have an expiration time of no longer than 30 seconds which should be sufficient for even 'parallel' decision support with something like 'Order Select' where a user continues to work while the decision support call is processing.

### Additional Data Retrieval

The context information provided as part of hook invocation will often not be enough for a CRD server to fully determine coverage requirements. This section of the guide describes a common set of queries that define data that most, if not all, CRD servers will need to perform their requirements assessment.  

For this release of the IG, conformant CRD clients **SHOULD** support the CDS Hooks [prefetch](http://cds-hooks.hl7.org/STU2/index.html#prefetch-template) capability and be able to perform all the prefetch queries defined perform all the queries defined in the [prefetch](#prefetch) section below. Where prefetch is not supported, CRD clients **SHOULD** implement interfaces to [_include](http://hl7.org/fhir/R4/search.html#include) resources not available in the system's database. That is, if some of the data is stored in a separate system, it should ideally still be retrievable via `_include` in queries executed against the client. Each payer will define the prefetch requests for their CRD server based on the information they require to provide coverage requirements. They **MAY** include more and/or less than described in this section. Prefetch requests **SHOULD** only include information that is always expected to be needed for each hook invocation. When information is only needed for certain invocations of the hook (e.g., for specific types of medications or services), that information **SHALL** only be retrieved by query using the provided token, never requested universally via prefetch. Not all CRD clients will support all prefetch requests.

> In future releases of this specification, the requirements in this section might become a **SHALL**. Implementers are encouraged to provide feedback about this possibility based on their initial implementation experience.

The base requirement for these queries, whether based on Encounter or one of the request resources, is to bring back the following associated resources:

* Patient
* Relevant Coverage
* Authoring Practitioner
* Authoring Organization
* Requested performing Practitioner (if specified)
* Requested performing Organization (if specified)
* Requested Location (if specified)
* Associated Medication (if any)
* Associated Device (if any)

Not all these will be relevant for all resource types. Different resources have differently named data elements and search parameters for them. In some cases, support only exists as extensions or does not exist at all. Where necessary, this implementation guide defines additional extensions to support retrieval of these elements. The intention is for both extensions and search parameters to eventually migrate into the core FHIR specification.

There are two possible mechanisms that can be used by the service to gather the information needed: prefetch and querying the CRD client to retrieve additional resources. Both mechanisms are defined as part of the [CDS Hooks specification](http://cds-hooks.hl7.org/STU2/index.html#providing-fhir-resources-to-a-cds-service). In some cases, a mixture of both approaches might be necessary.

#### Prefetch

Prefetch is an optional capability of CDS Hooks that allows the client to perform certain query functions on behalf of the CRD server and provide the results in the initial hook invocation. This allows the client to optimize query performance and can simplify functionality for the CRD server.

If a CRD server supports prefetch, it **SHALL** be able to parse prefetches that use the x-fhir-query syntax defined in the current CDS Hooks specification and not fail if that syntax is present. Systems **SHOULD** be able to execute such prefetch queries, but **MAY** choose to only execute queries that use the legacy CDS Hooks query syntax and ignore those using the newer x-fhir-query capabilities for now.

CRD client implementations **SHOULD NOT** expect standardized prefetch key names. CRD clients supporting prefetch **SHALL** inspect the CDS Hooks discovery endpoint to determine exact prefetch key names and queries.

In most cases, payers will require information about a patient's coverage. As mentioned in [Controlling Hook Invocation](deviations.md#controlling-hook-invocation), whether returned as part of prefetch or returned via query, Coverage **SHALL** be limited to a single instance. How this happens is up to the CRD client. The limitation of there only being one coverage applies regardless of whether the Coverage instance is being returned as part of prefetch or if Coverage is being searched using the token provided as part of hook invocation. Regardless of method of invocation, there **SHALL** be exactly one Coverage instance returned.

Coverage prefetch will look like this:

A recommended set of prefetch expectations for all hook types can be found [here](Binary-CRDServices.md).

Other information will need to be retrieved using queries that are more specific to the type of hook being invoked and the resources passed with it.  The table below lists the queries to retrieve common key information for each type of context resource if not using prefetch.  Note that the queries use `draftOrders` as the context, which will hold for order-select and order-sign hooks, but will need to be `dispatchedOrders` for order-dispatch hooks.  

The queries below make use of _include to reduce the overall number of queries that need to be performed. However, not all CRD clients will support _include at all or will support all _include search parameters leveraged in these examples. CRD services that choose to take advantage of _include will need to adapt their queries based on the support declared in the CRD client's CapabilityStatement.

| | | |
| :--- | :--- | :--- |
| Appointment | `Appointment?_id={{context.appointments.entry.resource.id}} &_include=Appointment:patient &_include=Appointment:practitioner &_include=Appointment:location &_include=Appointment:based-on:ServiceRequest &_include:iterate=PractitionerRole:organization &_include:iterate=PractitionerRole:practitioner &_include:iterate=PractitionerRole:location &_include:iterate=ServiceRequest:performer &_include:iterate=ServiceRequest:requester Coverage?patient={{context.patient}}` | Location only through performer |
| CommunicationRequest | `CommunicationRequest?_id={{context.draftOrders.entry.resource.ofType(CommunicationRequest).id}} &_include=CommunicationRequest:patient &_include=CommunicationRequest:recipient &_include=CommunicationRequest:requester &_include=CommunicationRequest:sender &_include:iterate=PractitionerRole:organization &_include:iterate=PractitionerRole:practitioner &_include:iterate=PractitionerRole:location Coverage?patient={{context.patient}}` | Location only through performer |
| DeviceRequest | `DeviceRequest?_id={{context.draftOrders.entry.resource.ofType(DeviceRequest).id}} &_include=DeviceRequest:patient &_include=DeviceRequest:performer &_include=DeviceRequest:requester &_include=DeviceRequest:device &_include:iterate=PractitionerRole:organization &_include:iterate=PractitionerRole:practitioner &_include:iterate=PractitionerRole:location Coverage?patient={{context.patient}}` | Location only through performer |
| Encounter | `Encounter?_id={{context.encounterId}} &_include=Encounter:patient &_include=Encounter:service-provider† &_include=Encounter:practitioner &_include=Encounter:location &_include:iterate=PractitionerRole:organization &_include:iterate=PractitionerRole:practitioner &_include:iterate=PractitionerRole:location Coverage?patient={{context.patient}}` | No requester |
| MedicationRequest | `MedicationRequest?_id={{context.draftOrders.entry.resource.ofType(MedicationRequest).id}} &_include=MedicationRequest:patient &_include=MedicationRequest:intended-dispenser &_include=MedicationRequest:requester:PractitionerRole &_include=MedicationRequest:medication &_include:iterate=PractitionerRole:organization &_include:iterate=PractitionerRole:practitioner &_include:iterate=PractitionerRole:location Coverage?patient={{context.patient}}` | Location only through performer |
| NutritionOrder | `NutritionOrder?_id={{context.draftOrders.entry.resource.ofType(NutritionOrder).id}} &_include=NutritionOrder:patient &_include=NutritionOrder:provider &_include=NutritionOrder:requester &_include=NutritionOrder:encounter &_include:iterate=PractitionerRole:organization &_include:iterate=PractitionerRole:practitioner &_include:iterate=PractitionerRole:location &_include:iterate=Encounter:location Coverage?patient={{context.patient}}` | Location only through request encounter |
| ServiceRequest | `ServiceRequest?_id={{context.draftOrders.entry.resource.ofType(ServiceRequest).id}} &_include=ServiceRequest:patient &_include=ServiceRequest:performer &_include=ServiceRequest:requester &_include:iterate=PractitionerRole:organization &_include:iterate=PractitionerRole:practitioner &_include:iterate=PractitionerRole:location Coverage?patient={{context.patient}}` | Location only through performer |
| VisionPrescription | `VisionPrescription?_id={{context.draftOrders.entry.resource.ofType(VisionPrescription).id}} &_include=VisionPrescription:patient &_include=VisionPrescription:prescriber &_include:iterate=PractitionerRole:organization &_include:iterate=PractitionerRole:practitioner &_include:iterate=PractitionerRole:location Coverage?patient={{context.patient}}` | Location only through performer |

 † The service-provider search type is only relevant if the CRD client supports the 'serviceProvider' element, which is not 'mustSupport'. 

#### FHIR Resource Access

If information needed is not provided by prefetch, the CRD server can query the client directly using the [FHIR resource access](http://cds-hooks.hl7.org/STU2/index.html#fhir-resource-access) mechanism defined in the CDS Hooks specification.

This can be done either by using individual queries or by invoking a batch of separate queries. In either case, the HTTP call that performs the query or executes the batch must pass the `fhirAuthorization.access_token` in the authorization header as defined in the [CDS Hooks specification](http://cds-hooks.hl7.org/STU2/index.html#fhir-resource-access). (Note that if the CRD client does not support _include, it may be necessary to perform separate queries in sequence to retrieve related resources.)

The following two examples show a batch query that could retrieve all CRD-relevant resources as well as the structure of the corresponding batch response.

**Query Batch Request**
 This query presumes that an `order-sign` hook has been invoked, and the following information has been passed in as context:

* The patient identifier 123
* The encounter identifier 987
* Two ServiceRequests with different PractitionerRole performers (ABC and DEF)

Note: This query also presumes that all this information would be relevant to the CRD server in the decisions it needed to make. In practice, the service would only query the information needed to determine coverage requirements. Also, the service will only be able to query data where the scopes made available in the `fhirAuthorization.scope` permit the desired queries.

The Batch bundle uses a mixture of read and search operations to retrieve the relevant resources.

**Query Batch Response**
 The response is a batch response Bundle, with each entry containing either a single resource (in response to a read) or a search response Bundle with the results of the previous search. Each entry in the response bundle corresponds to the GET entry in the request Bundle.

#### Error Handling

The use of an HTTP 412 response to the CDS Hooks invocation is for situations where the requested prefetch was not provided and the CRD service was unable to invoke the queries itself. It **SHALL NOT** to be used in situations where the prefetch was provided or the query was successfully performed but the record in question did not have all the data the payer might have needed/desired. Indicating additional information through DTR is the preferred approach when managing situations where the needed information isn't queryable from the EHR. Similarly, HTTP 4xx or 5xx responses are only appropriate if there was an internal failure of the service, not if the payer business rules for "needed data" were not met. Error codes indicate that there is a technical issue that should be fixed.

New versions of CDS Hooks may introduce additional data elements into any of the CRD request and response structures. In addition, CDS Hooks allows the definition of arbitrary extension elements in several locations within its data structures. It is possible that some parties to a CRD exchange may migrate to a newer CDS Hooks version and/or include extensions intended for use by other consumers and that there may therefore be elements present in an instance that are unexpected. CRD clients and servers **SHALL** ignore unexpected elements when processing instances.

#### Query Notes

*  

Conformant CRD clients
**SHOULD**be able to perform all of the queries defined in the [prefetch](#prefetch) section above and, where needed,
**SHOULD**implement interfaces to
[_include](http://hl7.org/fhir/R4/search.html#include)resources not available in the client's database.

 
*  

Executing queries using the _include mechanism will bring back some redundant information such as information that was already known to the CRD client and included in the request. Examples of this redundant information include returning the original request, returning Encounter and Appointment resources found in the hook contexts, and returning Patient, Practitioner, Organization, and Coverage resources that are common for different request types for the order-sign hook. This redundancy is the cost of using the _include mechanism. Payers seeking greater efficiency can perform direct queries that are more tuned at the cost of needing to make multiple service calls.

 
* Queries use the defined search parameter names from the respective FHIR specification versions. If parties processing these queries have varied from these standard search parameter names (as indicated by navigating their CapabilityStatements), the CRD server will be responsible for translating the parameters into the CRD client's local names. For example, if a particular CRD client's CapabilityStatement indicates that the parameter name (that corresponds to HL7's Encounter search criteria) is named 'visit' on the client's server, the service will have to construct its search URL accordingly.
* When full prefetch as defined here is not supported, CRD clients **SHOULD**, at minimum, support the batch query syntax shown [above](#fhir-resource-access). CRD servers **MAY** choose to support the batch query mechanism, perform client-specific queries as necessary, or return no results when a client does not support its prefetch requirements.
* While these queries attempt to bring back all the potentially relevant information, not all information will necessarily exist for all requests or events, particularly at the time the hook is called. CRD servers **SHALL** provide what coverage requirements they can based on the information available.
* When processing data from query responses, always check the 'self' link to ensure that the server executed what was requested and processed the data as necessary - or try querying by a different mechanism (e.g. multiple queries rather than relying on `_include`).

### SMART on FHIR Hook Invocation

In addition to the real-time decision support provided by CDS Hooks, providers will sometimes need to seek coverage requirements information without invoking the workflow of their provider system to actively create an order, appointment, encounter, etc. A few real-world examples where hooks may be invoked this way include exploring a "what if" scenario, answering a patient question related to whether a service would be covered, and retrieving a guidance document they had seen in a previous card.

The solution to this need to perform coverage discovery at any time is the use of a SMART on FHIR app. Many CRD clients already support SMART on FHIR. That standard allows independently developed applications to be launched from within the CRD client (possibly within the user interface) and to interact with its data. Clients may choose to use SMART on FHIR apps to invoke coverage requirements discovery from CRD servers for "what if" scenarios, using a CRD client's existing SMART on FHIR interface. Alternatively, they can develop such functionality internally.

CRD clients conforming with this specification **SHALL** support the SMART on FHIR interface, **SHALL** allow launching of SMART apps from within their application, and **SHALL** be capable of providing the SMART app access to information it exposes to CRD servers using the CDS Hooks interface.

NOTES:

* The use of SMART to explore "what if" scenarios is distinct from the use of SMART envisioned in CDS Hooks: 
* Rather than launching a SMART app based on a returned card, a SMART app is used here to invoke a CDS hook to artificially simulate a workflow in the CRD client that would normally trigger a hook.
* When a SMART app is launched, draft orders within a CRD client will not typically be available to the app to submit to the CRD server. Information for consideration in the "what if" scenario will need to be entered into the app directly.
* When a CRD server returns cards, any instructions associated with the cards will be displayed in the app, but it may not be able to execute the instructions within the cards.
 
* Exploration of "what if" scenarios using the app is intended to work for all the hooks. This might be accomplished using separate SMART apps for different types of orders or processes (e.g., distinct what if apps for ordering drugs, ordering labs, doing referrals, scheduling appointments) or a single SMART app that prompts the user to identify the scenario they are interested in exploring prior to invoking the hook.
* The app/CRD client **MAY** choose to use configuration options to control what types of calls are available.

In the specific case of order-based hooks, "what if" **SHOULD** use the Order Sign hook but **SHALL** use the configuration option that prevents the return of an unsolicited determination and **MAY** use configuration options to prevent the return of other irrelevant types of cards (e.g., duplicate therapy).

### Additional Considerations

1. When CRD clients pass resources to a CRD server as part of context, the resources **SHALL** have an ID and that ID **SHALL** be usable as a target for references in resources manipulated by CDS Hooks actions and/or by SMART apps. This does not mean that the IDs passed to CRD server must persist, but rather that the CRD client must handle adjustments to any references made to them (or provide necessary redirects) ensuring that any references made to the in-memory resource will remain valid. This also means that CRD clients will need to support the creation or updating of resources that include references to resources that might, at the time, only exist in memory and not yet be available as persistent entities.
1. The receipt of coverage requirements (be it "no requirements" or specific requirements or recommendations) has financial implications for both healthcare providers and payers. If a provider receives a message of "no requirements" and subsequently has a claim denied because of unmet requirements, it will be necessary for both sides to be able to confirm whether a "no requirements" response was sent and what information was in the hook invocation that led to that response. Therefore, in addition to any logging performed for security purposes, both CRD clients and CRD servers **SHALL** retain logs of all CRD-related hook invocations and their responses for access in the event of a dispute. Systems can use the `suggestion.uuid` element to aid in log reconciliation. Organizations **SHALL** have processes to ensure logs can be accessed by appropriate authorized users to help resolve discrepancies or issues in a timely manner.

NOTE: Because the information in these logs will often contain PHI, access to the logs themselves will need to be restricted and logged for security purposes.
1. CRD clients that invoke CDS hooks multiple times during the creation, editing, and review phase are responsible for managing the resulting cards and determining what to display to the user. CRD clients **SHOULD** ensure that multiple cards with the same advice are handled in a way that will not create a burden on the user.
1. Most implementation guides provide JSON, XML, and Turtle representations of artifacts. However, because this guide is primarily using CDS Hooks (which only supports JSON) and SMART on FHIR (which primarily uses JSON), this implementation guide only publishes the JSON version of artifacts.
1. The examples in this guide use whitespace for readability. Conformant systems **SHOULD** omit non-significant whitespace for performance reasons.
1. Examples provided within this specification strive to be realistic but might not reflect accurate/current coverage requirements.

