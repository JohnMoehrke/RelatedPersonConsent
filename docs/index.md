# RelatedPerson Consent - JohnMoehrke RelatedPerson Consent v0.1.0

* [**Table of Contents**](toc.md)
* **RelatedPerson Consent**

## RelatedPerson Consent

| | |
| :--- | :--- |
| *Official URL*:http://johnmoehrke.github.io/RelatedPersonConsent/ImplementationGuide/johnmoehrke.relatedpersonconsent.example | *Version*:0.1.0 |
| Draft as of 2026-08-18 | *Computable Name*:JohnMoehrkeRelatedPersonConsent |
| *Other Identifiers:*OID:1.3.6.1.4.1.66281.5 | |

This is an experimental IG.

Note to balloters

STU Note

### Scope

This guide addresses situations in which a patient has a representative who may act for the patient or access the patient's information. Examples include a parent representing a minor, an adult appointing a Durable Power of Attorney (POA) or a court appointing a representative.

The existence of a relationship and the authority granted through that relationship are related but distinct facts. A `RelatedPerson` identifies the person and their relationship to the patient. A `Consent` records the rationale, authorization, and conditions that an organization can apply.

The guide does not determine whether a person is legally entitled to act as a representative; that determination and its supporting evidence remain the responsibility of the implementing organization and applicable law.

### Solution

The guide defines a `RelatedPersonConsent` profile and an `AuthorizedRelatedPerson` profile. The model:

* uses `Patient` to identify the person whose information or authority is at issue;
* uses `RelatedPerson` to identify the representative and their relationship to the patient;
* uses `Consent.provision.actor` to identify the related person authorized by the Consent;
* uses `Consent.sourceReference` to link the Consent to the signed paperwork or other source document; and
* uses the Consent's permit provisions, purpose, action, security label, class, period, and data elements to describe the scope of access when that scope must be enforced.

The `RelatedPersonConsent` profile requires an active patient-privacy Consent, the patient, the presenting or enforcing organization, and at least one related person as the provision actor. A source reference to the signed paperwork or other legal instrument is recommended when that evidence can be exchanged and the organization is authorized to publish it. The `AuthorizedRelatedPerson` profile provides an optional `authorizingConsent` extension for systems that want the RelatedPerson to point directly back to the Consent.

### Use Cases and Resource Model

The pattern applies whenever a representative relationship needs more context than a relationship code can provide. Examples include a parent representing a minor, an adult appointing a Durable Power of Attorney (POA), a representative assigned because the patient lacks competency, or a court-appointed representative.

The resource responsibilities are deliberately separate:

* `Patient` identifies the person whose information or authority is involved.
* `RelatedPerson` identifies the representative and their relationship to the patient.
* `Consent` records the authorization, rationale, and enforceable conditions.
* `DocumentReference` and, when appropriate, `Binary` retain the source paperwork.

The diagram shows how these resources support the pattern:

```
classDiagram
class Patient {
subject of the consent
}
class RelatedPerson {
representative
relationship
patient
authorizingConsent
}
class RelatedPersonConsent {
status: active
scope: patient-privacy
category: delegation of authority
patient
sourceReference
provision.type: permit
provision.actor.reference
provision.actor.role: delegatee
provision.purpose
}
class DocumentReference {
signed consent paperwork
status
type
subject
content
}
class Organization {
organization presenting and enforcing the consent
}

RelatedPersonConsent --> Patient : patient
RelatedPersonConsent --> RelatedPerson : provision.actor
RelatedPersonConsent --> DocumentReference : sourceReference
RelatedPersonConsent --> Organization : organization
RelatedPerson --> Patient : patient
RelatedPerson --> RelatedPersonConsent : authorizingConsent
DocumentReference --> Patient : subject

```

### Finding and Linking the Authorization

The `RelatedPerson.relationship` code identifies roles such as father, mother, guardian, or lawyer, but it does not by itself grant access. The authorization is found in the Consent that points to the same patient and identifies the RelatedPerson in `Consent.provision.actor`.

An implementation can locate candidate Consents with the actor search parameter:

```
GET [path]/Consent?actor=RelatedPerson/1234

```

The implementation should then confirm that the Consent is for the same patient, is active and within its applicable period, and contains an applicable permit provision for the related person. The following consistency rules describe the intended links:

* `RelatedPerson.patient` matches `Consent.patient`.
* `Consent.provision.actor.reference` identifies the `RelatedPerson`.
* The Consent is applicable and permits the related person's authorized activity.

The optional `authorizingConsent` extension on `RelatedPerson` provides a direct back-link for systems that want easier navigation. It creates a reciprocal reference, so a REST workflow may need to create the RelatedPerson, create the Consent, and then update the RelatedPerson with the Consent reference. Systems that do not need the back-link can use the Consent actor search instead.

### Consent Profiling

The source paperwork may contain legal or organizational details that should not be reduced to a single FHIR code. Capture that evidence in a `DocumentReference` and, when appropriate, a `Binary`; the Consent's `sourceReference` points to the document. The Consent is the organization's actionable interpretation of that evidence, not a replacement for the source document.

The [RelatedPersonConsent profile](StructureDefinition-RelatedPersonConsent.md) constrains the FHIR core [Consent](http://hl7.org/fhir/consent.html) for this delegation use case:

* status - would indicate active
* category - would indicate patient consent, specifically a delegation of authority
* patient - would indicate the Patient resource reference for the given patient
* dateTime - would indicate when the privacy policy was presented
* performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
* organization - would indicate the Organization that presented the privacy policy, and that is going to enforce that privacy policy
* sourceReference - would point at the specific signed consent by the patient
* policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
* provision.type - permit - authorizes the RelatedPerson as a delegatee; nested provisions may deny specific exceptions.
* provision.actor.reference - would indicate the RelatedPerson resource
* provision.actor.role - would indicate this actor is delegated authority
* provision.purpose - would indicate some set of [authorized purposeOfUse](ValueSet-AuthPurposesVS.md)

In cases where a court or another actor compels the relationship, rather than the patient granting it, `Consent.performer` can identify the guardian, court, or other responsible actor.

### Access-Control Use

An access-control engine can process the Consent provisions without inferring authority from a relationship code. It can identify the requesting person as a `RelatedPerson`, find the applicable Consent, and evaluate the permit rule for the patient and requested purpose. It can then apply the provision's purpose, action, security label, class, period, and data restrictions.

This pattern does not make every related person automatically authorized. The organization must still evaluate the source evidence, policy, current status, and applicable law before enforcing access.

### Representative Activities and Fine-Grained Restrictions

A representative may be permitted to perform activities beyond simply viewing information. Candidate healthcare representative activities include:

* reviewing the patient's chart, notes, results, and care plans;
* requesting copies of records or authorizing disclosure to another person or organization;
* communicating with physicians, nurses, therapists, pharmacies, and other members of the care team;
* participating in care planning, referrals, discharge planning, and service coordination;
* scheduling, changing, or cancelling appointments;
* selecting providers, facilities, or services when the authority includes those decisions;
* advising on, agreeing to, declining, or withdrawing consent for examinations, procedures, medications, and other treatments;
* making decisions about admission, transfer, home care, rehabilitation, or hospice services;
* managing healthcare billing, insurance communication, and claims when those financial activities are included in the authority; and
* receiving notices and other communications needed to exercise the delegated healthcare authority.

Activities that should be considered for explicit restriction or separate authorization include:

* access to specially protected mental-health, substance-use-disorder, reproductive-health, sexual-health, genetic, or infectious-disease records;
* disclosure of the patient's information to named third parties, employers, insurers, or organizations outside the care team;
* decisions to start, stop, or substantially change life-sustaining treatment;
* psychiatric admission, restraint, seclusion, or other behavioral-health interventions;
* participation in research, clinical trials, or secondary use of the patient's data;
* organ, tissue, or donation decisions;
* reproductive decisions or procedures;
* financial transactions beyond communicating with a payer or handling a healthcare claim; and
* actions that remain the patient's personal decision or require a separate legal appointment under applicable law.

These are candidate activity categories, not a statement of legal authority. A system should represent permitted or denied activities using the Consent's purpose, action, security label, class, period, and data elements when those restrictions must be evaluated by an access-control engine. It should retain the source legal instrument and document any activation, expiration, revocation, or restriction that affects the decision.

The standard PurposeOfUse vocabulary does not provide a sufficiently fine-grained code for every representative activity. For example, `PWATRNY` identifies a request by a legal representative, but it does not distinguish reviewing records from authorizing treatment, selecting a facility, approving a transfer, or consenting to research enrollment. Codes such as `PATADMIN` or `CLINTRCH`, where applicable, describe the context of information operations; they do not by themselves grant the representative authority to make the underlying decision.

Implementations that need more than broad representative authorization should define and bind appropriate fine-grained codes, preferably in a governed action or purpose CodeSystem, or define a well-documented extension on `Consent.provision`. Candidate codes could distinguish treatment authorization, transfer authorization, research enrollment authorization, provider selection, and authorization to disclose information to named parties. Those codes would allow each activity to be represented by an independent permit or deny provision and evaluated consistently by an access-control engine. Until such codes are defined and legally mapped, the Consent should be understood as expressing only the broad representative authority supported by the source legal instrument.

### Considerations

Given this setup, a newborn would need a Consent drafted as soon as that newborn has a Patient resource to enable the parents' access. This could be done by the system creating the newborn Patient resource. This could also be done using Implied Consent mechanisms, which is a default policy that is used when no Consent exists for a given Patient->agent relationship.

Same is true for any new Patient for which there is some precedent for implied consent representative.

Forcing a Consent to exist does prove that the representative relationship is explicit, and is thus more transparent. Implied representative relationships are common, but not very transparent.

### Workflow

The Consent resource is not intended to be used to drive the workflow of the capturing of the Consent. The Consent is following the "Event Pattern", which means that it is the output of an event. The workflow that preceded this event would need to be managed by other resources in the [Request pattern](http://build.fhir.org/workflow.html#respatterns)

The Task resource is generic and can do this work. There are some specializations of Task, so we could end up at some kind of a Task derivative that is specific to the workflow leading up to a Consent. However it is first best to see if Task can be profiled to address the workflow.

For example a use-case where the Patient nominates a potential Person to become their RelatedPerson; that triggering a GP to review and approve it; that triggering some legal review and approval; resulting in a Consent instance and the creation of the RelatedPerson. This workflow could be profiled into an ActivityDefinition… I like the power of this modeling concept, but have not done it formally so am not sure of all the possible issues.

Note we have tried to keep workflow states out of the Consent.status; but some states have gotten in that I don't think are proper. But at this time we allow them in until there is a more formal task flow.

### Examples

Two examples given

#### Child delegating their Father

There is a basic example of a Patient delegating their father as their RelatedPerson. The resource objects are clickable to their examples.

* [Child Patient](Patient-ex-child.md)
* [Father as Related Person](RelatedPerson-ex-father.md)
* [Consent from the Patient authorizing the Father as a Related Person](Consent-ex-consent.md)

Note: This Consent simply indicates that the father is a delegatee for the child. This presumes that the definition of delegatee is clear enough, and that there are no restrictions on that "clear enough" definition. It might not be reasonable to assume that the delegatee is clear enough, and that there are no restrictions on that "clear enough" definition. In that case, the consent would need to be more specific about what activities the father is allowed to do.

#### Elderly indicating a legal representative

Durable Power of Attorney (POA). Note that typically an Advanced Directive would be common along with this, this IG is not covering Advanced Directive.

* [Elderly Patient](Patient-ex-elderly.md)
* [Attorney](RelatedPerson-ex-attorney.md)
* [Consent authorizing Power of Attorney](Consent-ex-poa.md)

The Consent identifies the attorney as having a healthcare Power of Attorney, but the purpose code alone does not establish every activity that the attorney may perform. The legal instrument, its activation conditions, the patient's capacity, and applicable jurisdiction determine the actual authority. The Consent should make the organization's enforceable interpretation explicit when a broad role is not sufficient.

In this example, the root permit is narrowed by nested deny provisions. The attorney is denied access to patient data carrying the `R` (restricted) or `V` (very restricted) confidentiality label, even though the attorney has broad Power of Attorney authority for other permitted activities.



## Resource Content

```json
{
  "resourceType" : "ImplementationGuide",
  "id" : "johnmoehrke.relatedpersonconsent.example",
  "url" : "http://johnmoehrke.github.io/RelatedPersonConsent/ImplementationGuide/johnmoehrke.relatedpersonconsent.example",
  "version" : "0.1.0",
  "name" : "JohnMoehrkeRelatedPersonConsent",
  "title" : "JohnMoehrke RelatedPerson Consent",
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
  "description" : "This Implementation Guide addresses RelatedPerson representative rational and authorization using a Consent resource.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "http://unstats.un.org/unsd/methods/m49/m49.htm",
      "code" : "001"
    }]
  }],
  "packageId" : "johnmoehrke.relatedpersonconsent.example",
  "license" : "CC-BY-4.0",
  "fhirVersion" : ["4.0.1"],
  "dependsOn" : [{
    "id" : "hl7tx",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on HL7 Terminology"
    }],
    "uri" : "http://terminology.hl7.org/ImplementationGuide/hl7.terminology",
    "packageId" : "hl7.terminology.r4",
    "version" : "7.3.0"
  },
  {
    "id" : "hl7ext",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on the HL7 Extension Pack"
    }],
    "uri" : "http://hl7.org/fhir/extensions/ImplementationGuide/hl7.fhir.uv.extensions",
    "packageId" : "hl7.fhir.uv.extensions.r4",
    "version" : "5.3.0"
  }],
  "definition" : {
    "extension" : [{
      "extension" : [{
        "url" : "code",
        "valueString" : "copyrightyear"
      },
      {
        "url" : "value",
        "valueString" : "2022+"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "releaselabel"
      },
      {
        "url" : "value",
        "valueString" : "ci-build"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "show-inherited-invariants"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "usage-stats-opt-out"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "logging"
      },
      {
        "url" : "value",
        "valueString" : "progress"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "shownav"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "active-tables"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-contact"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-jurisdiction"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-publisher"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-version"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "auto-oid-root"
      },
      {
        "url" : "value",
        "valueString" : "1.3.6.1.4.1.66281.5"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "autoload-resources"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "template/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "input/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-qa"
      },
      {
        "url" : "value",
        "valueString" : "temp/qa"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-temp"
      },
      {
        "url" : "value",
        "valueString" : "temp/pages"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-output"
      },
      {
        "url" : "value",
        "valueString" : "output"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-suppressed-warnings"
      },
      {
        "url" : "value",
        "valueString" : "input/ignoreWarnings.txt"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-history"
      },
      {
        "url" : "value",
        "valueString" : "http://johnmoehrke.github.io/RelatedPersonConsent/history.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "template-html"
      },
      {
        "url" : "value",
        "valueString" : "template-page.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "template-md"
      },
      {
        "url" : "value",
        "valueString" : "template-page-md.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-context"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-copyright"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-license"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-wg"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "fmm-definition"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/versions.html#maturity"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "propagate-status"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "excludelogbinaryformat"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "tabbed-snapshots"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-internal-dependency",
      "valueCode" : "hl7.fhir.uv.tools.r4#1.1.2"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "copyrightyear"
      },
      {
        "url" : "value",
        "valueString" : "2022+"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "releaselabel"
      },
      {
        "url" : "value",
        "valueString" : "ci-build"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "show-inherited-invariants"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "usage-stats-opt-out"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "logging"
      },
      {
        "url" : "value",
        "valueString" : "progress"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "shownav"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "active-tables"
      },
      {
        "url" : "value",
        "valueString" : "false"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-contact"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-jurisdiction"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-publisher"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-version"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "auto-oid-root"
      },
      {
        "url" : "value",
        "valueString" : "1.3.6.1.4.1.66281.5"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "autoload-resources"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "template/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "input/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-qa"
      },
      {
        "url" : "value",
        "valueString" : "temp/qa"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-temp"
      },
      {
        "url" : "value",
        "valueString" : "temp/pages"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-output"
      },
      {
        "url" : "value",
        "valueString" : "output"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-suppressed-warnings"
      },
      {
        "url" : "value",
        "valueString" : "input/ignoreWarnings.txt"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-history"
      },
      {
        "url" : "value",
        "valueString" : "http://johnmoehrke.github.io/RelatedPersonConsent/history.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "template-html"
      },
      {
        "url" : "value",
        "valueString" : "template-page.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "template-md"
      },
      {
        "url" : "value",
        "valueString" : "template-page-md.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-context"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-copyright"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-license"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-wg"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "fmm-definition"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/versions.html#maturity"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "propagate-status"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "excludelogbinaryformat"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "tabbed-snapshots"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    }],
    "resource" : [{
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-AuthPurposesVS.html"
      }],
      "reference" : {
        "reference" : "ValueSet/AuthPurposesVS"
      },
      "name" : "Authorization purposes for delegation access valueset",
      "description" : "ValueSet of the Authorized purposesOfUse types",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-AuthorizedRelatedPerson.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/AuthorizedRelatedPerson"
      },
      "name" : "Authorized RelatedPerson",
      "description" : "A RelatedPerson that has been justified and authorized by the Patient.\n\n- The RelatedPerson.patient must be the same as the Consent.patient\n- The Consent.provision.actor.reference must be the same as the RelatedPerson.id\n- The Consent is authorizing (permit) the RelatedPerson, and is not expired.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Patient"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Patient-ex-child.html"
      }],
      "reference" : {
        "reference" : "Patient/ex-child"
      },
      "name" : "Child Patient",
      "description" : "Child Patient",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Consent"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Consent-ex-poa.html"
      }],
      "reference" : {
        "reference" : "Consent/ex-poa"
      },
      "name" : "Consent of Elderly giving Power of Attorney",
      "description" : "Consent justifying RelatedPerson (the attorney) and authorizing power of attorney, and limited access to non-sensitive information.",
      "exampleCanonical" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/RelatedPersonConsent"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-RelatedPersonConsent.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/RelatedPersonConsent"
      },
      "name" : "Consent profile for a RelatedPerson relationship",
      "description" : "This defines the constraints on a Consent to indicate that a Patient has agreed and authorizes a Related Person.\n\n- status - would indicate active\n- category - would indicate patient consent specifically a delegation of authority\n- patient - would indicate the Patient resource reference for the given patient\n- dateTime - would indicate when the privacy policy was presented\n- performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian\n- organization - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy\n- source - would point at the specific signed consent by the patient\n- policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version specific policy\n- provision.type - permit - authorizes the RelatedPerson as a delegatee; nested provisions may deny specific exceptions.\n- provision.actor.reference - would indicate the RelatedPerson resource\n- provision.actor.role - would indicate this actor is delegated authority\n- provision.purpose - would indicate the purpose of the information activity; it does not by itself establish that the RelatedPerson is the clinician or decision-maker for that activity.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-AuthorizedCodes.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/AuthorizedCodes"
      },
      "name" : "Consent type that is authorizing a RelatedPerson",
      "description" : "CodeSystem for authorizing Consent types for a RelatedPerson",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "DocumentReference"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "DocumentReference-ex-documentreference.html"
      }],
      "reference" : {
        "reference" : "DocumentReference/ex-documentreference"
      },
      "name" : "DocumentReference Consent Paperwork example",
      "description" : "DocumentReference example of the paperwork of the Consent",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "DocumentReference"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "DocumentReference-ex-powerOfAttorney.html"
      }],
      "reference" : {
        "reference" : "DocumentReference/ex-powerOfAttorney"
      },
      "name" : "DocumentReference Consent Paperwork example",
      "description" : "The Legal text with legal signature of the Durable Power of Attorney",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Patient"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Patient-ex-elderly.html"
      }],
      "reference" : {
        "reference" : "Patient/ex-elderly"
      },
      "name" : "Elderly Patient example",
      "description" : "The Elderly Patient.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-ex-organization.html"
      }],
      "reference" : {
        "reference" : "Organization/ex-organization"
      },
      "name" : "Example Organization holding the data",
      "description" : "The Organization that holds the data, and enforcing any Consents",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-JFM-authorizingConsent.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/JFM-authorizingConsent"
      },
      "name" : "Extension that points at an authorizing Consent",
      "description" : "Used within a Resource to indicate that the activity enabled by the Resource is authorized by the Consent indicated. For example: Used within a RelatedParty to indicate the Consent the Patient has given authorizing the RelatedParty relationship to exist.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "RelatedPerson"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "RelatedPerson-ex-father.html"
      }],
      "reference" : {
        "reference" : "RelatedPerson/ex-father"
      },
      "name" : "Father - Related Person",
      "description" : "Related Father of the Patient authorized by a Consent",
      "exampleCanonical" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/AuthorizedRelatedPerson"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "RelatedPerson"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "RelatedPerson-ex-attorney.html"
      }],
      "reference" : {
        "reference" : "RelatedPerson/ex-attorney"
      },
      "name" : "non-family attorney",
      "description" : "Example to show that an authorized representative might not be family",
      "exampleCanonical" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/AuthorizedRelatedPerson"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Practitioner"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Practitioner-ex-doctor.html"
      }],
      "reference" : {
        "reference" : "Practitioner/ex-doctor"
      },
      "name" : "Practitioner example doctor",
      "description" : "Practitioner example for the doctor.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-JFM-authorizingConsentRetired.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/JFM-authorizingConsentRetired"
      },
      "name" : "Retired Extension that points at an authorizing Consent",
      "description" : "Retired:\nUsed within a Resource to indicate that the activity enabled by the Resource is authorized by the Consent indicated. For example: Used within a RelatedParty to indicate the Consent the Patient has given authorizing the RelatedParty relationship to exist.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Consent"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Consent-ex-consent.html"
      }],
      "reference" : {
        "reference" : "Consent/ex-consent"
      },
      "name" : "Simple Consent example",
      "description" : "Consent justifying RelatedPerson and authorizing access by that RelatedPerson",
      "exampleCanonical" : "http://johnmoehrke.github.io/RelatedPersonConsent/StructureDefinition/RelatedPersonConsent"
    }],
    "page" : {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
        "valueUrl" : "toc.html"
      }],
      "nameUrl" : "toc.html",
      "title" : "Table of Contents",
      "generation" : "html",
      "page" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
          "valueCode" : "normative"
        },
        {
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "index.html"
        }],
        "nameUrl" : "index.html",
        "title" : "RelatedPerson Consent",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
          "valueCode" : "informative"
        },
        {
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "maturity.html"
        }],
        "nameUrl" : "maturity.html",
        "title" : "Maturity",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
          "valueCode" : "informative"
        },
        {
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "download.html"
        }],
        "nameUrl" : "download.html",
        "title" : "Downloads and Analysis",
        "generation" : "markdown"
      }]
    },
    "parameter" : [{
      "code" : "path-resource",
      "value" : "fsh-generated/resources"
    },
    {
      "code" : "path-resource",
      "value" : "input/capabilities"
    },
    {
      "code" : "path-resource",
      "value" : "input/examples"
    },
    {
      "code" : "path-resource",
      "value" : "input/extensions"
    },
    {
      "code" : "path-resource",
      "value" : "input/models"
    },
    {
      "code" : "path-resource",
      "value" : "input/operations"
    },
    {
      "code" : "path-resource",
      "value" : "input/profiles"
    },
    {
      "code" : "path-resource",
      "value" : "input/resources"
    },
    {
      "code" : "path-resource",
      "value" : "input/vocabulary"
    },
    {
      "code" : "path-resource",
      "value" : "input/testing"
    },
    {
      "code" : "path-resource",
      "value" : "input/history"
    },
    {
      "code" : "path-pages",
      "value" : "template/config"
    },
    {
      "code" : "path-pages",
      "value" : "input/images"
    },
    {
      "code" : "path-tx-cache",
      "value" : "input-cache/txcache"
    }]
  }
}

```
