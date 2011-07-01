## Exclusive Validation

Given a Schema:

    ---
    //foo:
      exclusive: true

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

