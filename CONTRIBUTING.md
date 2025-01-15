# ❤️ Contributing

Contributions to Moxygen are welcome. Before contributing, please familiarize yourself with the codebase, [Apex Docs](https://github.com/cesarParra/apexdocs/wiki/2.-%F0%9F%93%96-Documenting-Apex-code), and the [Salesforce Code Analyzer](https://developer.salesforce.com/docs/platform/salesforce-code-analyzer/overview). For the codebase, there is a [reference guide](./docs/index.md) (still a bit of a work in progress).

Prior to contributing, please open up or comment on an issue so we can keep track of who is actively working on an item.

Active work items are listed under the [Moxygen](https://github.com/users/ZackFra/projects/1) project under the projects tab. The Moxygen project is organized into two backlogs. The Product Backlog contains features to be implemented. The Optimization Backlog is for process improvement items and administrative work around and in the git repository. As a contributor, you'd likely want to drill down on the Product Backlog.

# 🚀 Development

1. Set up a development environment
  i. This can be either a Trailhead org, a scratch org, or a Developer Edition org.
2. Clone or fork this repository.
3. Run `npm i` to install the latest version of our npm dependencies and to install our git hooks.
4. Install and set up Java Version 21 so the Salesforce Code Analyzer can run locally.
5. On commit, the pre-commit hook will
* Run prettier against your changes to ensure uniformity of the codebase.
* Scan all changed Apex files with PMD to ensure your changes align with this project's code standards.
6. Please run all unit tests to verify this will build prior to submitting your pull request.
* This can be done with the following command `npm run sf:apex:test`.

# 💡 Tips

* This is a large codebase. You will not figure it out in a day.
* From my experience working on open source in large codebases, it's best to drill down on specific features I want to implement or specific issues I want to resolve rather than trying to understand the entire codebase from front to back. For example, lets say there was a bug I was trying to fix, I might create a failing unit test then trace the stack trace down to figure out where the code went awry.
