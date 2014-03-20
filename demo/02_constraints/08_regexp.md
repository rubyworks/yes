= Regular Expression Constraint

Becuase regular expresion engines can vary somewhat across implementations
it is wise to stick to the basics.

Given a schema with a `regexp` constraint:

    ---
    //email:
      regexp: /@/

And a YAML document that has matching nodes:

    ---
    - email: foo@foo.net

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)

    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks matching nodes: 

    ---
    - email: 15907

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

