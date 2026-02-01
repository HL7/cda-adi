Profile: Healthcare_Agent_Consent_Entry
Parent: $Act
Id: Healthcare.Agent.Consent.Entry
Title: "ADI Healthcare Agent Consent Entry"
Description: """
This entry includes the person's consent to appoint a Healthcare Agent. It may include powers granted or denied.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft
//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(healthcare-agent-consent, 2.16.840.1.113883.4.823.1.4.2, 2026-08-28)

// These are needed because they are not already constrained in CDA-core-sd structureDefinition for ObservationMedia
* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #EVN (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"EVN\" Event (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

* id 1..*
* id ^comment = "MUST contain at least one [1..*] id."

* code.code = $loinc#81377-4

* text 1..1 
* text ^short = "links to the rendering of the healthcare agent consent"

* statusCode 1..1
//* statusCode = $ActStatusCode#completed

* effectiveTime 1..1

* entryRelationship MS 
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "observation"
* entryRelationship ^slicing.rules = #open
* entryRelationship contains 
    agent-appointment-part  1..3 MS and
    powers-granted-part 0..* MS and
    coded-powers-granted-part 0..* MS and
    powers-denied-part 0..* MS

* entryRelationship[agent-appointment-part].typeCode = #COMP (exactly)
* entryRelationship[agent-appointment-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[agent-appointment-part].inversionInd = false (exactly)
* entryRelationship[agent-appointment-part].observation 1..1
* entryRelationship[agent-appointment-part].observation only Agent_Appointment_Part

* entryRelationship[powers-granted-part].typeCode = #COMP (exactly)
* entryRelationship[powers-granted-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[powers-granted-part].inversionInd = false (exactly)
* entryRelationship[powers-granted-part].observation 1..1 MS 
* entryRelationship[powers-granted-part].observation only Powers_Granted_Part

* entryRelationship[coded-powers-granted-part].typeCode = #COMP (exactly)
* entryRelationship[coded-powers-granted-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[coded-powers-granted-part].inversionInd = false (exactly)
* entryRelationship[coded-powers-granted-part].observation 1..1 MS 
* entryRelationship[coded-powers-granted-part].observation only Coded_Powers_Granted_Part

* entryRelationship[powers-denied-part].typeCode = #COMP (exactly)
* entryRelationship[powers-denied-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[powers-denied-part].inversionInd = false (exactly)
* entryRelationship[powers-denied-part].observation 1..1 MS 
* entryRelationship[powers-denied-part].observation only Powers_Denied_Part


Profile: Agent_Appointment_Part
Parent: $Observation
Id: Agent.Appointment.Part
Title: "Agent Appointment Part of the ADI Healthcare Agent Consent Entry"
Description: """
This entry part includes the info about who was apointed a healthcare agent and their ordinal role.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft

* code.code from $HealthcareAgentProxyChoices (required)

* text ^short = "links to the rendering of a participating Healthcare Agent"

* participant 1..1
//TO DO need a variant to limit this to two codes, one for if confirmed and one for if not confirmed.
* participant.typeCode ^short = "Use NOT for person to be notified"
* participant.participantRole.classCode = $RoleClass#AGNT
* participant.participantRole.code.code from $PersonalAndLegalRelationshipRoleType (extensible)
* participant.participantRole.addr MS
* participant.participantRole.telecom MS

* participant.participantRole.playingEntity 1..1
* participant.participantRole.playingEntity.code MS
* participant.participantRole.playingEntity.code.code from $HealthcareAgentOrdinality (required)
* participant.participantRole.playingEntity.name MS



Profile: Powers_Granted_Part
Parent: $Observation
Id: Powers.Granted.Part
Title: "Powers Granted Part of the ADI Healthcare Agent Consent Entry"
Description: """
This entry part includes powers granted.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft

//TO DO: confirm if we have a better loinc code for Form Title
* code.code = $loinc#75786-4

* text ^short = "links to the rendering of Healthcare Agent powers"

* value 1..*
* value only $ED
* value ^short = "Granted powers"

Profile: Coded_Powers_Granted_Part
Parent: $Observation
Id: Coded.Powers.Granted.Part
Title: "Coded Powers Granted Part of the ADI Healthcare Agent Consent Entry"
Description: """
This entry part includes powers granted which are specific coded concepts.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft

//TO DO: confirm if we have a better loinc code for Form Title
* code.code = $loinc#75786-4

* text ^short = "links to the rendering of a coded Healthcare Agent power"

* value 1..1 
* value only $CD
* value ^short = "Coded power granted"
* value.code from $HealthcareAgentPowers (extensible)

Profile: Powers_Denied_Part
Parent: $Observation
Id: Powers.Denied.Part
Title: "Powers Denied Part of the ADI Healthcare Agent Consent Entry"
Description: """
This entry part includes powers denied.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"
* ^status = #draft

//TO DO: confirm if we have a better loinc code for Form Title
* code.code = $loinc#81346-9

* text ^short = "links to the rendering of Healthcare Agent"

* value 1..*
* value only $ED
* value ^short = "Granted powers"
