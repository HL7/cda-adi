Profile: Source_Form_Entry
Parent: $ObservationMedia
Id: Source.Form.Entry
Title: "ADI Source Form Entry"
Description: """
This entry includes the Source Form document and info about the jurisdiction for the form.
If the form is copyrighted by an organization, the organization's name may be included in an author participation.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft
//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(source-form, 2.16.840.1.113883.4.823.1.4.24, 2026-08-28)

// These are not needed because they are already constrained in CDA-core-sd structureDefinition for ObservationMedia
// * classCode = #ACT (exactly)
// * classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC) (CONF:1198-9024)."
// * moodCode = #EVN (exactly)
// * moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"EVN\" Event (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC) (CONF:1198-9025)."

* id 1..*
* id ^comment = "MUST contain at least one [1..*] id."

// These are not needed because they are already constrained in CDA-core-sd structureDefinition for ObservationMedia
// They are included here for clarity and to provide additional documentation for implementers.
// Also note the ClinicalDocument.effectiveTime should be set to the same date as the effectiveTime/low in this clinical statement pattern.
// ClinicalDocument.effectiveTime may also include a time component, but this should include the timezone offset for the time. 
* effectiveTime 1..1
* effectiveTime ^comment = "SHALL contain exactly one [1..1] effectiveTime."
* effectiveTime ^short = "The date the form was completed and expiration date if applicable."
* effectiveTime.low 1..1 MS
* effectiveTime.low ^short = "The date and time this version of the form was completed."
* effectiveTime.low pattern = "yyyyMMdd"
* effectiveTime.high 0..1
* effectiveTime.high ^short = "The datethe form is set to expire."
* effectiveTime.high ^comment = "SHALL contain at most one [0..1] high. If present, the high SHALL be greater than the low."
* effectiveTime.high ^pattern = "yyyyMMdd"

* value.mediaType 1..1
* value.mediaType = $mediaType#application/pdf

* entryRelationship MS 
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "observation"
* entryRelationship ^slicing.rules = #open
* entryRelationship contains 
    jurisdiction-part  0..1 MS and
    form-title-part 0..1 MS

* entryRelationship[jurisdiction-part].typeCode = #COMP (exactly)
* entryRelationship[jurisdiction-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[jurisdiction-part].inversionInd = false (exactly)
* entryRelationship[jurisdiction-part].observation 1..1
* entryRelationship[jurisdiction-part].observation only Jurisdiction_Part

* entryRelationship[form-title-part].typeCode = #COMP (exactly)
* entryRelationship[form-title-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[form-title-part].inversionInd = false (exactly)
* entryRelationship[form-title-part].observation 1..1 MS 
* entryRelationship[form-title-part].observation only Form_Title_Part


Profile: Jurisdiction_Part
Parent: $Observation
Id: Jurisdiction.Part
Title: "Jurisdiction Part of the ADI Source Form Entry"
Description: """
Sub-part of the ADI Source Form Entry. This entry part includes the info about the jurisdiction for the form.
This entry is not intended to be used as a complete clinical statement entry on its own.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft

* insert LogicalModelTemplate(jurisdiction-part, 2.16.840.1.113883.4.823.1.4.24.1, 2026-08-28)
* insert NarrativeLink

* code.code = $loinc#101349-9

* value 1..*
* value only $CD
* value.code from $States (required)

Profile: Form_Title_Part
Parent: $Observation
Id: Form.Title.Part
Title: "Form Title Part of the ADI Source Form Entry"
Description: """
Sub-part of the ADI Source Form Entry. This entry part includes the form title and optional copyright information.
This entry is not intended to be used as a complete clinical statement entry on its own.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft

* insert LogicalModelTemplate(form-title-part, 2.16.840.1.113883.4.823.1.4.24.2, 2026-08-28)
* insert NarrativeLink

* code.code = $loinc#92183-3

* value 1..*
* value only $ED
* value ^short = "The title of the form"

//* Need to add the author constraints for the Copyright date and holder name.
* author 0..1 MS
* author ^comment = "author.assignedAuthor.representedOrganization.name may include the name of the organization holding the copyright for the form."
* author.time 0..1 MS
* author.time ^short = "The date of the copyright for the form"
* author.assignedAuthor.representedOrganization.name 0..1 MS
* author.assignedAuthor.representedOrganization.name ^short = "The name of the organization holding the copyright for the form"