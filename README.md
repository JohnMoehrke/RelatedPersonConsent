# RelatedPerson Consent

An experimental FHIR implementation guide for documenting when a patient's
relationship with a representative is justified or authorized by a Consent.

Formal publication: https://johnmoehrke.github.io/RelatedPersonConsent

CI build: http://build.fhir.org/ig/JohnMoehrke/RelatedPersonConsent/branches/main/index.html

Source repository: https://github.com/JohnMoehrke/RelatedPersonConsent

## Blog Article

### Using FHIR Consent to Explain and Authorize a RelatedPerson

Healthcare systems often need to represent more than the fact that another
person is associated with a patient. A parent may represent a child, an adult
may appoint a lawyer to manage records, a guardian may be assigned for a patient
who lacks competency, or a court may appoint someone to act on the patient's
behalf. In each case, the relationship is important, but the relationship alone
does not fully describe the authority being exercised.

FHIR provides `RelatedPerson` for the relationship and `Consent` for the
patient's privacy and authorization decisions. Keeping those responsibilities
separate makes the model more useful. The `RelatedPerson` says who the person
is and how that person relates to the patient. The `Consent` says why the
relationship is recognized, who is granting or enforcing it, what policy applies,
and which activities or information may be accessed.

The central pattern is a patient-specific link between the resources. The
`RelatedPerson.patient` identifies the patient. The `Consent.patient` identifies
the same patient. The Consent's root provision is a permit, and its
`provision.actor.reference` identifies the `RelatedPerson` receiving delegated
authority. The actor role identifies that the person is acting as a delegatee,
while the purpose and other provision elements can narrow the authorization.

This arrangement also gives an implementation a practical discovery mechanism.
An access-control service can search for Consents by actor, confirm that the
Consent applies to the requested patient, and evaluate whether the Consent is
active and within its effective period. It can then apply the purpose, action,
security label, class, period, and data restrictions represented in the
provision. The service does not need to treat a relationship such as `father` or
`guardian` as an unrestricted access grant.

The source of the decision matters. A signed authorization, court appointment,
or other legal instrument may contain details that should not be reduced to a
single FHIR code. The Consent can point to that evidence through
`sourceReference`, typically a `DocumentReference` with a `Binary` when the
document content must be retained. The Consent is the organization's actionable
interpretation of that evidence; it is not a replacement for the evidence or a
universal statement of legal authority.

There is an important implementation tradeoff around discoverability. The guide
defines an `authorizingConsent` extension on `RelatedPerson`, which lets a client
follow the relationship directly to its Consent. That convenience creates a
two-way reference, however. A system may need to create the RelatedPerson,
create the Consent that references it, and then update the RelatedPerson with
the Consent reference. Alternatively, the system can avoid the extension and
discover the relationship through the Consent actor search parameter. The right
choice depends on the server's search, transaction, and lifecycle behavior.

Finally, the Consent should not be mistaken for the process that creates it. A
patient nomination, clinical review, legal review, and final approval are
workflow steps. They can be represented with `Task` or other workflow resources.
The Consent is the event record produced when the organization has a decision it
can apply. Separating workflow from the resulting authorization keeps
`Consent.status` focused on the authorization rather than turning it into a
workflow state machine.

The guide's examples show the Patient, RelatedPerson, source DocumentReference,
and authorizing Consent together:

- [Patient](https://johnmoehrke.github.io/RelatedPersonConsent/Patient-ex-patient.html)
- [Father as RelatedPerson](https://johnmoehrke.github.io/RelatedPersonConsent/RelatedPerson-ex-father.html)
- [Consent authorizing the RelatedPerson](https://johnmoehrke.github.io/RelatedPersonConsent/Consent-ex-consent.html)

The formal publication is the stable reference for this work; the CI build shows
the current development state.

Formal publication: https://johnmoehrke.github.io/RelatedPersonConsent

CI build: http://build.fhir.org/ig/JohnMoehrke/RelatedPersonConsent/branches/main/index.html

Source repository: https://github.com/JohnMoehrke/RelatedPersonConsent
