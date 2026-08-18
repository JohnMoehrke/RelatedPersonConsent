# Consent type that is authorizing a RelatedPerson - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Consent type that is authorizing a RelatedPerson**

## CodeSystem: Consent type that is authorizing a RelatedPerson 

| | |
| :--- | :--- |
| *Official URL*:http://johnmoehrke.github.io/RelatedPersonConsent/CodeSystem/AuthorizedCodes | *Version*:0.1.0 |
| Active as of 2026-08-18 | *Computable Name*:AuthorizedCodes |
| *Other Identifiers:*OID:1.3.6.1.4.1.66281.5.16.1 | |

 
CodeSystem for authorizing Consent types for a RelatedPerson 

 This Code system is referenced in the content logical definition of the following value sets: 

* This CodeSystem is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "AuthorizedCodes",
  "url" : "http://johnmoehrke.github.io/RelatedPersonConsent/CodeSystem/AuthorizedCodes",
  "identifier" : [{
    "system" : "urn:ietf:rfc:3986",
    "value" : "urn:oid:1.3.6.1.4.1.66281.5.16.1"
  }],
  "version" : "0.1.0",
  "name" : "AuthorizedCodes",
  "title" : "Consent type that is authorizing a RelatedPerson",
  "status" : "active",
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
  "description" : "CodeSystem for authorizing Consent types for a RelatedPerson",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "http://unstats.un.org/unsd/methods/m49/m49.htm",
      "code" : "001"
    }]
  }],
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 1,
  "concept" : [{
    "code" : "RelatedPersonAuthorizing",
    "display" : "Authorizing Consent for a Related Person"
  }]
}

```
