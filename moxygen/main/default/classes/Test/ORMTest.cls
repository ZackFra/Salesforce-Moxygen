@isTest
private class ORMTest {

    @isTest
    static void testORM() {
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            ORM db = new ORM();
            db.getSelector();
            db.getDML();
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        Assert.isFalse(isExceptionThrown, 'Exception was thrown');
    }
}