## Exclusive Constraints

As a reminder, exclusion can either be a boolean expression, in which case
it validates that there is no more than one matching node, or the value
is taken to be a YPath and validates that there are no matching paths
if the main selection is present.

### Boolean Cases

Given a Schema:

    ---
    //foo:
      exclusive: true

Then this YAML document is valid:

    ---
    - foo: true

And this YAML document is valid:

    ---
    - foo: true
    - bar: true

But this YAML document is not valid:

    ---
    - foo: true
    - foo: false

### YPath Cases

Given a Schema:

    ---
    //foo:
      exclusive: //bar

Then this YAML document is valid:

    ---
    - foo: true

But this YAML document is not valid:

    ---
    - foo: true
    - bar: false

