# Contributing

Contributions to Moxygen are welcome. Before contributing, please familiarize yourself with [Apex Docs](https://github.com/cesarParra/apexdocs/wiki/2.-%F0%9F%93%96-Documenting-Apex-code) and the [Salesforce Code Analyzer](https://developer.salesforce.com/docs/platform/salesforce-code-analyzer/overview).

Prior to contributing, please open up or comment on an issue so we can keep track of who is actively working on an item.

# Development

1. Set up a development environment
  i. This can be either a Trailhead org, a scratch org, or a Developer Edition org.
2. Clone or fork this repository.
3. Run `npm i` to install the latest version of our npm dependencies and to install our git hooks.
4. Install and set up Java Version 21 so the Salesforce Code Analyzer can run locally.
5. On commit, the pre-commit hook will
  i. Run prettier against your changes to ensure uniformity of the codebase.
  ii. Scan all changed Apex files with PMD to ensure your changes align with this project's code standards.
6. Run all unit tests to verify this will build prior to submitting your pull request.
* This can be done with the following command `npm run sf:apex:test`