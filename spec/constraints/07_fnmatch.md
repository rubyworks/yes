= File Name Constraint

Given a schema with a `fnmatch` constraint:

    ---
    //path:
      fnmatch: "*.rb"

And a YAML document that has matching nodes:

    ---
    - email: foo.rb

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks matching nodes: 

    ---
    - path: foo.txt

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

