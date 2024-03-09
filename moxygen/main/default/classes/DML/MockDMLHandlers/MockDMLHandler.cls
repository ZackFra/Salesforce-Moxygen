public abstract class MockDMLHandler {
    protected Map<String, Map<Id, SObject>> mockObjects;
    protected Set<Id> deletedRecords;
    protected SaveResultService srService = new SaveResultService();

    protected Boolean wasCalled = false;

    public Boolean wasCalled() {
        return this.wasCalled;
    }

    public void setMockObjects(Map<String, Map<Id, SObject>> mockObjects) {
        this.mockObjects = mockObjects;
    }

    public void setDeletedRecords(Set<Id> deletedRecords) {
        this.deletedRecords = deletedRecords;
    }
}