@isTest
private class DateLiteralComparableFactoryTest {
    @isTest
    static void ensureCreateWorksWithAllSupportedTokens() {
        Set<String> supportedTokens = DateLiteralComparableFactory.getSupportedTokens();
        for (String supportedToken : supportedTokens) {
            if (supportedToken.contains('n_')) {
                supportedToken += ':5';
            }
            DateLiteral dl = new DateLiteral.Builder()
                .setFieldValue(supportedToken)
                .build();
            DateLiteralComparable comparable = DateLiteralComparableFactory.create(
                dl
            );
            Assert.isNotNull(
                comparable,
                'DateLiteralComparable should not be null'
            );
        }
    }

    @isTest
    static void ensureValidationWorksAsExpected() {
        DateLiteral dl = new DateLiteral.Builder()
            .setFieldValue('unexpected_token')
            .build();
        Boolean isExceptionThrown = false;
        try {
            DateLiteralComparableFactory.create(dl);
            Assert.fail('ValidationException should have been thrown');
        } catch (ValidationException e) {
            isExceptionThrown = true;
        }

        Assert.isTrue(
            isExceptionThrown,
            'ValidationException should have been thrown'
        );
    }
}
