// This is the basic pattern for a provider authored document.
// It is specifically about directives that are created as a portable medical order
// which can travel with the patient across care settings.

Profile: POLSTPortableMedicalOrdersDocument
Parent: USRealmHeader
Id: PortableMedicalOrderDocument
Title: "Portable Medical Order"
Description: """This profile defines the requirements for communicating a practitioner-authored portable medical order (PMO) advance healthcare directive document using a Composition Resource. Different states may call this type of document by a number of different names:

- MOLST (Medical Orders for Life Sustaining Treatment)
- POLST (Physician Orders for Life Sustaining Treatment)
- MOST (Medical Orders for Scope of Treatment)
- POST (Physician Orders for Scope of Treatment)
- TPOPP (Transportable Physician Orders for Patient Preferences)
- Out-of-hospital Do Not Resuscitate (DNR) Orders
- DNAR (Do Not Attempt Resuscitation) or AND (Allow Natural Death) Orders

It is a practitioner-generated document, authored by a practitioner with necessary credentials established for the document within its jurisdiction of use. If other care professionals are involved in the creation of the document, their supporting role in the advance care planning process can be represented in the service event associated with the document. If data entry assistance is provided, the person performing the data entry can be represented in the role of a data enterer. However, only the authoring practitioner signs the document as the legal authenticator. The signature of the person/patient who is the subject of the document also is required. If the subject is unable to sign the document, a person who is permitted to sign on their behalf may sign in place of the subject.

Additionally, the system used to assemble the document can be represented as a participant of the document in the role of Assembler. The Custodian organization responsible for maintaining the source copy of the document must be included.

The document includes a mandatory source form section to hold a pdf of the original “source form” showing the PMO completed by the practitioner and patient. It also includes a mandatory Medical Orders section. This section includes machine processable representations of–at a minimum- the directive regarding cardiopulmonary resuscitation. Other directives such as initial treatment and other types of orders may also be included to facilitate data resusability as the document is shared between systems. However, the source form remains the “source of truth” providing the full range of relevant orders. 

A PMO document may contain additional textual information from the source form that does not have corresponding encoded entries. In this case, the section.text element is populated without corresponding section.entry elements. For minimum required information, the information in the section.text element will include corresponding section.entry elements and will be linked using the test linking mechanism.

Optionally, the document may contain sections for form completion information which includes the necessary signature information, administrative information, additional documentation, upon death information, healthcare agent appointment, and notary and witness information.
"""

// C-CDA uses a RuleSet * insert LogicalModelTemplate(polst-pmo, 2.16.840.1.113883.9.275.1, 2026-08-28)
// ANDREA: Why templateId 3..*?
* templateId 3..*
* templateId contains pmo 1..1
* templateId[pmo].root = "2.16.840.1.113883.9.275.1"
* templateId[pmo].extension = "2026-08-28"

//* insert DocumentCategory(Advance Healthcare Directives, 42348-3, Advance healthcare directives)
* sdtcCategory MS 
* sdtcCategory ^slicing.discriminator[+].type = #value
* sdtcCategory ^slicing.discriminator[=].path = "code"
* sdtcCategory ^slicing.discriminator[+].type = #value
* sdtcCategory ^slicing.discriminator[=].path = "codeSystem"
* sdtcCategory ^slicing.rules = #open
* sdtcCategory contains 
     ahdDocumentClass 1..1 MS and
     pmoDocumentClass 0..1 MS
* sdtcCategory[ahdDocumentClass].code 1..1
* sdtcCategory[ahdDocumentClass].code = $loinc#42348-3
* sdtcCategory[ahdDocumentClass].code ^short = "Used to categorize the document type as an Advance Healthcare Directive"
* sdtcCategory[ahdDocumentClass].codeSystem 1..1
* sdtcCategory[ahdDocumentClass].codeSystem = "2.16.840.1.113883.6.1"
* sdtcCategory[ahdDocumentClass].codeSystemName 1..1
* sdtcCategory[ahdDocumentClass].codeSystemName = "LOINC"
* sdtcCategory[ahdDocumentClass].displayName 1..1
* sdtcCategory[pmoDocumentClass].code 1..1
* sdtcCategory[pmoDocumentClass].code = $loinc#93037-0
* sdtcCategory[pmoDocumentClass].code ^short = "Used to categorize the document type as a Provider-Authored Portable Medical Order Advance Healthcare Directive"
* sdtcCategory[pmoDocumentClass].codeSystem 1..1
* sdtcCategory[pmoDocumentClass].codeSystem = "2.16.840.1.113883.6.1"
* sdtcCategory[pmoDocumentClass].codeSystemName 1..1
* sdtcCategory[pmoDocumentClass].codeSystemName = "LOINC"
* sdtcCategory[pmoDocumentClass].displayName 1..1

// $PortableMedicalOrderDocumentTypes

* code from $PortableMedicalOrderDocumentTypes (required) 
* code ^short = """
This profile is used to represent a provider-authored advance healthcare directive document. A provider-authored advance healthcare directive document establishes portable medical orders for the patient. 
This sub-category of advance healthcare directive documents always is authored by a licensed physician and is represented as the legal authenticator. If other care providers are involved in the creation of these types of documents, they may be included 
as facilitators. The patient (or their representative) is required to sign the document and is represented as an authenticator (attester). Others who sign the document are represented as authenticators with their role 
such as witness or notary also included.
It includes a presentation of the original source form of the completed document. It includes information about the portable medical orders, and may additionally include administrative and completion information, 
additional documentation, and witness and notary information if required for the form to be considered valid. 
The document always contains the source form in the Source Form section. It may include textual information present in the source form, organized in standard structural sections which 
may or may not include machine processable encoded entries.
"""
* code ^comment = "SHALL contain exactly one [1..1] code."

* sdtcStatusCode 1..1
* sdtcStatusCode ^comment = "sdtc:statusCode is #completed is for documents where all activities required for a valid document have been completed, #new is for new documents or document versions that have not been completed yet."

* effectiveTime ^short = "The system origination time"
* effectiveTime ^comment = "Use miliseconds and the relevant timezone offset from UTC to explicitly state the timezone of the document's author and to support federated document management."

// add setId as 1..1 and comment
* setId 1..1
* setId ^short = "Identifier a single logical document"
* setId ^comment = "Identifies all versions of a single logical document"
//add versionNumber as 1..1 and comment
* versionNumber 1..1
* versionNumber ^short = "The distinct version of a logical document"
* versionNumber ^comment = "Used in conjunction with setId to identify a distinct version of a logical document"

// ANDREA: Let's discuss where to move this to, and how to create some examples.
// learn how to constrain act relationship for documentation of and then ServiceEvent - lesson for another day - or try this on your own
// documentationOf is going to be a slicing exercise.

//section constraints
* component.structuredBody.component MS 
//  How do I read this syntax? Each slice is distinguished by the profile used for the section.
* component.structuredBody.component ^slicing.discriminator[+].type = #profile
* component.structuredBody.component ^slicing.discriminator[=].path = "section"
* component.structuredBody.component ^slicing.rules = #open
* component.structuredBody.component contains 
// This is the section level constraints within the document body.
// It uses cardinality for SHALL 1..1,  SHOULD 0..1 MS, and  MAY 0..1   always put "and" at the end until the last one.
// ANDREA - what was the rule on when to use MS and when not to?
     source-form 1..1 MS and 
     planned-procedures-pmo 0..1 MS and
     upon-death-preferences 0..1 MS and
     healthcare-agent-appointment 0..1 MS and
     additional-documentation 0..1 MS and
     administrative-information 0..1 MS and
     completion-information 0..1 MS and
     witness-and-notary 0..1 MS
     
// Source_Form_Section is the computable name of the Section template (defined separately)
// What should be documented in the comment? use the conformance verbs to make your expectation clearer.
* component.structuredBody.component[source-form].section only Source_Form_Section
* component.structuredBody.component[source-form].section ^short = "Original form image for rendering"
* component.structuredBody.component[source-form].section ^comment = "SHALL contain only one 1..1 Source Form ObservationMedia Entry."

* component.structuredBody.component[healthcare-agent-appointment].section only Planned_Procedures_PMO_Section
* component.structuredBody.component[healthcare-agent-appointment].section ^short = "Portable medical orders"
//ANDREA - need to discuss SHOULD 0..1. Is it your understanding this will limit the number of occurences to no more than 1? 
* component.structuredBody.component[healthcare-agent-appointment].section ^comment = "SHOULD contain 0..* ADI Portable Medial Order Entry."

* component.structuredBody.component[source-form].section only Upon_Death_Preferences_Section
* component.structuredBody.component[source-form].section ^short = "Person's preferences if they should pass away--burial arrangements, actions to be taken after their death, etc."
* component.structuredBody.component[source-form].section ^comment = "SHOULD contain 0..* Care Experience Preference Entry where the precondition is death."

* component.structuredBody.component[healthcare-agent-appointment].section only Healthcare_Agent_Appointment_Section
* component.structuredBody.component[healthcare-agent-appointment].section ^short = "Consent information that appoints healthcare agents"
//ANDREA - need to discuss SHOULD 0..1. Is it your understanding this will limit the number of occurences to no more than 1? 
* component.structuredBody.component[healthcare-agent-appointment].section ^comment = "SHOULD contain 0..1 Healthcare Agent Consent Entry. This entry includes options for expressing why no healthcare agent(s) were appointed."

* component.structuredBody.component[source-form].section only Additional_Documentation_Section
* component.structuredBody.component[source-form].section ^short = "Information about additional relevant advance healthcare directive documents and where they can be accessed"
* component.structuredBody.component[source-form].section ^comment = "SHOULD contain 0..* Advance Healthcare Directive Observation Entry."

* component.structuredBody.component[administrative-information].section only Administrative_Information_Section
* component.structuredBody.component[administrative-information].section ^short = "Information collected for administrative reasons"
* component.structuredBody.component[administrative-information].section ^comment = "SHOULD contain 0..* Advance Healthcare Directive Observation Entry."

* component.structuredBody.component[source-form].section only Completion_Information_Section
* component.structuredBody.component[source-form].section ^short = "Requirements to complete a valid document"
* component.structuredBody.component[source-form].section ^comment = "SHOULD contain 0..* Clause Observation Entry. SHOULD contain 0..1 Esignature ObservationMedia Entry where the id references the associated authenticator in the header."

* component.structuredBody.component[source-form].section only Witness_And_Notary_Section
* component.structuredBody.component[source-form].section ^short = "Person's signature and Information about Witnesses or Notary required to complete a valid document"
* component.structuredBody.component[source-form].section ^comment = "SHOULD contain 0..* Esignature ObservationMedia Entry where the id references the associated authenticator in the header."

