public with sharing class MockORM implements IORM {
    ISelector s;
    IDML d;
    public MockORM() {
        s = new MockSelector();
        d = new MockDML();
    }

    public ISelector getSelector() {
        return s;
    }

    public IDML getDML() {
        return d;
    }
}