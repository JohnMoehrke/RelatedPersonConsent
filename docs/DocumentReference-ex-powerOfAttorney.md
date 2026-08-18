# DocumentReference Consent Paperwork example - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **DocumentReference Consent Paperwork example**

## Example DocumentReference: DocumentReference Consent Paperwork example

Security Label: [test health data (Details: ActReason code HTEST = 'test health data')](http://terminology.hl7.org/7.3.0/CodeSystem-v3-ActReason.html)

**status**: Current

**type**: Power of attorney

**subject**: [John Schmidt Other, DoB: 1923-07-25](Patient-ex-elderly.md)

**author**: [Organization somewhere org](Organization-ex-organization.md)

**description**: The captured signed document

> **content**

### Attachments

| | | | |
| :--- | :--- | :--- | :--- |
| - | **ContentType** | **Data** | **Title** |
| * | text/plain | `QXQgdmVybyBlb3MgZXQgYWNjdXNhbXVz...`(base64 data - 1,128 base64 chars) | Hello World |




## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "ex-powerOfAttorney",
  "meta" : {
    "security" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "code" : "HTEST"
    }]
  },
  "status" : "current",
  "type" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "64298-3",
      "display" : "Power of attorney"
    }]
  },
  "subject" : {
    "reference" : "Patient/ex-elderly"
  },
  "author" : [{
    "reference" : "Organization/ex-organization"
  }],
  "description" : "The captured signed document",
  "content" : [{
    "attachment" : {
      "contentType" : "text/plain",
      "data" : "QXQgdmVybyBlb3MgZXQgYWNjdXNhbXVzIGV0IGl1c3RvIG9kaW8gZGlnbmlzc2ltb3MgZHVjaW11cyBxdWkgYmxhbmRpdGlpcyBwcmFlc2VudGl1bSB2b2x1cHRhdHVtIGRlbGVuaXRpIGF0cXVlIGNvcnJ1cHRpIHF1b3MgZG9sb3JlcyBldCBxdWFzIG1vbGVzdGlhcyBleGNlcHR1cmkgc2ludCBvY2NhZWNhdGkgY3VwaWRpdGF0ZSBub24gcHJvdmlkZW50LCBzaW1pbGlxdWUgc3VudCBpbiBjdWxwYSBxdWkgb2ZmaWNpYSBkZXNlcnVudCBtb2xsaXRpYSBhbmltaSwgaWQgZXN0IGxhYm9ydW0gZXQgZG9sb3J1bSBmdWdhLiBFdCBoYXJ1bSBxdWlkZW0gcmVydW0gZmFjaWxpcyBlc3QgZXQgZXhwZWRpdGEgZGlzdGluY3Rpby4gTmFtIGxpYmVybyB0ZW1wb3JlLCBjdW0gc29sdXRhIG5vYmlzIGVzdCBlbGlnZW5kaSBvcHRpbyBjdW1xdWUgbmloaWwgaW1wZWRpdCBxdW8gbWludXMgaWQgcXVvZCBtYXhpbWUgcGxhY2VhdCBmYWNlcmUgcG9zc2ltdXMsIG9tbmlzIHZvbHVwdGFzIGFzc3VtZW5kYSBlc3QsIG9tbmlzIGRvbG9yIHJlcGVsbGVuZHVzLiBUZW1wb3JpYnVzIGF1dGVtIHF1aWJ1c2RhbSBldCBhdXQgb2ZmaWNpaXMgZGViaXRpcyBhdXQgcmVydW0gbmVjZXNzaXRhdGlidXMgc2FlcGUgZXZlbmlldCB1dCBldCB2b2x1cHRhdGVzIHJlcHVkaWFuZGFlIHNpbnQgZXQgbW9sZXN0aWFlIG5vbiByZWN1c2FuZGFlLiBJdGFxdWUgZWFydW0gcmVydW0gaGljIHRlbmV0dXIgYSBzYXBpZW50ZSBkZWxlY3R1cywgdXQgYXV0IHJlaWNpZW5kaXMgdm9sdXB0YXRpYnVzIG1haW9yZXMgYWxpYXMgY29uc2VxdWF0dXIgYXV0IHBlcmZlcmVuZGlzIGRvbG9yaWJ1cyBhc3BlcmlvcmVzIHJlcGVsbGF0Lg==",
      "title" : "Hello World"
    }
  }]
}

```
