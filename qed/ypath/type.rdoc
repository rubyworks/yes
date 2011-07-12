== YPath Type

Given a YAML document:

    ---
    foo: "foo1"
    bar: !example
      foo: "foo2"
      baz: "baz"

Lets let try out some YPaths.

    s = @yaml.select('!example')

    s.size.assert == 1

    s1 = s.first
    s1.type.assert == "map"

