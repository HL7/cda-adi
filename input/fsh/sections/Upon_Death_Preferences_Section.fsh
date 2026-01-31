Profile: Upon_Death_Preferences_Section 
// $Section is an alias
Parent: $Section
Id: Upon.Death.Preferences.Section
Title: "Upon Death Preferences Section"
Description: """
This section contains care experience preferences expressed by the person which address what they want to have happen after their death.
"""
* ^status = #draft

// You don't need to slice the templateId if you only require one to be asserted to assert conformance to this template.
// Depending how strict you want to be, you can constrain the high order cardinality.  You may need to use 1..
// Including the 1..* may cause a validation problem.
* templateId 1..*
* templateId.root 1..1 
* templateId.root = "2.16.840.1.113883.4.823.1.3.5"
* templateId.extension 1..1 
* templateId.extension = "2026-08-28"

* code 1..1  
* code ^short = "Upon Death Section"
* code.code 1..1
* code.code = $loinc#81337-8
* code.codeSystem 1..1
* code.codeSystem = "2.16.840.1.113883.6.1"
* code.codeSystemName = "LOINC"

* title 1..1
* title ^short = "Upon Death Preferences" 

* text ^short = "Rendering of Upon Death Preferences information"