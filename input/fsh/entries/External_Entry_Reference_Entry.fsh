Profile: External_Entry_Reference_Entry
Parent: EntryReference
Id: External.Entry.Reference.Entry
Title: "ADI External Entry Reference Entry"
Description: """
This entry represents the act of referencing another an external entry not include in this CDA document instance.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft
//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(external-entry-reference, 2.16.840.1.113883.4.823.1.4.2.5, 2026-08-28)

// These are not needed because they are already constrained in CDA-core-sd structureDefinition for ObservationMedia
// * classCode = #ACT (exactly)
// * classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC) (CONF:1198-9024)."
// * moodCode = #EVN (exactly)
// * moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"EVN\" Event (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC) (CONF:1198-9025)."

* id 1..*
* id ^comment = "MUST contain at least one [1..*] id."
* id ^short = "When using a FHIR Collection Bundle for the entries, use the Resource name/Resource id as the id value. For example, 
if the entry is a FHIR Patient resource with id 123, then the id value would be 'Condition/123'."

* reference 1..1
* reference ^comment = "MUST contain exactly one [1..1] reference."
* reference ^short = ""

* reference.typeCode = #REFR (exactly)
* reference.typeCode ^comment = "MUST contain exactly one [1..1] @typeCode=\"REFR\" Reference (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.110 STATIC) (CONF:1198-9026)."

// CDA requires that one of the following be present.
* reference.externalDocument ^comment = "Use externalDocument to reference any FHIR DocumentReference EntryResource or Composition Entry Resource."
* reference.externalObservation ^comment = "Use externalObservation to reference any FHIR Entry Observation Resource."
* reference.externalProcedure ^comment = "Use externalProcedure to reference any FHIR Entry Procedure Resource."
* reference.externalAct ^comment = "Use externalAct to reference any other FHIR Entry Resource."