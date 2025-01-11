# Reference Guide

## Exceptions

### [NotFoundException](exceptions/NotFoundException.md)

Generic exception for when something is not found

### [ValidationException](exceptions/ValidationException.md)

This class is responsible for handling validation exceptions

## interfaces

### [IBuilder](interfaces/IBuilder.md)

Interface for a builder class

## Miscellaneous

### [Aggregate](miscellaneous/Aggregate.md)

Aggregate class to represent the result of an aggregate query

### [AggregateBuilder](miscellaneous/AggregateBuilder.md)

Creates Aggregate objects from ProtoAggregates

### [ProtoAggregate](miscellaneous/ProtoAggregate.md)

before we create an aggregate, wean a proto-aggregate, 
i.e. a Map&lt;String, Object&gt; that will be used to store the aggregate

### [Common](miscellaneous/Common.md)

Common utility class for basic operations, should not contain complex code

### [ApexTypes](miscellaneous/ApexTypes.md)

A class that contains the names of the Apex types.

### [DynamicCast](miscellaneous/DynamicCast.md)

DynamicCast is a class that provides a method to cast a value to a specified type.

### [DynamicCastTest](miscellaneous/DynamicCastTest.md)

### [TypeOf](miscellaneous/TypeOf.md)

TypeOf is a class that provides a method to determine the type of an object.

### [ExceptionFactory](miscellaneous/ExceptionFactory.md)

Factory class for creating exceptions

### [fflib_IDGenerator](miscellaneous/fflib_IDGenerator.md)

Copyright (c) 2014, FinancialForce.com, inc 
All rights reserved. 
 
Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met: 
 
- Redistributions of source code must retain the above copyright notice, 
this list of conditions and the following disclaimer. 
- Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation 
and/or other materials provided with the distribution. 
- Neither the name of the FinancialForce.com, inc nor the names of its contributors 
may be used to endorse or promote products derived from this software without 
specific prior written permission. 
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS &quot;AS IS&quot; AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS 
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY 
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

### [GMT](miscellaneous/GMT.md)

Salesforce is insanely inconsistent about dates and date times, this class returns values in GMT

### [IdAndReferenceFieldComparator](miscellaneous/IdAndReferenceFieldComparator.md)

This class is used to compare two fields to determine if one is a reference to the other

### [IdFieldComparator](miscellaneous/IdFieldComparator.md)

Id Field Comparator

### [IdFieldComparatorFactory](miscellaneous/IdFieldComparatorFactory.md)

Returns a comparator for the given field types, compares ID fields (i.e. ID, Reference)

### [ReferenceFieldComparator](miscellaneous/ReferenceFieldComparator.md)

Comparator for two reference fields, checks if they reference the same object

### [AggregateCalculatorFactory](miscellaneous/AggregateCalculatorFactory.md)

Generates an instance of an aggregate calculator based on the type provided

### [AggregateCalculatorOptions](miscellaneous/AggregateCalculatorOptions.md)

Options for the AggregateCalculator class

### [AverageCalculator](miscellaneous/AverageCalculator.md)

Calculates the average of a set of values.

### [CalendarMonthCalculator](miscellaneous/CalendarMonthCalculator.md)

Calculates the calendar month from a date value

### [CalendarQuarterCalculator](miscellaneous/CalendarQuarterCalculator.md)

Calculates the calendar month from a date value

### [CalendarYearCalculator](miscellaneous/CalendarYearCalculator.md)

Calculates the calendar month from a date value

### [CountCalculator](miscellaneous/CountCalculator.md)

CountCalculator is a concrete implementation of IAggregateCalculator that calculates the count of records.

### [CountDistinctCalculator](miscellaneous/CountDistinctCalculator.md)

CountDistinctCalculator is a class that implements the IAggregateCalculator interface. It calculates the distinct count of a field.

### [IAggregateCalculator](miscellaneous/IAggregateCalculator.md)

Interface for aggregate calculator

### [MaxCalculator](miscellaneous/MaxCalculator.md)

calculates the MAX value of a field for an aggregate result

### [MinCalculator](miscellaneous/MinCalculator.md)

Calculates the minimum value of a field

### [SumCalculator](miscellaneous/SumCalculator.md)

Calculates the sum of a field

### [AggregateProcessor](miscellaneous/AggregateProcessor.md)

Processor for aggregate functions

### [AggregateQueryHandler](miscellaneous/AggregateQueryHandler.md)

This class is responsible for handling the aggregate queries

### [AggregateStandardProcessor](miscellaneous/AggregateStandardProcessor.md)

Standard processor for aggregate queries

### [AggregateService](miscellaneous/AggregateService.md)

Contains static methods for working with aggregates and proto-aggregates

### [AliasService](miscellaneous/AliasService.md)

Tool for finding the aliases on nodes

### [BooleanLogicHandler](miscellaneous/BooleanLogicHandler.md)

A class to handle boolean logic, when it comes to HAVING and WHERE clauses, it&#x27;s all the same except for the comparison

### [BooleanLogicOptions](miscellaneous/BooleanLogicOptions.md)

This class is used to store the options for the BooleanLogic class

### [HavingLogicHandler](miscellaneous/HavingLogicHandler.md)

This class is used to handle the having clause logic

### [WhereLogicHandler](miscellaneous/WhereLogicHandler.md)

This class is responsible for handling the WHERE clause logic

### [DateLiteral](miscellaneous/DateLiteral.md)

Represents the value and new record field value for a date literal

### [IWhereLogicComparisonStrategy](miscellaneous/IWhereLogicComparisonStrategy.md)

Strategy inreferace for WHERE logic comparison

### [WhereLogicComparisonResults](miscellaneous/WhereLogicComparisonResults.md)

Contains the results of a where logic comparison

### [WhereLogicDateFuncStrategy](miscellaneous/WhereLogicDateFuncStrategy.md)

This class is responsible for handling date functions in the WHERE clause

### [WhereLogicParentFieldStrategy](miscellaneous/WhereLogicParentFieldStrategy.md)

Strategy for getting the field value of a parent field

### [WhereLogicRecordFieldStrategy](miscellaneous/WhereLogicRecordFieldStrategy.md)

This class is responsible for handling record fields in the WHERE clause

### [ComparableRecordData](miscellaneous/ComparableRecordData.md)

Encapsulates the data needed to compare records

### [ComparableService](miscellaneous/ComparableService.md)

This class provides the ability to compare fields on SObjects with the mock database

### [ParentLookupChain](miscellaneous/ParentLookupChain.md)

Represents a chain of fields to look up on a parent object

### [ParentLookupResolver](miscellaneous/ParentLookupResolver.md)

A class to resolve a parent lookup chain

### [QueriedFieldResolver](miscellaneous/QueriedFieldResolver.md)

This class is used to resolve the field in a query

### [AggregateComparator](miscellaneous/AggregateComparator.md)

A class to compare two pre-Aggregate based on a set of fields 
(a pre-Aggregate is a ProtoAggregate where the keys are the field names and the values are the field values)

### [ObjectComparator](miscellaneous/ObjectComparator.md)

This class is used to compare two generic objects of the same type.

### [SObjectComparator](miscellaneous/SObjectComparator.md)

This class is used to compare two SObjects based on the fields provided in the constructor.

### [MockDatabase](miscellaneous/MockDatabase.md)

The MockDatabase class is used to simulate the Salesforce database in Apex unit tests

### [MockDatabaseUtils](miscellaneous/MockDatabaseUtils.md)

: utilities for a MockDatabase, contains methods that DO NOT mutate the database 
: a method in here must be dependent on the database, but not necessary to understand 
: the database

### [ParentRecordData](miscellaneous/ParentRecordData.md)

A class to store data about a parent record

### [QueryValidator](miscellaneous/QueryValidator.md)

Validate the AST of a query, this does not validate the query against the schema, 
but rather checks for invalid queries that are not supported by the SOQL parser

### [MockDatabaseDMLHandler](miscellaneous/MockDatabaseDMLHandler.md)

MockDatabaseDMLHandler is used to handle DML operations on the mock database

### [MockDatabaseSOQLHandler](miscellaneous/MockDatabaseSOQLHandler.md)

This class is response for handling SOQL queries to the mock database

### [MockDMLHandler](miscellaneous/MockDMLHandler.md)

MockDMLHandler is an abstract class that provides a base class for mocking DML operations.

### [MockDeleteHandler](miscellaneous/MockDeleteHandler.md)

MockDeleteHandler is a class that extends MockDMLHandler and overrides the delete methods to simulate the delete operation

### [MockInsertHandler](miscellaneous/MockInsertHandler.md)

MockInsertHandler is used to mock the insert operation

### [MockUndeleteHandler](miscellaneous/MockUndeleteHandler.md)

MockUndeleteHandler is used to mock the Database.UndeleteResult class and the Database.undelete method

### [MockUpdateHandler](miscellaneous/MockUpdateHandler.md)

MockUpdateHandler is used to mock the update operation in the database

### [MockUpsertHandler](miscellaneous/MockUpsertHandler.md)

MockUpsertHandler is used to mock the upsert operation in the database

### [MockAggregateQueryHandler](miscellaneous/MockAggregateQueryHandler.md)

This class is responsible for handling aggregate SOQL queries to the mock database

### [MockCountQueryHandler](miscellaneous/MockCountQueryHandler.md)

This class is responsible for handling count SOQL queries to the mock database

### [MockRecordQueryHandler](miscellaneous/MockRecordQueryHandler.md)

This class is responsible for handling record SOQL queries to the mock database

### [MockSOQLHandler](miscellaneous/MockSOQLHandler.md)

Base class for handling SOQL queries to the mock database

### [DateFuncs](miscellaneous/DateFuncs.md)

Repository of aggregate date functions

### [AggregateLimitHandler](miscellaneous/AggregateLimitHandler.md)

Handles the limit for the aggregate query

### [CountLimitHandler](miscellaneous/CountLimitHandler.md)

Handles the limit for the count of records

### [ILimitHandler](miscellaneous/ILimitHandler.md)

Interface for limit handler

### [LimitHandlerFactory](miscellaneous/LimitHandlerFactory.md)

Used to create a limit handler based on the query type

### [LimitOptions](miscellaneous/LimitOptions.md)

The options to be passed into an ILimitHandler

### [RecordLimitHandler](miscellaneous/RecordLimitHandler.md)

Limit handler for record limit

### [Node](miscellaneous/Node.md)

: Returns a string representation of the AST

### [NodeBuilder](miscellaneous/NodeBuilder.md)

: Builder class for the Node class, used to create a Node

### [NodeService](miscellaneous/NodeService.md)

Service class for manipulating and describing the nodes of the AST created by the parser 
each method is a static method that takes in a TopLevelNodes

### [TopLevelNodes](miscellaneous/TopLevelNodes.md)

This class is used to parse the top level nodes of a SOQL query. 
Designed to refresh the instance if the head node changes, i.e. if a new SOQL query is made.

### [AggregateOffsetHandler](miscellaneous/AggregateOffsetHandler.md)

Handler for offsetting aggregate results

### [CountOffsetHandler](miscellaneous/CountOffsetHandler.md)

OffsetHandler for Count

### [IOffsetHandler](miscellaneous/IOffsetHandler.md)

Interface for offset handler

### [OffsetHandlerFactory](miscellaneous/OffsetHandlerFactory.md)

This class is responsible for creating the appropriate offset handler based on the query type.

### [OffsetOptions](miscellaneous/OffsetOptions.md)

Options class for the Offset class

### [RecordOffsetHandler](miscellaneous/RecordOffsetHandler.md)

Offset handler for records

### [EqualityHandler](miscellaneous/EqualityHandler.md)

Handles the equality operator

### [ExcludesHandler](miscellaneous/ExcludesHandler.md)

Handles the excludes operator

### [GreaterThanHandler](miscellaneous/GreaterThanHandler.md)

Handles the greater than operator

### [GreaterThanOrEqualHandler](miscellaneous/GreaterThanOrEqualHandler.md)

Handles the greater than or equal operator

### [IOperatorHandler](miscellaneous/IOperatorHandler.md)

comparison handlers for WHERE and HAVING clauses

### [InHandler](miscellaneous/InHandler.md)

Handler for IN operator

### [IncludesHandler](miscellaneous/IncludesHandler.md)

Handles the includes operator

### [InequalityHandler](miscellaneous/InequalityHandler.md)

Handles the inequality operator

### [LessThanHandler](miscellaneous/LessThanHandler.md)

Handles the less than operator

### [LessThanOrEqualHandler](miscellaneous/LessThanOrEqualHandler.md)

Handles the LessThanOrEqual operator

### [LikeHandler](miscellaneous/LikeHandler.md)

Handles the LIKE operator

### [NotInHandler](miscellaneous/NotInHandler.md)

Handles the NotIn operator

### [OperatorHandlerFactory](miscellaneous/OperatorHandlerFactory.md)

Provides a factory for creating operator handlers.

### [DateLiteralComparable](miscellaneous/DateLiteralComparable.md)

Abstract class for date literal comparison

### [DateLiteralComparableFactory](miscellaneous/DateLiteralComparableFactory.md)

Factory class for creating DateLiteralComparable instances

### [Last90DaysComparable](miscellaneous/Last90DaysComparable.md)

Comparable class for LAST_90_DAYS

### [LastFiscalYearComparable](miscellaneous/LastFiscalYearComparable.md)

Comparable for the LAST_FISCAL_YEAR date literal

### [LastMonthComparable](miscellaneous/LastMonthComparable.md)

Comparable class for LAST_MONTH

### [LastNDaysComparable](miscellaneous/LastNDaysComparable.md)

Comparable class for LAST_N_DAYS

### [LastNFiscalYearsComparable](miscellaneous/LastNFiscalYearsComparable.md)

Comparable class for LAST_N_FISCAL_YEARS

### [LastNWeeksComparable](miscellaneous/LastNWeeksComparable.md)

Comparable class for LAST_N_WEEKS

### [LastQuarterComparable](miscellaneous/LastQuarterComparable.md)

Compares a date field to the last quarter

### [LastWeekComparable](miscellaneous/LastWeekComparable.md)

Comparable class for LAST_WEEK

### [NDaysAgoComparable](miscellaneous/NDaysAgoComparable.md)

Comparable class for N_DAYS_AGO

### [NMonthsAgoComparable](miscellaneous/NMonthsAgoComparable.md)

Comparable class for N_MONTHS_AGO

### [Next90DaysComparable](miscellaneous/Next90DaysComparable.md)

Comparable class for NEXT_90_DAYS

### [NextFiscalYearComparable](miscellaneous/NextFiscalYearComparable.md)

Comparable for the NEXT_FISCAL_YEAR date literal

### [NextMonthComparable](miscellaneous/NextMonthComparable.md)

Comparable class for NEXT_MONTH

### [NextNDaysComparable](miscellaneous/NextNDaysComparable.md)

Comparable class for NEXT_N_DAYS

### [NextNQuartersComparable](miscellaneous/NextNQuartersComparable.md)

Comparable for the NEXT_N_QUARTERS token

### [NextNWeeksComparable](miscellaneous/NextNWeeksComparable.md)

Comparable class for NEXT_N_WEEKS

### [NextQuarterComparable](miscellaneous/NextQuarterComparable.md)

Compares the NEXT_QUARTER token

### [NextWeekComparable](miscellaneous/NextWeekComparable.md)

Comparable class for NEXT_WEEK

### [ThisFiscalYearComparable](miscellaneous/ThisFiscalYearComparable.md)

Comparable for the THIS_FISCAL_YEAR token

### [ThisMonthComparable](miscellaneous/ThisMonthComparable.md)

Comparable class for THIS_MONTH

### [ThisQuarterComparable](miscellaneous/ThisQuarterComparable.md)

Comparable class for THIS_QUARTER

### [ThisWeekComparable](miscellaneous/ThisWeekComparable.md)

Comparable class for THIS_WEEK

### [ThisYearComparable](miscellaneous/ThisYearComparable.md)

Comparable for THIS_YEAR

### [TodayComparable](miscellaneous/TodayComparable.md)

Comparable class for TODAY

### [TomorrowComparable](miscellaneous/TomorrowComparable.md)

Comparable class for TOMORROW

### [YesterdayComparable](miscellaneous/YesterdayComparable.md)

Comparable class for YESTERDAY

### [AggregateOrderByHandler](miscellaneous/AggregateOrderByHandler.md)

Handles the ORDER BY clause for aggregate queries

### [OrderByHandler](miscellaneous/OrderByHandler.md)

Abstract class for OrderByHandler

### [OrderByHandlerFactory](miscellaneous/OrderByHandlerFactory.md)

Factory class for creating OrderByHandler instances

### [OrderByOptions](miscellaneous/OrderByOptions.md)

Options class for OrderBy

### [RecordOrderByHandler](miscellaneous/RecordOrderByHandler.md)

Order by handler for record data

### [Regex](miscellaneous/Regex.md)

A class to handle regex operations

### [Attributes](miscellaneous/Attributes.md)

Attributes for SObject

### [ChildSubQuerySelectHandler](miscellaneous/ChildSubQuerySelectHandler.md)

Child subquery select handler

### [FieldSelectHandler](miscellaneous/FieldSelectHandler.md)

FieldSelectHandler is a class that implements ISelectHandler. It is used to handle the selection of a field.

### [FieldSelector](miscellaneous/FieldSelector.md)

FieldSelector is a class that is used to select fields from a queried record based on a field node.

### [ISelectHandler](miscellaneous/ISelectHandler.md)

Interface for handling select operations

### [ParentSubQuerySelectHandler](miscellaneous/ParentSubQuerySelectHandler.md)

Handles the selection of a field that is a parent relationship in a subquery

### [PolymorphicAttributes](miscellaneous/PolymorphicAttributes.md)

Attributes for polymorphic SObject

### [PolymorphicSelectHandler](miscellaneous/PolymorphicSelectHandler.md)

Select handler for TYPEOF operator

### [SelectHandlerFactory](miscellaneous/SelectHandlerFactory.md)

Factory class to create appropriate select handler based on the field node type

### [Types](miscellaneous/Types.md)

MIT License 
 
Copyright (c) 2024 Zackary Frazier 
 
Permission is hereby granted, free of charge, to any person obtaining a copy 
of this software and associated documentation files (the &quot;Software&quot;), to deal 
in the Software without restriction, including without limitation the rights 
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions: 
 
The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software. 
 
THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.

### [Parser](miscellaneous/Parser.md)

The parser breaks down a SOQL query into an AST, to be fed into the parser (MockDatabase)

### [AbstractSyntaxTreeWithQuery](miscellaneous/AbstractSyntaxTreeWithQuery.md)

Represents and AST as stored in the parser static resources

### [ParserTestUtil](miscellaneous/ParserTestUtil.md)

### [AggregateFuncParser](miscellaneous/AggregateFuncParser.md)

This class is responsible for parsing aggregate functions

### [AliasParser](miscellaneous/AliasParser.md)

This class is responsible for parsing aliases in the query

### [FieldListParser](miscellaneous/FieldListParser.md)

This class is responsible for parsing a list of fields.

### [FieldParser](miscellaneous/FieldParser.md)

This class is responsible for parsing a field from a query string.

### [ForUpdateParser](miscellaneous/ForUpdateParser.md)

This class is responsible for parsing the FOR UPDATE clause in a SOQL query

### [ForViewOrReferenceParser](miscellaneous/ForViewOrReferenceParser.md)

This class is responsible for parsing the FOR VIEW or FOR REFERENCE clause

### [FromParser](miscellaneous/FromParser.md)

Class is responsible for parsing the &#x27;from&#x27; clause of a query

### [GroupByParser](miscellaneous/GroupByParser.md)

This class is responsible for parsing the GROUP BY clause of a SOQL query

### [HavingParser](miscellaneous/HavingParser.md)

This class is responsible for parsing the HAVING clause of a SOQL query.

### [LimitParser](miscellaneous/LimitParser.md)

This class is responsible for parsing the limit clause of a query

### [OffsetParser](miscellaneous/OffsetParser.md)

This class is responsible for parsing the offset clause of a query

### [OperatorParser](miscellaneous/OperatorParser.md)

This class is responsible for parsing operators in the query string.

### [OrderByParser](miscellaneous/OrderByParser.md)

This class is responsible for parsing the ORDER BY clause of a SOQL query.

### [ParserUtils](miscellaneous/ParserUtils.md)

Contains utility methods for the parser, could probably be refactored out of existance though

### [ParsingException](miscellaneous/ParsingException.md)

Custom exception for parsing errors

### [QueryParser](miscellaneous/QueryParser.md)

This class is responsible for parsing a SOQL query

### [SObjectParser](miscellaneous/SObjectParser.md)

Parses an SObject name in a query

### [ScopeParser](miscellaneous/ScopeParser.md)

This class is responsible for parsing the scope clause of a SOQL query

### [SelectParser](miscellaneous/SelectParser.md)

Parser for the SELECT clause

### [SubParser](miscellaneous/SubParser.md)

SubParser is an abstract class that provides helper methods for parsing subqueries.

### [UpdateTrackingOrViewStatParser](miscellaneous/UpdateTrackingOrViewStatParser.md)

This class is responsible for parsing the UPDATE TRACKING or UPDATE VIEWSTAT query

### [ValueListParser](miscellaneous/ValueListParser.md)

This class is responsible for parsing a list of values.

### [ValueParser](miscellaneous/ValueParser.md)

This class is responsible for parsing values in the query string

### [WhereParser](miscellaneous/WhereParser.md)

This class is responsible for parsing the WHERE clause of a SOQL query.

### [WithDataCategoryParser](miscellaneous/WithDataCategoryParser.md)

This class is used to parse the WITH DATA CATEGORY clause in a SOQL query

### [WithSecurityEnforcedParser](miscellaneous/WithSecurityEnforcedParser.md)

This class is responsible for parsing the WITH SECURITY_ENFORCED clause in a SOQL query.

### [BindVariableParser](miscellaneous/BindVariableParser.md)

A class to parse a bind variable

### [BooleanParser](miscellaneous/BooleanParser.md)

A parser for boolean values

### [DateLiteralParser](miscellaneous/DateLiteralParser.md)

Generic date literal parser

### [DateParser](miscellaneous/DateParser.md)

DateParser is a parser for date values.

### [NullParser](miscellaneous/NullParser.md)

NullParser is a parser for null values.

### [NumberParser](miscellaneous/NumberParser.md)

NumberParser is a parser for numeric values.

### [PrimitiveParserFactory](miscellaneous/PrimitiveParserFactory.md)

Factory class for primitive parsers

### [StringParser](miscellaneous/StringParser.md)

A class to parse a generic string

### [Intermediary](miscellaneous/Intermediary.md)

: Class to hold the head of a parsed query and the remaining subquery

### [NodeType](miscellaneous/NodeType.md)

This class is responsible for handling the NodeType constants

### [Token](miscellaneous/Token.md)

This class is responsible for handling the Token constants

### [SaveResultService](miscellaneous/SaveResultService.md)

This class is used to create success and failure results for DML operations.

### [SchemaService](miscellaneous/SchemaService.md)

this class is intended to handle interactions with the Schema class 
and provide a layer of abstraction for the Schema class, non-mutating 
string arguments to these methods are understood to be case-insensitive 
anything named &quot;getName&quot; are understood to return proper API names 
every argument is understood to be non-null

### [OrganizationSingleton](miscellaneous/OrganizationSingleton.md)

Singleton for the Organization object

## Moxygen

### [DML](moxygen/DML.md)

DML class to handle DML operations, wrapper around Database methods 
to allow for mocking and stubbing in unit tests 
Note: There is no test class, because there is no consistent way to test this in 
a way that would be meaningful. The methods are all wrappers around Database methods

### [ORM](moxygen/ORM.md)

ORM class is responsible for creating and returning the Selector and DML objects 
ORM is short for Object Relationshal Mapping, i.e. Salesforce&#x27;s database

### [RelationshipBuilder](moxygen/RelationshipBuilder.md)

RelationshipBuilder class to build parent and child relationships

### [Selector](moxygen/Selector.md)

Wrapper class for Database class