# RELEASE HISTORY

## HEAD / 2011-07-02

Current Development (7rans)

Changes:

* 4 Test Enhancements

    * Add test for RequiresValidation.
    * Use Lint class, as YES is now a module.
    * Move QED .rdoc files to .md files.
    * Add required and count constraint tests.

* 13 General Enhancements

    * Pass tree to validations and change Required to Requires.
    * Add node shortcuts to NodeValidation class.
    * Fix AbstractValidation#match_delta range comparisons.
    * Rename yaml-yes executable to yes-lint.
    * Refactored validation into individual validation classes.
    * Rename range to count and add new constraints.
    * Add exclusive and improved required validation.
    * Output a generalized node representation.
    * Add schema for yes itself.
    * When node's #type_id is nil use #kind.
    * Fix typo in README example.
    * Clarify design in README.
    * Initial commit.

