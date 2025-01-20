"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const core_1 = __importDefault(require("@actions/core"));
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const potentialDuplicates = fs_1.default.readFileSync(path_1.default.resolve(process.cwd(), process.argv[2]), 'utf-8');
const hardisDuplicateResponse = JSON.parse(potentialDuplicates);
if (!('result' in hardisDuplicateResponse)) {
    core_1.default.error('No response from Hardis');
    process.exit(core_1.default.ExitCode.Failure);
}
const duplicates = hardisDuplicateResponse.result.duplicates;
const numberOfDuplicates = Object.keys(duplicates).length;
if (numberOfDuplicates === 0) {
    core_1.default.info('No duplicates found');
    process.exit(core_1.default.ExitCode.Success);
}
for (const duplicate of Object.keys(duplicates)) {
    const duplicateFiles = duplicates[duplicate];
    core_1.default.error(`Duplicates found for ${duplicate}:\n${duplicateFiles.join('\n')}`);
}
process.exit(core_1.default.ExitCode.Failure);
