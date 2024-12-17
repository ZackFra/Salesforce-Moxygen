const fs = require("fs");
const { execSync } = require("child_process");

const FILE_NAME = "sfdx-project.json";

const file = fs.readFileSync(FILE_NAME, "utf-8");
const project = JSON.parse(file);
const packageAliases = Object.keys(project.packageAliases);
const latestVersion = packageAliases[packageAliases.length - 1];
const installResults = execSync("sf package install -p " + latestVersion + " -w 10").toString();
console.log(installResults);
