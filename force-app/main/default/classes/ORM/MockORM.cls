/**
 * @description Mock ORM, for testing purposes
 */
@IsTest
public inherited sharing class MockORM implements IORM {
    ISelector s;
    IDML d;
    public MockORM() {
        s = new MockSelector();
        d = new MockDML();
    }

    /**
     * @description returns the selector
     * @return the selector
     */
    public ISelector getSelector() {
        return s;
    }

    /**
     * @description returns the DML
     * @return the DML
     */
    public IDML getDML() {
        return d;
    }

    /**
     * @description returns if the record is deleted
     * @param recordId the record id
     * @return if the record is deleted
     */
    public Boolean isDeleted(Id recordId) {
        return ((MockDML) d).isDeleted(recordId);
    }

    /**
     * @description returns the record by id
     * @param recordId the record id
     * @return the record
     */
    public SObject selectRecordById(Id recordId) {
        return ((MockDML) d).selectRecordById(recordId);
    }

    /**
     * @description returns the deleted record by id
     * @param recordId the record id
     * @return the deleted record
     */
    public SObject selectDeletedRecordById(Id recordId) {
        return ((MockDML) d).selectDeletedRecordById(recordId);
    }

    public Boolean wasCalled(MockDML.DMLType type) {
        return ((MockDML) d).wasCalled(type);
    }

    public Boolean wasCalled(String queryString) {
        return ((MockSelector) s).wasCalled(queryString);
    }

    public Boolean wasQueryCalled() {
        return ((MockSelector) s).wasCalled();
    }
}