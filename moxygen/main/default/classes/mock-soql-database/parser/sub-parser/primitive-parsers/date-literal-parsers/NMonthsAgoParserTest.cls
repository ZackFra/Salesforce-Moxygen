@isTest
private class NMonthsAgoParserTest {

    @IsTest
    static void ensureTokenCanBeParsed() {
        Assert.isTrue(
            DateLiteralParserTestUtil.ensureVariableTokenCanBeParsed('N_MONTHS_AGO:5', new NMonthsAgoParser()),
            'N_MONTHS_AGO should be parsed'
        );
    }
}