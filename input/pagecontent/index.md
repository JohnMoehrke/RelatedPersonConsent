<div markdown="1" class="dragon">

This is an experimental IG.

</div>

<div class="note-to-balloters">

Note to balloters

</div>

<div class="stu-note">

STU Note

</div>

This IG focuses on a use-case where the existence of a representative (e.g. guardian) is backed by a rationale and agreement from the Patient. Specifically some cases:
1. When the Patient is a minor and the representative is a parent.
2. When an adult Patient is physically or mentally competent, but still wants to appoint a representative to manage his/her medical records (e.g., a Lawyer).
3. When the Patient does not have competency to manage their medical records, thus some representative is assigned.
4. When the courts appoint a representative.

There may be more, but this list gives us a set of perspectives upon the reason why there is a need for a Consent to back the representative.

<div>
{%include relationships.svg%}
</div>
<br clear="all">

Thus
- Patient resource is used to identify the Patient
- RelatedPerson resource is used to identify the representative
- Consent resource is used to document the Patient agreement with the representative. This might further be used in advanced cases to define what the RelatedPerson is allowed to do, and thus differentiate between multiple RelatedPerson resources a division of responsibilities.


### Relationship between RelatedPerson and Consent

The RelatedPerson resource would be the way that most will document a relationship between a patient and a representative (e.g., guardian). It is a clear link between the Patient and the other person.  However the RelatedPerson does not have anywhere to explain the details of why the relationship exists, or any conditions on the relationship. There is a RelatedPerson.relationship that can be used to differentiate some roles, but this is very coarse level.
- RelatedPerson.relationship has a clear code for Father, Mother, etc.

It is not clear to me that the RelatedPerson needs to have some indication that there is a Consent explaining the rationale. One would determine this by searching for Consents that point at the RelatedPerson instance.  It is possible that the RelatedPerson.relationship could hold normal codes explaining the relationship, and one more that indicates that a rationale is available. Not clear that is proper or needed. It is also possible that there should be an element in RelatedPerson to point at the Consent, but I am not sure yet about that either.

Thus for any given RelatedPerson, one can look for Consent.provision.actor.references that include the RelatedPerson.id value. this can be done by searching on Consent using the actor parameter:

>   GET [path]/Consent?actor=RelatedPerson/1234

might be good to make sure the Consent is for that patient, and that the Consent is PERMITing that RelatedPerson... etc...

There are other rules that might be possible to do with invariants, but I just itemize them:
- The RelatedPerson.patient must be the same as the Consent.patient
- The Consent.provision.agent.reference must be the same as the RelatedPerson.id
- The Consent is authorizing (permit) the RelatedPerson, and is not expired.

#### Authorizing Consent Extension

This may seem cumbersome, so I was thinking that an extension in RelatedPerson that explicitly points at the Consent would be more appropriate. 
* [Extension for indicating a Consent justifies / authorizes](StructureDefinition-JFM-authorizingConsent.html)

Thus in this IG [there is a minimal profile on RelatedPerson](StructureDefinition-AuthorizedRelatedPerson.html) that simply indicates that this extension is needed.

Note that this extension does make the creation of the Consent and RelatedPerson resources difficult as they both reference each-other. Thus from a purely REST perspective one needs to create the RelatedPerson resource, then create the Consent that points at the RelatedPerson, then UPDATE the RelatedPerson to add the extension that points back at the Consent. This kind of double pointers is discouraged in REST and in FHIR.

### Consent profiling

As with any Consent, often there is paperwork that ultimately holds the legal details. This legal paperwork is critical to overall legal precedent, and represents the ceremony of the act of consent from the patient. These details should be captured by a DocumentReference and Binary. The Consent.sourceReference would then point at that DocumentReference. (Could use Consent.sourceAttachment, but I am not a fan of bloating the Consent with that detail).

The Consent then would need to be profiled. The main difference from the FHIR core [Consent](http://hl7.org/fhir/consent.html) I outlined in my [Consent article](https://healthcaresecprivacy.blogspot.com/2022/05/explaining-fhir-consent-examples.html) is that this might be a specific kind of [Privacy Consent delegating authority](StructureDefinition-RelatedPersonConsent.html), and the RelatedPerson instance would be indicated specifically in the .provision.agent.

- status - would indicate active
- category - would indicate patient consent, specifically a delegation of authority
- patient - would indicate the Patient resource reference for the given patient
- dateTime - would indicate when the privacy policy was presented
- performer - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
- organization - would indicate the Organization that presented the privacy policy, and that is going to enforce that privacy policy
- source - would point at the specific signed consent by the patient
- policy.uri - would indicate the privacy policy that was presented. Usually, the url to the version-specific policy
- provision.type - permit - given there is no way to deny, this would be fixed at permit.
- provision.agent.reference - would indicate the RelatedPerson resource
- provision.agent.role - would indicate this agent is delegated authority
- provision.purpose - would indicate some set of [authorized purposeOfUse](ValueSet-AuthPurposesVS.html)

In the case where the court or some actor that is not the Patient is compelling the RelatedPerson relationship, then the Consent.performer would indicate that the Patient is not the one granting the relationship, but rather the guardian or the courts.

#### using Consent to enable access control

One advantage of using a Consent resource as defined here is that there would be a natural set of provisions in a Consent that would be processable by an Access Control engine that understands Consent. This Access Control engine would not need to understand RelatedPerson, other than to know that a given user is a RelatedPerson (vs Patient, Person, Practitioner, etc). Thus the Consent.permit rules are used to mediate access to that Patient's data by that given user.

### Consideration

Given this setup, a newborn would need a Consent drafted as soon as that newborn has a Patient resource to enable the parents' access. This could be done by the system creating the newborn Patient resource. This could also be done using Implied Consent mechanisms, which is a default policy that is used when no Consent exists for a given Patient->agent relationship. 

Same is true for any new Patient for which there is some precedent for implied consent representative. 

Forcing a Consent to exist does prove that the representative relationship is explicit, and is thus more transparent. Implied representative relationships are common, but not very transparent.


### Workflow of capturing the Consent

The Consent resource is not intended to be used to drive the workflow of the capturing of the Consent. The Consent is following the "Event Pattern", which means that it is the output of an event.  The workflow that preceded this event would need to be managed by other resources in the [Request pattern](http://build.fhir.org/workflow.html#respatterns)

The Task resource is generic and can do this work. There are some specializations of Task, so we could end up at some kind of a Task derivative that is specific to the workflow leading up to a Consent. However it is first best to see if Task can be profiled to address the workflow. 

For example a use-case where the Patient nominates a potential Person to become their RelatedPerson; that triggering a GP to review and approve it; that triggering some legal review and approval; resulting in a Consent instance and the creation of the RelatedPerson. This workflow could be profiled into an ActivityDefinition... I like the power of this modeling concept, but have not done it formally so am not sure of all the possible issues.

Note we have tried to keep workflow states out of the Consent.status; but some states have gotten in that I don't think are proper. But at this time we allow them in until there is a more formal task flow.

### Examples

There is a basic example of a Patient delegating their father as their RelatedPerson. The resource objects are clickable to their examples.

<div>
{%include example.svg%}
</div>
<br clear="all">

- [Patient](Patient-ex-patient.html)
- [Father as Related Person](RelatedPerson-ex-father.html)
- [Consent from the Patient authorizing the Father as a Related Person](Consent-ex-consent.html)
