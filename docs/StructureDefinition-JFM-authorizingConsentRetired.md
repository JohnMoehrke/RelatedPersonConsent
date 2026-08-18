# Retired Extension that points at an authorizing Consent - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Retired Extension that points at an authorizing Consent**

## Extension: Retired Extension that points at an authorizing Consent 

| | |
| :--- | :--- |
| *Official URL*:http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/JFM-authorizingConsentRetired | *Version*:0.1.0 |
| Retired as of 2026-08-18 | *Computable Name*:AuthorizingConsentRetired |
| *Other Identifiers:*OID:1.3.6.1.4.1.66281.5.42.3 | |

Retired: Used within a Resource to indicate that the activity enabled by the Resource is authorized by the Consent indicated. For example: Used within a RelatedParty to indicate the Consent the Patient has given authorizing the RelatedParty relationship to exist.

**Context of Use**

**Usage info**

**Usages:**

* This Extension is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/johnmoehrke.relatedpersonconsent.example|current/StructureDefinition/StructureDefinition-JFM-authorizingConsentRetired.json)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-JFM-authorizingConsentRetired.csv), [Excel](StructureDefinition-JFM-authorizingConsentRetired.xlsx), [Schematron](StructureDefinition-JFM-authorizingConsentRetired.sch) 

#### Constraints



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "JFM-authorizingConsentRetired",
  "url" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/JFM-authorizingConsentRetired",
  "identifier" : [{
    "system" : "urn:ietf:rfc:3986",
    "value" : "urn:oid:1.3.6.1.4.1.66281.5.42.3"
  }],
  "version" : "0.1.0",
  "name" : "AuthorizingConsentRetired",
  "title" : "Retired Extension that points at an authorizing Consent",
  "status" : "retired",
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
  "description" : "Retired:\nUsed within a Resource to indicate that the activity enabled by the Resource is authorized by the Consent indicated. For example: Used within a RelatedParty to indicate the Consent the Patient has given authorizing the RelatedParty relationship to exist.",
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
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "RelatedPerson"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "Retired Extension that points at an authorizing Consent",
      "definition" : "Retired:\nUsed within a Resource to indicate that the activity enabled by the Resource is authorized by the Consent indicated. For example: Used within a RelatedParty to indicate the Consent the Patient has given authorizing the RelatedParty relationship to exist."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/JFM-authorizingConsentRetired"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Consent"]
      }]
    }]
  }
}

```
