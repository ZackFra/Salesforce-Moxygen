@IsTest
@SuppressWarnings('PMD.CyclomaticComplexity, PMD.NcssTypeCount')
private with sharing class MockDatabaseUtilsTest {
    @IsTest
    static void testClone() {
        Lexer t = new Lexer();
        Node head = t.parse('SELECT Id FROM Account');
        Test.startTest();
        Node clone = head.deepClone();
        Test.stopTest();
        Assert.areEqual(
            head.toString(),
            clone.toString(),
            'Expected clone to be the same as the original'
        );
    }

    @IsTest
    static void testEqualityHandlerInteger() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle(1, '1');
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testEqualityHandlerString() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle('test', 'test');
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testEqualityHandlerBoolean() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle(true, 'true');
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testEqualityHandlerNull() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle(null, null);
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testEqualityHandlerDate() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle(Date.newInstance(2020, 1, 1), '2020-01-01');
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testEqualityHandlerDateTime1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle(DateTime.newInstanceGmt(2020, 1, 1, 1, 1, 1), '2020-01-01T01:01:01+00:00');
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testEqualityHandlerDateTime2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle(DateTime.newInstanceGmt(2020, 1, 1, 1, 1, 1), '2020-01-01T01:01:01-00:00');
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testEqualityHandlerDateTime3() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle(DateTime.newInstanceGmt(2020, 1, 1, 1, 1, 1), '2020-01-01T01:01:01Z');
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testEqualityHandlerTime() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isEqual = handler.handle(Time.newInstance(1, 1, 1, 1), '01:01:01.001Z');
        Test.stopTest();

        Assert.isTrue(
            isEqual,
            'Expected values to be equal'
        );
    }

    @IsTest
    static void testInequalityHandlerDate() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(Date.newInstance(2019, 1, 1), '2020-01-01');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testInequalityHandlerDateTime1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01+01:00');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testInequalityHandlerDateTime2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01-08:00');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testInequalityHandlerDateTime3() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01Z');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testInequalityHandlerTime() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(Time.newInstance(0, 0, 0, 0), '01:01:01.000Z');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqual1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle('test1', 'test');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );        
    }

    @IsTest
    static void testNotEqual2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<>');
        Test.startTest();
        Boolean isNotEqual = handler.handle('test1', 'test');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );        
    }

    @IsTest
    static void testLike() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('like');
        Test.startTest();
        Boolean isLike = handler.handle('test', '%tes_');
        Test.stopTest();

        Assert.isTrue(
            isLike,
            'Expected values to be like'
        );
    }

    @IsTest
    static void testIn() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('in');
        Test.startTest();
        Boolean isIn = handler.handle('test', new List<String>{'test', 'test1'});
        Test.stopTest();

        Assert.isTrue(
            isIn,
            'Expected value to be in list'
        );
    }

    @IsTest
    static void testNotIn() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('not in');
        Test.startTest();
        Boolean isNotIn = handler.handle('test', new List<String>{'test1', 'test2'});
        Test.stopTest();

        Assert.isTrue(
            isNotIn,
            'Expected value to not be in list'
        );
    }

    @IsTest
    static void testGreaterThanHandler() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle('test1', 'test');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );        
    }

    @IsTest
    static void testLessThanHandler() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle('test', 'test1');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );        
    }

    @IsTest
    static void testGreaterThanOrEqualHandler() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle('test', 'test');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandler() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle('test', 'test');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testNull() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('=');
        Test.startTest();
        Boolean isNull = handler.handle(null, null);
        Test.stopTest();

        Assert.isTrue(
            isNull,
            'Expected value to be true'
        );
    }

    @IsTest
    static void testGreaterThanHandlerString() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle('test1', 'test');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerNull() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle(null, 'test');
        Test.stopTest();

        Assert.isFalse(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerDouble() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle((Double) 2.0, '1.0');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest 
    static void testGreaterThanHandlerInteger() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle(2, '1');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest 
    static void testGreaterThanHandlerDecimal() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle( (Decimal) 2.0, '1.0');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerDate() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle(Date.newInstance(2020, 1, 1), '2019-01-01');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerDateTime1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle(DateTime.newInstance(2020, 1, 1, 1, 1, 1), '1999-01-01T23:01:01+01:00');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerDateTime2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle(DateTime.newInstance(2020, 1, 1, 1, 1, 1), '1999-01-01T23:01:01-08:00');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerDateTime3() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle(DateTime.newInstance(2020, 1, 1, 1, 1, 1), '1999-01-01T23:01:01Z');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerTime() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle(Time.newInstance(1, 1, 1, 1), '00:00:00.000Z');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerLong() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle( (Long) 2L, '1');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerString() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle('test', 'test1');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerNull() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle(null, 'test');
        Test.stopTest();

        Assert.isFalse(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerDouble() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle((Double) 1.0, '2.0');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerInteger() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle(1, '2');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerDecimal() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle( (Decimal) 1.0, '2.0');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerDate() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle(Date.newInstance(2019, 1, 1), '2020-01-01');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerDateTime1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01+01:00');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }
    
    @IsTest
    static void testLessThanHandlerDateTime2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01-08:00');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerDateTime3() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01Z');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerTime() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle(Time.newInstance(0, 0, 0, 0), '01:01:01.000Z');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testLessThanHandlerLong() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<');
        Test.startTest();
        Boolean isLessThan = handler.handle( (Long) 1L, '2');
        Test.stopTest();

        Assert.isTrue(
            isLessThan,
            'Expected value a to be less than value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerString() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle('test', 'test');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerNull() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle(null, 'test');
        Test.stopTest();

        Assert.isFalse(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerDouble() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle((Double) 2.0, '1.0');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerInteger() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle(2, '1');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerDecimal() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle( (Decimal) 2.0, '1.0');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerDate() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle(Date.newInstance(2020, 1, 1), '2020-01-01');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerDateTime1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle(DateTime.newInstance(2020, 1, 1, 1, 1, 1), '2020-01-01T01:01:01+01:00');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerDateTime2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle(DateTime.newInstance(2020, 1, 1, 1, 1, 1), '2020-01-01T01:01:01+08:00');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerDateTime3() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle(DateTime.newInstance(2020, 1, 1, 1, 1, 1), '2020-01-01T01:01:01Z');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerTime() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle(Time.newInstance(1, 1, 1, 1), '01:01:01.000Z');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testGreaterThanOrEqualHandlerLong() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>=');
        Test.startTest();
        Boolean isGreaterThanOrEqual = handler.handle( (Long) 2L, '1');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThanOrEqual,
            'Expected value a to be greater than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerString() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle('test', 'test');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerNull() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle(null, 'test');
        Test.stopTest();

        Assert.isFalse(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerDouble() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle((Double) 1.0, '2.0');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerInteger() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle(1, '2');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerDecimal() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle( (Decimal) 1.0, '2.0');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerDate() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle(Date.newInstance(2019, 1, 1), '2020-01-01');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerDateTime1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01+01:00');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerDateTime2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01-08:00');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerDateTime3() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01Z');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerTime() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle(Time.newInstance(0, 0, 0, 0), '01:01:01.000Z');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testLessThanOrEqualHandlerLong() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('<=');
        Test.startTest();
        Boolean isLessThanOrEqual = handler.handle( (Long) 1L, '2');
        Test.stopTest();

        Assert.isTrue(
            isLessThanOrEqual,
            'Expected value a to be less than or equal to value b'
        );
    }

    @IsTest
    static void testNotEqualHandlerString() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle('test1', 'test');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerNull() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(null, 'test');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerDouble() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle((Double) 1.0, '2.0');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerInteger() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(1, '2');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerDecimal() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle( (Decimal) 1.0, '2.0');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerDate() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(Date.newInstance(2019, 1, 1), '2020-01-01');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerDateTime1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01+01:00');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerDateTime2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01-08:00');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerDateTime3() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(DateTime.newInstance(1999, 1, 1, 23, 1, 1), '2020-01-01T01:01:01Z');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerTime() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle(Time.newInstance(0, 0, 0, 0), '01:01:01.000Z');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testNotEqualHandlerLong() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('!=');
        Test.startTest();
        Boolean isNotEqual = handler.handle( (Long) 1L, '2');
        Test.stopTest();

        Assert.isTrue(
            isNotEqual,
            'Expected values to not be equal'
        );
    }

    @IsTest
    static void testLikeHandler() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('like');
        Test.startTest();
        Boolean isLike = handler.handle('test', '%tes_');
        Test.stopTest();

        Assert.isTrue(
            isLike,
            'Expected values to be like'
        );
    }

    @IsTest
    static void testInHandler() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('in');
        Test.startTest();
        Boolean isIn = handler.handle('test', new List<String>{'test', 'test1'});
        Test.stopTest();

        Assert.isTrue(
            isIn,
            'Expected value to be in list'
        );
    }

    @IsTest
    static void testNotInHandler() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('not in');
        Test.startTest();
        Boolean isNotIn = handler.handle('test', new List<String>{'test1', 'test2'});
        Test.stopTest();

        Assert.isTrue(
            isNotIn,
            'Expected value to not be in list'
        );
    }

    @IsTest
    static void testGreaterThanHandlerString1() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle('test1', 'test');
        Test.stopTest();

        Assert.isTrue(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerString2() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle('test', 'test1');
        Test.stopTest();

        Assert.isFalse(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }

    @IsTest
    static void testGreaterThanHandlerString3() {
        OperatorHandlerFactory opHandlerFactory = new OperatorHandlerFactory();
        IOperatorHandler handler = opHandlerFactory.getHandler('>');
        Test.startTest();
        Boolean isGreaterThan = handler.handle('test', 'test');
        Test.stopTest();

        Assert.isFalse(
            isGreaterThan,
            'Expected value a to be greater than value b'
        );
    }
}