## Length Constraint

### Fixed Length

Given a schema with a `length` constraint using a single number:

    ---
    //foo:
      length: 1

And a YAML document that has that number of nodes:

    ---
    - foo: "A"

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks the right number of nodes: 

    ---
    - foo: "AB"

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

### Range

Given a schema with a `length` constraint using a fixed range:

    ---
    //foo:
      count: 1..2

And a YAML document that has that range of nodes:

    ---
    - foo: "A"
    - foo: "AB"

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks the right number of nodes: 

    ---
    - foo: ""
    - foo: "ABC"

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

### Range N

Given a schema with a `length` constraint using a range from a fixed number
to `n`, respesenting infinity:

    ---
    //foo:
      count: 2..n

And a YAML document that has such a range of nodes:

    ---
    - foo: "AB"
    - foo: "ABC"

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks the right number of nodes: 

    ---
    - foo: "A"

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

TODO: more detailed assertions on returned errors list.

The above covers the basics of length constraints. The following will test
a large set of length scenarios stored in [fixtures/length.yml](fixtures/length.yml).

    Table('fixtures/length.yml', :stream=>true) do |set|
      yes = YES::Lint.new(set['schema'])
      errors = yes.validate(set['data'])
      errors.assert == set['assert']
    end

QED.
