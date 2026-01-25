Profile: Care_Experience_Preferences_Section 
// $Section is an alias
Parent: $Section
Id: Care.Experience.Preferences.Section
Title: "Care Experience Preferences Section"
Description: """
This section contains information about the person's expressed care experience preferences.
"""
* ^status = #draft

// You don't need to slice the templateId if you only require one to be asserted to assert conformance to this template.
// Depending how strict you want to be, you can constrain the high order cardinality.  You may need to use 1..
// Including the 1..* may cause a validation problem.
* templateId 1..*
* templateId.root 1..1 
* templateId.root = "2.16.840.1.113883.4.823.1.3.6"
* templateId.extension 1..1 
* templateId.extension = "2026-08-28"

* code 1..1  
* code ^short = "Care Experience Preferences Section"
* code.code 1..1
* code.code = $loinc#81338-6
* code.codeSystem 1..1
* code.codeSystem = "2.16.840.1.113883.6.1"
* code.codeSystemName = "LOINC"

* title 1..1
* title = "Care Experience Preferences" 

* text ^short = "Rendering of care experience preferences"