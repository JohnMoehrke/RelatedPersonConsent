# Practitioner example doctor - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Practitioner example doctor**

## Example Practitioner: Practitioner example doctor

Security Label: [test health data (Details: ActReason code HTEST = 'test health data')](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActReason.html)

**telecom**: [JohnMoehrke@example.com](mailto:JohnMoehrke@example.com)



## Resource Content

```json
{
  "resourceType" : "Practitioner",
  "id" : "ex-doctor",
  "meta" : {
    "security" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "code" : "HTEST"
    }]
  },
  "telecom" : [{
    "system" : "email",
    "value" : "JohnMoehrke@example.com"
  }]
}

```
