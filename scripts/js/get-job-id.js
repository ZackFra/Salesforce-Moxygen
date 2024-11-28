const fs = require("fs");

const fileStream = fs.createReadStream("validate.json", "utf-8");
let validateJobText = "";

fileStream.on("data", (chunk) => {
    validateJobText += chunk.toString('utf-8');
});

fileStream.on("end", () => {
    try {
        parseValidateJob(validateJobText);
    } catch (err) {
        console.error("Error parsing validate job: ", err);
        fs.writeFileSync("job-id.txt", "", "utf-8");
    }
});

const parseValidateJob = (validateJobText) => {
    const validateJob = JSON.parse(removeNonReadable(validateJobText));
    if(validateJob.result.success) {
        fs.writeFileSync("job-id.txt", validateJob.result.id, "utf-8");
    } else {
        console.error("Job failed to validate");
        fs.writeFileSync("job-id.txt", "", "utf-8");
    }
}

const removeNonReadable = (str) => {
    return str.replace(/[^\x20-\x7E]/g, '');
}