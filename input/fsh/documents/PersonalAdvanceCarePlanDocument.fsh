// This is the basic pattern for a Patient authored document.
// It is specifically about patient authored directives.
// Be sure to add the HL7 FHIR Shorthand extension to Visual Studio Code for helpful syntax support.

Profile: PersonalAdvanceCarePlanDocument
// This is a Person-Authored document, so Parent template is the PatientGenerated document. Provider-Authored uses USRealm Header.
Parent: USRealmHeaderforPatientGeneratedDocument
Id: PersonalACP
Title: "Personal Advance Care Plan"
Description: """This profile defines the requirements for communicating a Personal Advance Care Plan (ACP) document using a Composition Resource. 

Depending on the range of content included, this type of document is known by different names:
- Durable Medical Power of Attorney - healthcare agent appointment only
- Living Will - treatment preferences only
- Living Will and Durable Medical Power of Attorney
- Advance Care Plan - a combined Living Will and Durable Medical Power of Attorney plus additional content regarding relevant care experience preferences

It is a person-generated document, authored by the subject of the document. If care professionals are involved in the creation of the document, their supporting role in the advance care planning process can be represented in the service event associated with the document. If data entry assistance is provided, the person performing the data entry can be represented in the role of a data enterer. 

Additionally, the system used to assemble the document can be represented as a participant of the document in the role of Assembler. The Custodian organization responsible for maintaining the source copy of the document must be included.

For a person authored document, the person's signature is required. Notarization or witnessing of the document also should be represented because person-authored documents typically are not considered complete without validation for the person's identity and signature.

The document includes a mandatory source form section to hold a pdf of the original “source form” completed by the person. It also includes a healthcare agent appointment section which is mandatory in all types of PACP documents with the exception of a Living Will. If the person elects not to appoint a healthcare agent, the section includes information about the reason why. This section includes machine processable representations of the healthcare agent information and their powers and limitations to facilitate data resusability as the document is shared between systems.

A Personal ACP document may contain additional textual information from the source form that does not have corresponding encoded entries. In this case, the section.text element is populated without corresponding section.entry elements. For minimum required information, the information in the section.text element will include corresponding section.entry elements and will be linked using the test linking mechanism.

Optionally, the document may contain sections for treatment intervention preferences, care experience preferences, additional documentation, administrative information which includes record of the person's signature, and notary or witness information.
"""

// C-CDA uses a RuleSet * insert LogicalModelTemplate(personal-acp, 2.16.840.1.113883.4.823.1.1.1, 2026-08-28  We can't figure out how this works.)
* templateId 3..*
* templateId contains personal-acp 1..1
* templateId [personal-acp].root = "2.16.840.1.113883.4.823.1.1.1"
* templateId [personal-acp].extension = "2026-08-28"

* id ^comment = "This is the master identifier in a DocumentReference document indexing resource." 

//* insert DocumentCategory(Advance Healthcare Directives, 42348-3, Advance healthcare directives)
* sdtcCategory MS 
* sdtcCategory ^slicing.discriminator[+].type = #value
* sdtcCategory ^slicing.discriminator[=].path = "code"
* sdtcCategory ^slicing.discriminator[+].type = #value
* sdtcCategory ^slicing.discriminator[=].path = "codeSystem"
* sdtcCategory ^slicing.rules = #open
* sdtcCategory contains 
     ahdDocumentClass 1..1 and
     pacpDocumentClass 0..1 MS
* sdtcCategory[ahdDocumentClass].code 1..1
* sdtcCategory[ahdDocumentClass].code = $loinc#42348-3
* sdtcCategory[ahdDocumentClass].code ^short = "Used to categorize the document type as an Advance Healthcare Directive"
* sdtcCategory[ahdDocumentClass].codeSystem 1..1
* sdtcCategory[ahdDocumentClass].codeSystem = "2.16.840.1.113883.6.1"
* sdtcCategory[ahdDocumentClass].codeSystemName 1..1
* sdtcCategory[ahdDocumentClass].codeSystemName = "LOINC"
* sdtcCategory[ahdDocumentClass].displayName 1..1
* sdtcCategory[pacpDocumentClass].code 1..1
* sdtcCategory[pacpDocumentClass].code = $loinc#81334-5
* sdtcCategory[pacpDocumentClass].code ^short = "Used to categorize the document type as a Person Authored Advance Healthcare Directive"
* sdtcCategory[pacpDocumentClass].codeSystem 1..1
* sdtcCategory[pacpDocumentClass].codeSystem = "2.16.840.1.113883.6.1"
* sdtcCategory[pacpDocumentClass].codeSystemName 1..1
* sdtcCategory[pacpDocumentClass].codeSystemName = "LOINC"
* sdtcCategory[pacpDocumentClass].displayName 1..1

* code from $AdvanceDirectiveDocumentTypes (required) 
* code ^short = """
This profile is used to represent a person authored advance healthcare directive document. A person authored advance healthcare directive document is categorized as a personal advance care plan (Personal ACP) document. This sub-category of advance healthcare directive documents expresses the patient’s own preferences as opposed to provider authored advance healthcare directive documents which establish portable medical orders for the patient. 
This sub-category of advance healthcare directive document always is authored by the subject of the document (the patient). If care providers are involved in the creation of these types of documents, they may be included as facilitators. The patient (or their representative) is required to sign the document and is represented as an authenticator. Others who sign the document are represented as authenticators with their role such as witness or notary also included.
It includes a presentation of the completed source form of the completed document. It also includes information about the person’s appointed healthcare agent(s), treatment intervention and care experience preferences under potential future health scenarios, as well as administrative and completion information, additional documentation, and witness and notary information if required for the form to be considered valid. 
The document always contains the source form in the Source Form section. It may include other textual information organized in standard structural sections which may or may not include machine processable encoded entries. 
"""
* code ^comment = "SHALL contain exactly one [1..1] code."

* sdtcStatusCode 1..1
* sdtcStatusCode ^comment = "sdtc:statusCode is #completed is for documents where all activities required for a valid document have been completed, #new is for new documents that have not been published yet."

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
     source-form 1..1 and 
     administrative-information 0..1 and
     healthcare-agent-appointment 1..1 and
     care-experience-preferences 0..1 and
     treatment-intervention-preferences 0..1 and
     upon-death-preferences 0..1 and
     witness-and-notary 0..1 and
     completion-information 0..1 and
     additional-documentation 0..1

// Source_Form_Section is the computable name of the Section template (defined separately)
// What should be documented in the comment? use the conformance verbs to make your expectation clearer.
* component.structuredBody.component[source-form].section only Source_Form_Section
* component.structuredBody.component[source-form].section ^short = "Original form image for rendering"
* component.structuredBody.component[source-form].section ^comment = "SHALL contain only one 1..1 Source Form ObservationMedia Entry."

* component.structuredBody.component[administrative-information].section only Administrative_Information_Section
* component.structuredBody.component[administrative-information].section ^short = "Information collected for administrative reasons"
* component.structuredBody.component[administrative-information].section ^comment = "SHOULD contain 0..* Advance Healthcare Directive Observation Entry."

* component.structuredBody.component[healthcare-agent-appointment].section only Healthcare_Agent_Appointment_Section
* component.structuredBody.component[healthcare-agent-appointment].section ^short = "Consent information that appoints healthcare agents"
* component.structuredBody.component[healthcare-agent-appointment].section ^comment = "SHALL Contain only one 1..1 Healthcare Agent Consent Entry. This entry includes options for expressing why no healthcare agent(s) were appointed."

* component.structuredBody.component[care-experience-preferences].section only Care_Experience_Preferences_Section
* component.structuredBody.component[care-experience-preferences].section ^short = "Person's conditional care experience preferences"
* component.structuredBody.component[care-experience-preferences].section ^comment = "SHOULD contain 0..* Care Experience Preference Entry."

* component.structuredBody.component[treatment-intervention-preferences].section only Treatment_Intervention_Preferences_Section
* component.structuredBody.component[treatment-intervention-preferences].section ^short = "Persion's conditional treatment intervention preferences"
* component.structuredBody.component[treatment-intervention-preferences].section ^comment = "SHOULD contain 0..* Treatment Intervention Preference Entry"

* component.structuredBody.component[source-form].section only Upon_Death_Preferences_Section
* component.structuredBody.component[source-form].section ^short = "Person's preferences if they should pass away--burial arrangements, actions to be taken after their death, etc."
* component.structuredBody.component[source-form].section ^comment = "SHOULD contain 0..* Care Experience Preference Entry where the precondition is death."

* component.structuredBody.component[source-form].section only Witness_And_Notary_Section
* component.structuredBody.component[source-form].section ^short = "Person's signature and Information about Witnesses or Notary required to complete a valid document"
* component.structuredBody.component[source-form].section ^comment = "SHOULD contain 0..* Esignature ObservationMedia Entry where the id references the associated authenticator in the header."

* component.structuredBody.component[source-form].section only Completion_Information_Section
* component.structuredBody.component[source-form].section ^short = "Requirements to complete a valid document"
* component.structuredBody.component[source-form].section ^comment = "SHOULD contain 0..* Clause Observation Entry. SHOULD contain 0..1 Esignature ObservationMedia Entry where the id references the associated authenticator in the header."

* component.structuredBody.component[source-form].section only Additional_documentation_Section
* component.structuredBody.component[source-form].section ^short = "Information about additional relevant advance healthcare directive documents and where they can be accessed"
* component.structuredBody.component[source-form].section ^comment = "SHOULD contain 0..* Advance Healthcare Directive Observation Entry."