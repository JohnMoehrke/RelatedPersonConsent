
This IG focuses on a use-case where the existance of a representative is backed by a rational and agreement from the Patient. Specifically some cases:
1. When the Patient is a minor and the representative is a parent
2. When an adult Patient is physically or mentally competent, but still wants to appoint a representative to manage his/her medical records (e.g., a Lawyer)
3. When the Patient does not have competency to manage their medical records, thus some representative is assigned.
4. When the courts appoint a representative 

There may be more, but this list gives us a set of perspectives upon the reason why there is a need for a Consent to back the representative.

<div>
{%include relationships.svg%}
</div>
<br clear="all">

Thus
- Patient resource is used to indentify the Patient
- RelatedPerson resource is used to identify the representative
- Consent resource is used to document the Patient agreement with the representative. This might further be used in advanced cases to define what the RelatedPerson is allowed to do, and thus differentiate between multiple RelatedPerson a division of responsibilities.


### Relationship between RelatedPerson and Consent

The RelatedPerson resource would be the way that most will document a relationship between a patient and a representative (e.g., guardian). It is a clear link between the Patient and the other person.  However the RelatedPerson does not have anywhere to explain the details of why the relationship exists, or any conditions on the relationship. There is a RelatedPerson.relationship that can be used to differentiate some roles, but this is very corse level.
- RelatedPerson.relationship has a clear code for CHILD

It is not clear to me that the RelatedPerson needs to have some indication that there is a Consent explaining the rationale. One would determine this by searching for Consents that point at the RelatedPerson instance.  It is possible that the RelatedPerson.relationship could hold normal codes explaining the relationship, and one more that indicates that a rationale is available. Not clear that is proper or needed. It is also possible that there should be an element in RelatedPerson to point at the Consent, but I am not sure yet about that either.

Thus for any given RelatedPerson, one can look for Consent.provision.actor.references that include the RelatedPerson.id value. this can be done by searching on Consent using the actor parameter

>   GET [path]/Consent?actor=RelatedPerson/1234

might be good to make sure the Consent is for that patient, and that the Consent is PERMITing that RelatedPerson... etc...

This may seem cumbersome, so I was thinking that an extension in RelatedPerson that explicitly points at the Consent would be more appropriate. If we think this is needed, then we could put in a Change Request explaining the use-case and our solution. The committee might choose to add an element to R5 (RelatedPerson.authorization), might choose to add an extension to R5 (which can be used in R4), or might come up with some other solution.
* TODO -- profile this extension here

### Consent profiling

As with any Consent, often there is paperwork that ultimately holds the legal details. This legal paperwork is critical to overall legal precident, and represents the ceremony of the act of consent from the patient. These details should be captured by a DocumentReference and Binary. The Consent.sourceReference would then point at that DocumentReference. (Could use Consent.sourceAttachment, but I am not a fan of bloating the Consent with that detail).

The Consent then would need to be profiled. The main difference from the Consents I outlined in my Consent article is that this might be a specific kind of Privacy Consent delegating authority, and the RelatedPerson instance would be indicated specifically in the .provision.agent.

- status - would indicate active
- category - would indicate patient consent specifically a delegation of authority
- subject - would indicate the Patient resource reference for the given patient
- dateTime - would indicate when the privacy policy was presented
- grantor - would indicate who presented the privacy policy
- grantee - would indicate the Patient resource if the patient was presented, a RelatedPerson for parent or guardian
- controller - would indicate the Organization who presented the privacy policy, and which is going to enforce that privacy policy
- policyText - would indicate the privacy policy that was presented. Usually, the url to the version specific policy
- provision.type - permit - given there is no way to deny, this would be fixed at permit.
- provision.agent.reference - would indicate the RelatedPerson resource


In the case where the courts or some actor that is not the Patient is compelling the RelatedPerson relationship, then the Consent.grantor and Consent.grantee. To indicate that the Patient is not the one granting the relationship, but rather the guardian or the courts.

### using Consent to enable access control

One advantage of using a Consent resource as defined here, is that there would be a natural set of provisions in a Consent that would be processable by an Access Control engine that understands Consent. This Access Control engine would not need to understand RelatedPerson, other than to know that a given user is a RelatedPerson (vs Patient, Person, Practitioner, etc). Thus the Consent.permit rules are used to mediate acces to that Patient's data by that given user.

### Consideration

Given this setup, a newborn would need a Consent drafted as soon as that newborn has a Patient resource to enable the parents access. This could be done by the system creating the newborn Patient resource. This could also be done using Implied Consent mechanisms, which is a default policy that is used when no Consent exists for a given Patient->agent relationship. 

Same is true for any new Patient for which there is some precident for implied consent representative. 

Forcing a Consent to exist does prove that the representative relationship is explict, and is thus more transparent. Implied representative relationships are common, but not very transparent.


### Workflow of capturing the Consent

The Consent resource is not intended to be used to drive the workflow of the capturing of the Consent. The Consent is following the "Event Pattern", which means that it is the output of an event.  The workflow that preceded this event would need to be managed by other resources in the [Request pattern](http://build.fhir.org/workflow.html#respatterns)

The Task resource is generic and can do this work. There are some specializations of Task, so we could end up at some kind of a Task derivative that is specific to the workflow leading up to a Consent. However it is first best to look at if Task can be profiled to address the workflow. 

For example a use-case where the Patient nominates a potential Person to become their RelatedPerson; that triggering a GP to review and approve it; that triggering some legal review and approval; resulting in a Consent instance and the creation of the RelatedPerson. This workflow could be profiled into an ActivityDefinition... I like the power of this modeling concept, but have not done it formally so am not sure of all the possible issues.

Note we have tried to keep workflow states out of the Consent.status; but some states have gotten in that I don't think are proper. But at this time we allow them in until there is a more formal task flow.

