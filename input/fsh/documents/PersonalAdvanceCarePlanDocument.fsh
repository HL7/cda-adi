// This is the basic pattern for a Patient authored document.
// It is specifically about patient authored directives.

Profile: PersonalAdvanceCarePlanDocument
Parent: USRealmHeaderforPatientGeneratedDocument
Id: PersonalACP
Title: "Personal Advance Care Plan"
Description: """This template encompasses information that makes up the author's advance care information plan.

This template defines the requirements for communicating a Personal Advance Care Plan (Personal ACP) using a CDA document. It is used to create a person-generated 
document which is authored by the subject of the document (the patient/person). It includes a healthcare agent appointment. It also contains information about the person's goals, preferences, and priorities (GPPs) for 
care and treatment under certain potential future conditions.

It is possible for a Personal ACP document to only contain textual information and not have any encoded entries. Implementers may populate the section.text 
element without populating any corresponding section.entry elements.

For a Person-authored document, the author always is the subject."""

* insert LogicalModelTemplate(personal-acp, 2.16.840.1.113883.4.823.1.1.1, 2026-08-28)
* insert DocumentCategory(Advance Healthcare Directives, 42348-3, Advance healthcare directives)

// note: status = #active is for published templates, #draft is for new templates that have not been published yet.
* ^status = #active
//* code from $AdvanceDirectiveDocumentTypes (required) 
//  * ^short = "The Discharge Summary recommends use of a single document type code, 18842-5 \"Discharge summary\", with further specification provided by author or performer, setting, or specialty. When pre-coordinated codes are used, any coded values describing the author or performer of the service act or the practice setting must be consistent with the LOINC document type."
//  * ^comment = "SHALL contain exactly one [1..1] code (CONF:1198-17178)."