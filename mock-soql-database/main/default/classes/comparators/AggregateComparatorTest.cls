@isTest
private class AggregateComparatorTest {

    @isTest
    private static void testCompareToEqual() {

        ProtoAggregate protoAggr1 = new ProtoAggregate( new Map<String, Object> {
            'field1' => 'value1',
            'field2' => 'value2'
        });
        
        ProtoAggregate protoAggr2 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => 'value2'
        });

        Map<String, String> fieldDatum1 = new Map<String, String> {
            'fieldApiName' => 'field1',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, String> fieldDatum2 = new Map<String, String> {
            'fieldApiName' => 'field2',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>> {
            'field1' => fieldDatum1,
            'field2' => fieldDatum2
        };

        AggregateComparator comparator = new AggregateComparator(fields);

        Test.startTest();
        Integer result = comparator.compare(protoAggr1, protoAggr2);
        Test.stopTest();
        Assert.areEqual(
            0, 
            result, 
            'The two aggregates should be equal'
        );
    }

    @IsTest
    private static void testCompareToLessThan() {
            
        ProtoAggregate protoAggr1 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => 'value2'
        });
        
        ProtoAggregate protoAggr2 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => 'value3'
        });

        Map<String, String> fieldDatum1 = new Map<String, String> {
            'fieldApiName' => 'field1',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, String> fieldDatum2 = new Map<String, String> {
            'fieldApiName' => 'field2',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>> {
            'field1' => fieldDatum1,
            'field2' => fieldDatum2
        };

        AggregateComparator comparator = new AggregateComparator(fields);

        Test.startTest();
        Integer result = comparator.compare(protoAggr1, protoAggr2);
        Test.stopTest();
        Assert.areEqual(
            -1, 
            result, 
            'The first aggregate should be less than the second'
        );
    }

    @IsTest
    private static void testCompareToGreaterThan() {
        ProtoAggregate protoAggr1 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => 'value3'
        });
        
        ProtoAggregate protoAggr2 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => 'value2'
        });

        Map<String, String> fieldDatum1 = new Map<String, String> {
            'fieldApiName' => 'field1',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, String> fieldDatum2 = new Map<String, String> {
            'fieldApiName' => 'field2',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>> {
            'field1' => fieldDatum1,
            'field2' => fieldDatum2
        };

        AggregateComparator comparator = new AggregateComparator(fields);

        Test.startTest();
        Integer result = comparator.compare(protoAggr1, protoAggr2);
        Test.stopTest();
        Assert.areEqual(
            1, 
            result, 
            'The first aggregate should be less than the second'
        );       
    }

    @IsTest
    private static void testCompareToParentField() {
        ProtoAggregate protoAggr1 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'parent1.field2' => 'value2'
        });
        
        ProtoAggregate protoAggr2 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'parent2.field2' => 'value2'
        });

        Map<String, String> fieldDatum1 = new Map<String, String> {
            'fieldApiName' => 'field1',
            'relationshipName' => 'parent1.field2',
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, String> fieldDatum2 = new Map<String, String> {
            'fieldApiName' => 'field2',
            'relationshipName' => 'parent2.field2',
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>> {
            'field1' => fieldDatum1,
            'field2' => fieldDatum2
        };

        AggregateComparator comparator = new AggregateComparator(fields);

        Test.startTest();
        Integer result = comparator.compare(protoAggr1, protoAggr2);
        Test.stopTest();
        Assert.areEqual(
            0, 
            result, 
            'The two aggregates should be equal'
        );
    }

    @IsTest
    private static void testCompareToNullLessThan() {
        ProtoAggregate protoAggr1 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => null
        });
        
        ProtoAggregate protoAggr2 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => 'value2'
        });

        Map<String, String> fieldDatum1 = new Map<String, String> {
            'fieldApiName' => 'field1',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };

        Map<String, String> fieldDatum2 = new Map<String, String> {
            'fieldApiName' => 'field2',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };

        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>> {
            'field1' => fieldDatum1,
            'field2' => fieldDatum2
        };

        AggregateComparator comparator = new AggregateComparator(fields);
        Test.startTest();
        Integer result = comparator.compare(protoAggr1, protoAggr2);
        Test.stopTest();
        Assert.areEqual(
            -1, 
            result, 
            'The first aggregate should be less than the second'
        );
    }

    @IsTest
    private static void testCompareToNullGreaterThan() {
        ProtoAggregate protoAggr1 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => 'value2'
        });
        
        ProtoAggregate protoAggr2 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => null
        });

        Map<String, String> fieldDatum1 = new Map<String, String> {
            'fieldApiName' => 'field1',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };

        Map<String, String> fieldDatum2 = new Map<String, String> {
            'fieldApiName' => 'field2',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'first'
        };

        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>> {
            'field1' => fieldDatum1,
            'field2' => fieldDatum2
        };

        AggregateComparator comparator = new AggregateComparator(fields);

        Test.startTest();
        Integer result = comparator.compare(protoAggr1, protoAggr2);
        Test.stopTest();
        Assert.areEqual(
            1, 
            result, 
            'The first aggregate should be less than the second'
        );
    }

    @IsTest
    private static void testCompareToNullEqual() {
        ProtoAggregate protoAggr1 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => null
        });
        
        ProtoAggregate protoAggr2 = new ProtoAggregate(new Map<String, Object> {
            'field1' => 'value1',
            'field2' => null
        });

        Map<String, String> fieldDatum1 = new Map<String, String> {
            'fieldApiName' => 'field1',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, String> fieldDatum2 = new Map<String, String> {
            'fieldApiName' => 'field2',
            'relationshipName' => null,
            'order' => 'asc',
            'nullDir' => 'last'
        };

        Map<String, Map<String, String>> fields = new Map<String, Map<String, String>> {
            'field1' => fieldDatum1,
            'field2' => fieldDatum2
        };

        AggregateComparator comparator = new AggregateComparator(fields);

        Test.startTest();
        Integer result = comparator.compare(protoAggr1, protoAggr2);
        Test.stopTest();
        Assert.areEqual(
            0, 
            result, 
            'The two aggregates should be equal'
        );
    }
}