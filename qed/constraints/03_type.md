## Type Constraint

Given a schema with a `type` constraint:

    ---
    //foo:
      type: str

And a YAML document that has matching nodes:

    ---
    - foo: I'm a string!

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks matching nodes: 

    ---
    - foo: 15907

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

