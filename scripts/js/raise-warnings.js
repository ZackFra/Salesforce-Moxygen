/* 
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

// `::warning file={name},line={line},endLine={endLine},title={title}::{message}`

const fs = require("fs");

const codeScanFile = JSON.parse(fs.readFileSync("codescan.json", "utf8"));

const errors = [];

for (const warning of codeScanFile) {
  for (const violation of warning.violations) {
    let message = `::warning file=${warning.fileName},line=${violation.line},endLine=${violation.endLine},title=${violation.ruleName}::${violation.category.toUpperCase()} WARNING, SEVERITY (${violation.severity}) ${violation.message} in ${warning.fileName} at line ${violation.line} - ${violation.ruleName} - ${violation.url}`;
    message = message.replaceAll("\r", "").replaceAll("\n", "");

    errors.push({ severity: violation.severity, message });
  }
}

// sort errors by severity, we want the high severity errors to be at the top
errors.sort((a, b) => a.severity - b.severity);

for (const error of errors) {
  console.log(error.message);
}
