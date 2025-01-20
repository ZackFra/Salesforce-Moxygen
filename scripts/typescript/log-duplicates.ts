import core from '@actions/core'

const hardisDuplicateResponse: HardisDuplicateResponse = JSON.parse(process.argv[2])
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