Profile: Cardiopulmonary_Resuscitation_Order_Entry
Parent: $Act
Id: CardiopulmonaryResuscitationOrderEntry
Title: "Cardiopulmonary Resuscitation Order Entry"
Description: """
This entry is an act in moodCode RQO. In FHIR this expresses a ServiceRequest with an intent of a directive. 
It includes a CPR procedure (in moodCode RQO) for the person as a portable medical order. 
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(cardio-resuscitation-order, 2.16.840.1.113883.9.275.3.1, 2026-08-28)

// These are needed because they are not already constrained in CDA-core-sd structureDefinition for ObservationMedia
* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

* id 1..*
* id ^comment = "MUST contain at least one [1..*] id."

* code.code = $loinc#100822-6

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

* statusCode 1..1
* statusCode.code = $ActStatusCode#active

// ANDREA - can I say this in a constraint?
// This is the time when the order is placed.
* effectiveTime 1..1
* effectiveTime ^short = "Time when the order is placed."

* entryRelationship MS 
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "observation"
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "act"
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "procedure"
* entryRelationship ^slicing.rules = #open
* entryRelationship contains 
    order-detail-part 1..1 and
    planned-procedure-part 0..1 MS and
    clinical-instruction-part 0..* MS and
    goal-part 0..* MS

* entryRelationship[order-detail-part].typeCode = #COMP (exactly)
* entryRelationship[order-detail-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[order-detail-part].inversionInd = false (exactly)
* entryRelationship[order-detail-part].act 1..1
* entryRelationship[order-detail-part].act only CPR_Order_Detail_Part
* entryRelationship[order-detail-part].act ^comment = "If needed, the identifier for the order detail part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[planned-procedure-part].typeCode = #COMP (exactly)
* entryRelationship[planned-procedure-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[planned-procedure-part].inversionInd = false (exactly)
* entryRelationship[planned-procedure-part].procedure 1..1 MS 
* entryRelationship[planned-procedure-part].procedure only CPR_Planned_Procedure_Part
* entryRelationship[planned-procedure-part].procedure ^comment = "If needed, the identifier for the procedure part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[clinical-instruction-part].typeCode = #COMP (exactly)
* entryRelationship[clinical-instruction-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[clinical-instruction-part].inversionInd = false (exactly)
* entryRelationship[clinical-instruction-part].observation 1..1 MS 
* entryRelationship[clinical-instruction-part].observation only InstructionObservation
* entryRelationship[clinical-instruction-part].observation ^comment = "If needed, the identifier for the instruction part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[goal-part].typeCode = #COMP (exactly)
* entryRelationship[goal-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[goal-part].inversionInd = false (exactly)
* entryRelationship[goal-part].observation 1..1 MS 
* entryRelationship[goal-part].observation only GoalObservation
* entryRelationship[goal-part].observation ^comment = "If needed, the identifier for the goal part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* precondition 0..1 MS
* precondition ^short = "Expresses the precondition in an order that is conditional upon a certain health scenario."

Profile: CPR_Order_Detail_Part
Parent: $Act
Id: CPROrderDetailPart
Title: "CPR Order Detail"
Description: """
This entry is an act in moodCode RQO. In FHIR this expresses the ServiceRequest.orderDetail. 
For a CPR order, there can be only one order detail.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(cpr-order-detail-part, 2.16.840.1.113883.9.275.3.1.1, 2026-08-28)

* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

* id ^comment = """
Entry parts don't really need to be separately identified.
If needed, the identifier for the order detail part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct.
"""

* code.code from $CardiopulmonaryResuscitationOrderOptions (required)

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

* statusCode 1..1
* statusCode.code = $ActStatusCode#active


Profile: CPR_Planned_Procedure_Part
Parent: PlannedProcedure
Id: CPRPlannedProcedurePart
Title: "CPR Procedure Information"
Description: """
This entry is an procedure in moodCode RQO. In FHIR this expresses the ServiceRequest.code. 
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(cpr-planned-procedure-part, 2.16.840.1.113883.9.275.3.1.2, 2026-08-28)

// Remove becuase this constraint already is specified in the parent template.
//* classCode = #PROC (exactly)
//* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

// * id 1..* Remove becuase this constraint already is specified in the parent template.
* id ^comment = """
MUST contain at least one [1..*] id.
If needed, the identifier for the procedure part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct.
"""

* code.code from $CardiopulmonaryResuscitationOrderProcedures (extensible)

* negationInd MS
* negationInd ^comment = """
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

// this constraint is in the parent template. * statusCode.code = $ActStatusCode#active, so it doesn't need to be repeated


// *****************************************************************************************************************
// Start of templates for Initial Treatment Order
// *****************************************************************************************************************
Profile: Initial_Treatment_Order_Entry
Parent: $Act
Id: InitialTreatmentOrderEntry
Title: "Initial Treatment Order Entry"
Description: """
This entry is an act in moodCode RQO. In FHIR this expresses a ServiceRequest with an intent of a directive. 
Each entry includes only a single procedures (with moodCode RQO) for the person as a portable medical order. 
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(initial-treatment-order, 2.16.840.1.113883.9.275.3.2, 2026-08-28)

// These are needed because they are not already constrained in CDA-core-sd structureDefinition for ObservationMedia
* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

* id 1..*
* id ^comment = "MUST contain at least one [1..*] id."

* code.code = $loinc#100823-4

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

* statusCode 1..1
* statusCode.code = $ActStatusCode#active

// This is the time when the order is placed. It should be a TS or may be IVL with effectiveTime.low populated and no effectiveTime.high.
* effectiveTime 1..1

// Design note:  We could have permitted multiple procedures to be expressed in this entry because negationInd is destinct for each procedure
// However, that could not be accomplished in a single entry in FHIR, so we opted to design the CDA template to match the limitation in FHIR.
// In FHIR, the do not perform element is not bound with the code, so it is all or nothing for all coded procedures.
* entryRelationship MS 
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "observation"
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "act"
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "procedure"
* entryRelationship ^slicing.rules = #open
* entryRelationship contains 
    order-detail-part 1..1 and
    planned-procedure-part 0..1 MS and
    clinical-instruction-part 0..* MS and
    goal-part 0..* MS

* entryRelationship[order-detail-part].typeCode = #COMP (exactly)
* entryRelationship[order-detail-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[order-detail-part].inversionInd = false (exactly)
* entryRelationship[order-detail-part].act 1..1
* entryRelationship[order-detail-part].act only Initial_Treatment_Order_Detail_Part
* entryRelationship[order-detail-part].act ^comment = "If needed, the identifier for the order detail part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[planned-procedure-part].typeCode = #COMP (exactly)
* entryRelationship[planned-procedure-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[planned-procedure-part].inversionInd = false (exactly)
* entryRelationship[planned-procedure-part].procedure 1..1 MS 
* entryRelationship[planned-procedure-part].procedure only Initial_Treatment_Planned_Procedure_Part
* entryRelationship[planned-procedure-part].procedure ^comment = "If needed, the identifier for the procedure part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[clinical-instruction-part].typeCode = #COMP (exactly)
* entryRelationship[clinical-instruction-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[clinical-instruction-part].inversionInd = false (exactly)
* entryRelationship[clinical-instruction-part].observation 1..1 MS 
* entryRelationship[clinical-instruction-part].observation only InstructionObservation
* entryRelationship[clinical-instruction-part].observation ^comment = "If needed, the identifier for the instruction part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[goal-part].typeCode = #COMP (exactly)
* entryRelationship[goal-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[goal-part].inversionInd = false (exactly)
* entryRelationship[goal-part].observation 1..1 MS 
* entryRelationship[goal-part].observation only GoalObservation
* entryRelationship[goal-part].observation ^comment = "If needed, the identifier for the goal part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* precondition 0..1 MS
* precondition ^short = "Expresses the precondition in an order that is conditional upon a certain health scenario."


Profile: Initial_Treatment_Order_Detail_Part
Parent: $Act
Id: InitialTreatmentOrderDetailPart
Title: "Initial Treatment Order Detail"
Description: """
This entry is an act in moodCode RQO. In FHIR this expresses the ServiceRequest.orderDetail. 
For a CPR order, there can be only one order detail.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(initial-treatment-order-detail-part, 2.16.840.1.113883.9.275.3.2.1, 2026-08-28)

* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

* id ^comment = """
Entry parts don't really need to be separately identified.
If needed, the identifier for the order detail part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct.
"""

* code.code from $InitialTreatmentPortableMedicalOrderOptions (extensible)

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

* statusCode 1..1
* statusCode.code = $ActStatusCode#active


Profile: Initial_Treatment_Planned_Procedure_Part
Parent: PlannedProcedure
Id: InitialTreatmentPlannedProcedurePart
Title: "Initial Treatment Procedure Information"
Description: """
This entry is an procedure in moodCode RQO. In FHIR this expresses the ServiceRequest.code. 
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(initial-treatment-planned-procedure-part, 2.16.840.1.113883.9.275.3.2.2, 2026-08-28)

// Remove becuase this constraint already is specified in the parent template.
//* classCode = #PROC (exactly)
//* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

// * id 1..* Remove becuase this constraint already is specified in the parent template.
* id ^comment = """
MUST contain at least one [1..*] id.
If needed, the identifier for the procedure part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct.
"""

* code.code from $AdditionalPortableMedicalOrderProcedures (extensible)

* negationInd MS
* negationInd ^comment = """
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

// this constraint is in the parent template. * statusCode.code = $ActStatusCode#active

// This effectiveTime is used to express a trial period.
* effectiveTime 0..1
* effectiveTime ^short = "Represents the trial period duration, if a trial period is specified."

// *****************************************************************************************************************
// Start of templates for Additional Orders
// *****************************************************************************************************************
Profile: Additional_Order_Entry
Parent: $Act
Id: AdditionalOrderEntry
Title: "Additional Order Entry"
Description: """
This entry is an act in moodCode RQO. In FHIR this expresses a ServiceRequest with an intent of a directive. 
Each entry includes only a single procedures (with moodCode RQO) for the person as a portable medical order. 
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(additional-order, 2.16.840.1.113883.9.275.3.3, 2026-08-28)

// These are needed because they are not already constrained in CDA-core-sd structureDefinition for ObservationMedia
* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

* id 1..*
* id ^comment = "MUST contain at least one [1..*] id."

* code.code = $loinc#100824-2

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

* statusCode 1..1
* statusCode.code = $ActStatusCode#active

// This is the time when the order is placed. It should be a TS or may be IVL with effectiveTime.low populated and no effectiveTime.high.
* effectiveTime 1..1

// Design note:  We could have permitted multiple procedures to be expressed in this entry because negationInd is destinct for each procedure
// However, that could not be accomplished in a single entry in FHIR, so we opted to design the CDA template to match the limitation in FHIR.
// In FHIR, the do not perform element is not bound with the code, so it is all or nothing for all coded procedures.
* entryRelationship MS 
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "observation"
//* entryRelationship ^slicing.discriminator[+].type = #profile
//* entryRelationship ^slicing.discriminator[=].path = "act"
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "procedure"
* entryRelationship ^slicing.rules = #open
//  Remove this because there is no order detail part.  order-detail-part 1..1 and   
* entryRelationship contains 
    planned-procedure-part 0..1 MS and
    clinical-instruction-part 0..* MS and
    goal-part 0..* MS

* entryRelationship[planned-procedure-part].typeCode = #COMP (exactly)
* entryRelationship[planned-procedure-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[planned-procedure-part].inversionInd = false (exactly)
* entryRelationship[planned-procedure-part].procedure 1..1 MS 
* entryRelationship[planned-procedure-part].procedure only Additional_Order_Planned_Procedure_Part
* entryRelationship[planned-procedure-part].procedure ^comment = "If needed, the identifier for the procedure part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[clinical-instruction-part].typeCode = #COMP (exactly)
* entryRelationship[clinical-instruction-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[clinical-instruction-part].inversionInd = false (exactly)
* entryRelationship[clinical-instruction-part].observation 1..1 MS 
* entryRelationship[clinical-instruction-part].observation only InstructionObservation
* entryRelationship[clinical-instruction-part].observation ^comment = "If needed, the identifier for the instruction part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[goal-part].typeCode = #COMP (exactly)
* entryRelationship[goal-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[goal-part].inversionInd = false (exactly)
* entryRelationship[goal-part].observation 1..1 MS 
* entryRelationship[goal-part].observation only GoalObservation
* entryRelationship[goal-part].observation ^comment = "If needed, the identifier for the goal part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* precondition 0..1 MS
* precondition ^short = "Expresses the precondition in an order that is conditional upon a certain health scenario."

Profile: Additional_Order_Planned_Procedure_Part
Parent: PlannedProcedure
Id: AdditionalOrderPlannedProcedurePart
Title: "Additional Order Procedure Information"
Description: """
This entry is a procedure in moodCode RQO. In FHIR this expresses the ServiceRequest.code. 
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(additional-order-planned-procedure-part, 2.16.840.1.113883.9.275.3.3.2, 2026-08-28)

// Remove becuase this constraint already is specified in the parent template.
//* classCode = #PROC (exactly)
//* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

// * id 1..* Remove becuase this constraint already is specified in the parent template.
* id ^comment = """
MUST contain at least one [1..*] id.
If needed, the identifier for the procedure part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct.
"""

* code.code from $AdditionalPortableMedicalOrderProcedures (extensible)

* negationInd MS
* negationInd ^comment = """
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

// this constraint is in the parent template. * statusCode.code = $ActStatusCode#active

// This effectiveTime is used to express a trial period.
* effectiveTime 0..1
* effectiveTime ^short = "Represents the trial period duration, if a trial period is specified."


// *****************************************************************************************************************
// Start of templates for Medically Assisted Nutrition Order
// *****************************************************************************************************************
Profile: Medically_Assisted_Nutrition_Order_Entry
Parent: $Act
Id: MedicallyAssistedNutritionOrderEntry
Title: "Medically Assisted Nutrition Order Entry"
Description: """
This entry is an act in moodCode RQO. In FHIR this expresses a ServiceRequest with an intent of a directive. 
Each entry includes only a single procedures (with moodCode RQO) for the person as a portable medical order. 
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(nutrition-order, 2.16.840.1.113883.9.275.3.4, 2026-08-28)

// These are needed because they are not already constrained in CDA-core-sd structureDefinition for ObservationMedia
* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

* id 1..*
* id ^comment = "MUST contain at least one [1..*] id."

* code.code = $loinc#100825-9

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

* statusCode 1..1
* statusCode.code = $ActStatusCode#active

// This is the time when the order is placed. It should be a TS or may be IVL with effectiveTime.low populated and no effectiveTime.high.
* effectiveTime 1..1

// Design note:  We could have permitted multiple procedures to be expressed in this entry because negationInd is destinct for each procedure
// However, that could not be accomplished in a single entry in FHIR, so we opted to design the CDA template to match the limitation in FHIR.
// In FHIR, the do not perform element is not bound with the code, so it is all or nothing for all coded procedures.
* entryRelationship MS 
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "observation"
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "act"
* entryRelationship ^slicing.discriminator[+].type = #profile
* entryRelationship ^slicing.discriminator[=].path = "procedure"
* entryRelationship ^slicing.rules = #open
* entryRelationship contains 
    order-detail-part 1..1 and
    planned-procedure-part 0..1 MS and
    clinical-instruction-part 0..* MS and
    goal-part 0..* MS

* entryRelationship[order-detail-part].typeCode = #COMP (exactly)
* entryRelationship[order-detail-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[order-detail-part].inversionInd = false (exactly)
* entryRelationship[order-detail-part].act 1..1
* entryRelationship[order-detail-part].act only Medically_Assisted_Nutrition_Order_Detail_Part
* entryRelationship[order-detail-part].act ^comment = "If needed, the identifier for the order detail part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[planned-procedure-part].typeCode = #COMP (exactly)
* entryRelationship[planned-procedure-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[planned-procedure-part].inversionInd = false (exactly)
* entryRelationship[planned-procedure-part].procedure 1..1 MS 
* entryRelationship[planned-procedure-part].procedure only Medically_Assisted_Nutrition_Planned_Procedure_Part
* entryRelationship[planned-procedure-part].procedure ^comment = "If needed, the identifier for the procedure part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[clinical-instruction-part].typeCode = #COMP (exactly)
* entryRelationship[clinical-instruction-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[clinical-instruction-part].inversionInd = false (exactly)
* entryRelationship[clinical-instruction-part].observation 1..1 MS 
* entryRelationship[clinical-instruction-part].observation only InstructionObservation
* entryRelationship[clinical-instruction-part].observation ^comment = "If needed, the identifier for the instruction part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* entryRelationship[goal-part].typeCode = #COMP (exactly)
* entryRelationship[goal-part].typeCode ^comment = "SHALL contain exactly one [1..1] @typeCode=\"COMP\" Refers to (CodeSystem: HL7ActRelationshipType urn:oid:2.16.840.1.113883.5.1002)."
* entryRelationship[goal-part].inversionInd = false (exactly)
* entryRelationship[goal-part].observation 1..1 MS 
* entryRelationship[goal-part].observation only GoalObservation
* entryRelationship[goal-part].observation ^comment = "If needed, the identifier for the goal part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct."

* precondition 0..1 MS
* precondition ^short = "Expresses the precondition in an order that is conditional upon a certain health scenario."

Profile: Medically_Assisted_Nutrition_Order_Detail_Part
Parent: $Act
Id: MedicallyAssistedNutritionOrderDetailPart
Title: "Medically Assisted Nutrition Order Detail"
Description: """
This entry is an act in moodCode RQO. In FHIR this expresses the ServiceRequest.orderDetail. 
For a CPR order, there can be only one order detail.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(medically-assisted-nutrition-order-detail-part, 2.16.840.1.113883.9.275.3.4.1, 2026-08-28)

* classCode = #ACT (exactly)
* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

* id ^comment = """
Entry parts don't really need to be separately identified.
If needed, the identifier for the order detail part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct.
"""

* code.code from $MedicallyAssistedNutritionOrderOptions (extensible)

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

* statusCode 1..1
* statusCode.code = $ActStatusCode#active


Profile: Medically_Assisted_Nutrition_Planned_Procedure_Part
Parent: PlannedProcedure
Id: MedicallyAssistedNutritionPlannedProcedurePart
Title: "Medically Assisted Nutrition Procedure Information"
Description: """
This entry is an procedure in moodCode RQO. In FHIR this expresses the ServiceRequest.code. 
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""
//* ^identifier.system = "urn:ietf:rfc:3986"
//* ^identifier.value = "urn:hl7ii:2.16.840.1.113883.10.20.22.4.3:2024-05-01"

//* obeys should-text-ref-value and should-author
* insert LogicalModelTemplate(medically-assisted-nutrition-planned-procedure-part, 2.16.840.1.113883.9.275.3.4.2, 2026-08-28)

// Remove becuase this constraint already is specified in the parent template.
//* classCode = #PROC (exactly)
//* classCode ^comment = "SHALL contain exactly one [1..1] @classCode=\"ACT\" Act (CodeSystem: HL7ActClass urn:oid:2.16.840.1.113883.5.6 STATIC)."
* moodCode = #RQO (exactly)
* moodCode ^comment = "SHALL contain exactly one [1..1] @moodCode=\"RQO\" Request (CodeSystem: HL7ActMood urn:oid:2.16.840.1.113883.5.1001 STATIC)."

// * id 1..* Remove becuase this constraint already is specified in the parent template.
* id ^comment = """
MUST contain at least one [1..*] id.
If needed, the identifier for the procedure part of this clinical statement can be the id of the statement suffixed with a part# to make it distinct.
"""

* code.code = $sct#386373004

* negationInd MS
* negationInd ^comment = """
If the order is to NOT perform the procedure, then negationInd will be true for the procedure. 
In FHIR this aligns with use of the doNotPerform element.
"""

* text 1..1 
* text ^short = "links to the rendering of the portable medical order"

// this constraint is in the parent template. * statusCode.code = $ActStatusCode#active

// This effectiveTime is used to express a trial period.
* effectiveTime 0..1
* effectiveTime ^short = "Represents the trial period duration, if a trial period is specified."