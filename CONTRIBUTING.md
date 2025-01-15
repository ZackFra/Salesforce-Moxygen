# ❤️ Contributing

Contributions to Moxygen are welcome.

Before contributing, please familiarize yourself with the codebase, [recursive descent parsers](https://www.youtube.com/watch?v=iddRD8tJi44), [Apex Docs](https://github.com/cesarParra/apexdocs/wiki/2.-%F0%9F%93%96-Documenting-Apex-code), the [Salesforce CLI](https://www.npmjs.com/package/@salesforce/cli), and the [Salesforce Code Analyzer](https://developer.salesforce.com/docs/platform/salesforce-code-analyzer/overview). It likely wouldn't hurt to also learn the basics of npm. For the codebase, there is a [reference guide](./docs/index.md). The top-level code is contained in the `mox` folder. Then the in-memory database is in the `mock-soql-database` folder, divided between the `core` (e.g. interpreter) and the `parser` folders.

Prior to contributing, please open up or comment on an issue so we can keep track of who is actively working on an item.

Active work items are listed under the [Moxygen](https://github.com/users/ZackFra/projects/1) project under the projects tab. The Moxygen project is organized into two backlogs. The Product Backlog contains features to be implemented. The Optimization Backlog is for process improvement items and administrative work around and in the git repository. As a contributor, you'd likely want to drill down on the Product Backlog.

# 🚀 Development

1. Set up a development environment.
* This can be either a Trailhead org, a scratch org, or a Developer Edition org.
2. Clone or fork this repository.
3. Run `npm i` to install the latest version of our npm dependencies and to install our git hooks.
4. Install and set up Java Version 21 so the Salesforce Code Analyzer can run locally.
5. On commit, the pre-commit hook will
* Run prettier against your changes to ensure uniformity of the codebase.
* Scan all changed Apex files with PMD to ensure your changes align with this project's code standards.
6. Please run all unit tests to verify this will build prior to submitting your pull request.
* This can be done with the following command `npm run sf:apex:test`.

## 📓 Notes
* Any time you need to interact with dates, times, and date times, use the GMT class defined in the `gmt` folder. It returns all values in GMT. If you need a method to create a new GMT date, time, or date time, define it there.
* The SchemaService exists to simplify interactions with the Salesforce Schema object.
* If needed, fake ids can be generated via the fflib__IdGenerator class.
* The DynamicCast and TypeOf classes support dynamically casting primitive types and checking the types of values at runtime.
* The Common class is the general utility class.

# 💡 Tips

* This is a large codebase. You will not figure it out in a day.
* From my experience working on open source in large codebases it's best to drill down on specific features you want to implement or specific issues you want to resolve rather than trying to understand the entire codebase from front to back. [Test-driven development](https://en.wikipedia.org/wiki/Test-driven_development) is useful for this approach. For example, lets say there was a feature I wanted to implement. I might create a failing unit test, then follow the stack trace down to find where changes are needed to create the behavior I want to see. Refactor, rinse, repeat.
