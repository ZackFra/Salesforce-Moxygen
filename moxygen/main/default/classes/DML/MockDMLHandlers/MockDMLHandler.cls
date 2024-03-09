/**
 * @description MockDMLHandler is an abstract class that provides a base class for mocking DML operations.
 * @author Zackary Frazier
 * @since 3/9/2024
 */
public abstract class MockDMLHandler {
    protected Map<String, Map<Id, SObject>> mockObjects;
    protected Set<Id> deletedRecords;
    protected SaveResultService srService = new SaveResultService();

    protected Boolean wasCalled = false;

    /**
     * @description Returns true if the method was called, otherwise false.
     * @return  `Boolean`
     */
    public Boolean wasCalled() {
        return this.wasCalled;
    }

    /**
     * @description Sets the mockObjects map to the provided map.
     * @param mockObjects 
     */
    public void setMockObjects(Map<String, Map<Id, SObject>> mockObjects) {
        this.mockObjects = mockObjects;
    }

    /**
     * @description Sets the deletedRecords set to the provided set.
     * @param deletedRecords The set of Ids to set the deletedRecords to.
     */
    public void setDeletedRecords(Set<Id> deletedRecords) {
        this.deletedRecords = deletedRecords;
    }
}