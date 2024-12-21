@isTest
private class LastNWeeksParserTest {

    @IsTest
    static void ensureLastNWeeksCanBeParsed() {
        Assert.isTrue(
            DateLiteralParserTestUtil.ensureVariableTokenCanBeParsed('LAST_N_WEEKS:5', new LastNWeeksParser()),
            'N_DAYS_AGO should be parsed'
        );
    }
}