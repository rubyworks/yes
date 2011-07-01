## Exclusive Constraint

### Boolean

Given a schema with an `exclusive` constraint using a boolean value:

    ---
    //foo:
      exclusive: true

And a YAML document that has that includes a matching node:

    ---
    - foo: true

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks a matching node:

    ---
    - foo: true
    - foo: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

### YPath

Given a schema with an `exclusive` constraint using a YPath value:

    ---
    //foo:
      exclusive: //bar

And a YAML document that has that includes a matching node:

    ---
    - foo: true
    - gah: true

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks a matching node:

    ---
    - foo: true
    - bar: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

The above covers the basics of exclusive constraints. The following will test
a large set of exclusive scenarios stored in [fixtures/exclusive.yml](fixtures/exclusive.yml).

    Table('fixtures/exclusive.yml', :stream=>true) do |set|
      yes = YES::Lint.new(set['schema'])
      errors = yes.validate(set['data'])
      errors.assert == set['assert']
    end

