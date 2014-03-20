## Required Constraint

Given a schema with a `required` constraint:

    ---
    //foo:
      required: true

And a YAML document that hasthe required path:

    ---
    foo: true

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    yes.validate(@yaml).assert.empty?

If given a YAML document that lacks the required path: 

    ---
    bar: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

TODO: more detailed assertions on returned errors list.



