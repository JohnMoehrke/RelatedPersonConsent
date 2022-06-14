
Instance: ex-organization
InstanceOf: Organization
Title: "Example Organization holding the data"
Description: "The Organization that holds the data, and enforcing any Consents"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* active = true
* name = "somewhere org"



Instance: ex-doctor
InstanceOf: Practitioner
Title: "Practitioner example doctor"
Description: "Practitioner example for the doctor."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* telecom.system = #email
* telecom.value = "JohnMoehrke@example.com"



// history - http://playgroundjungle.com/2018/02/origins-of-john-jacob-jingleheimer-schmidt.html
Instance:   ex-patient
InstanceOf: Patient
Title:      "Patient example"
Description: "Patient example for completeness sake."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* name[+].use = #usual
* name[=].family = "Schmidt"
* name[=].given = "John"
* name[+].use = #old
* name[=].family = "Schnidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingle"
* name[=].given[+] = "Heimer"
* name[=].period.end = "1960"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingleheimer"
* name[=].period.start = "1960-01-01"
* name[+].use = #nickname
* name[=].family = "Schmidt"
* name[=].given = "Jack"
* gender = #other
* birthDate = "1923-07-25"
* address.state = "WI"
* address.country = "USA"



Instance: ex-documentreference
InstanceOf: DocumentReference
Title: "DocumentReference Consent Paperwork example"
Description: "DocumentReference example of the paperwork of the Consent"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #current
* content.attachment.title = "Hello World"
* content.attachment.contentType = #text/plain



Instance: ex-father
InstanceOf: AuthorizedRelatedPerson
Title: "Father - Related Person"
Description: "Related Father of the Patient authorized by a Consent"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* active = true
* patient = Reference(ex-patient)
* relationship = 	http://terminology.hl7.org/CodeSystem/v3-RoleCode#FTH "father"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingleheimer"
// after all, that is his name too
* gender = #male
* extension[authorizingConsent].valueReference = Reference(ex-consent)


Instance: ex-consent
InstanceOf: RelatedPersonConsent
Title: "Simple Consent example"
Description: "Consent justifying RelatedPerson and authorizing access by that RelatedPerson"
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #active
* scope = http://terminology.hl7.org/CodeSystem/consentscope#patient-privacy
* category[representative] = AuthorizedCodes#RelatedPersonAuthorizing
* category[rel-info] = http://loinc.org#64292-6 "Release of information consent"
* category[idscl] = http://terminology.hl7.org/CodeSystem/v3-ActCode#IDSCL
* patient = Reference(ex-patient)
* dateTime = "2022-06-13"
* performer = Reference(ex-patient)
* organization = Reference(ex-organization)
* sourceReference = Reference(ex-documentreference)
* policy.uri = "http://example.org/policies/representative.xacml"
* provision.type = #permit
* provision.actor.reference = Reference(ex-father)
* provision.actor.role = http://terminology.hl7.org/CodeSystem/v3-RoleCode#DELEGATEE
* provision.purpose = http://terminology.hl7.org/CodeSystem/v3-ActReason#FAMRQT




Extension: AuthorizingConsent
Id: JFM-authorizingConsent
Title: "Extension that points at an authorizing Consent"
Description: """
Used within a Resource to indicate that the activity enabled by the Resource is authorized by the Consent indicated. For example: Used within a RelatedParty to indicate the Consent the Patient has given authorizing the RelatedParty relationship to exist.
"""
* value[x] only Reference(Consent or RelatedPersonConsent)
* valueReference 1..1




Profile: AuthorizedRelatedPerson
Parent: RelatedPerson
Title: "Authorized RelatedPerson"
Description: """
A RelatedPerson that has been justified and authorized by the Patient.

- The RelatedPerson.patient must be the same as the Consent.patient
- The Consent.provision.agent.reference must be the same as the RelatedPerson.id
- The Consent is authorizing (permit) the RelatedPerson, and is not expired.
"""
* extension contains AuthorizingConsent named authorizingConsent 1..1



CodeSystem:  AuthorizedCodes 
Title: "Consent type that is authorizing a RelatedPerson"
Description:  "CodeSystem for authorizing Consent types for a RelatedPerson"
* ^caseSensitive = true
* #RelatedPersonAuthorizing "Authorizing Consent for a Related Person"


Profile: RelatedPersonConsent
Parent: Consent
Title: "Consent profile for a RelatedPerson relationship"
Description: """
This defines the constraints on a Consent to indicate that a Patient has agreed and authorizes a Related Person.

- status - would indicate active
- category - would indicate patient consent specifically a delegation of authority
- patient - would indicate the Patient resource reference for the given patient
- dateTime - would indicate when the privacy policy was presented
- performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
- organization - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy
- source - would point at the specific signed consent by the patient
- policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version specific policy
- provision.type - permit - given there is no way to deny, this would be fixed at permit.
- provision.agent.reference - would indicate the RelatedPerson resource
- provision.agent.role - would indicate this agent is delegated authority
- provision.purpose - would indicate some set of authorized purposeOfUse
"""
* modifierExtension 0..0
* status = #active
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category 3..3
* category contains
   representative 1..1 and
   rel-info 1..1 and
   idscl 1..1
* category[representative] = AuthorizedCodes#RelatedPersonAuthorizing
* category[rel-info] = http://loinc.org#64292-6 "Release of information consent"
* category[idscl] = http://terminology.hl7.org/CodeSystem/v3-ActCode#IDSCL
* patient 1..1
* dateTime 1..1
* performer 1..
* organization 1..
* sourceReference MS
* sourceReference ^short = "would point at the Consent paperwork signed by the Patient"
* provision.type = #permit
* provision.actor 1..
* provision.actor.reference only Reference(RelatedPerson)
* provision.actor.role =  http://terminology.hl7.org/CodeSystem/v3-RoleCode#DELEGATEE
* provision.purpose from AuthPurposesVS


ValueSet: AuthPurposesVS
Title: "Authorization purposes for delegation access valueset"
Description: "ValueSet of the Authorized purposesOfUse types"
* http://terminology.hl7.org/CodeSystem/v3-ActReason#FAMRQT
