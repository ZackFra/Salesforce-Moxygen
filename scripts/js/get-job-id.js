const fs = require("fs");

const FILE_NAME = "job-id.txt";

const fileStream = fs.createReadStream("validate.json", "utf-8");
let validateJobText = "";

fileStream.on("data", buildValidateJobText);
fileStream.on("end", tryToParseValidateJob);

/**
 * @description writes the validate job's json output to validateJobText
 * @param {string} chunk 
 */
const buildValidateJobText = (chunk) => {
    validateJobText += chunk.toString('utf-8');
}

/**
 * @description attempts to parse the validate job output and write the job id to a file
 *              if an error occurs, the job-id.txt file will be cleared
 */
const tryToParseValidateJob = () => {
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
const parseValidateJob = (validateJobText) => {
    const validateJob = JSON.parse(removeNonReadable(validateJobText));
    if(validateJob.result.success) {
        fs.writeFileSync(FILE_NAME, validateJob.result.id, "utf-8");
    } else {
        console.error("Job failed to validate");
        fs.writeFileSync(FILE_NAME, "", "utf-8");
    }
}

/**
 * @description for whatever reason, sfdx will append non-readable characters at the start of the JSON output for
 *              the validate job command. This function removes those characters.
 * @param {string} str 
 * @returns {string}
 */
const removeNonReadable = (str) => {
    return str.replace(/[^\x20-\x7E]/g, '');
}