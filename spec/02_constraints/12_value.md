## Value Constraint

The value constraint differs from other constraints in that it
actually applies a separate set of constraints on the value
of a sequence's or mapping's elements.

Given a schema with an `valuee` constraint:

    ---
    //foo:
      value:
        type: str

And a YAML document that that includes a matching node:

    ---
    foo:
      - "okay"

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks a matching node:

    ---
    foo:
      - 0

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

