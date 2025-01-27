"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const child_process_1 = require("child_process");
const core = __importStar(require("@actions/core"));
(0, child_process_1.execSync)("sf org display --json > orgDisplay.json");
const orgDisplay = fs_1.default.readFileSync(path_1.default.resolve(process.cwd(), 'orgDisplay.json'), 'utf-8');
const orgDisplayJson = JSON.parse(orgDisplay);
const apiVersion = parseInt(orgDisplayJson.result.apiVersion, 10);
(0, child_process_1.execSync)(`sf data query --query "SELECT Name, ApiVersion FROM ApexClass WHERE ApiVersion != ${apiVersion}" --json > query.json`);
const queryResponse = fs_1.default.readFileSync(path_1.default.resolve(process.cwd(), 'query.json'), 'utf-8');
const queryResponseJson = JSON.parse(queryResponse);
if (queryResponseJson.result.totalSize > 0) {
    core.error(`The following Apex classes are not using the same API version as the project: ${apiVersion}`);
    for (const record of queryResponseJson.result.records) {
        core.error(`- ${record.Name} (${record.ApiVersion})`);
    }
    core.error('Please update the API version of these classes to match the project');
    process.exit(core.ExitCode.Failure);
}
