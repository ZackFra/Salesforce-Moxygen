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

/**
 * @description This class is used to create success and failure results for DML operations.
 */
@IsTest
public with sharing class SaveResultService {
    /**
     * @description This method is used to create a success result for DML operations.
     * @param recordId The Id of the record that was created or updated.
     * @param resultType The type of result to create.
     * @return The success result.
     */
    public Object createSuccess(Id recordId, Type resultType) {
        String serializedResult = '{"success":true,';
        if (resultType == Database.UpsertResult.class) {
            serializedResult += '"created":true,';
        }
        serializedResult += '"id":"' + recordId + '"}';
        return JSON.deserialize(serializedResult, resultType);
    }

    /**
     * @description This method is used to create a failure result for DML operations.
     * @param message The error message.
     * @param resultType The type of result to create.
     * @return The failure result.
     */
    public Object createFailure(String message, Type resultType) {
        String serializedResult = '{"success": false,';
        if (resultType == Database.UpsertResult.class) {
            serializedResult += '"created":false,';
        }
        serializedResult += '"errors":[{"message":"' + message + '"}]}';
        return JSON.deserialize(serializedResult, resultType);
    }
}
