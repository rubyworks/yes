## Range Constraint

### Fixed Range

Given a schema with a `range` constraint using a single value,
e.g. `1` then the range is equivalent to `1..1`:

    ---
    //foo:
      range: 1

And a YAML document that has matching nodes:

    ---
    - foo: 1

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks matching nodes: 

    ---
    - foo: 2

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

### Range

Given a schema with a `range` constraint using a fixed range:

    ---
    //foo:
      range: 1..2

And a YAML document that has matching nodes:

    ---
    - foo: 1
    - foo: 2

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks matching nodes: 

    ---
    - foo: 3

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

### Range N

Given a schema with a `range` constraint using a range from a fixed number
to `n`, respesenting infinity:

    ---
    //foo:
      range: 2..n

And a YAML document that has matching nodes:

    ---
    - foo: 2
    - foo: 3

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks matching nodes: 

    ---
    - foo: 1

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

TODO: more detailed assertions on returned errors list.

The above covers the basics of range constraints. The following
will test a large set of range scenarios stored in [range.yml](range.yml).

    Table('fixtures/range.yml', :stream=>true) do |set|
      yes = YES::Lint.new(set['schema'])
      errors = yes.validate(set['data'])
      errors.assert == set['assert']
    end

QED.
