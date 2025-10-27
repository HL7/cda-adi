// This is the basic pattern for a provider authored document.
// It is specifically about directives that are created as a portable medical order
// which can travel with the patient across care settings.

Profile: POLSTPortableMedicalOrdersDocument
Parent: USRealmHeader
Description: "A provider authored advance healthcare directive document which 
contains a source form document and also may include structured sections for machine
processable representation of the patient's consent to appoint one or more healthcare agents. 
It also may inlcude care experience and treatment intervention preferences so healthcare agents
will know the patients wishes should they need to make care decisions on the patient's behalf."

* insert LogicalModelTemplate(polst-pmo, 2.16.840.1.113883.9.275.1, 2026-08-28)
* insert DocumentCategory(Advance Healthcare Directives, 42348-3, Advance healthcare directives)