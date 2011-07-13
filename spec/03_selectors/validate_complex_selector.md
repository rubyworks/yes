## Using a Complex Selector

Given a schema with a hash based selector:

    ---
    ? { regexp: /^Choo/ }
    : { count: 2 }

And a YAML document that has matching nodes:

    ---
    - Choo Choo Train
    - Choo Choo Toy

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)

    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks matching nodes: 

    ---
    - Choo Choo Train

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

