## Inclusive Constraints

As a reminder, inclusion can either be a boolean expression,
in which case it validates that there is at least one matching
node, or the value is taken to be a ypath and validates that
there are matching paths if the main selection is present.

### Boolean Cases

Given a Schema:

    ---
    //foo:
      inclusive: true

Then this YAML document is valid:

    ---
    foo: true

And this YAML document is valid:

    ---
    foo: true
    bar: true

But this YAML document is not valid:

    ---
    bar: true

### YPath Cases

Given a Schema:

    ---
    //foo:
      inclusive: //bar

Then this YAML document is valid:

    ---
    - foo: true
    - bar: true


