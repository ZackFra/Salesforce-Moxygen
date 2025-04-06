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
@SuppressWarnings(
    'PMD.NcssTypeCount, PMD.CyclomaticComplexity, PMD.CognitiveComplexity, PMD.ApexUnitTestClassShouldHaveAsserts'
)
private class ParserTest {
    @IsTest
    static void canParseTodayLiteralInDate() {
        Parser p = new Parser();
        Node head = p.parse('SELECT Id FROM Account WHERE CreatedDate = TODAY');
        Node todayNode = head.right.right.left.right;
        Assert.areEqual(
            todayNode.nodeType,
            NodeType.DATE_LITERAL,
            'Should be a date literal'
        );
        Assert.areEqual(
            todayNode.id,
            Token.TODAY_LITERAL,
            'Should be a today literal'
        );
        Assert.isNull(todayNode.left, 'Should not have a left node');
        Assert.isNull(todayNode.right, 'Should not have a right node');
    }

    @IsTest
    static void canParseYesterdayLiteralInDate() {
        Parser p = new Parser();
        Node head = p.parse(
            'SELECT Id FROM Account WHERE CreatedDate = YESTERDAY'
        );
        Node yesterdayNode = head.right.right.left.right;
        Assert.areEqual(
            NodeType.DATE_LITERAL,
            yesterdayNode.nodeType,
            'Should be a date literal'
        );
        Assert.areEqual(
            yesterdayNode.id,
            Token.YESTERDAY_LITERAL,
            'Should be a today literal'
        );
        Assert.isNull(yesterdayNode.left, 'Should not have a left node');
        Assert.isNull(yesterdayNode.right, 'Should not have a right node');
    }

    @IsTest
    static void canParseTomorrowLiteralInDate() {
        Parser p = new Parser();
        Node head = p.parse(
            'SELECT Id FROM Account WHERE CreatedDate = TOMORROW'
        );
        Node tomorrowNode = head.right.right.left.right;
        Assert.areEqual(
            NodeType.DATE_LITERAL,
            tomorrowNode.nodeType,
            'Should be a date literal'
        );
        Assert.areEqual(
            Token.TOMORROW_LITERAL,
            tomorrowNode.id,
            'Should be a today literal'
        );
        Assert.isNull(tomorrowNode.left, 'Should not have a left node');
        Assert.isNull(tomorrowNode.right, 'Should not have a right node');
    }

    @IsTest
    static void testUpdateTrackingExpectError() {
        ParserTestUtil.assertExceptionIsThrownWithMessage(
            'SELECT Name FROM Account UPDATE TRACKING',
            'UPDATE TRACKING is not supported by the mock SOQL parser'
        );
    }

    @IsTest
    static void testUpdateViewStatExpectError() {
        ParserTestUtil.assertExceptionIsThrownWithMessage(
            'SELECT Name FROM Account UPDATE VIEWSTAT',
            'UPDATE VIEWSTAT is not supported by the mock SOQL parser'
        );
    }

    @IsTest
    static void testWithDataCategoryExpectError() {
        ParserTestUtil.assertExceptionIsThrownWithMessage(
            'SELECT Title FROM KnowledgeArticleVersion WHERE PublishStatus=\'online\' WITH DATA CATEGORY Geography__c ABOVE usa__c',
            'WITH [DATA CATEGORY] is not supported by the mock SOQL parser'
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
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHEREName = \'test\''
        );
    }

    @IsTest
    static void testSpacing6() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name= \'test\''
        );
    }

    @IsTest
    static void testSpacing7() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name =\'test\''
        );
    }

    @IsTest
    static void testSpacing8() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\'AND Id = \'test\''
        );
    }

    @IsTest
    static void testSpacing9() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' ANDId = \'test\''
        );
    }

    @IsTest
    static void testSpacing10() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id= \'test\''
        );
    }

    @IsTest
    static void testSpacing11() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id =\'test\''
        );
    }

    @IsTest
    static void testSpacing12() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\'GROUP BY Name'
        );
    }

    @IsTest
    static void testSpacing13() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUPBY Name'
        );
    }

    @IsTest
    static void testSpacing14() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BYName'
        );
    }

    @IsTest
    static void testSpacing15() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name'
        );
    }

    @IsTest
    static void testSpacing16() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY NameORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing17() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDERBY Name'
        );
    }

    @IsTest
    static void testSpacing18() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BYName'
        );
    }

    @IsTest
    static void testSpacing19() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing20() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY NameLIMIT 10'
        );
    }

    @IsTest
    static void testSpacing21() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT10'
        );
    }

    @IsTest
    static void testSpacing22() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10'
        );
    }

    @IsTest
    static void testSpacing23() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10OFFSET 5'
        );
    }

    @IsTest
    static void testSpacing24() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET5'
        );
    }

    @IsTest
    static void testSpacing25() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5'
        );
    }

    @IsTest
    static void testSpacing26() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5FOR VIEW'
        );
    }

    @IsTest
    static void testSpacing27() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FORVIEW'
        );
    }

    @IsTest
    static void testSpacing28() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FOR VIEW'
        );
    }

    @IsTest
    static void testSpacing29() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECTName FROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FOR VIEW'
        );
    }

    @IsTest
    static void testSpacing30() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT NameFROM Account WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FOR VIEW'
        );
    }

    @IsTest
    static void testSpacing31() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROMAccount WHERE Name = \'test\' AND Id = \'test\' GROUP BY Name ORDER BY Name LIMIT 10 OFFSET 5 FOR VIEW'
        );
    }

    @IsTest
    static void testSpacing32() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND(Name = \'test\' OR Id !=null)GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing33() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing34() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing35() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing36() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing37() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing38() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing39() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing40() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing41() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account WHERE Name = \'test\' AND (Name = \'test\' OR Id != null) GROUP BY Name ORDER BY Name'
        );
    }

    @IsTest
    static void testSpacing42() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\''
        );
    }

    @IsTest
    static void testSpacing43() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account GROUP BY NameHAVING Name = \'test\''
        );
    }

    @IsTest
    static void testSpacing44() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account GROUP BY Name HAVINGName = \'test\''
        );
    }

    @IsTest
    static void testSpacing45() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account GROUP BY Name HAVING Name= \'test\''
        );
    }

    @IsTest
    static void testSpacing46() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account GROUP BY Name HAVING Name =\'test\''
        );
    }

    @IsTest
    static void testSpacing47() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\'AND Id = \'test\''
        );
    }

    @IsTest
    static void testSpacing48() {
        ParserTestUtil.assertExceptionIsThrown(
            'SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' ANDId = \'test\''
        );
    }

    @IsTest
    static void testSpacing49() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id= \'test\''
        );
    }

    @IsTest
    static void testSpacing50() {
        ParserTestUtil.assertExceptionIsNotThrown(
            'SELECT Name FROM Account GROUP BY Name HAVING Name = \'test\' AND Id =\'test\''
        );
    }

    @IsTest
    static void ensureParserCanParseSoqlDateTimeLiteral() {
        Parser p = new Parser();
        DateTime now = GMT.now();
        String nowAsSoqlString = Common.dateTimeToSoqlString(now);

        String soqlQuery =
            'SELECT Id FROM Opportunity WHERE CreatedDate = ' + nowAsSoqlString;

        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    now +
                    ' and ' +
                    nowAsSoqlString +
                    ' and ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @IsTest
    static void ensureParserCanParseDateLiteralToken() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_WEEK';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureParserCanParseLastNWeeks() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_N_WEEKS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureParserCanParseThisQuarter() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = THIS_QUARTER';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureParserCanParseLastQuarter() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_QUARTER';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensuresParserCanParseNextQuarter() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = NEXT_QUARTER';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureParserCanParseNextNQuarters() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = NEXT_N_QUARTERS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureParserCanParseThisYear() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = THIS_YEAR';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureParserCanParseThisFiscalYear() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = THIS_FISCAL_YEAR';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureParserCanParseLastNFiscalYears() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_N_FISCAL_YEARS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNextFiscalYearCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = NEXT_FISCAL_YEAR';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureLastFiscalYearCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_FISCAL_YEAR';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNextNFiscalYearsCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = NEXT_N_FISCAL_YEARS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNFiscalYearsAgoCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = N_FISCAL_YEARS_AGO:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNYearsAgoCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = N_YEARS_AGO:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureLastNFiscalQuartersCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_N_FISCAL_QUARTERS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNextFiscalQuarterCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = NEXT_FISCAL_QUARTER';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNextNFiscalQuartersCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = NEXT_N_FISCAL_QUARTERS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureLastFiscalQuarterCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_FISCAL_QUARTER';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureThisFiscalQuarterCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = THIS_FISCAL_QUARTER';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureLastNYearsCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_N_YEARS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureLastYearCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_YEAR';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNextNYearsCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = NEXT_N_YEARS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureLastNQuartersCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_N_QUARTERS:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNQuartersAgoCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = N_QUARTERS_AGO:5';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNWeeksAgoCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = N_WEEKS_AGO:3';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureNextNMonthsCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = NEXT_N_MONTHS:6';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @isTest
    static void ensureLastNMonthsCanBeParsed() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate = LAST_N_MONTHS:6';
        Test.startTest();
        try {
            p.parse(soqlQuery);
        } catch (Exception e) {
            Assert.fail(
                'Expected no exception but got ' +
                    e.getMessage() +
                    ' for ' +
                    soqlQuery
            );
        }
        Test.stopTest();
    }

    @IsTest
    static void ensureInOperatorWorksWithDateLiterals() {
        Parser p = new Parser();
        String soqlQuery = 'SELECT Id FROM Opportunity WHERE CreatedDate IN (TODAY, TOMORROW, YESTERDAY)';
        Test.startTest();
        Node head = p.parse(soqlQuery);
        Test.stopTest();

        Node whereNode = head.right.right;
        Assert.areEqual(
            whereNode.nodeType,
            NodeType.XWHERE,
            'Should be a where clause'
        );
        Node inNode = whereNode.left;
        Assert.areEqual('in', inNode.id, 'Should be an in operator');
        Node valueListNode = inNode.right;
        Assert.areEqual(
            valueListNode.nodeType,
            NodeType.VALUE_LIST,
            'Should be a value list'
        );
        Node todayNode = valueListNode.left;
        Assert.areEqual(
            todayNode.nodeType,
            NodeType.DATE_LITERAL,
            'Should be a date literal'
        );
        Node tomorrowNode = todayNode.left.left;
        Assert.areEqual(
            tomorrowNode.nodeType,
            NodeType.DATE_LITERAL,
            'Should be a date literal'
        );
        Node yesterdayNode = tomorrowNode.left.left;
        Assert.areEqual(
            yesterdayNode.nodeType,
            NodeType.DATE_LITERAL,
            'Should be a date literal'
        );

        Assert.areEqual(
            todayNode.nodeType,
            NodeType.DATE_LITERAL,
            'Should be a date literal'
        );
        Assert.areEqual(
            tomorrowNode.nodeType,
            NodeType.DATE_LITERAL,
            'Should be a date literal'
        );
        Assert.areEqual(
            yesterdayNode.nodeType,
            NodeType.DATE_LITERAL,
            'Should be a date literal'
        );

        Assert.areEqual(
            todayNode.id,
            Token.TODAY_LITERAL,
            'Should be a today literal'
        );
        Assert.areEqual(
            tomorrowNode.id,
            Token.TOMORROW_LITERAL,
            'Should be a tomorrow literal'
        );
        Assert.areEqual(
            yesterdayNode.id,
            Token.YESTERDAY_LITERAL,
            'Should be a yesterday literal'
        );
    }
}
