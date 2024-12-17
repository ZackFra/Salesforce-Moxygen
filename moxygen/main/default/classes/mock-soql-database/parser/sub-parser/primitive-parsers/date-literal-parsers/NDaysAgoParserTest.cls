@isTest
private class NDaysAgoParserTest {

    @IsTest
    static void ensureNDaysAgoCanBeParsed() {
        Assert.isTrue(
            DateLiteralParserTestUtil.ensureVariableTokenCanBeParsed('N_DAYS_AGO:5', new NDaysAgoParser()),
            'N_DAYS_AGO should be parsed'
        );
    }
}