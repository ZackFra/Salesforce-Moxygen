const fs = require("fs");

const validateJob = JSON.parse(fs.readFileSync("validate.json", "utf8"));
if(validateJob.success) {
    fs.writeFileSync("job-id.txt", validateJob.id, "utf8");
}