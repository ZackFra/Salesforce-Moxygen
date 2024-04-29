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


@IsTest
@SuppressWarnings('PMD')
private class ParserDateFuncTest {
    @IsTest
    static void testCalendarMonthInSelectClause() {
        Parser t = new Parser();
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            t.parse('SELECT Name, CALENDAR_MONTH(CreatedDate) FROM Account GROUP BY Name, CALENDAR_MONTH(CreatedDate)');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isFalse(isExceptionThrown, 'Expected exception to not be thrown');
    }

    @IsTest
    static void testCalendarMonthInWhereClause() {
        Parser t = new Parser();
        Test.startTest();
        Boolean isExceptionThrown = false;
        try {
            t.parse('SELECT Name FROM Account WHERE CALENDAR_MONTH(CreatedDate) = 1');
        } catch(Exception e) {
            isExceptionThrown = true;
        }
        Test.stopTest();

        Assert.isFalse(isExceptionThrown, 'Expected exception to not be thrown');
    }

    @IsTest
    static void testCalendarMonthInWhereClauseAST() {
        Parser t = new Parser();
        Test.startTest();
        Node head = t.parse('SELECT Name FROM Account WHERE CALENDAR_MONTH(CreatedDate) = 1');
        Test.stopTest();

        Assert.areEqual('select', head.nodeType, 'Expected head.nodeType to be select');
        Assert.areEqual('select', head.id, 'Expected head.id to be select');
        Assert.isNotNull(head.left, 'Expected head.left to not be null');
        Assert.isNotNull(head.right, 'Expected head.right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('field', nameNode.nodeType, 'Expected nameNode.nodeType to be field');
        Assert.areEqual('name', nameNode.id, 'Expected nameNode.id to be name');
        Assert.isNull(nameNode.left, 'Expected nameNode.left to be null');
        Assert.isNull(nameNode.right, 'Expected nameNode.right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.nodeType, 'Expected fromNode.nodeType to be from');
        Assert.areEqual('from', fromNode.id, 'Expected fromNode.id to be from');
        Assert.isNotNull(fromNode.left, 'Expected fromNode.left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected fromNode.right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('object', accountNode.nodeType, 'Expected accountNode.nodeType to be sobject');
        Assert.areEqual('account', accountNode.id, 'Expected accountNode.id to be account');
        Assert.isNull(accountNode.left, 'Expected accountNode.left to be null');
        Assert.isNull(accountNode.right, 'Expected accountNode.right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.nodeType, 'Expected whereNode.nodeType to be where');
        Assert.areEqual('where', whereNode.id, 'Expected whereNode.id to be where');
        Assert.isNotNull(whereNode.left, 'Expected whereNode.left to not be null');
        Assert.isNull(whereNode.right, 'Expected whereNode.right to be null');

        Node opNode = whereNode.left;
        Assert.areEqual('operator', opNode.nodeType, 'Expected opNode.nodeType to be operator');
        Assert.areEqual('=', opNode.id, 'Expected opNode.id to be =');
        Assert.isNotNull(opNode.left, 'Expected opNode.left to not be null');
        Assert.isNotNull(opNode.right, 'Expected opNode.right to not be null');

        Node calendarMonthNode = opNode.left;
        Assert.areEqual('aggregate function', calendarMonthNode.nodeType, 'Expected calendarMonthNode.nodeType to be function');
        Assert.areEqual('calendar_month', calendarMonthNode.id, 'Expected calendarMonthNode.id to be CALENDAR_MONTH');
        Assert.isNull(calendarMonthNode.left, 'Expected calendarMonthNode.left to not be null');
        Assert.isNotNull(calendarMonthNode.right, 'Expected calendarMonthNode.right to be null');

        Node createdDateNode = calendarMonthNode.right;
        Assert.areEqual('field', createdDateNode.nodeType, 'Expected createdDateNode.nodeType to be field');
        Assert.areEqual('createddate', createdDateNode.id, 'Expected createdDateNode.id to be CreatedDate');
        Assert.isNull(createdDateNode.left, 'Expected createdDateNode.left to be null');
        Assert.isNull(createdDateNode.right, 'Expected createdDateNode.right to be null');

        Node oneNode = opNode.right;
        Assert.areEqual('number', oneNode.nodeType, 'Expected oneNode.nodeType to be number');
        Assert.areEqual('1', oneNode.id, 'Expected oneNode.id to be 1');
        Assert.isNull(oneNode.left, 'Expected oneNode.left to be null');
        Assert.isNull(oneNode.right, 'Expected oneNode.right to be null');
    }
}