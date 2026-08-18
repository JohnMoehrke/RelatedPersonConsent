# Artifacts Summary - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* **Artifacts Summary**

## Artifacts Summary

This page provides a list of the FHIR artifacts defined as part of this implementation guide.

### Structures: Resource Profiles 

These define constraints on FHIR resources for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Authorized RelatedPerson](StructureDefinition-AuthorizedRelatedPerson.md) | A RelatedPerson that has been justified and authorized by the Patient.* The RelatedPerson.patient must be the same as the Consent.patient
* The Consent.provision.actor.reference must be the same as the RelatedPerson.id
* The Consent is authorizing (permit) the RelatedPerson, and is not expired.
 |
| [Consent profile for a RelatedPerson relationship](StructureDefinition-RelatedPersonConsent.md) | This defines the constraints on a Consent to indicate that a Patient has agreed and authorizes a Related Person.* status - would indicate active
* category - would indicate patient consent specifically a delegation of authority
* patient - would indicate the Patient resource reference for the given patient
* dateTime - would indicate when the privacy policy was presented
* performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
* organization - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy
* source - would point at the specific signed consent by the patient
* policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version specific policy
* provision.type - permit - authorizes the RelatedPerson as a delegatee; nested provisions may deny specific exceptions.
* provision.actor.reference - would indicate the RelatedPerson resource
* provision.actor.role - would indicate this actor is delegated authority
* provision.purpose - would indicate the purpose of the information activity; it does not by itself establish that the RelatedPerson is the clinician or decision-maker for that activity.
 |

### Structures: Extension Definitions 

These define constraints on FHIR data types for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Extension that points at an authorizing Consent](StructureDefinition-JFM-authorizingConsent.md) | Used within a Resource to indicate that the activity enabled by the Resource is authorized by the Consent indicated. For example: Used within a RelatedParty to indicate the Consent the Patient has given authorizing the RelatedParty relationship to exist. |
| [Retired Extension that points at an authorizing Consent](StructureDefinition-JFM-authorizingConsentRetired.md) | Retired: Used within a Resource to indicate that the activity enabled by the Resource is authorized by the Consent indicated. For example: Used within a RelatedParty to indicate the Consent the Patient has given authorizing the RelatedParty relationship to exist. |

### Terminology: Value Sets 

These define sets of codes used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Authorization purposes for delegation access valueset](ValueSet-AuthPurposesVS.md) | ValueSet of the Authorized purposesOfUse types |

### Terminology: Code Systems 

These define new code systems used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Consent type that is authorizing a RelatedPerson](CodeSystem-AuthorizedCodes.md) | CodeSystem for authorizing Consent types for a RelatedPerson |

### Example: Example Instances 

These are example instances that show what data produced and consumed by systems conforming with this implementation guide might look like.

| | |
| :--- | :--- |
| [Child Patient](Patient-ex-child.md) | Child Patient |
| [Consent of Elderly giving Power of Attorney](Consent-ex-poa.md) | Consent justifying RelatedPerson (the attorney) and authorizing power of attorney, and limited access to non-sensitive information. |
| [DocumentReference Consent Paperwork example](DocumentReference-ex-documentreference.md) | DocumentReference example of the paperwork of the Consent |
| [DocumentReference Consent Paperwork example](DocumentReference-ex-powerOfAttorney.md) | The Legal text with legal signature of the Durable Power of Attorney |
| [Elderly Patient example](Patient-ex-elderly.md) | The Elderly Patient. |
| [Example Organization holding the data](Organization-ex-organization.md) | The Organization that holds the data, and enforcing any Consents |
| [Father - Related Person](RelatedPerson-ex-father.md) | Related Father of the Patient authorized by a Consent |
| [Practitioner example doctor](Practitioner-ex-doctor.md) | Practitioner example for the doctor. |
| [Simple Consent example](Consent-ex-consent.md) | Consent justifying RelatedPerson and authorizing access by that RelatedPerson |
| [non-family attorney](RelatedPerson-ex-attorney.md) | Example to show that an authorized representative might not be family |

