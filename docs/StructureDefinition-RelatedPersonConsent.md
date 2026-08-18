# Consent profile for a RelatedPerson relationship - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Consent profile for a RelatedPerson relationship**

## Resource Profile: Consent profile for a RelatedPerson relationship 

| | |
| :--- | :--- |
| *Official URL*:http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/RelatedPersonConsent | *Version*:0.1.0 |
| Draft as of 2026-08-18 | *Computable Name*:RelatedPersonConsent |
| *Other Identifiers:*OID:1.3.6.1.4.1.66281.5.42.4 | |

 
This defines the constraints on a Consent to indicate that a Patient has agreed and authorizes a Related Person. 
* status - would indicate active
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
 

**Usages:**

* Examples for this Profile: [Consent/ex-consent](Consent-ex-consent.md) and [Consent/ex-poa](Consent-ex-poa.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/johnmoehrke.relatedpersonconsent.example|current/StructureDefinition/StructureDefinition-RelatedPersonConsent.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-RelatedPersonConsent.csv), [Excel](StructureDefinition-RelatedPersonConsent.xlsx), [Schematron](StructureDefinition-RelatedPersonConsent.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "RelatedPersonConsent",
  "url" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/RelatedPersonConsent",
  "identifier" : [{
    "system" : "urn:ietf:rfc:3986",
    "value" : "urn:oid:1.3.6.1.4.1.66281.5.42.4"
  }],
  "version" : "0.1.0",
  "name" : "RelatedPersonConsent",
  "title" : "Consent profile for a RelatedPerson relationship",
  "status" : "draft",
  "date" : "2026-08-18T10:19:00-05:00",
  "publisher" : "John Moehrke (himself)",
  "contact" : [{
    "name" : "John Moehrke (himself)",
    "telecom" : [{
      "system" : "url",
      "value" : "http://healthcaresecprivacy.blogspot.com"
    },
    {
      "system" : "email",
      "value" : "JohnMoehrke@gmail.com"
    }]
  },
  {
    "name" : "John Moehrke (himself)",
    "telecom" : [{
      "system" : "email",
      "value" : "JohnMoehrke@gmail.com"
    }]
  }],
  "description" : "This defines the constraints on a Consent to indicate that a Patient has agreed and authorizes a Related Person.\n\n- status - would indicate active\n- category - would indicate patient consent specifically a delegation of authority\n- patient - would indicate the Patient resource reference for the given patient\n- dateTime - would indicate when the privacy policy was presented\n- performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian\n- organization - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy\n- source - would point at the specific signed consent by the patient\n- policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version specific policy\n- provision.type - permit - authorizes the RelatedPerson as a delegatee; nested provisions may deny specific exceptions.\n- provision.actor.reference - would indicate the RelatedPerson resource\n- provision.actor.role - would indicate this actor is delegated authority\n- provision.purpose - would indicate the purpose of the information activity; it does not by itself establish that the RelatedPerson is the clinician or decision-maker for that activity.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "http://unstats.un.org/unsd/methods/m49/m49.htm",
      "code" : "001"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Consent",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Consent",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Consent",
      "path" : "Consent"
    },
    {
      "id" : "Consent.modifierExtension",
      "path" : "Consent.modifierExtension",
      "max" : "0"
    },
    {
      "id" : "Consent.status",
      "path" : "Consent.status",
      "patternCode" : "active"
    },
    {
      "id" : "Consent.scope",
      "path" : "Consent.scope",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/consentscope",
          "code" : "patient-privacy"
        }]
      }
    },
    {
      "id" : "Consent.category",
      "path" : "Consent.category",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "$this"
        }],
        "rules" : "open"
      },
      "min" : 3
    },
    {
      "id" : "Consent.category:representative",
      "path" : "Consent.category",
      "sliceName" : "representative",
      "min" : 1,
      "max" : "1",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://johnmoehrke.github.io/RelatedPersonConsent/CodeSystem/AuthorizedCodes",
          "code" : "RelatedPersonAuthorizing"
        }]
      }
    },
    {
      "id" : "Consent.category:relInfo",
      "path" : "Consent.category",
      "sliceName" : "relInfo",
      "min" : 1,
      "max" : "1",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "64292-6"
        }]
      }
    },
    {
      "id" : "Consent.category:idscl",
      "path" : "Consent.category",
      "sliceName" : "idscl",
      "min" : 1,
      "max" : "1",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
          "code" : "IDSCL"
        }]
      }
    },
    {
      "id" : "Consent.patient",
      "path" : "Consent.patient",
      "min" : 1
    },
    {
      "id" : "Consent.dateTime",
      "path" : "Consent.dateTime",
      "min" : 1
    },
    {
      "id" : "Consent.performer",
      "path" : "Consent.performer",
      "min" : 1
    },
    {
      "id" : "Consent.organization",
      "path" : "Consent.organization",
      "min" : 1
    },
    {
      "id" : "Consent.source[x]",
      "path" : "Consent.source[x]",
      "short" : "would point at the Consent paperwork signed by the Patient",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Consent",
        "http://hl7.org/fhir/StructureDefinition/DocumentReference",
        "http://hl7.org/fhir/StructureDefinition/Contract",
        "http://hl7.org/fhir/StructureDefinition/QuestionnaireResponse"]
      }]
    },
    {
      "id" : "Consent.provision",
      "path" : "Consent.provision",
      "min" : 1
    },
    {
      "id" : "Consent.provision.type",
      "path" : "Consent.provision.type",
      "min" : 1,
      "patternCode" : "permit"
    },
    {
      "id" : "Consent.provision.actor",
      "path" : "Consent.provision.actor",
      "min" : 1
    },
    {
      "id" : "Consent.provision.actor.role",
      "path" : "Consent.provision.actor.role",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
          "code" : "DELEGATEE"
        }]
      }
    },
    {
      "id" : "Consent.provision.actor.reference",
      "path" : "Consent.provision.actor.reference",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/RelatedPerson"]
      }]
    },
    {
      "id" : "Consent.provision.action",
      "path" : "Consent.provision.action",
      "short" : "may indicate subset of actions allowed"
    },
    {
      "id" : "Consent.provision.securityLabel",
      "path" : "Consent.provision.securityLabel",
      "short" : "may indicate a subset of data tags allowed"
    },
    {
      "id" : "Consent.provision.purpose",
      "path" : "Consent.provision.purpose",
      "short" : "may indicate a subset of access purposes of use allowed",
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://johnmoehrke.github.io/RelatedPersonConsent/ValueSet/AuthPurposesVS"
      }
    },
    {
      "id" : "Consent.provision.class",
      "path" : "Consent.provision.class",
      "short" : "may indicate a subset of classes of data allowed"
    },
    {
      "id" : "Consent.provision.dataPeriod",
      "path" : "Consent.provision.dataPeriod",
      "short" : "may indicate a data period allowed"
    },
    {
      "id" : "Consent.provision.data",
      "path" : "Consent.provision.data",
      "short" : "may indicate specific data instances allowed"
    },
    {
      "id" : "Consent.provision.provision",
      "path" : "Consent.provision.provision",
      "short" : "may indicate exceptions, specific rules disallowed"
    }]
  }
}

```
