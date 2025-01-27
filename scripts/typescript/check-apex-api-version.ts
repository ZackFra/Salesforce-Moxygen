import fs from 'fs';
import path from 'path'
import { execSync } from 'child_process'

import * as core from '@actions/core'

execSync("sf org display --json > orgDisplay.json")
const orgDisplay = fs.readFileSync(path.resolve(process.cwd(), 'query.json'), 'utf-8')
const orgDisplayJson = JSON.parse(orgDisplay) as OrgDisplayResponse
const apiVersion = parseInt(orgDisplayJson.result.apiVersion, 10)

execSync(`sf data query --query "SELECT Name, ApiVersion FROM ApexClass WHERE ApiVersion != ${apiVersion} --json > query.json`)

const queryResponse = fs.readFileSync(path.resolve(process.cwd(), 'query.json'), 'utf-8')
const queryResponseJson = JSON.parse(queryResponse) as QueryResponse

if(queryResponseJson.result.totalSize > 0) {
    core.error(`The following Apex classes are not using the same API version as the project: ${apiVersion}`)
    for(const record of queryResponseJson.result.records) {
        core.error(`- ${record.Name} (${record.ApiVersion})`)
    }
    core.error('Please update the API version of these classes to match the project')
    process.exit(core.ExitCode.Failure)
}
