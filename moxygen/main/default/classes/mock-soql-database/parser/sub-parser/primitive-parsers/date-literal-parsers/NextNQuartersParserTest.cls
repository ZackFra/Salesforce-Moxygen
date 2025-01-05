@isTest
private class NextNQuartersParserTest {

    @IsTest
    static void ensureNextNQuartersCanBeParsed() {
        Assert.isTrue(
            DateLiteralParserTestUtil.ensureVariableTokenCanBeParsed('NEXT_N_QUARTERS:5', new NextNQuarters()),
            'NEXT_N_QUARTERS should be parsed'
        );
    }
}