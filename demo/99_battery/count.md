## Count Validation

Given a Schema:

    ---
    //foo:
      count: 1

Then this YAML document is valid:

    ---
    foo: true

And this YAML document is valid:

    ---
    foo: true
    bar: true

But this YAML document is not valid:

    ---
    - foo: true
    - foo: true


