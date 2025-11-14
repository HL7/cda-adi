// make a value set from other codeSystems and value sets defined elsewhere
//This is the way to make a "grouper valueSet"
//ValueSet:  Payer_Role_Codes_VS
//Title: "Payer Role Codes"
//Description: "TBD... "
//Id:  Payer.Role.Codes.VS
//* ^experimental = false
//* include codes from valueset http://terminology.hl7.org/ValueSet/v3-RoleCode
//* include codes from system http://terminology.hl7.org/CodeSystem/ib 
//* include codes from system http://snomed.info/sct

// Example of making a value set with explicit enumerated codes
//ValueSet: Antepartum_Review_of_Systems_Menstrual_History_VS
//Title: "Antepartum Review of Systems Menstrual History"
//Description: "Antepartum Review of Systems Menstrual History This value set identifies the menstrual-history related observations that may inform the pregnancy care."
//Id: Antepartum.Review.of.Systems.Menstrual.History.VS
//* ^experimental = false
//use $alias#code in that valueSet
//* $sct#21840007   "Date of Last Menstrual Period" 
//* $sct#364307006   "Menses Monthly" 
// APSOpenIssue_015: * $sct#21840007   "Prior Menses Date" Removed because it is a repeat concept wiht the same code as "date of last menstral period". CP may need to be made on the CDA APS to remove as well
//* $sct#364306002   "Duration of Menstrual Flow" 
//* $sct#289887006   "Frequency of Menstrual Cycles" 
//* $sct#10036567   "On Birth Control Pills at conception" --- code no longer supported by SNOMED ct 
//* $sct#398700009   "Menarche" 
//* $sct#250423000   "hCG+"


// Example of using a valueset from a Profile or IG you are dependent upon.  This requires an explicit dependency to be defined in the sushiConfig.yaml file
// In this approach, nothing goes in this valueSet file.