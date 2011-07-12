## Count Constraint

### Fixed Count

Given a schema with a `count` constraint using a single number:

    ---
    //foo:
      count: 1

And a YAML document that has that number of nodes:

    ---
    - foo: true

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks the right number of nodes: 

    ---
    - foo: true
    - foo: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

### Range

Given a schema with a `count` constraint using a fixed range:

    ---
    //foo:
      count: 1..2

And a YAML document that has that range of nodes:

    ---
    - foo: true

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks the right number of nodes: 

    ---
    - foo: true
    - foo: true
    - foo: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

### Range N

Given a schema with a `count` constraint using a range from a fixed number
to `n`, respesenting infinity:

    ---
    //foo:
      count: 2..n

And a YAML document that has such a range of nodes:

    ---
    - foo: true
    - foo: true
    - foo: true

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks the right number of nodes: 

    ---
    - foo: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

TODO: more detailed assertions on returned errors list.

