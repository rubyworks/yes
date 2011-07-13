## Sub-Selecting Nodes with Map Field

The `map` field, while appearing alongside constraint definitions
in the schema, is not actually a constraint, but rather a sub-ypath
selector that combines the parent ypath with the mapping keys 
that are given under it. This provides a convenient way to keep
sub-paths local to their parent nodes, rather then create separate
long-name ypath entries. Obviously the `map` field only effectively
applies to mapping nodes.

Lets' take an example of the more explicit form:

    ---
    foo:
      type: map
    foo/bar:
      type: str

This can be writ instead, Given a schema with a `map` field:

    ---
    foo:
      type: map
      map:
        bar:
          type: str

And a YAML document that includes a matching node:

    ---
    foo:
      bar: okay

Then validation of the YAML document with the schema will
be valid and retun no validation errors.

    yes = YES::Lint.new(@schema)
    errors = yes.validate(@yaml)
    errors.assert.empty?

If given a YAML document that lacks a matching node:

    ---
    foo:
      bar: 0

Then the validation will return errors.

    errors = yes.validate(@yaml)
    errors.refute.empty?

