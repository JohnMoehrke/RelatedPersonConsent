# Authorized RelatedPerson - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Authorized RelatedPerson**

## Resource Profile: Authorized RelatedPerson 

| | |
| :--- | :--- |
| *Official URL*:http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/AuthorizedRelatedPerson | *Version*:0.1.0 |
| Draft as of 2026-08-18 | *Computable Name*:AuthorizedRelatedPerson |
| *Other Identifiers:*OID:1.3.6.1.4.1.66281.5.42.1 | |

 
A RelatedPerson that has been justified and authorized by the Patient. 
* The RelatedPerson.patient must be the same as the Consent.patient
* The Consent.provision.actor.reference must be the same as the RelatedPerson.id
* The Consent is authorizing (permit) the RelatedPerson, and is not expired.
 

**Usages:**

* Examples for this Profile: [RelatedPerson/ex-attorney](RelatedPerson-ex-attorney.md) and [RelatedPerson/ex-father](RelatedPerson-ex-father.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/johnmoehrke.relatedpersonconsent.example|current/StructureDefinition/StructureDefinition-AuthorizedRelatedPerson.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-AuthorizedRelatedPerson.csv), [Excel](StructureDefinition-AuthorizedRelatedPerson.xlsx), [Schematron](StructureDefinition-AuthorizedRelatedPerson.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "AuthorizedRelatedPerson",
  "url" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/AuthorizedRelatedPerson",
  "identifier" : [{
    "system" : "urn:ietf:rfc:3986",
    "value" : "urn:oid:1.3.6.1.4.1.66281.5.42.1"
  }],
  "version" : "0.1.0",
  "name" : "AuthorizedRelatedPerson",
  "title" : "Authorized RelatedPerson",
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
  "description" : "A RelatedPerson that has been justified and authorized by the Patient.\n\n- The RelatedPerson.patient must be the same as the Consent.patient\n- The Consent.provision.actor.reference must be the same as the RelatedPerson.id\n- The Consent is authorizing (permit) the RelatedPerson, and is not expired.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "http://unstats.un.org/unsd/methods/m49/m49.htm",
      "code" : "001"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "RelatedPerson",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/RelatedPerson",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "RelatedPerson",
      "path" : "RelatedPerson"
    },
    {
      "id" : "RelatedPerson.extension",
      "path" : "RelatedPerson.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "RelatedPerson.extension:authorizingConsent",
      "path" : "RelatedPerson.extension",
      "sliceName" : "authorizingConsent",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/JFM-authorizingConsent"]
      }]
    }]
  }
}

```
