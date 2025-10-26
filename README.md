# cda-adi
Repo established to house the new CDA IG in SD format. This CDA IG will be built with IG Publisher.
## Personal Advance Care Plan Document
### Minimally Structured PACP Document 2.16.840.1.113883.4.823.1.1.1  2026-08-28
**Inherits from:**  
> Patient Generated Document  2.16.840.1.113883.10.20.29.1  2024-05-01
>
> US Realm Header  2.16.840.1.113883.10.20.22.1.1  2024-05-01  
**Key Metadata:**  
id: [1..1]  
setId: [1..1]  
versionNumber: [1..1]  
category: [1..*]  
code: [1..1]  
statusCode:[1..1]  
recordTarget: [1..1]  
author: [1..1]  
custodian: [1..1]  
dataEnterer: [0..1]  
serviceEvent: [0..*] Captures information about advance care planning services provided in the development of the document, who the performer of the services was, and the time intervals associated with the service events.  
assembler: [0..1]  
authenticator(s): [0..*]  
legalAuthenticator: [0..0]  
relatedDocument: [0..1]  
effectiveTime: [1..1]  

## Physician Order for Life Sustaining Treatment Document
### Minimally Structured POLST Document 2.16.840.1.113883.9.275.2.1  2026-08-28
**Inherits from:**  
> US Realm Header  2.16.840.1.113883.10.20.22.1.1  2024-05-01  
**Key Metadata:**  
id: [1..1]  
setId: [1..1]  
versionNumber: [1..1]  
category: [1..*]  
code: [1..1]  
statusCode:[1..1]  
recordTarget: [1..1]  
author: [1..1]  
custodian: [1..1]  
dataEnterer: [0..1]  
serviceEvent: [0..*] Captures information about advance care planning services provided in the development of the document, who the performer of the services was, and the time intervals associated with the service events.  
assembler: [0..1]  
authenticator(s): [0..*]  
legalAuthenticator: [0..1]  
relatedDocument: [0..1]  
effectiveTime: [1..1]  
