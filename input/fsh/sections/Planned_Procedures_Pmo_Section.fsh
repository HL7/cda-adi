Profile: Planned_Procedures_PMO_Section 
// $Section is an alias
Parent: $Section
Id: PlannedProceduresPMOSection
Title: "Planned Procedure PMO Section"
Description: """
This section contains portable medical orders for the patient.
"""
* ^status = #draft

// You don't need to slice the templateId if you only require one to be asserted to assert conformance to this template.
// Depending how strict you want to be, you can constrain the high order cardinality.  You may need to use 1..
// Including the 1..* may cause a validation problem.
// ANDREA is this the right syntax to express "you can have any number of templateId's but one of them need to be this one?"
//ANDREA - it seems like the right syntax is a slice definition so you don't preclude other templateId root values in combination with the extension value.
//if the parent was already sliced, or if you want someone to inherit this section as a parent, they can make slices in their section template.
* templateId 1..* 
* templateId ^slicing.discriminator[+].type = #value
* templateId ^slicing.discriminator[=].path = "root"
* templateId ^slicing.discriminator[+].type = #value
* templateId ^slicing.discriminator[=].path = "extension"
* templateId ^slicing.rules = #open
* templateId ^slicing.description = "Slicing for templateIds"
* templateId ^slicing.ordered = false
* templateId contains planned-procedures-pmo-section 1..1
* templateId[planned-procedures-pmo-section].root 1..1
* templateId[planned-procedures-pmo-section].root = "2.16.840.1.113883.9.275.2.1"
* templateId[planned-procedures-pmo-section].extension 1..1 
* templateId[planned-procedures-pmo-section].extension = "2026-08-28"

* code 1..1  
* code ^short = "Planned Procedures PMO Section"
* code.code 1..1
* code.code = $loinc#59772-4
* code.codeSystem 1..1
* code.codeSystem = "2.16.840.1.113883.6.1"
* code.codeSystemName = "LOINC"

* title 1..1
* title ^short = "- Portable Medical Orders - Planned Procedures" 

* text ^short = "Rendering of Portable Medical Orders - Planned Procedures"

* entry ^slicing.discriminator[+].type = #profile
* entry ^slicing.discriminator[=].path = "act"
* entry ^slicing.rules = #open
//* entry ^short = "If section/@nullFlavor is not present:"
* entry ^comment = "SHALL contain at least one [1..*] entry."

* entry contains 
     cardiopulmonaryResuscitationOrder 1..1 MS and
     initialTreatmentOrder 0..* MS and 
     additionalOrder 0..* MS and
     nutritionOrder 0..1 MS

* entry[cardiopulmonaryResuscitationOrder].act 1..1 MS 
* entry[cardiopulmonaryResuscitationOrder].act only Cardiopulmonary_Resuscitation_Order_Entry

* entry[initialTreatmentOrder].act 1..1 MS 
* entry[initialTreatmentOrder].act only Initial_Treatment_Order_Entry

* entry[additionalOrder].act 1..1 MS 
* entry[additionalOrder].act only Additional_Order_Entry

* entry[nutritionOrder].act 1..1 MS 
* entry[nutritionOrder].act only Medically_Assisted_Nutrition_Order_Entry