## Lint#select_nodes

The `select_nodes` method can take a YPath string or a complex selector.

A Complex selector is a mapping (i.e. a Ruby Hash) that uses node constraints
to select nodes from the document tree.

To try this out we need a Lint instance, which we will supply an empty, dummy
schema, as w won't be testing validation.

    yes = YES::Lint.new('')

Given a YAML document:

    ---
    - Choo Choo Train
    - Choo Choo Toy

Which we parse into a node tree.

    tree = YAML.parse(@yaml)

A complex selector can be used to match nodes using the #select_nodes method.

    complex_selector = { regexp: /^Choo/ }

    selected = yes.select_nodes(complex_selector, tree)

    selected.size.assert == 2

