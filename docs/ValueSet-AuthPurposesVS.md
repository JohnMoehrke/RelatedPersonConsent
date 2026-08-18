# Authorization purposes for delegation access valueset - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Authorization purposes for delegation access valueset**

## ValueSet: Authorization purposes for delegation access valueset 

| | |
| :--- | :--- |
| *Official URL*:http://johnmoehrke.github.io/RelatedPersonConsent/ValueSet/AuthPurposesVS | *Version*:0.1.0 |
| Draft as of 2026-08-18 | *Computable Name*:AuthPurposesVS |
| *Other Identifiers:*OID:1.3.6.1.4.1.66281.5.48.1 | |

 
ValueSet of the Authorized purposesOfUse types 

 **References** 

* [Consent profile for a RelatedPerson relationship](StructureDefinition-RelatedPersonConsent.md)

### Logical Definition (CLD)

 

### Expansion

-------

 Explanation of the columns that may appear on this page: 

| | |
| :--- | :--- |
| Level | A few code lists that FHIR defines are hierarchical - each code is assigned a level. In this scheme, some codes are under other codes, and imply that the code they are under also applies |
| System | The source of the definition of the code (when the value set draws in codes defined elsewhere) |
| Code | The code (used as the code in the resource instance) |
| Display | The display (used in the*display*element of a[Coding](http://hl7.org/fhir/R4/datatypes.html#Coding)). If there is no display, implementers should not simply display the code, but map the concept into their application |
| Definition | An explanation of the meaning of the concept |
| Comments | Additional notes about how to use the code |



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "AuthPurposesVS",
  "url" : "http://johnmoehrke.github.io/RelatedPersonConsent/ValueSet/AuthPurposesVS",
  "identifier" : [{
    "system" : "urn:ietf:rfc:3986",
    "value" : "urn:oid:1.3.6.1.4.1.66281.5.48.1"
  }],
  "version" : "0.1.0",
  "name" : "AuthPurposesVS",
  "title" : "Authorization purposes for delegation access valueset",
  "status" : "draft",
  "experimental" : false,
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
  "description" : "ValueSet of the Authorized purposesOfUse types",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "http://unstats.un.org/unsd/methods/m49/m49.htm",
      "code" : "001"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "concept" : [{
        "code" : "FAMRQT"
      },
      {
        "code" : "PWATRNY"
      },
      {
        "code" : "PATADMIN"
      }]
    }]
  }
}

```
