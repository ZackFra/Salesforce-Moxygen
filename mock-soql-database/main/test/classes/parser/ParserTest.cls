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
@SuppressWarnings('PMD.NcssTypeCount, PMD.CyclomaticComplexity, PMD.CognitiveComplexity, PMD.ApexUnitTestClassShouldHaveAsserts')
private class ParserTest {

    @IsTest
    private static void testOrderBy() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Account ORDER BY Name, Id');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node orderByNode = fromNode.right;
        Assert.areEqual('order by', orderByNode.id, 'Expected id to be "order by"');
        Assert.areEqual('order by', orderByNode.nodeType, 'Expected nodeType to be "order by"');
        Assert.isNotNull(orderByNode.left, 'Expected left to be not null');
        Assert.isNull(orderByNode.right, 'Expected right to be null');

        Node nameNode = orderByNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node idNode2 = nameNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');
    }

    @IsTest
    private static void testLimit() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Account LIMIT 10');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node limitNode = fromNode.right;
        Assert.areEqual('limit', limitNode.id, 'Expected id to be "limit"');
        Assert.areEqual('limit', limitNode.nodeType, 'Expected nodeType to be "limit"');
        Assert.isNotNull(limitNode.left, 'Expected left to be not null');
        Assert.isNull(limitNode.right, 'Expected right to be null');

        Node valueNode = limitNode.left;
        Assert.areEqual('10', valueNode.id, 'Expected id to be "10"');
        Assert.areEqual('number', valueNode.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testForUpdate() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Account FOR UPDATE');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node forUpdateNode = fromNode.right;
        Assert.areEqual('for update', forUpdateNode.id, 'Expected id to be "for update"');
        Assert.areEqual('for update', forUpdateNode.nodeType, 'Expected nodeType to be "for update"');
        Assert.isNull(forUpdateNode.left, 'Expected left to be null');
        Assert.isNull(forUpdateNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testHavingClause() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Account GROUP BY Id HAVING COUNT(Id) > 0');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');
    
        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNotNull(groupByNode.right, 'Expected right to be not null');

        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNotNull(groupByNode.right, 'Expected right to be not null');

        Node idNode2 = groupByNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node havingNode = groupByNode.right;
        Assert.areEqual('having', havingNode.id, 'Expected id to be "having"');
        Assert.areEqual('having', havingNode.nodeType, 'Expected nodeType to be "having"');
        Assert.isNotNull(havingNode.left, 'Expected left to be not null');
        Assert.isNull(havingNode.right, 'Expected right to be null');

        Node operatorNode = havingNode.left;
        Assert.areEqual('>', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node aggregateFunctionNode = operatorNode.left;
        Assert.areEqual('count', aggregateFunctionNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', aggregateFunctionNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(aggregateFunctionNode.left, 'Expected left to be null');
        Assert.isNotNull(aggregateFunctionNode.right, 'Expected right to be not null');

        Node idNode3 = aggregateFunctionNode.right;
        Assert.areEqual('id', idNode3.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode3.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode3.left, 'Expected left to be null');
        Assert.isNull(idNode3.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('0', valueNode.id, 'Expected id to be "0"');
        Assert.areEqual('number', valueNode.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testAggrFuncs() {
        List<Map<String, Object>> nodes = new List<Map<String, Object>>();
        Test.startTest();
        for(String func : AggregateService.SUPPORTED_NUMERIC_FUNCS) {
            Parser t = new Parser();
            Node head = t.parse('SELECT ' + func + '(Amount) FROM Opportunity');
            Map<String, Object> nodeDatum = new Map<String, Object> {
                'head' => head,
                'func' => func
            };
            nodes.add(nodeDatum);
        }
        Test.stopTest();


        for(Map<String, Object> nodeData : nodes) { 
            Node head = (Node) nodeData.get('head');
            String func = (String) nodeData.get('func');

            // we expect this to come back in a particular order
            Assert.areEqual('select', head.id, 'Expected id to be "select"');
            Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
            Assert.isNotNull(head.left, 'Expected left to be not null');
            Assert.isNotNull(head.right, 'Expected right to be not null');
    
            Node sumNode = head.left;
            Assert.areEqual(func, sumNode.id, 'Expected id to be "' + func + '"');
            Assert.areEqual('aggregate function', sumNode.nodeType, 'Expected nodeType to be "aggregate function"');
            Assert.isNull(sumNode.left, 'Expected left to be null');
            Assert.isNotNull(sumNode.right, 'Expected right to be not null');
    
            Node amountNode = sumNode.right;
            Assert.areEqual('amount', amountNode.id, 'Expected id to be "amount"');
            Assert.areEqual('field', amountNode.nodeType, 'Expected nodeType to be "field"');
            Assert.isNull(amountNode.left, 'Expected left to be null');
            Assert.isNull(amountNode.right, 'Expected right to be null');
    
            Node fromNode = head.right;
            Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
            Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
            Assert.isNotNull(fromNode.left, 'Expected left to be not null');
            Assert.isNull(fromNode.right, 'Expected right to be null');
    
            Node opportunityNode = fromNode.left;
            Assert.areEqual('opportunity', opportunityNode.id, 'Expected id to be "opportunity"');
            Assert.areEqual('object', opportunityNode.nodeType, 'Expected nodeType to be "object"');
            Assert.isNull(opportunityNode.left, 'Expected left to be null');
            Assert.isNull(opportunityNode.right, 'Expected right to be null');       
        }
    }

    @IsTest
    private static void testBindVar() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Account WHERE Id = :id');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node operatorNode = whereNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node idNode2 = operatorNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node bindVarNode = operatorNode.right;
        Assert.areEqual('id', bindVarNode.id, 'Expected id to be "id"');
        Assert.areEqual('bind variable', bindVarNode.nodeType, 'Expected nodeType to be "bind variable"');
        Assert.isNull(bindVarNode.left, 'Expected left to be null');
        Assert.isNull(bindVarNode.right, 'Expected right to be null');

    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testAndStatements() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName = \'test\' AND LastName = \'test2\' AND Account.Name = \'testAcct\'');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node andNode = whereNode.left;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode = andNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node andNode2 = andNode.right;
        Assert.areEqual('and', andNode2.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode2.left, 'Expected left to not be null');
        Assert.isNotNull(andNode2.right, 'Expected right to not be null');

        Node operatorNode2 = andNode2.left;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node lastNameNode = operatorNode2.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node operatorNode3 = andNode2.right;
        Assert.areEqual('=', operatorNode3.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node accountNameNode = operatorNode3.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode.left, 'Expected left to be null');
        Assert.isNull(accountNameNode.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('testacct', valueNode3.id, 'Expected id to be "testacct"');
        Assert.areEqual('string', valueNode3.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testQueryWithOrAnd() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName = \'test\' OR LastName = \'test2\' AND Account.Name = \'testAcct\'');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node orNode = whereNode.left;
        Assert.areEqual('or', orNode.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode.left, 'Expected left to not be null');
        Assert.isNotNull(orNode.right, 'Expected right to not be null');

        Node operatorNode = orNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node andNode = orNode.right;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode2 = andNode.left;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node lastNameNode = operatorNode2.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node operatorNode3 = andNode.right;
        Assert.areEqual('=', operatorNode3.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node accountNameNode = operatorNode3.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode.left, 'Expected left to be null');
        Assert.isNull(accountNameNode.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('testacct', valueNode3.id, 'Expected id to be "testacct"');
        Assert.areEqual('string', valueNode3.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');

        
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testNot() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Contact WHERE NOT FirstName = \'test\'');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node notNode = whereNode.left;
        Assert.areEqual('not', notNode.id, 'Expected id to be "not"');
        Assert.areEqual('not', notNode.nodeType, 'Expected nodeType to be "not"');
        Assert.isNotNull(notNode.left, 'Expected left to be not null');
        Assert.isNull(notNode.right, 'Expected right to be null');

        Node operatorNode = notNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testCorrectsForAndWithOr() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName = \'test\' OR LastName = \'test2\' AND Account.Name = \'testAcct\' OR Account.Name = \'testAcct2\'');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node orNode = whereNode.left;
        Assert.areEqual('or', orNode.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode.left, 'Expected left to not be null');
        Assert.isNotNull(orNode.right, 'Expected right to not be null');

        Node orNode2 = orNode.left;
        Assert.areEqual('or', orNode2.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode2.left, 'Expected left to not be null');
        Assert.isNotNull(orNode2.right, 'Expected right to not be null');

        Node operatorNode = orNode2.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node andNode = orNode2.right;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode2 = andNode.left;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node lastNameNode = operatorNode2.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node operatorNode3 = andNode.right;
        Assert.areEqual('=', operatorNode3.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node accountNameNode = operatorNode3.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode.left, 'Expected left to be null');
        Assert.isNull(accountNameNode.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('testacct', valueNode3.id, 'Expected id to be "testacct"');
        Assert.areEqual('string', valueNode3.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');

        Node operatorNode4 = orNode.right;
        Assert.areEqual('=', operatorNode4.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode4.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode4.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode4.right, 'Expected right to not be null');

        Node accountNameNode2 = operatorNode4.left;
        Assert.areEqual('account.name', accountNameNode2.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode2.left, 'Expected left to be null');
        Assert.isNull(accountNameNode2.right, 'Expected right to be null');

        Node valueNode4 = operatorNode4.right;
        Assert.areEqual('testacct2', valueNode4.id, 'Expected id to be "testacct2"');
        Assert.areEqual('string', valueNode4.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode4.left, 'Expected left to be null');
        Assert.isNull(valueNode4.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testCorrectsForAndWithOrWithSubExpr() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName = \'test\' AND LastName = \'test2\' OR (Account.Name = \'testAcct\' AND Account.Name = \'testAcct2\' OR Account.Name = \'testAcct3\')');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node orNode = whereNode.left;
        Assert.areEqual('or', orNode.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode.left, 'Expected left to not be null');
        Assert.isNotNull(orNode.right, 'Expected right to not be null');

        Node andNode = orNode.left;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode = andNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node firstNameNode = operatorNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node operatorNode2 = andNode.right;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node lastNameNode = operatorNode2.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node subExprNode2 = orNode.right;
        Assert.areEqual('conditional subexpression', subExprNode2.id, 'Expected id to be "conditional subexpression"');
        Assert.areEqual('conditional subexpression', subExprNode2.nodeType, 'Expected nodeType to be "conditional subexpression"');
        Assert.isNotNull(subExprNode2.left, 'Expected left to not be null');
        Assert.isNull(subExprNode2.right, 'Expected right to be null');

        Node orNode2 = subExprNode2.left;
        Assert.areEqual('or', orNode2.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(orNode2.left, 'Expected left to not be null');
        Assert.isNotNull(orNode2.right, 'Expected right to not be null');

        Node andNode2 = orNode2.left;
        Assert.areEqual('and', andNode2.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode2.left, 'Expected left to not be null');
        Assert.isNotNull(andNode2.right, 'Expected right to not be null');

        Node operatorNode3 = andNode2.left;
        Assert.areEqual('=', operatorNode3.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node accountNameNode = operatorNode3.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode.left, 'Expected left to be null');
        Assert.isNull(accountNameNode.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('testacct', valueNode3.id, 'Expected id to be "testacct"');
        Assert.areEqual('string', valueNode3.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');

        Node operatorNode4 = andNode2.right;
        Assert.areEqual('=', operatorNode4.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode4.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode4.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode4.right, 'Expected right to not be null');

        Node accountNameNode2 = operatorNode4.left;
        Assert.areEqual('account.name', accountNameNode2.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode2.left, 'Expected left to be null');
        Assert.isNull(accountNameNode2.right, 'Expected right to be null');

        Node valueNode4 = operatorNode4.right;
        Assert.areEqual('testacct2', valueNode4.id, 'Expected id to be "testacct2"');
        Assert.areEqual('string', valueNode4.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode4.left, 'Expected left to be null');
        Assert.isNull(valueNode4.right, 'Expected right to be null');

        Node operatorNode5 = orNode2.right;
        Assert.areEqual('=', operatorNode5.id, 'Expected id to be "operator"');
        Assert.areEqual('operator', operatorNode5.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode5.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode5.right, 'Expected right to not be null');

        Node accountNameNode3 = operatorNode5.left;
        Assert.areEqual('account.name', accountNameNode3.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode3.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode3.left, 'Expected left to be null');
        Assert.isNull(accountNameNode3.right, 'Expected right to be null');

        Node valueNode5 = operatorNode5.right;
        Assert.areEqual('testacct3', valueNode5.id, 'Expected id to be "testacct3"');
        Assert.areEqual('string', valueNode5.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode5.left, 'Expected left to be null');
        Assert.isNull(valueNode5.right, 'Expected right to be null');

    }

    @IsTest
    private static void testAlias() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT COUNT(Id) Cnt1 FROM Account GROUP BY Id');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node countNode = head.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to not be null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node aliasNode = idNode.left;
        Assert.areEqual('Cnt1', aliasNode.id, 'Expected id to be "Cnt1"');
        Assert.areEqual('alias', aliasNode.nodeType, 'Expected nodeType to be "alias"');
        Assert.isNull(aliasNode.left, 'Expected left to be null');
        Assert.isNull(aliasNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual(accountNode.id, 'account', 'Expected id to be "account"');
        Assert.areEqual(accountNode.nodeType, 'object', 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNull(groupByNode.right, 'Expected right to be null');

        Node idNode2 = groupByNode.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testParseValueList() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id FROM Contact WHERE FirstName IN (\'test\', \'test2\')');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual(idNode.id, 'id', 'Expected id to be "id"');
        Assert.areEqual(idNode.nodeType, 'field', 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual('contact', contactNode.id, 'Expected id to be "contact"');
        Assert.areEqual('object', contactNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node whereNode = fromNode.right;
        Assert.areEqual('where', whereNode.id, 'Expected id to be "where"');
        Assert.areEqual('where', whereNode.nodeType, 'Expected nodeType to be "where"');
        Assert.isNotNull(whereNode.left, 'Expected left to be not null');
        Assert.isNull(whereNode.right, 'Expected right to be null');

        Node inNode = whereNode.left;
        Assert.areEqual('in', inNode.id, 'Expected id to be "in"');
        Assert.areEqual('operator', inNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(inNode.left, 'Expected left to not be null');
        Assert.isNotNull(inNode.right, 'Expected right to not be null');

        Node firstNameNode = inNode.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(firstNameNode.left, 'Expected left to be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node valueListNode = inNode.right;
        Assert.areEqual('value list', valueListNode.id, 'Expected id to be "value list"');
        Assert.areEqual('value list', valueListNode.nodeType, 'Expected nodeType to be "value list"');
        Assert.isNotNull(valueListNode.left, 'Expected left to not be null');
        Assert.isNull(valueListNode.right, 'Expected right to be null');

        Node valueNode = valueListNode.left;
        Assert.areEqual('test', valueNode.id, 'Expected id to be "test"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNotNull(valueNode.left, 'Expected left to not be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node valueListNode2 = valueNode.left;
        Assert.areEqual('value list', valueListNode2.id, 'Expected id to be "value list"');
        Assert.areEqual('value list', valueListNode2.nodeType, 'Expected nodeType to be "value list"');
        Assert.isNotNull(valueListNode2.left, 'Expected left to not be null');
        Assert.isNull(valueListNode2.right, 'Expected right to be null');

        Node valueNode2 = valueListNode2.left;
        Assert.areEqual('test2', valueNode2.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');
    }

    @IsTest
    private static void testSingularCount() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT COUNT() FROM Account');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node countNode = head.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNull(countNode.right, 'Expected right to be null');
 
        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

    }

    @IsTest
    private static void testSimpleAlias() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id id FROM Account');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNotNull(idNode.right, 'Expected right to not be null');

        Node idAliasNode = idNode.right;
        Assert.areEqual('id', idAliasNode.id, 'Expected id to be "id"');
        Assert.areEqual('alias', idAliasNode.nodeType, 'Expected nodeType to be "alias"');
        Assert.isNull(idAliasNode.left, 'Expected left to be null');
        Assert.isNull(idAliasNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testAliases() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Account.Name acctName, Name, COUNT(Id) FROM Contact GROUP BY Name, Account.Name');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node accountNameNode = head.left;
        Assert.areEqual('account.name', accountNameNode.id, 'Expected id to be "account.name"');
        Assert.areEqual('field', accountNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(accountNameNode.left, 'Expected left to not be null');
        Assert.isNotNull(accountNameNode.right, 'Expected right to not be null');

        Node acctNameNode = accountNameNode.right;
        Assert.areEqual('acctName', acctNameNode.id, 'Expected id to be "acctName"');
        Assert.areEqual('alias', acctNameNode.nodeType, 'Expected nodeType to be "alias"');
        Assert.isNull(acctNameNode.left, 'Expected left to be null');
        Assert.isNull(acctNameNode.right, 'Expected right to be null');

        Node nameNode = accountNameNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node countNode = nameNode.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to not be null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node contactNode = fromNode.left;
        Assert.areEqual(contactNode.id, 'contact', 'Expected id to be "contact"');
        Assert.areEqual(contactNode.nodeType, 'object', 'Expected nodeType to be "object"');
        Assert.isNull(contactNode.left, 'Expected left to be null');
        Assert.isNull(contactNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual(groupByNode.id, 'group by', 'Expected id to be "group by"');
        Assert.areEqual(groupByNode.nodeType, 'group by', 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNull(groupByNode.right, 'Expected right to be null');

        Node nameNode2 = groupByNode.left;
        Assert.areEqual(nameNode2.id, 'name', 'Expected id to be "name"');
        Assert.areEqual(nameNode2.nodeType, 'field', 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode2.left, 'Expected left to not be null');
        Assert.isNull(nameNode2.right, 'Expected right to be null');

        Node accountNameNode2 = nameNode2.left;
        Assert.areEqual(accountNameNode2.id, 'account.name', 'Expected id to be "account.name"');
        Assert.areEqual(accountNameNode2.nodeType, 'field', 'Expected nodeType to be "field"');
        Assert.isNull(accountNameNode2.left, 'Expected left to be null');
        Assert.isNull(accountNameNode2.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testSubQueryNoAlias() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account');
        Test.stopTest();
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node nameNode = idNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node subQueryNode = nameNode.left;
        Assert.areEqual('subquery', subQueryNode.id, 'Expected id to be "subquery"');
        Assert.areEqual('subquery', subQueryNode.nodeType, 'Expected nodeType to be "subquery"');
        Assert.isNull(subQueryNode.left, 'Expected left to be not null');
        Assert.isNotNull(subQueryNode.right, 'Expected right to not be null');

        Node selectNode2 = subQueryNode.right;
        Assert.areEqual('select', selectNode2.id, 'Expected id to be "select"');
        Assert.areEqual('select', selectNode2.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(selectNode2.left, 'Expected left to be not null');
        Assert.isNotNull(selectNode2.right, 'Expected right to be not null');

        Node idNode2 = selectNode2.left;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode2.left, 'Expected left to not be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node firstNameNode = idNode2.left;
        Assert.areEqual('firstname', firstNameNode.id, 'Expected id to be "firstname"');
        Assert.areEqual('field', firstNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(firstNameNode.left, 'Expected left to not be null');
        Assert.isNull(firstNameNode.right, 'Expected right to be null');

        Node lastNameNode = firstNameNode.left;
        Assert.areEqual('lastname', lastNameNode.id, 'Expected id to be "lastname"');
        Assert.areEqual('field', lastNameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(lastNameNode.left, 'Expected left to be null');
        Assert.isNull(lastNameNode.right, 'Expected right to be null');

        Node fromNode = selectNode2.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node contactsNode = fromNode.left;
        Assert.areEqual('contacts', contactsNode.id, 'Expected id to be "contacts"');
        Assert.areEqual('object', contactsNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(contactsNode.left, 'Expected left to be null');
        Assert.isNull(contactsNode.right, 'Expected right to be null');

        Node fromNode2 = head.right;
        Assert.areEqual('from', fromNode2.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode2.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode2.left, 'Expected left to be not null');
        Assert.isNull(fromNode2.right, 'Expected right to be null');

        Node accountNode = fromNode2.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testHavingClauseWithMultipleConditions() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Name, COUNT(Id) FROM Account GROUP BY Name HAVING COUNT(Id) > 1 AND COUNT(Id) < 10');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node countNode = nameNode.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to be not null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNotNull(groupByNode.right, 'Expected right to be not null');

        Node nameNode2 = groupByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNull(nameNode2.right, 'Expected right to be null');

        Node havingNode = groupByNode.right;
        Assert.areEqual('having', havingNode.id, 'Expected id to be "having"');
        Assert.areEqual('having', havingNode.nodeType, 'Expected nodeType to be "having"');
        Assert.isNotNull(havingNode.left, 'Expected left to be not null');
        Assert.isNull(havingNode.right, 'Expected right to be null');

        Node andNode = havingNode.left;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode = andNode.left;
        Assert.areEqual('>', operatorNode.id, 'Expected id to be ">"');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node countNode2 = operatorNode.left;
        Assert.areEqual('count', countNode2.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode2.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode2.left, 'Expected left to be null');
        Assert.isNotNull(countNode2.right, 'Expected right to not be null');

        Node idNode2 = countNode2.right;
        Assert.areEqual('id', idNode2.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode2.left, 'Expected left to be null');
        Assert.isNull(idNode2.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('1', valueNode.id, 'Expected id to be "1"');
        Assert.areEqual('number', valueNode.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node operatorNode2 = andNode.right;
        Assert.areEqual('<', operatorNode2.id, 'Expected id to be "<"');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node countNode3 = operatorNode2.left;
        Assert.areEqual('count', countNode3.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode3.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode3.left, 'Expected left to be null');
        Assert.isNotNull(countNode3.right, 'Expected right to not be null');

        Node idNode3 = countNode3.right;
        Assert.areEqual('id', idNode3.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode3.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode3.left, 'Expected left to be null');
        Assert.isNull(idNode3.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('10', valueNode2.id, 'Expected id to be "10"');
        Assert.areEqual('number', valueNode2.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testHavingClauseWhereAdjust() {
        Parser l = new Parser();
        
        Test.startTest();
        Node head = l.parse('SELECT Name, SUM(NumberOfEmployees) FROM Account GROUP BY Name HAVING Name = \'Test2\' OR Name = \'Test1\' AND SUM(NumberOfEmployees) > 10');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to be not null');
        Assert.isNotNull(head.right, 'Expected right to be not null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node sumNode = nameNode.left;
        Assert.areEqual('sum', sumNode.id, 'Expected id to be "sum"');
        Assert.areEqual('aggregate function', sumNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(sumNode.left, 'Expected left to be null');
        Assert.isNotNull(sumNode.right, 'Expected right to not be null');

        Node numberOfEmployeesNode = sumNode.right;
        Assert.areEqual('numberofemployees', numberOfEmployeesNode.id, 'Expected id to be "numberofemployees"');
        Assert.areEqual('field', numberOfEmployeesNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(numberOfEmployeesNode.left, 'Expected left to be null');
        Assert.isNull(numberOfEmployeesNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to be not null');
        Assert.isNotNull(fromNode.right, 'Expected right to be not null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node groupByNode = fromNode.right;
        Assert.areEqual('group by', groupByNode.id, 'Expected id to be "group by"');
        Assert.areEqual('group by', groupByNode.nodeType, 'Expected nodeType to be "group by"');
        Assert.isNotNull(groupByNode.left, 'Expected left to be not null');
        Assert.isNotNull(groupByNode.right, 'Expected right to be not null');

        Node nameNode2 = groupByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNull(nameNode2.right, 'Expected right to be null');

        Node havingNode = groupByNode.right;
        Assert.areEqual('having', havingNode.id, 'Expected id to be "having"');
        Assert.areEqual('having', havingNode.nodeType, 'Expected nodeType to be "having"');
        Assert.isNotNull(havingNode.left, 'Expected left to not be null');
        Assert.isNull(havingNode.right, 'Expected right to be null');

        Node orNode = havingNode.left;
        Assert.areEqual('or', orNode.id, 'Expected id to be "or"');
        Assert.areEqual('or', orNode.nodeType, 'Expected nodeType to be "or"');
        Assert.isNotNull(orNode.left, 'Expected left to not be null');
        Assert.isNotNull(orNode.right, 'Expected right to not be null');

        Node operatorNode = orNode.left;
        Assert.areEqual('=', operatorNode.id, 'Expected id to be "="');
        Assert.areEqual('operator', operatorNode.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode.right, 'Expected right to not be null');

        Node nameNode3 = operatorNode.left;
        Assert.areEqual('name', nameNode3.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode3.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode3.left, 'Expected left to be null');
        Assert.isNull(nameNode3.right, 'Expected right to be null');

        Node valueNode = operatorNode.right;
        Assert.areEqual('test2', valueNode.id, 'Expected id to be "test2"');
        Assert.areEqual('string', valueNode.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');

        Node andNode = orNode.right;
        Assert.areEqual('and', andNode.id, 'Expected id to be "and"');
        Assert.areEqual('and', andNode.nodeType, 'Expected nodeType to be "and"');
        Assert.isNotNull(andNode.left, 'Expected left to not be null');
        Assert.isNotNull(andNode.right, 'Expected right to not be null');

        Node operatorNode2 = andNode.left;
        Assert.areEqual('=', operatorNode2.id, 'Expected id to be "="');
        Assert.areEqual('operator', operatorNode2.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode2.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode2.right, 'Expected right to not be null');

        Node nameNode4 = operatorNode2.left;
        Assert.areEqual('name', nameNode4.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode4.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode4.left, 'Expected left to be null');
        Assert.isNull(nameNode4.right, 'Expected right to be null');

        Node valueNode2 = operatorNode2.right;
        Assert.areEqual('test1', valueNode2.id, 'Expected id to be "test1"');
        Assert.areEqual('string', valueNode2.nodeType, 'Expected nodeType to be "string"');
        Assert.isNull(valueNode2.left, 'Expected left to be null');
        Assert.isNull(valueNode2.right, 'Expected right to be null');

        Node operatorNode3 = andNode.right;
        Assert.areEqual('>', operatorNode3.id, 'Expected id to be ">"');
        Assert.areEqual('operator', operatorNode3.nodeType, 'Expected nodeType to be "operator"');
        Assert.isNotNull(operatorNode3.left, 'Expected left to not be null');
        Assert.isNotNull(operatorNode3.right, 'Expected right to not be null');

        Node sumNode2 = operatorNode3.left;
        Assert.areEqual('sum', sumNode2.id, 'Expected id to be "sum"');
        Assert.areEqual('aggregate function', sumNode2.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(sumNode2.left, 'Expected left to be null');
        Assert.isNotNull(sumNode2.right, 'Expected right to not be null');

        Node numberOfEmployeesNode2 = sumNode2.right;
        Assert.areEqual('numberofemployees', numberOfEmployeesNode2.id, 'Expected id to be "numberofemployees"');
        Assert.areEqual('field', numberOfEmployeesNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(numberOfEmployeesNode2.left, 'Expected left to be null');
        Assert.isNull(numberOfEmployeesNode2.right, 'Expected right to be null');

        Node valueNode3 = operatorNode3.right;
        Assert.areEqual('10', valueNode3.id, 'Expected id to be "10"');
        Assert.areEqual('number', valueNode3.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode3.left, 'Expected left to be null');
        Assert.isNull(valueNode3.right, 'Expected right to be null');
    }

    @IsTest
    private static void testOrderByDesc() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Name FROM Account ORDER BY Name DESC');
        Test.stopTest();
        
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node orderByNode = fromNode.right;
        Assert.areEqual('order by', orderByNode.id, 'Expected id to be "order by"');
        Assert.areEqual('order by', orderByNode.nodeType, 'Expected nodeType to be "order by"');
        Assert.isNotNull(orderByNode.left, 'Expected left to not be null');
        Assert.isNull(orderByNode.right, 'Expected right to be null');

        Node nameNode2 = orderByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNotNull(nameNode2.right, 'Expected right to not be null');

        Node descNode = nameNode2.right;
        Assert.areEqual('desc', descNode.id, 'Expected id to be "desc"');
        Assert.areEqual('direction', descNode.nodeType, 'Expected nodeType to be "desc"');
        Assert.isNull(descNode.left, 'Expected left to be null');
        Assert.isNull(descNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testNullsFirst() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Name FROM Account ORDER BY Name NULLS FIRST');
        Test.stopTest();
        
        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node orderByNode = fromNode.right;
        Assert.areEqual('order by', orderByNode.id, 'Expected id to be "order by"');
        Assert.areEqual('order by', orderByNode.nodeType, 'Expected nodeType to be "order by"');
        Assert.isNotNull(orderByNode.left, 'Expected left to not be null');
        Assert.isNull(orderByNode.right, 'Expected right to be null');

        Node nameNode2 = orderByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNotNull(nameNode2.right, 'Expected right to not be null');

        Node nullsFirstNode = nameNode2.right;
        Assert.areEqual('nulls first', nullsFirstNode.id, 'Expected id to be "nulls first"');
        Assert.areEqual('nulls direction', nullsFirstNode.nodeType, 'Expected nodeType to be "nulls first"');
        Assert.isNull(nullsFirstNode.left, 'Expected left to be null');
        Assert.isNull(nullsFirstNode.right, 'Expected right to be null');

    }

    @IsTest
    private static void testNullsLast() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Name FROM Account ORDER BY Name NULLS LAST');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node orderByNode = fromNode.right;
        Assert.areEqual('order by', orderByNode.id, 'Expected id to be "order by"');
        Assert.areEqual('order by', orderByNode.nodeType, 'Expected nodeType to be "order by"');
        Assert.isNotNull(orderByNode.left, 'Expected left to not be null');
        Assert.isNull(orderByNode.right, 'Expected right to be null');

        Node nameNode2 = orderByNode.left;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNotNull(nameNode2.right, 'Expected right to not be null');

        Node nullsLastNode = nameNode2.right;
        Assert.areEqual('nulls last', nullsLastNode.id, 'Expected id to be "nulls last"');
        Assert.areEqual('nulls direction', nullsLastNode.nodeType, 'Expected nodeType to be "nulls last"');
        Assert.isNull(nullsLastNode.left, 'Expected left to be null');
        Assert.isNull(nullsLastNode.right, 'Expected right to be null');
    }

    @IsTest
    private static void testOffset() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Name FROM Account OFFSET 10');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node offsetNode = fromNode.right;
        Assert.areEqual('offset', offsetNode.id, 'Expected id to be "offset"');
        Assert.areEqual('offset', offsetNode.nodeType, 'Expected nodeType to be "offset"');
        Assert.isNotNull(offsetNode.left, 'Expected left to be null');
        Assert.isNull(offsetNode.right, 'Expected right to not be null');

        Node valueNode = offsetNode.left;
        Assert.areEqual('10', valueNode.id, 'Expected id to be "10"');
        Assert.areEqual('number', valueNode.nodeType, 'Expected nodeType to be "number"');
        Assert.isNull(valueNode.left, 'Expected left to be null');
        Assert.isNull(valueNode.right, 'Expected right to be null');
        
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testTypeOf() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT TYPEOF What WHEN Account THEN Name WHEN Opportunity THEN Amount ELSE Name END FROM Event');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node typeofNode = head.left;
        Assert.areEqual('what', typeofNode.id, 'Expected id to be "what"');
        Assert.areEqual('typeof', typeofNode.nodeType, 'Expected nodeType to be "typeof"');
        Assert.isNull(typeofNode.left, 'Expected left to be null');
        Assert.isNotNull(typeofNode.right, 'Expected right to not be null');

        Node whenNode = typeofNode.right;
        Assert.areEqual('when', whenNode.id, 'Expected id to be "when"');
        Assert.areEqual('when', whenNode.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(whenNode.left, 'Expected left to not be null');
        Assert.isNotNull(whenNode.right, 'Expected right to not be null');

        Node accountNode = whenNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node nameNode = whenNode.right;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "when"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "when"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNotNull(nameNode.right, 'Expected right to not be null');

        Node whenNode2 = nameNode.right;
        Assert.areEqual('when', whenNode2.id, 'Expected id to be "when"');
        Assert.areEqual('when', whenNode2.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(whenNode2.left, 'Expected left to not be null');
        Assert.isNotNull(whenNode2.right, 'Expected right to not be null');


        Node opportunityNode = whenNode2.left;
        Assert.areEqual('opportunity', opportunityNode.id, 'Expected id to be "opportunity"');
        Assert.areEqual('object', opportunityNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(opportunityNode.left, 'Expected left to be null');
        Assert.isNull(opportunityNode.right, 'Expected right to be null');

        Node amountNode = whenNode2.right;
        Assert.areEqual('amount', amountNode.id, 'Expected id to be "amount"');
        Assert.areEqual('field', amountNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(amountNode.left, 'Expected left to be null');
        Assert.isNotNull(amountNode.right, 'Expected right to not be null');

        Node elseNode = amountNode.right;
        Assert.areEqual('else', elseNode.id, 'Expected id to be "else"');
        Assert.areEqual('else', elseNode.nodeType, 'Expected nodeType to be "else"');
        Assert.isNull(elseNode.left, 'Expected left to not be null');
        Assert.isNotNull(elseNode.right, 'Expected right to be null');

        Node nameNode2 = elseNode.right;
        Assert.areEqual('name', nameNode2.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode2.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode2.left, 'Expected left to be null');
        Assert.isNull(nameNode2.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node eventNode = fromNode.left;
        Assert.areEqual('event', eventNode.id, 'Expected id to be "event"');
        Assert.areEqual('object', eventNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(eventNode.left, 'Expected left to be null');
        Assert.isNull(eventNode.right, 'Expected right to be null');
    }

    @IsTest
    @SuppressWarnings('PMD.NcssMethodCount')
    private static void testTypeOfMultipleFields() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT TYPEOF What WHEN Account THEN Name, Phone WHEN Opportunity THEN Amount ELSE Name END FROM Event');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node typeofNode = head.left;
        Assert.areEqual('what', typeofNode.id, 'Expected id to be "typeof"');
        Assert.areEqual('typeof', typeofNode.nodeType, 'Expected nodeType to be "typeof"');
        Assert.isNull(typeofNode.left, 'Expected left to be null');
        Assert.isNotNull(typeofNode.right, 'Expected right to not be null');

        Node whenNode = typeofNode.right;
        Assert.areEqual('when', whenNode.id, 'Expected id to be "when"');
        Assert.areEqual('when', whenNode.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(whenNode.left, 'Expected left to not be null');
        Assert.isNotNull(whenNode.right, 'Expected right to not be null');

        Node accountNode = whenNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node nameNode = whenNode.right;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "when"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(nameNode.left, 'Expected left to not be null');
        Assert.isNotNull(nameNode.right, 'Expected right to not be null');

        Node phoneNode = nameNode.left;
        Assert.areEqual('phone', phoneNode.id, 'Expected id to be "phone"');
        Assert.areEqual('field', phoneNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(phoneNode.left, 'Expected left to be null');
        Assert.isNull(phoneNode.right, 'Expected right to be null');

        Node whenNode2 = nameNode.right;
        Assert.areEqual('when', whenNode2.id, 'Expected id to be "when"');
        Assert.areEqual('when', whenNode2.nodeType, 'Expected nodeType to be "when"');
        Assert.isNotNull(whenNode2.left, 'Expected left to not be null');
        Assert.isNotNull(whenNode2.right, 'Expected right to not be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNull(fromNode.right, 'Expected right to be null');

        Node eventNode = fromNode.left;
        Assert.areEqual('event', eventNode.id, 'Expected id to be "event"');
        Assert.areEqual('object', eventNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(eventNode.left, 'Expected left to be null');
        Assert.isNull(eventNode.right, 'Expected right to be null');

    }

    @IsTest
    private static void testScope() {
        Test.startTest();
        Parser t = new Parser();
        Node head = t.parse('SELECT Id, Name FROM Account USING SCOPE everything');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node idNode = head.left;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(idNode.left, 'Expected left to not be null');
        Assert.isNull(idNode.right, 'Expected right to be null');

        Node nameNode = idNode.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(nameNode.left, 'Expected left to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node usingNode = fromNode.right;
        Assert.areEqual('using scope', usingNode.id, 'Expected id to be "using"');
        Assert.areEqual('using scope', usingNode.nodeType, 'Expected nodeType to be "using"');
        Assert.isNotNull(usingNode.left, 'Expected left to not be null');
        Assert.isNull(usingNode.right, 'Expected right to be null');

        Node scopeNode = usingNode.left;
        Assert.areEqual('everything', scopeNode.id, 'Expected id to be "everything"');
        Assert.areEqual('scope', scopeNode.nodeType, 'Expected nodeType to be "scope"');
        Assert.isNull(scopeNode.left, 'Expected left to be null');
        Assert.isNull(scopeNode.right, 'Expected right to be null');

    }

    @IsTest
    static void testGroupByRollup() {
        String exMessage;
        Test.startTest();
        Parser t = new Parser();
        try {
            t.parse('SELECT Name, COUNT(Id) FROM Account GROUP BY ROLLUP(Name)');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'GROUP BY ROLLUP is not supported by the mock SOQL parser',
            exMessage, 
            'Expected GROUP BY ROLLUP to not be supported'
        );
    }

    @IsTest
    static void testGroupByCube() {
        Parser t = new Parser();
        String exMessage;
        Test.startTest();
        try {
            t.parse('SELECT Name, COUNT(Id) FROM Account GROUP BY CUBE(Name, CreatedDate, LastModifiedDate)');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'GROUP BY CUBE is not supported by the mock SOQL parser',
            exMessage, 
            'Expected GROUP BY CUBE to not be supported'
        );

    }

    @IsTest
    static void testForView() {
        Parser t = new Parser();
        Test.startTest();
        Node head = t.parse('SELECT Name, COUNT(Id) FROM Account FOR VIEW');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left not to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node countNode = nameNode.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to not be null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node forViewNode = fromNode.right;
        Assert.areEqual('for view', forViewNode.id, 'Expected id to be "for view"');
        Assert.areEqual('for view', forViewNode.nodeType, 'Expected nodeType to be "for view"');
        Assert.isNull(forViewNode.left, 'Expected left to be null');
        Assert.isNull(forViewNode.right, 'Expected right to be null');

    }

    @IsTest
    static void testForReference() {
        Parser t = new Parser();
        Test.startTest();
        Node head = t.parse('SELECT Name, COUNT(Id) FROM Account FOR REFERENCE');
        Test.stopTest();

        Assert.areEqual('select', head.id, 'Expected id to be "select"');
        Assert.areEqual('select', head.nodeType, 'Expected nodeType to be "select"');
        Assert.isNotNull(head.left, 'Expected left to not be null');
        Assert.isNotNull(head.right, 'Expected right to not be null');

        Node nameNode = head.left;
        Assert.areEqual('name', nameNode.id, 'Expected id to be "name"');
        Assert.areEqual('field', nameNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNotNull(nameNode.left, 'Expected left not to be null');
        Assert.isNull(nameNode.right, 'Expected right to be null');

        Node countNode = nameNode.left;
        Assert.areEqual('count', countNode.id, 'Expected id to be "count"');
        Assert.areEqual('aggregate function', countNode.nodeType, 'Expected nodeType to be "aggregate function"');
        Assert.isNull(countNode.left, 'Expected left to be null');
        Assert.isNotNull(countNode.right, 'Expected right to not be null');

        Node idNode = countNode.right;
        Assert.areEqual('id', idNode.id, 'Expected id to be "id"');
        Assert.areEqual('field', idNode.nodeType, 'Expected nodeType to be "field"');
        Assert.isNull(idNode.left, 'Expected left to be null');

        Node fromNode = head.right;
        Assert.areEqual('from', fromNode.id, 'Expected id to be "from"');
        Assert.areEqual('from', fromNode.nodeType, 'Expected nodeType to be "from"');
        Assert.isNotNull(fromNode.left, 'Expected left to not be null');
        Assert.isNotNull(fromNode.right, 'Expected right to not be null');

        Node accountNode = fromNode.left;
        Assert.areEqual('account', accountNode.id, 'Expected id to be "account"');
        Assert.areEqual('object', accountNode.nodeType, 'Expected nodeType to be "object"');
        Assert.isNull(accountNode.left, 'Expected left to be null');
        Assert.isNull(accountNode.right, 'Expected right to be null');

        Node forViewNode = fromNode.right;
        Assert.areEqual('for reference', forViewNode.id, 'Expected id to be "for reference"');
        Assert.areEqual('for reference', forViewNode.nodeType, 'Expected nodeType to be "for reference"');
        Assert.isNull(forViewNode.left, 'Expected left to be null');
        Assert.isNull(forViewNode.right, 'Expected right to be null');
    }

    @IsTest
    static void testUpdateTrackingExpectError() {
        Parser t = new Parser();
        String exMessage;
        Test.startTest();
        try {
            t.parse('SELECT Name, COUNT(Id) FROM Account UPDATE TRACKING');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'UPDATE TRACKING is not supported by the mock SOQL parser',
            exMessage, 
            'Expected UPDATE TRACKING to not be supported'
        );
    }

    @IsTest
    static void testUpdateViewStatExpectError() {
        Parser t = new Parser();
        String exMessage;
        Test.startTest();
        try {
            t.parse('SELECT Name, COUNT(Id) FROM Account UPDATE VIEWSTAT');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'UPDATE VIEWSTAT is not supported by the mock SOQL parser',
            exMessage, 
            'Expected UPDATE VIEWSTAT to not be supported'
        );
    }

    @IsTest
    static void testWithDataCategoryExpectError() {
        Parser t = new Parser();
        String exMessage;
        Test.startTest();
        try {
            t.parse('SELECT Title FROM KnowledgeArticleVersion WHERE PublishStatus=\'online\' WITH DATA CATEGORY Geography__c ABOVE usa__c');
        } catch(QueryException ex) {
            exMessage = ex.getMessage();
        } catch(Exception ex) {
            exMessage = ex.getMessage();
        }
        Test.stopTest();

        Assert.areEqual(
            'WITH [DATA CATEGORY] is not supported by the mock SOQL parser',
            exMessage, 
            'Expected WITH DATA CATEGORY to not be supported'
        );
    }

    // Syntax Tests
    @IsTest
    static void testSpacing1() {
        ParserTestUtil.assertExceptionIsThrown('SELECTNameFROMAccount');
    }

    @IsTest
    static void testSpacing2() {
        ParserTestUtil.assertExceptionIsThrown('SELECTName FROM Account');
    }

    @IsTest
    static void testSpacing3() {
        ParserTestUtil.assertExceptionIsThrown('SELECT NameFROM Account');
    }

    @IsTest
    static void testSpacing4() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROMAccount');
    }

    @IsTest
    static void testSpacing5() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHEREName = \'test\'');
    }

    @IsTest
    static void testSpacing6() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name= \'test\'');
    }

    @IsTest
    static void testSpacing7() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name =\'test\'');
    }

    @IsTest
    static void testSpacing8() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\'AND Id = \'test\'');
    }

    @IsTest
    static void testSpacing9() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' ANDId = \'test\'');
    }

    @IsTest
    static void testSpacing10() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id= \'test\'');
    }

    @IsTest
    static void testSpacing11() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id =\'test\'');
    }

    @IsTest
    static void testSpacing12() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\'GROUP BY Name');
    }

    @IsTest
    static void testSpacing13() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUPBY Name');
    }

    @IsTest
    static void testSpacing14() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BYName');
    }

    @IsTest
    static void testSpacing15() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name');
    }

    @IsTest
    static void testSpacing16() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY NameORDER BY Name');
    }

    @IsTest
    static void testSpacing17() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDERBY Name');
    }

    @IsTest
    static void testSpacing18() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BYName');
    }

    @IsTest
    static void testSpacing19() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing20() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY NameLIMIT 10');
    }

    @IsTest
    static void testSpacing21() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT10');
    }

    @IsTest
    static void testSpacing22() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10');
    }

    @IsTest
    static void testSpacing23() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10OFFSET 5');
    }

    @IsTest
    static void testSpacing24() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET5');
    }

    @IsTest
    static void testSpacing25() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5');
    }

    @IsTest
    static void testSpacing26() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5FOR VIEW');
    }

    @IsTest
    static void testSpacing27() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FORVIEW');
    }

    @IsTest
    static void testSpacing28() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FOR VIEW');
    }

    @IsTest
    static void testSpacing29() {
        ParserTestUtil.assertExceptionIsThrown('SELECTName FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FOR VIEW');
    }

    @IsTest
    static void testSpacing30() {
        ParserTestUtil.assertExceptionIsThrown('SELECT NameFROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FOR VIEW');
    }

    @IsTest
    static void testSpacing31() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROMAccount WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FOR VIEW');
    }

    @IsTest
    static void testSpacing32() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND(Name = \'test\' OR Id !=null)GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing33() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing34() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing35() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing36() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing37() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing38() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing39() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing40() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing41() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name');
    }

    @IsTest
    static void testSpacing42() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\'');
    }

    @IsTest
    static void testSpacing43() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account GROUP BY NameHAVING Name = \'test\'');
    }

    @IsTest
    static void testSpacing44() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account GROUP BY Name HAVINGName = \'test\'');
    }

    @IsTest
    static void testSpacing45() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account GROUP BY Name HAVING Name= \'test\'');
    }

    @IsTest
    static void testSpacing46() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account GROUP BY Name HAVING Name =\'test\'');
    }

    @IsTest
    static void testSpacing47() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\'AND Id = \'test\'');
    }

    @IsTest
    static void testSpacing48() {
        ParserTestUtil.assertExceptionIsThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' ANDId = \'test\'');
    }

    @IsTest
    static void testSpacing49() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id= \'test\'');
    }

    @IsTest
    static void testSpacing50() {
        ParserTestUtil.assertExceptionIsNotThrown('SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id =\'test\'');
    }
}