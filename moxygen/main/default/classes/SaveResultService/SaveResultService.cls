/**
 * @description This class is used to create success and failure results for DML operations.
 */
@IsTest
public inherited sharing class SaveResultService {
    /**
     * @description This method is used to create a success result for DML operations.
     * @param recordId The Id of the record that was created or updated.
     * @param resultType The type of result to create.
     * @return The success result.
     */
    public Object createSuccess(Id recordId, Type resultType) {
        String serializedResult = '{"success":true,';
        if(resultType == Database.UpsertResult.class) {
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
        if(resultType == Database.UpsertResult.class) {
            serializedResult += '"created":false,';
        }
        serializedResult += '"errors":[{"message":"' + message + '"}]}';
        return JSON.deserialize(serializedResult, resultType);
    }
}