# Child Patient - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Child Patient**

## Example Patient: Child Patient

Security Label: [test health data (Details: ActReason code HTEST = 'test health data')](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActReason.html)

Bob Seebeth Male, DoB: 2014-08-28

-------



## Resource Content

```json
{
  "resourceType" : "Patient",
  "id" : "ex-child",
  "meta" : {
    "security" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "code" : "HTEST"
    }]
  },
  "name" : [{
    "use" : "usual",
    "family" : "Seebeth",
    "given" : ["Bob"]
  }],
  "gender" : "male",
  "birthDate" : "2014-08-28"
}

```
