@isTest
private class NextNWeeksParserTest {

    @IsTest
    static void ensureNextNWeeksCanBeParsed() {
        Assert.isTrue(
            DateLiteralParserTestUtil.ensureVariableTokenCanBeParsed('NEXT_N_WEEKS:5', new NextNWeeksParser()),
            'NEXT_N_WEEKS should be parsed'
        );
    }
}