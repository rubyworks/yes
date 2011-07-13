## YPath by Tag

Given a YAML document:

    ---
    foo: "foo1"
    bar: !example
      foo: "foo2"
      baz: "baz"

It would be nice if we could select nodes by tag, like:

    s = @yaml.select('!example')

    s.size.assert == 1

    s1 = s.first
    s1.type.assert == "map"

But this does not work at this time.

