// This is the basic pattern for a provider authored document.
// It is specifically about directives that are created as a portable medical order
// which can travel with the patient across care settings.

Profile: POLSTPortableMedicalOrdersDocument
Parent: USRealmHeader
Description: """This profile defines the requirements for communicating a practitioner-authored portable medical order (PMO) advance healthcare directive document using a Composition Resource. Different states may call this type of document by a number of different names:

- MOLST (Medical Orders for Life Sustaining Treatment)
- POLST (Physician Orders for Life Sustaining Treatment)
- MOST (Medical Orders for Scope of Treatment)
- POST (Physician Orders for Scope of Treatment)
- TPOPP (Transportable Physician Orders for Patient Preferences)
- Out-of-hospital Do Not Resuscitate (DNR) Orders
- DNAR (Do Not Attempt Resuscitation) or AND (Allow Natural Death) Orders

It is a practitioner-generated document, authored by a practitioner with necessary credentials established for the document within its jurisdiction of use. If other care professionals are involved in the creation of the document, their supporting role in the advance care planning process can be represented in the service event associated with the document. If data entry assistance is provided, the person performing the data entry can be represented in the role of a data enterer. However, only the authoring practitioner signs the document as the legal authenticator. The signature of the person/patient who is the subject of the document also is required. If the subject is unable to sign the document, a person who is permitted to sign on their behalf may sign in place of the subject.

Additionally, the system used to assemble the document can be represented as a participant of the document in the role of Assembler. The Custodian organization responsible for maintaining the source copy of the document must be included.

The document includes a mandatory source form section to hold a pdf of the original “source form” showing the PMO completed by the practitioner and patient. It also includes a mandatory Medical Orders section. This section includes machine processable representations of–at a minimum- the directive regarding cardiopulmonary resuscitation. Other directives such as initial treatment and other types of orders may also be included to facilitate data resusability as the document is shared between systems. However, the source form remains the “source of truth” providing the full range of relevant orders. 

A PMO document may contain additional textual information from the source form that does not have corresponding encoded entries. In this case, the section.text element is populated without corresponding section.entry elements. For minimum required information, the information in the section.text element will include corresponding section.entry elements and will be linked using the test linking mechanism.

Optionally, the document may contain sections for form completion information which includes the necessary signature information, administrative information, additional documentation, upon death information, healthcare agent appointment, and notary and witness information. 
"""

* insert LogicalModelTemplate(polst-pmo, 2.16.840.1.113883.9.275.1, 2026-08-28)
* insert DocumentCategory(Advance Healthcare Directives, 42348-3, Advance healthcare directives)