# non-family attorney - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **non-family attorney**

## Example RelatedPerson: non-family attorney

Profile: [Authorized RelatedPerson](StructureDefinition-AuthorizedRelatedPerson.md)

Security Label: [test health data (Details: ActReason code HTEST = 'test health data')](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActReason.html)

**Extension that points at an authorizing Consent**: [ex-poa](Consent-ex-poa.md)

**active**: true

**patient**: [John Schmidt Other, DoB: 1923-07-25](Patient-ex-elderly.md)

**relationship**: power of attorney

**name**: Ralph Luz (Official)

**gender**: Male



## Resource Content

```json
{
  "resourceType" : "RelatedPerson",
  "id" : "ex-attorney",
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
      "reference" : "Consent/ex-poa"
    }
  }],
  "active" : true,
  "patient" : {
    "reference" : "Patient/ex-elderly"
  },
  "relationship" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
      "code" : "POWATT",
      "display" : "power of attorney"
    }]
  }],
  "name" : [{
    "use" : "official",
    "family" : "Luz",
    "given" : ["Ralph"]
  }],
  "gender" : "male"
}

```
