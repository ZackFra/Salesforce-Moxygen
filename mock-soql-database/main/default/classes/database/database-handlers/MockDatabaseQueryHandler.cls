public inherited sharing class MockDatabaseQueryHandler {
    private Map<String, Map<Id, SObject>> mockObjects;
    public MockDatabaseQueryHandler(Map<String, Map<Id, SObject>> mockObjects) {
        this.mockObjects = mockObjects;
    }
    
}