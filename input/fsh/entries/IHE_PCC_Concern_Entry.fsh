Profile: IHE_PCC_Concern_Entry
Parent: $Act
Id: IHE.PCC.Concern.Entry
Title: "IHE Concern Entry"
Description: """
This event (moodCode='EVN') represents an act (<act classCode='ACT') of being concerned about a problem, allergy or other issue. The <effectiveTime> element describes the period of concern. The subject of concern is one or more observations about related problems (see 1.3.6.1.4.1.19376.1.5.3.1.4.5.2) or allergies and intolerances (see 1.3.6.1.4.1.19376.1.5.3.1.4.5.3). Additional references can be provided having additional information related to the concern. The concern entry allows related acts to be grouped. This4415 allows representing the history of a problem as a series of observation over time, for example.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft
//* obeys should-text-ref-value and should-author
* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC) (CONF:1198-9024)."
* moodCode = #EVN (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"EVN\" Event (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC) (CONF:1198-9025)."
* templateId 2..* MS 
* templateId ^slicing.discriminator[+].type = #value
* templateId ^slicing.discriminator[=].path = "root"
* templateId ^slicing.discriminator[+].type = #value
* templateId ^slicing.discriminator[=].path = "extension"
* templateId ^slicing.rules = #open
* templateId contains 
    problem 0..1 MS and 
    allergies-and-intolerances 0..1 MS and 
    ihe-concern-entry 1..1 
* templateId[problem].root 1..1
* templateId[problem].root = "2.16.840.1.113883.10.20.1.27"
* templateId[allergies-and-intolerances].root 1..1
* templateId[allergies-and-intolerances].root = "1.3.6.1.4.1.19376.1.5.3.1.4.6"
* templateId[ihe-concern-entry].root 1..1
* templateId[ihe-concern-entry].root = "1.3.6.1.4.1.19376.1.5.3.1.4.5.1"
* id 1..* MS 
* id ^comment = "MUST contain at least one [1..*] id (CONF:1198-9026)."
* code MS 
* code ^comment = "SHALL contain exactly one [1..1] code (CONF:1198-9027)."
* code.nullFlavor 1..1 
* code.nullFlavor = #NA