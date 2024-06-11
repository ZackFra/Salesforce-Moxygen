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

    @IsTest
    static void testParseCalendarYearInWhereClause() {
        Parser t = new Parser();
        Test.startTest();
        Node head = t.parse('SELECT Name FROM Account WHERE CALENDAR_YEAR(CreatedDate) = 2024');
        Test.stopTest();

        Assert.areEqual(NodeType.XSELECT, head.nodeType, 'Expected head.nodeType to be select');
        Assert.areEqual(Token.XSELECT, head.id, 'Expected head.id to be select');
        Assert.isNotNull(head.left, 'Expected head.left to not be null');
        Assert.isNotNull(head.right, 'Expected head.right to not be null');

        Node nameNode = head.left;
        Assert.areEqual(NodeType.FIELD, nameNode.nodeType, 'Expected nameNode.nodeType to be field');
        Assert.areEqual('name', nameNode.id, 'Expected nameNode.id to be name');
        Assert.isNull(nameNode.left, 'Expected nameNode.left to be null');
        Assert.isNull(nameNode.right, 'Expected nameNode.right to be null');

        Node fromNode = head.right;
        Assert.areEqual(NodeType.XFROM, fromNode.nodeType, 'Expected fromNode.nodeType to be from');
        Assert.areEqual(Token.XFROM, fromNode.id, 'Expected fromNode.id to be from');
        Assert.isNotNull(fromNode.left, 'Expected fromNode.left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected fromNode.right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual(NodeType.SF_OBJECT, accountNode.nodeType, 'Expected accountNode.nodeType to be sobject');
        Assert.areEqual('account', accountNode.id, 'Expected accountNode.id to be account');
        Assert.isNull(accountNode.left, 'Expected accountNode.left to be null');
        Assert.isNull(accountNode.right, 'Expected accountNode.right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual(NodeType.XWHERE, whereNode.nodeType, 'Expected whereNode.nodeType to be where');
        Assert.areEqual(Token.XWHERE, whereNode.id, 'Expected whereNode.id to be where');
        Assert.isNotNull(whereNode.left, 'Expected whereNode.left to not be null');
        Assert.isNull(whereNode.right, 'Expected whereNode.right to be null');

        Node opNode = whereNode.left;
        Assert.areEqual(NodeType.OPERATOR, opNode.nodeType, 'Expected opNode.nodeType to be operator');
        Assert.areEqual(Token.XEQUALS, opNode.id, 'Expected opNode.id to be =');
        Assert.isNotNull(opNode.left, 'Expected opNode.left to not be null');
    }

    @IsTest
    static void testParseCalendarYearInSelectClause() {
        Parser t = new Parser();
        Test.startTest();
        Node head = t.parse('SELECT Name, CALENDAR_YEAR(CreatedDate) FROM Account GROUP BY Name, CALENDAR_YEAR(CreatedDate)');
        Test.stopTest();

        Assert.areEqual(NodeType.XSELECT, head.nodeType, 'Expected head.nodeType to be select');
        Assert.areEqual(Token.XSELECT, head.id, 'Expected head.id to be select');
        Assert.isNotNull(head.left, 'Expected head.left to not be null');
        Assert.isNotNull(head.right, 'Expected head.right to not be null');

        Node nameNode = head.left;
        Assert.areEqual(NodeType.FIELD, nameNode.nodeType, 'Expected nameNode.nodeType to be field');
        Assert.areEqual('name', nameNode.id, 'Expected nameNode.id to be name');
        Assert.isNotNull(nameNode.left, 'Expected nameNode.left not to be null');
        Assert.isNull(nameNode.right, 'Expected nameNode.right to be null');

        Node calendarYearNode = nameNode.left;
        Assert.areEqual(NodeType.AGGREGATE_FUNCTION, calendarYearNode.nodeType, 'Expected calendarYearNode.nodeType to be aggregate function');
        Assert.areEqual(Token.CALENDAR_YEAR, calendarYearNode.id, 'Expected calendarYearNode.id to be CALENDAR_YEAR');
        Assert.isNull(calendarYearNode.left, 'Expected calendarYearNode.left to be null');
        Assert.isNotNull(calendarYearNode.right, 'Expected calendarYearNode.right to not be null');

        Node createdDateNode = calendarYearNode.right;
        Assert.areEqual(NodeType.FIELD, createdDateNode.nodeType, 'Expected createdDateNode.nodeType to be field');
        Assert.areEqual('createddate', createdDateNode.id, 'Expected createdDateNode.id to be CreatedDate');
        Assert.isNull(createdDateNode.left, 'Expected createdDateNode.left to be null');
        Assert.isNull(createdDateNode.right, 'Expected createdDateNode.right to be null');

        Node fromNode = head.right;
        Assert.areEqual(NodeType.XFROM, fromNode.nodeType, 'Expected fromNode.nodeType to be from');
        Assert.areEqual(Token.XFROM, fromNode.id, 'Expected fromNode.id to be from');
        Assert.isNotNull(fromNode.left, 'Expected fromNode.left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected fromNode.right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual(NodeType.SF_OBJECT, accountNode.nodeType, 'Expected accountNode.nodeType to be sobject');
        Assert.areEqual('account', accountNode.id, 'Expected accountNode.id to be account');
        Assert.isNull(accountNode.left, 'Expected accountNode.left to be null');
        Assert.isNull(accountNode.right, 'Expected accountNode.right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual(NodeType.XGROUP_BY, groupByNode.nodeType, 'Expected groupByNode.nodeType to be group by');
        Assert.areEqual(NodeType.XGROUP_BY, groupByNode.id, 'Expected groupByNode.id to be group by');
        Assert.isNotNull(groupByNode.left, 'Expected groupByNode.left to not be null');
        Assert.isNull(groupByNode.right, 'Expected groupByNode.right to be null');

        Node nameNode2 = groupByNode.left;
        Assert.areEqual(NodeType.FIELD, nameNode2.nodeType, 'Expected nameNode2.nodeType to be field');
        Assert.areEqual('name', nameNode2.id, 'Expected nameNode2.id to be name');
        Assert.isNotNull(nameNode2.left, 'Expected nameNode2.left to not be null');
        Assert.isNull(nameNode2.right, 'Expected nameNode2.right to be null');

        Node calendarYearNode2 = nameNode2.left;
        Assert.areEqual(NodeType.AGGREGATE_FUNCTION, calendarYearNode2.nodeType, 'Expected calendarYearNode2.nodeType to be aggregate function');
        Assert.areEqual(Token.CALENDAR_YEAR, calendarYearNode2.id, 'Expected calendarYearNode2.id to be CALENDAR_YEAR');
        Assert.isNull(calendarYearNode2.left, 'Expected calendarYearNode2.left to be null');
        Assert.isNotNull(calendarYearNode2.right, 'Expected calendarYearNode2.right to not be null');
    }

    /**
     * @description Test for success when CALENDAR_QUARTER is in the SELECT clause
     */
    @IsTest
    static void testParseCalendarQuarterInSelectClause() {
        Parser p = new Parser();
        Test.startTest();
        Node head = p.parse('SELECT Name, CALENDAR_QUARTER(CreatedDate) FROM Account GROUP BY Name, CALENDAR_QUARTER(CreatedDate)');
        Test.stopTest();

        Assert.areEqual(NodeType.XSELECT, head.nodeType, 'Expected head.nodeType to be select');
        Assert.areEqual(Token.XSELECT, head.id, 'Expected head.id to be select');
        Assert.isNotNull(head.left, 'Expected head.left to not be null');
        Assert.isNotNull(head.right, 'Expected head.right to not be null');

        Node nameNode = head.left;
        Assert.areEqual(NodeType.FIELD, nameNode.nodeType, 'Expected nameNode.nodeType to be field');
        Assert.areEqual('name', nameNode.id, 'Expected nameNode.id to be name');
        Assert.isNotNull(nameNode.left, 'Expected nameNode.left to not be null');
        Assert.isNull(nameNode.right, 'Expected nameNode.right to be null');

        Node calendarQuarterNode = nameNode.left;
        Assert.areEqual(NodeType.AGGREGATE_FUNCTION, calendarQuarterNode.nodeType, 'Expected calendarQuarterNode.nodeType to be aggregate function');
        Assert.areEqual(Token.CALENDAR_QUARTER, calendarQuarterNode.id, 'Expected calendarQuarterNode.id to be CALENDAR_QUARTER');
        Assert.isNull(calendarQuarterNode.left, 'Expected calendarQuarterNode.left to be null');
        Assert.isNotNull(calendarQuarterNode.right, 'Expected calendarQuarterNode.right to not be null');

        Node createdDateNode = calendarQuarterNode.right;
        Assert.areEqual(NodeType.FIELD, createdDateNode.nodeType, 'Expected createdDateNode.nodeType to be field');
        Assert.areEqual('createddate', createdDateNode.id, 'Expected createdDateNode.id to be CreatedDate');
        Assert.isNull(createdDateNode.left, 'Expected createdDateNode.left to be null');
        Assert.isNull(createdDateNode.right, 'Expected createdDateNode.right to be null');
    }

    @IsTest
    static void parseCalendarQuarterInWhereClause() {
        Parser p = new Parser();
        Test.startTest();
        Node head = p.parse('SELECT Name FROM Account WHERE CALENDAR_QUARTER(CreatedDate) = 1');
        Test.stopTest();

        Assert.areEqual(NodeType.XSELECT, head.nodeType, 'Expected head.nodeType to be select');
        Assert.areEqual(Token.XSELECT, head.id, 'Expected head.id to be select');
        Assert.isNotNull(head.left, 'Expected head.left to not be null');
        Assert.isNotNull(head.right, 'Expected head.right to not be null');

        Node fromNode = head.right;
        Assert.areEqual(NodeType.XFROM, fromNode.nodeType, 'Expected fromNode.nodeType to be from');
        Assert.areEqual(Token.XFROM, fromNode.id, 'Expected fromNode.id to be from');
        Assert.isNotNull(fromNode.left, 'Expected fromNode.left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected fromNode.right to not be null');

        Node whereNode = fromNode.right;
        Assert.areEqual(NodeType.XWHERE, whereNode.nodeType, 'Expected whereNode.nodeType to be where');
        Assert.areEqual(Token.XWHERE, whereNode.id, 'Expected whereNode.id to be where');
        Assert.isNotNull(whereNode.left, 'Expected whereNode.left to not be null');
        Assert.isNull(whereNode.right, 'Expected whereNode.right to be null');

        Node opNode = whereNode.left;
        Assert.areEqual(NodeType.OPERATOR, opNode.nodeType, 'Expected opNode.nodeType to be operator');
        Assert.areEqual(Token.XEQUALS, opNode.id, 'Expected opNode.id to be =');
        Assert.isNotNull(opNode.left, 'Expected opNode.left to not be null');
        Assert.isNotNull(opNode.right, 'Expected opNode.right to not be null');

        Node calendarQuarterNode = opNode.left;
        Assert.areEqual(NodeType.AGGREGATE_FUNCTION, calendarQuarterNode.nodeType, 'Expected calendarQuarterNode.nodeType to be aggregate function');
        Assert.areEqual(Token.CALENDAR_QUARTER, calendarQuarterNode.id, 'Expected calendarQuarterNode.id to be CALENDAR_QUARTER');
        Assert.isNotNull(calendarQuarterNode.right, 'Expected calendarQuarterNode.right to not be null');
        Assert.isNull(calendarQuarterNode.left, 'Expected calendarQuarterNode.left to be null');

        Node createdDateNode = calendarQuarterNode.right;
        Assert.areEqual(NodeType.FIELD, createdDateNode.nodeType, 'Expected createdDateNode.nodeType to be field');
        Assert.areEqual('createddate', createdDateNode.id, 'Expected createdDateNode.id to be CreatedDate');
        Assert.isNull(createdDateNode.left, 'Expected createdDateNode.left to be null');
        Assert.isNull(createdDateNode.right, 'Expected createdDateNode.right to be null');

        Node valueNode = opNode.right;
        Assert.areEqual(NodeType.XNUMBER, valueNode.nodeType, 'Expected valueNode.nodeType to be number');
        Assert.areEqual('1', valueNode.id, 'Expected valueNode.id to be 1');
        Assert.isNull(valueNode.left, 'Expected valueNode.left to be null');
        Assert.isNull(valueNode.right, 'Expected valueNode.right to be null');
    }

    @IsTest
    static void parseCalendarQuarterInHavingClause() {
        
        Parser p = new Parser();
        Test.startTest();
        Node head = p.parse('SELECT Name, CALENDAR_QUARTER(CreatedDate) FROM Account GROUP BY Name, CALENDAR_QUARTER(CreatedDate) HAVING CALENDAR_QUARTER(CreatedDate) = 1');
        Test.stopTest();

        Assert.areEqual(NodeType.XSELECT, head.nodeType, 'Expected head.nodeType to be select');
        Assert.areEqual(Token.XSELECT, head.id, 'Expected head.id to be select');
        Assert.isNotNull(head.left, 'Expected head.left to not be null');
        Assert.isNotNull(head.right, 'Expected head.right to not be null');

        Node fromNode = head.right;
        Assert.areEqual(NodeType.XFROM, fromNode.nodeType, 'Expected fromNode.nodeType to be from');
        Assert.areEqual(token.XFROM, fromNode.id, 'Expected fromNode.id to be from');
        Assert.isNotNull(fromNode.left, 'Expected fromNode.left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected fromNode.right to not be null');

        
        Node groupByNode = fromNode.right;
        Assert.areEqual(NodeType.XGROUP_BY, groupByNode.nodeType, 'Expected groupByNode.nodeType to be group');
        Assert.areEqual(NodeType.XGROUP_BY, groupByNode.id, 'Expected groupByNode.id to be group');
        Assert.isNotNull(groupByNode.left, 'Expected groupByNode.left to not be null');
        Assert.isNotNull(groupByNode.right, 'Expected groupByNode.right to not be null');

        Node havingNode = groupByNode.right;
        Assert.areEqual(NodeType.XHAVING, havingNode.nodeType, 'Expected havingNode.nodeType to be having');
        Assert.areEqual(Token.XHAVING, havingNode.id, 'Expected havingNode.id to be having');
        Assert.isNotNull(havingNode.left, 'Expected havingNode.left to not be null');
        Assert.isNull(havingNode.right, 'Expected havingNode.right to be null');

        Node opNode = havingNode.left;
        Assert.areEqual(NodeType.OPERATOR, opNode.nodeType, 'Expected opNode.nodeType to be operator');
        Assert.areEqual(Token.XEQUALS, opNode.id, 'Expected opNode.id to be =');
        Assert.isNotNull(opNode.left, 'Expected opNode.left to not be null');
        Assert.isNotNull(opNode.right, 'Expected opNode.right to not be null');

        Node calendarQuarterNode = opNode.left;
        Assert.areEqual(NodeType.AGGREGATE_FUNCTION, calendarQuarterNode.nodeType, 'Expected calendarQuarterNode.nodeType to be aggregate function');
        Assert.areEqual(Token.CALENDAR_QUARTER, calendarQuarterNode.id, 'Expected calendarQuarterNode.id to be CALENDAR_QUARTER');
        Assert.isNotNull(calendarQuarterNode.right, 'Expected calendarQuarterNode.right to not be null');
        Assert.isNull(calendarQuarterNode.left, 'Expected calendarQuarterNode.left to be null');

        Node createdDateNode = calendarQuarterNode.right;
        Assert.areEqual(NodeType.FIELD, createdDateNode.nodeType, 'Expected createdDateNode.nodeType to be field');
        Assert.areEqual('createddate', createdDateNode.id, 'Expected createdDateNode.id to be CreatedDate');
        Assert.isNull(createdDateNode.left, 'Expected createdDateNode.left to be null');
        Assert.isNull(createdDateNode.right, 'Expected createdDateNode.right to be null');

        Node valueNode = opNode.right;
        Assert.areEqual(NodeType.XNUMBER, valueNode.nodeType, 'Expected valueNode.nodeType to be number');
        Assert.areEqual('1', valueNode.id, 'Expected valueNode.id to be 1');
        Assert.isNull(valueNode.left, 'Expected valueNode.left to be null');
        Assert.isNull(valueNode.right, 'Expected valueNode.right to be null');

    }
}