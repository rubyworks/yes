## Inclusive Constraint

### Boolean

Given a schema with an `inclusive` constraint using a boolean value:

    ---
    //foo:
      inclusive: true

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
    - bar: true
    - baz: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

### YPath

Given a schema with an `inclusive` constraint using a YPath value:

    ---
    //foo:
      inclusive: //bar

And a YAML document that has that includes a matching node:

    ---
    - foo: true
    - bar: true

Then validation of the YAML document with the schema will
ve valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks a matching node:

    ---
    - foo: true
    - baz: true

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

