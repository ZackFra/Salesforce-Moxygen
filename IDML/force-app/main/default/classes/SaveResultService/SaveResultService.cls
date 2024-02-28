public with sharing class SaveResultService {
    public Object createSuccess(Id recordId, Type resultType) {
        String serializedResult = '{"success":true,';
        if(resultType == Database.UpsertResult.class) {
            serializedResult += '"created":true,';
        }
        serializedResult += '"id":"' + recordId + '"}';
        return JSON.deserialize(serializedResult, resultType);
    }

    public Object createFailure(String message, Type resultType) {
        String serializedResult = '{"success": false,';
        if(resultType == Database.UpsertResult.class) {
            serializedResult += '"created":false,';
        }
        serializedResult += '"errors":[{"message":"' + message + '"}]}';
        return JSON.deserialize(serializedResult, resultType);
    }
}