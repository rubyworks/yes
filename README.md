YES - YAML Easy Schema
======================

## SALES PITCH

It doesn't get any easier than this!

YES is a schema system for YAML that is intuitive and extremely powerful.

YES Schemas are also YAML documents, so they eat there own dog food.


## HOW IT WORKS

The design of YeS is as simple as it is powerful. A YeS schema is composed
of YPath selectors mapped to document specifications. A YeS document can
be either a mapping or a sequence of such specifications. YPath is a syntax
for selecting *nodes* from a YAML document.

When validating a YAML document against a YeS schema a "lint" program
simply collects all matching nodes with their applicable constraints into
a collection of *unit-validations*. Then this collection is filtered of 
all *passing* validations. All that is left are the failures. If the 
filtered list is empty the document is completely valid. If not empty,
the lint program can provide a detailed *editorial* list of the failures.

Specification are generally constraints which limit possible entires in
the document. But they also can be specifiers which instruct parsers how
to interpret a document based on it's structure (as opposed to document tags).

Lets take an example schema:

    people/*/name:
      regexp: '[^/n]'

This simple schema selects all nodes under a `people` sequence of
mappings with a name key, the value of which cannot contain newlines.
In other words, this would satisfy the schema:

    people:
      - name: Charlie Adams
      - name: Julie Ann Rose

But this would not:

    people:
      - name: |
          Charlie
          Adams

Sometimes multiple constraints of the same type need to be applied to 
a set of nodes. This can be done by expressing the same YPath with 
different constraints, for example:

    - people/*/name:
        regexp: '[^/t]'
    - people/*/name:
        regexp: '[^/n]'

But to make the intent more succinct a sequence of constraints can be give
along with the *logical-and* tag , `!!and`.

    people/*/name: !!and
      - regexp: '[^/t]'
      - regexp: '[^/n]'

If the `!!and` tag is not given, then the default operator is used, 
*logical-or*, which can also be explicitly stated as `!!or`:

    people/*/name: !!or
      - regexp: '[^/t]'
      - regexp: '[^/n]'

In this way logical relationships of constraints can be created.

    people/*/password: !!or
      - !!and
        - regexp: '[^/s]'
        - regexp: '\w'
        - regexp: '\d'
      - !!and
        - regexp: '[^/s]'
        - regexp: '\w'
        - regexp: '\W'

(Of course these examples can be better handled via more sophisticated regular
expressions, but the intent is only to show that logical operations are possible.)

In these example we have only shown examples of `regexp` contraint, but there are
many other types including: *count*, *length*, *required*, *tag*, *value*, etc.


## COMMAND LINE

To use on the command line *lint* tool. Say we have a `schema.yes` file:

    --- !!yes
    name:
      type: str
      regexp: '[^\n]'
      required: true
    age:
      type: int
    birth:
      type: date

Try it on `sample.yaml`.

    ---
    name: Thomas T. Thomas
    age: 42
    birth: 1976-07-04

Using the executable.

    $ yes-lint schema.yes sample.yaml

In code that is:

    require 'yes'

    lint = YES::Lint.new(File.new('schema.yes'))

    lint.validate(File.new('sample.yaml'))


## TODO

* We need a tag specifier as opposed to a tag constraint, i.e. "is tag" vs. "has tag".
  This way a schema can specify that certain nodes should be interpreted as if they
  had such-and-such tag, as opposed to saying they must have such-and-such tag.


## CONTRIBUTE

Come on folks! Let's get YAML up to snuff. A good Schema could really
help YAML go the distance and penetrate some of those "Enterprisey" worlds.

* Please read, write and comment on issues[https://github.com/rubyworks/yes/issues].
* Please critique the code.
* Please fork and submit patches in topic branches.

And please contribute to {Rubyworks Ruby Development Fund}[http://rubyworks.github.org]
so us poor Ruby OSS developers can eat :)


## COPYRIGHT

Copyright (c) 2011 Rubyworks 

[BSD-2 License](LICENSE.txt)

See LICENSE.txt for details.

