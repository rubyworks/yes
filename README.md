YES - YAML Easy Schema
======================

YES is a schema system for YAML that is intuitive and powerful.
YES schemas are also YAML documents, so it "eats its own dog food",
as they say.

## HOW IT WORKS

The design of YES is rather simple. A YES schema is composed of YPath
selectors mapped to document constraints. A YES document can be either
a mapping or a sequence of such constraints. YPath is a syntax for
selecting *nodes* from a YAML document.

When validating a YAML document against a YES schema a "lint" program
simply collects all matching nodes with their applicable constraints into
a collection of *unit-validations*. Then this collection is filtered of 
all *passing* validations. All that is left are the failures. If the 
filtered list is empty the document is completely valid. If not empty,
the lint program can provide a detailed *editorial* list of the failures.

In general, contraints limit the possible nodes in a document. Some
contraints are *specifiers* which instruct parsers how to interpret a
document based on it's structure (as opposed to document tags).


## Note About miniKanren

Although YES was conceived of and partially implemented before we
ever heard of [miniKanren](http://minikanren.org/), it later become
apparent that YES is essentially a DSL variant on miniKanren for the
specific purpose of creating schema for YAML documents. This presents
a rather fruitful possibility that core logic of miniKanren implementations,
already in the wild, could be used as a basis for creating YES implementations.


## Examples

Lets take an example schema:

    people/*/name:
      implicit: !name
      regexp: '[^/n]'

This simple schema selects all nodes under a `people` sequence of
mappings with a `name` key, the value of which cannot contain newlines
due to the `regex` constraint, and should be parsed with implcit tag
of `!name`, as specified by the `implicit` constraint.

The following document would satisfy the schema:

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

But to make the intent more succinct a sequence of constraints instead of
a mapping can be given.

    people/*/name:
      - regexp: '[^/t]'
      - regexp: '[^/n]'

This construct implies *logical-and* relation. This can be explicitly given
with a `!!and` tag.

    people/*/name: !!and
      - regexp: '[^/t]'
      - regexp: '[^/n]'

Which as you may have guessed means `!!or` can be used to explicity create a
*logical-or* constraint relation:

    people/*/name: !!or
      - regexp: '[^/t]'
      - regexp: '[^/n]'

In this way complex logical relationships of constraints can be created.

    people/*/login: !!or
      - !!and
        - implicit: !id
        - regexp: '^\d+$'
      - !!and
        - implicit: !name
        - regexp: '^\w+$'

(Of course these examples can be better handled via more sophisticated regular
expressions, but the intent is only to show that logical operations are possible.)

(NOT IMPLEMENTED YET) By preceding a subentry with slash (`/`) YES will interpret
the entry as a continutation of the parent YPATH rather than node criteria.

    - people/*:
        /name:
          regexp: '[^/t]'

In this way schemas can often be more reflective of the the actual structure of the
document they formailze.

In the above example we have only shown examples of `regexp` and `implicit` contraints,
but there are many other types including: *count*, *length*, *required*, *tag*,
*value*, etc. See the [DEMO.md](DEMO.md) file for details.


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

