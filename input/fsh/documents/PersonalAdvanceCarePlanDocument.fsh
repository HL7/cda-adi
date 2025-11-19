// This is the basic pattern for a Patient authored document.
// It is specifically about patient authored directives.

Profile: PersonalAdvanceCarePlanDocument
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

* insert LogicalModelTemplate(personal-acp, 2.16.840.1.113883.4.823.1.1.1, 2026-08-28)
* insert DocumentCategory(Advance Healthcare Directives, 42348-3, Advance healthcare directives)

// note: status = #active is for published templates, #draft is for new templates that have not been published yet.
* ^status = #active
//* code from $AdvanceDirectiveDocumentTypes (required) 
//  * ^short = "The Discharge Summary recommends use of a single document type code, 18842-5 \"Discharge summary\", with further specification provided by author or performer, setting, or specialty. When pre-coordinated codes are used, any coded values describing the author or performer of the service act or the practice setting must be consistent with the LOINC document type."
//  * ^comment = "SHALL contain exactly one [1..1] code (CONF:1198-17178)."