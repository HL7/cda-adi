// This is the basic pattern for a Patient authored document.
// It is specifically about patient authored directives.

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
     ahdDocumentClass 1..1 MS and
     pacpDocumentClass 0..1 MS
* sdtcCategory[ahdDocumentClass].code 1..1 MS
* sdtcCategory[ahdDocumentClass].code = $loinc#42348-3
* sdtcCategory[ahdDocumentClass].code ^short = "Used to categorize the document type as an Advance Healthcare Directive"
* sdtcCategory[ahdDocumentClass].codeSystem 1..1 MS
* sdtcCategory[ahdDocumentClass].codeSystem = "2.16.840.1.113883.6.1"
* sdtcCategory[ahdDocumentClass].codeSystemName 1..1 MS
* sdtcCategory[ahdDocumentClass].codeSystemName = "LOINC"
* sdtcCategory[ahdDocumentClass].displayName 1..1 MS
* sdtcCategory[pacpDocumentClass].code 1..1 MS
* sdtcCategory[pacpDocumentClass].code = $loinc#81334-5
* sdtcCategory[pacpDocumentClass].code ^short = "Used to categorize the document type as a Person-Authored Advance Healthcare Directive"
* sdtcCategory[pacpDocumentClass].codeSystem 1..1 MS
* sdtcCategory[pacpDocumentClass].codeSystem = "2.16.840.1.113883.6.1"
* sdtcCategory[pacpDocumentClass].codeSystemName 1..1 MS
* sdtcCategory[pacpDocumentClass].codeSystemName = "LOINC"
* sdtcCategory[pacpDocumentClass].displayName 1..1 MS

* code from $AdvanceDirectiveDocumentTypes (required) 
* code ^short = "Add a description defining PACP document types and how to select the specific type."
* code ^comment = "SHALL contain exactly one [1..1] code."

* sdtcStatusCode 1..1 MS
* sdtcStatusCode ^comment = "sdtc:statusCode is #active is for published templates, #draft is for new templates that have not been published yet."

* effectiveTime ^comment = "recommend to use miliseconds and use the relevant timezone offset from UTC to explicitly state the timezone of the author."

// add setId as 1..1 and comment
//add versionNumber as 1..1 and comment

// learn how to constrain act relationship for documentation of and then ServiceEvent - lesson for another day - or try this on your own
// documentationOf is going to be a slicing exercise.

//section constraints
* component.structuredBody.component MS 
//  
* component.structuredBody.component ^slicing.discriminator[+].type = #profile
* component.structuredBody.component ^slicing.discriminator[=].path = "section"
* component.structuredBody.component ^slicing.rules = #open
* component.structuredBody.component contains 
// includes the entry templates
     active-problems 0..1 MS and 
     allergies 0..1 MS and
     payers 0..1 
// IHE_PCC_Active_Problems_Section is the computable name of the Section template (defined separately)
* component.structuredBody.component[active-problems].section only IHE_PCC_Active_Problems_Section
* component.structuredBody.component[active-problems].section ^comment = "SHALL Contain at least 1..* problem entries Otherwise a Null value SHALL be present"