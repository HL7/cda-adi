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

* value.mediaType 1..1
* value.mediaType = $mediaType#application/pdf

* author MS
* author ^comment = "author.assignedAuthor.representedOrganization.name may include the name of the organization holding the copyright for the form."

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
This entry part includes the info about the jurisdiction for the form.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft

* code.code = $loinc#101349-9

* value 1..*
* value only $CD
* value.code from $States (required)

Profile: Form_Title_Part
Parent: $Observation
Id: Form.Title.Part
Title: "Form Title Part of the ADI Source Form Entry"
Description: """
This entry part includes the form title.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft

* code.code = $loinc#92183-3

* value 1..*
* value only $ED
* value ^short = "The title of the form"