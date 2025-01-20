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
const core = __importStar(require("@actions/core"));
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const potentialDuplicates = fs_1.default.readFileSync(path_1.default.resolve(process.cwd(), process.argv[2]), 'utf-8');
const hardisDuplicateResponse = JSON.parse(potentialDuplicates);
if (!('result' in hardisDuplicateResponse)) {
    core.error('No response from Hardis');
    process.exit(core.ExitCode.Failure);
}
const duplicates = hardisDuplicateResponse.result.duplicates;
const numberOfDuplicates = Object.keys(duplicates).length;
if (numberOfDuplicates === 0) {
    core.info('No duplicates found');
    process.exit(core.ExitCode.Success);
}
for (const duplicate of Object.keys(duplicates)) {
    const duplicateFiles = duplicates[duplicate];
    core.error(`Duplicates found for ${duplicate}:}`);
    for (const duplicateFile of duplicateFiles) {
        core.error(`- ${duplicateFile}`);
    }
}
core.error('Please remove all duplicates before continuing');
process.exit(core.ExitCode.Failure);
