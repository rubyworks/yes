## Requires Constraint

Given a schema with a `requires` constraint:

    ---
    /foo:
      requires:
        - bar

And a YAML document that has the required path:

    ---
    foo: 
      bar: true

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    yes.validate(@yaml).assert.empty?

Given a YAML document that lacks the required path: 

    ---
    foo: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

TODO: more detailed assertions on returned errors list.

