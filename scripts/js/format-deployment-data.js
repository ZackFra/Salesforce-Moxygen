const fs = require("fs");

const FILE_NAME = "deployment-request.json";

const fileStream = fs.createReadStream(process.argv[2], "utf-8");
const repository = process.argv[3];
const pullRequestNumber = process.argv[4];
let validateJobText = "";

fileStream.on("data", buildValidateJobText);
fileStream.on("end", tryToParseValidateJob);

/**
 * @description writes the validate job's json output to validateJobText
 * @param {string} chunk 
 */
function buildValidateJobText(chunk) {
    validateJobText += chunk.toString('utf-8');
}

/**
 * @description attempts to parse the validate job output and write the job id to a file
 *              if an error occurs, the job-id.txt file will be cleared
 */
function tryToParseValidateJob() {
    try {
        parseValidateJob(validateJobText);
    } catch (err) {
        console.error("Error parsing validate job: ", err);
        fs.writeFileSync(FILE_NAME, "", "utf-8");
    }
}

/**
 * @description parses the validate job output and writes the job id to a file
 * @param {string} validateJobText 
 */
function parseValidateJob(validateJobText) {
    const validateJob = JSON.parse(removeNonReadable(validateJobText));
    if(validateJob.result.success) {
        fs.writeFileSync(FILE_NAME, JSON.stringify({
            pullRequestUrl: `/${repository}/pull/${pullRequestNumber}`,
            deploymentStatus: validateJob
        }), "utf-8");
    } else {
        console.error("Job failed to validate");
        process.exit(1);
    }
}

/**
 * @description for whatever reason, sfdx will append non-readable characters at the start of the JSON output for
 *              the validate job command. This function removes those characters.
 * @param {string} str 
 * @returns {string}
 */
function removeNonReadable(str) {
    return str.replace(/[^\x20-\x7E]/g, '');
}