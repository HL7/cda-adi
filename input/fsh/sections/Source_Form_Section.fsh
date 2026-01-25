Profile: Source_Form_Section 
// $Section is an alias
Parent: $Section
Id: Source.Form.Section
Title: "Source Form Section"
Description: """
This shall contain the binary object used to render the source form in it's original format with completion signatures, etc.
"""
* ^status = #draft

//* obeys ihe-shall-problem-concern-act 
//The above phrase is an invariant which requires this section to include the defined entry. In the absence of that entry, the section shall include a nullFlavor.
//* nullFlavor ^short = "If a required section contains no information, the @nullFlavor MAY be set to NI"
//* nullFlavor = #NI

// You don't need to slice the templateId if you only require one to be asserted to assert conformance to this template.
// Depending how strict you want to be, you can constrain the high order cardinality.  You may need to use 1..
// Including the 1..* may cause a validation problem.
* templateId 1..*
* templateId.root 1..1 
* templateId.root = "2.16.840.1.113883.4.823.1.3.10"
* templateId.extension 1..1 
* templateId.extension = "2026-08-28"

* code 1..1  
* code ^short = "Source Form Section"
* code.code 1..1
//  Take this question to Office Hours.  How do I make an invariant to express a constraint to require this section's code.code to equal the clinicalDocument.code.
// * code.code = $loinc#ANDREA-1
* code.code = $loinc#81334-5
* code.codeSystem 1..1
* code.codeSystem = "2.16.840.1.113883.6.1"
* code.codeSystemName = "LOINC"

* title 1..1
* title = "Source Form Document" 

* text ^short = "Rendering of the Source Form Document and any additional entry data."

//ANDREA - need more information on how to include various type of entries.
//* entry ^slicing.discriminator[+].type = #profile
//* entry ^slicing.discriminator[=].path = "act"
//* entry ^slicing.discriminator[+].type = #profile
//* entry ^slicing.discriminator[=].path = "observation"
//* entry ^slicing.rules = #open
//* entry ^short = "If section/@nullFlavor is not present:"
//* entry ^comment = "SHALL contain at least one [1..*] entry (CONF:1198-9183)"
//* entry contains problem-Concern-Entry 1..* MS 
//* entry[problem-Concern-Entry].act 1..1 MS 
//* entry[problem-Concern-Entry].act only IHE_PCC_Concern_Entry



//confirm if this entry is an act
// Invariant: shall-source-form-entry-act
// Description: "If section/@nullFlavor is not present, SHALL contain at least one source-form-entry-act"
// * severity = #error
// * expression = "nullFlavor.exists() or entry.where(act.hasTemplateIdOf('https://profiles.ihe.net/PCC/PSCc/StructureDefinition/Source_Form_Entry')).exists()"