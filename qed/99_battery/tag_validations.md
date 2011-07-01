## Tag Validation

Given a Schema:

    ---
    //name:
      tag: `<tag:yes.com,2011:name>`

Then this YAML document is valid:

    ---
    name: !<tag:yes.com,2011:name> Choo Choo Train

And this YAML document is valid:

    ---
    - name: !<tag:yes.com,2011:name> Choo Choo Train

But this YAML document is not valid:

    ---
    - name: Choo Choo Train


