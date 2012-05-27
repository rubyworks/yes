## Tag Constraint

Given a schema with a `type` constraint:

    ---
    //name:
      tag: '<tag:yes.com,2011:name>'

And a YAML document that has matching nodes:

    ---
    - name: !!<tag:yes.com,2011:name> Choo Choo Train

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks matching nodes: 

    ---
    - name: Jar Jar Binks

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

