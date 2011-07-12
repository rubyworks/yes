= YPath Index

Given a YAML document:

    ---
    foo: "foo1"
    bar:
      foo: "foo2"
      baz: "baz"

Lets let try out some YPaths.

    s = @yaml.select('foo')

    s.size.assert == 1

    s1 = s.first
    s1.value.assert == "foo1"

Try another

    s = @yaml.select('//foo')

    s.size.assert == 2

    s1 = s.last
    s1.value.assert == "foo2"

