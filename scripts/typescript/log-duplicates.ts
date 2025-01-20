import * as core from '@actions/core'
import fs from 'fs'
import path from 'path'

const potentialDuplicates = fs.readFileSync(path.resolve(process.cwd(), process.argv[2]), 'utf-8')
const hardisDuplicateResponse: HardisDuplicateResponse = JSON.parse(potentialDuplicates)
if(!('result' in hardisDuplicateResponse)) {
    core.error('No response from Hardis')
    process.exit(core.ExitCode.Failure)
}

const duplicates = hardisDuplicateResponse.result.duplicates

const numberOfDuplicates = Object.keys(duplicates).length
if(numberOfDuplicates === 0) {
    core.info('No duplicates found')
    process.exit(core.ExitCode.Success)
}

for(const duplicate of Object.keys(duplicates)) {
    const duplicateFiles: string[] = duplicates[duplicate]
    core.error(`Duplicates found for ${duplicate}:\n${duplicateFiles.join('\n')}`)
}

process.exit(core.ExitCode.Failure)