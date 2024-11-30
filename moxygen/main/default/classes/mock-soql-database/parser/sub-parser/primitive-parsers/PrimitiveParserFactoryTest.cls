@isTest
private class PrimitiveParserFactoryTest {

    @isTest
    static void ensureCorrectPrimitiveParsersAreReturned() {
        Map<String, Type> parserTypeByToken = PrimitiveParserFactory.parserTypeByToken;
        Set<String> expectedTokens = PrimitiveParserFactory.getPrimitiveParserTokens();
        for(String token : expectedTokens) {
            SubParser parser = PrimitiveParserFactory.getPrimitiveParser(token);
            Type expectedParserType = parserTypeByToken.get(token);
            Assert.areEqual(expectedParserType.getName(), TypeOf.forObject(parser), 'Parser type should be ' + expectedParserType);
        }

        SubParser numParser = PrimitiveParserFactory.getPrimitiveParser('123');
        Assert.areEqual(NumberParser.class.getName(), TypeOf.forObject(numParser), 'Parser type should be NumberParser');

        SubParser dtParser = PrimitiveParserFactory.getPrimitiveParser('2020-01-01');
        Assert.areEqual(DateParser.class.getName(), TypeOf.forObject(dtParser), 'Parser type should be DateParser');

        SubParser dateTimeParser = PrimitiveParserFactory.getPrimitiveParser('2020-01-01T00:00:00Z');
        Assert.areEqual(DateParser.class.getName(), TypeOf.forObject(dateTimeParser), 'Parser type should be DateParser');
    }
}