@isTest
private class AggregateTest {
    @IsTest
    private static void testInstantiation() {
        ProtoAggregate protoAggregate = new ProtoAggregate();
        protoAggregate.put('expr0', 1);
        protoAggregate.put('expr1', 2);
        protoAggregate.put('expr2', 3);

        Test.startTest();
        Aggregate aggr = new Aggregate(protoAggregate);
        Test.stopTest();

        Assert.areEqual(1, aggr.get('expr0'), 'expr0 should be 1');
        Assert.areEqual(2, aggr.get('expr1'), 'expr1 should be 2');
        Assert.areEqual(3, aggr.get('expr2'), 'expr2 should be 3');
    }

    @IsTest
    private static void testToString() {
        ProtoAggregate protoAggregate = new ProtoAggregate();
        protoAggregate.put('expr0', 1);
        protoAggregate.put('expr1', 2);
        protoAggregate.put('expr2', 3);

        Test.startTest();
        Aggregate aggr = new Aggregate(protoAggregate);
        Test.stopTest();
        String expected = '{expr0=1, expr1=2, expr2=3}';
        Assert.areEqual(expected, aggr.toString(), 'toString should return a string representation of the aggregate');
    }
}