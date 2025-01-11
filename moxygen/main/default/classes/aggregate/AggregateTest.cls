/*
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

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
    private static void testAggregate() {
        Map<String, Object> ar = new Map<String, Object>{
            'Name' => 'Test Account',
            'Type' => 'Prospect',
            'Industry' => 'Agriculture'
        };

        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            new Aggregate(ar);
        } catch (Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isFalse(isExceptionThrown, 'Exception was thrown');
    }

    @IsTest
    private static void testGet() {
        Map<String, Object> ar = new Map<String, Object>{
            'Name' => 'Test Account',
            'Type' => 'Prospect',
            'Industry' => 'Agriculture'
        };

        Test.startTest();
        Aggregate a = new Aggregate(ar);
        String name = (String) a.get('Name');
        String type = (String) a.get('Type');
        String industry = (String) a.get('Industry');
        Test.stopTest();

        Assert.areEqual('Test Account', name, 'Name is not correct');
        Assert.areEqual('Prospect', type, 'Type is not correct');
        Assert.areEqual('Agriculture', industry, 'Industry is not correct');
    }

    @IsTest
    private static void testToString() {
        Map<String, Object> ar = new Map<String, Object>{
            'Name' => 'Test Account',
            'Type' => 'Prospect',
            'Industry' => 'Agriculture'
        };

        Test.startTest();
        Aggregate a = new Aggregate(ar);
        String s = a.toString();
        Test.stopTest();

        Assert.areEqual(
            '{Industry=Agriculture, Name=Test Account, Type=Prospect}',
            s,
            'String is not correct'
        );
    }
}
