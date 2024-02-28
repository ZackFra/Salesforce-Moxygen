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
}