# Father - Related Person - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Father - Related Person**

## Example RelatedPerson: Father - Related Person

Profile: [Authorized RelatedPerson](StructureDefinition-AuthorizedRelatedPerson.md)

Security Label: [test health data (Details: ActReason code HTEST = 'test health data')](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActReason.html)

**Extension that points at an authorizing Consent**: [ex-consent](Consent-ex-consent.md)

**active**: true

**patient**: [Bob Seebeth Male, DoB: 2014-08-28](Patient-ex-child.md)

**relationship**: father

**name**: John Jacob Jingleheimer Schmidt (Official)

**gender**: Male



## Resource Content

```json
{
  "resourceType" : "RelatedPerson",
  "id" : "ex-father",
  "meta" : {
    "profile" : ["http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/AuthorizedRelatedPerson"],
    "security" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "code" : "HTEST"
    }]
  },
  "extension" : [{
    "url" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/JFM-authorizingConsent",
    "valueReference" : {
      "reference" : "Consent/ex-consent"
    }
  }],
  "active" : true,
  "patient" : {
    "reference" : "Patient/ex-child"
  },
  "relationship" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
      "code" : "FTH",
      "display" : "father"
    }]
  }],
  "name" : [{
    "use" : "official",
    "family" : "Schmidt",
    "given" : ["John", "Jacob", "Jingleheimer"]
  }],
  "gender" : "male"
}

```
