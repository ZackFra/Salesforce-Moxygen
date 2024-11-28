const fs = require("fs");

const validateJob = JSON.parse(fs.readFileSync("validate.json", "utf8"));
if(validateJob.success) {
    fs.writeFileSync("job-id.txt", validateJob.id, "utf8");
} else {
    console.error("Job failed to validate");
    fs.writeFileSync("job-id.txt", "", "utf8");
}