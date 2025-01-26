# Reference Guide

## Data Store

### [DataStore](data-store/DataStore.md)

Static data store for records

## Date Functions

### [CalendarMonthFunc](date-functions/CalendarMonthFunc.md)

Function to calculate the calendar month of a date or datetime value

### [CalendarQuarterFunc](date-functions/CalendarQuarterFunc.md)

Function to calculate the calendar quarter of a date or datetime value

### [CalendarYearFunc](date-functions/CalendarYearFunc.md)

Function to calculate the calendar year of a date or datetime value

### [DateFuncFactory](date-functions/DateFuncFactory.md)

Factory class to create date functions by name

### [DateFuncs](date-functions/DateFuncs.md)

Repository of aggregate date functions

### [IDateFunc](date-functions/IDateFunc.md)

Interface for date functions

## Exceptions

### [NotFoundException](exceptions/NotFoundException.md)

Generic exception for when something is not found

### [ParsingException](exceptions/ParsingException.md)

Custom exception for parsing errors

### [ValidationException](exceptions/ValidationException.md)

This class is responsible for handling validation exceptions

## fflib

### [fflib_IDGenerator](fflib/fflib_IDGenerator.md)

Generates fake Salesforce Ids for testing purposes

## Mock Database

### [MockDatabase](mock-database/MockDatabase.md)

The MockDatabase class is used to simulate the Salesforce database in Apex unit tests

### [Types](mock-database/Types.md)

Types defined for this package

## Moxygen

### [DML](moxygen/DML.md)

DML class to handle DML operations, wrapper around Database methods 
to allow for mocking and stubbing in unit tests.

### [ORM](moxygen/ORM.md)

ORM class is the state manager for the Moxygen library. 
It is responsble for managing the state of the library&#x27;s settings and context. 
It&#x27;s named ORM because Salesforce is an ORM, and unfortunately, the Database namespace 
is already taken.

### [Selector](moxygen/Selector.md)

Wrapper class for Database class&#x27;s query methods. This class is used to allow for mocking of the Database class in unit tests.

## Uncategorized

### [AbstractSyntaxTreeWithQuery](uncategorized/AbstractSyntaxTreeWithQuery.md)

Represents and AST as stored in the parser static resources

### [Aggregate](uncategorized/Aggregate.md)

Aggregate class to represent the result of an aggregate query

### [AggregateBuilder](uncategorized/AggregateBuilder.md)

Creates Aggregate objects from ProtoAggregates

### [AggregateCalculatorFactory](uncategorized/AggregateCalculatorFactory.md)

Generates an instance of an aggregate calculator based on the type provided

### [AggregateCalculatorOptions](uncategorized/AggregateCalculatorOptions.md)

Options for the AggregateCalculator class

### [AggregateComparator](uncategorized/AggregateComparator.md)

A class to compare two pre-Aggregate based on a set of fields 
(a pre-Aggregate is a ProtoAggregate where the keys are the field names and the values are the field values)

### [AggregateFuncParser](uncategorized/AggregateFuncParser.md)

This class is responsible for parsing aggregate functions

### [AggregateLimitHandler](uncategorized/AggregateLimitHandler.md)

Handles the limit for the aggregate query

### [AggregateOffsetHandler](uncategorized/AggregateOffsetHandler.md)

Handler for offsetting aggregate results

### [AggregateOrderByHandler](uncategorized/AggregateOrderByHandler.md)

Handles the ORDER BY clause for aggregate queries

### [AggregateProcessor](uncategorized/AggregateProcessor.md)

Processor for aggregate functions

### [AggregateQueryHandler](uncategorized/AggregateQueryHandler.md)

This class is responsible for handling the aggregate queries

### [AggregateService](uncategorized/AggregateService.md)

Contains static methods for working with aggregates and proto-aggregates

### [AggregateStandardProcessor](uncategorized/AggregateStandardProcessor.md)

Standard processor for aggregate queries

### [AliasParser](uncategorized/AliasParser.md)

This class is responsible for parsing aliases in the query

### [AliasService](uncategorized/AliasService.md)

Tool for finding the aliases on nodes

### [ApexTypes](uncategorized/ApexTypes.md)

A class that contains the names of the Apex types.

### [Attributes](uncategorized/Attributes.md)

Attributes for SObject

### [AverageCalculator](uncategorized/AverageCalculator.md)

Calculates the average of a set of values.

### [BindVariableParser](uncategorized/BindVariableParser.md)

A class to parse a bind variable

### [BooleanLogicHandler](uncategorized/BooleanLogicHandler.md)

A class to handle boolean logic, when it comes to HAVING and WHERE clauses, it&#x27;s all the same except for the comparison

### [BooleanLogicOptions](uncategorized/BooleanLogicOptions.md)

This class is used to store the options for the BooleanLogic class

### [BooleanParser](uncategorized/BooleanParser.md)

A parser for boolean values

### [CalendarMonthCalculator](uncategorized/CalendarMonthCalculator.md)

Calculates the calendar month from a date value

### [CalendarQuarterCalculator](uncategorized/CalendarQuarterCalculator.md)

Calculates the calendar month from a date value

### [CalendarYearCalculator](uncategorized/CalendarYearCalculator.md)

Calculates the calendar month from a date value

### [ChildSubQuerySelectHandler](uncategorized/ChildSubQuerySelectHandler.md)

Child subquery select handler

### [Common](uncategorized/Common.md)

Common utility class for basic operations, should not contain complex code

### [ComparableRecordData](uncategorized/ComparableRecordData.md)

Encapsulates the data needed to compare records

### [ComparableService](uncategorized/ComparableService.md)

This class provides the ability to compare fields on SObjects with the mock database

### [CountCalculator](uncategorized/CountCalculator.md)

CountCalculator is a concrete implementation of IAggregateCalculator that calculates the count of records.

### [CountDistinctCalculator](uncategorized/CountDistinctCalculator.md)

CountDistinctCalculator is a class that implements the IAggregateCalculator interface. It calculates the distinct count of a field.

### [CountLimitHandler](uncategorized/CountLimitHandler.md)

Handles the limit for the count of records

### [CountOffsetHandler](uncategorized/CountOffsetHandler.md)

OffsetHandler for Count

### [DateLiteral](uncategorized/DateLiteral.md)

Represents the value and new record field value for a date literal

### [DateLiteralComparable](uncategorized/DateLiteralComparable.md)

Abstract class for date literal comparison

### [DateLiteralComparableFactory](uncategorized/DateLiteralComparableFactory.md)

Factory class for creating DateLiteralComparable instances

### [DateLiteralParser](uncategorized/DateLiteralParser.md)

Generic date literal parser

### [DateParser](uncategorized/DateParser.md)

DateParser is a parser for date values.

### [DmlEngine](uncategorized/DmlEngine.md)

MockDatabaseDMLHandler is used to handle DML operations on the mock database

### [DynamicCast](uncategorized/DynamicCast.md)

DynamicCast is a class that provides a method to cast a value to a specified type.

### [DynamicCastTest](uncategorized/DynamicCastTest.md)

### [EqualityHandler](uncategorized/EqualityHandler.md)

Handles the equality operator

### [ExcludesHandler](uncategorized/ExcludesHandler.md)

Handles the excludes operator

### [FieldListParser](uncategorized/FieldListParser.md)

This class is responsible for parsing a list of fields.

### [FieldParser](uncategorized/FieldParser.md)

This class is responsible for parsing a field from a query string.

### [FieldSelectHandler](uncategorized/FieldSelectHandler.md)

FieldSelectHandler is a class that implements ISelectHandler. It is used to handle the selection of a field.

### [FieldSelector](uncategorized/FieldSelector.md)

FieldSelector is a class that is used to select fields from a queried record based on a field node.

### [ForUpdateParser](uncategorized/ForUpdateParser.md)

This class is responsible for parsing the FOR UPDATE clause in a SOQL query

### [ForViewOrReferenceParser](uncategorized/ForViewOrReferenceParser.md)

This class is responsible for parsing the FOR VIEW or FOR REFERENCE clause

### [FromParser](uncategorized/FromParser.md)

Class is responsible for parsing the &#x27;from&#x27; clause of a query

### [GMT](uncategorized/GMT.md)

Salesforce is insanely inconsistent about dates and date times, this class returns values in GMT

### [GreaterThanHandler](uncategorized/GreaterThanHandler.md)

Handles the greater than operator

### [GreaterThanOrEqualHandler](uncategorized/GreaterThanOrEqualHandler.md)

Handles the greater than or equal operator

### [GroupByParser](uncategorized/GroupByParser.md)

This class is responsible for parsing the GROUP BY clause of a SOQL query

### [HavingLogicHandler](uncategorized/HavingLogicHandler.md)

This class is used to handle the having clause logic

### [HavingParser](uncategorized/HavingParser.md)

This class is responsible for parsing the HAVING clause of a SOQL query.

### [IAggregateCalculator](uncategorized/IAggregateCalculator.md)

Interface for aggregate calculator

### [IdAndReferenceFieldComparator](uncategorized/IdAndReferenceFieldComparator.md)

This class is used to compare two fields to determine if one is a reference to the other

### [IdFieldComparator](uncategorized/IdFieldComparator.md)

Id Field Comparator

### [IdFieldComparatorFactory](uncategorized/IdFieldComparatorFactory.md)

Returns a comparator for the given field types, compares ID fields (i.e. ID, Reference)

### [ILimitHandler](uncategorized/ILimitHandler.md)

Interface for limit handler

### [IncludesHandler](uncategorized/IncludesHandler.md)

Handles the includes operator

### [InequalityHandler](uncategorized/InequalityHandler.md)

Handles the inequality operator

### [InHandler](uncategorized/InHandler.md)

Handler for IN operator

### [Intermediary](uncategorized/Intermediary.md)

: Class to hold the head of a parsed query and the remaining subquery

### [IOffsetHandler](uncategorized/IOffsetHandler.md)

Interface for offset handler

### [IOperatorHandler](uncategorized/IOperatorHandler.md)

comparison handlers for WHERE and HAVING clauses

### [ISelectHandler](uncategorized/ISelectHandler.md)

Interface for handling select operations

### [IWhereLogicComparisonStrategy](uncategorized/IWhereLogicComparisonStrategy.md)

Strategy inreferace for WHERE logic comparison

### [Last90DaysComparable](uncategorized/Last90DaysComparable.md)

Comparable class for LAST_90_DAYS

### [LastFiscalYearComparable](uncategorized/LastFiscalYearComparable.md)

Comparable for the LAST_FISCAL_YEAR date literal

### [LastMonthComparable](uncategorized/LastMonthComparable.md)

Comparable class for LAST_MONTH

### [LastNDaysComparable](uncategorized/LastNDaysComparable.md)

Comparable class for LAST_N_DAYS

### [LastNFiscalYearsComparable](uncategorized/LastNFiscalYearsComparable.md)

Comparable class for LAST_N_FISCAL_YEARS

### [LastNWeeksComparable](uncategorized/LastNWeeksComparable.md)

Comparable class for LAST_N_WEEKS

### [LastQuarterComparable](uncategorized/LastQuarterComparable.md)

Compares a date field to the last quarter

### [LastWeekComparable](uncategorized/LastWeekComparable.md)

Comparable class for LAST_WEEK

### [LessThanHandler](uncategorized/LessThanHandler.md)

Handles the less than operator

### [LessThanOrEqualHandler](uncategorized/LessThanOrEqualHandler.md)

Handles the LessThanOrEqual operator

### [LikeHandler](uncategorized/LikeHandler.md)

Handles the LIKE operator

### [LimitHandlerFactory](uncategorized/LimitHandlerFactory.md)

Used to create a limit handler based on the query type

### [LimitOptions](uncategorized/LimitOptions.md)

The options to be passed into an ILimitHandler

### [LimitParser](uncategorized/LimitParser.md)

This class is responsible for parsing the limit clause of a query

### [MaxCalculator](uncategorized/MaxCalculator.md)

calculates the MAX value of a field for an aggregate result

### [MinCalculator](uncategorized/MinCalculator.md)

Calculates the minimum value of a field

### [MockAggregateQueryHandler](uncategorized/MockAggregateQueryHandler.md)

This class is responsible for handling aggregate SOQL queries to the mock database

### [MockCountQueryHandler](uncategorized/MockCountQueryHandler.md)

This class is responsible for handling count SOQL queries to the mock database

### [MockDeleteHandler](uncategorized/MockDeleteHandler.md)

MockDeleteHandler is a class that extends MockDMLHandler and overrides the delete methods to simulate the delete operation

### [MockDMLHandler](uncategorized/MockDMLHandler.md)

MockDMLHandler is an abstract class that provides a base class for mocking DML operations.

### [MockInsertHandler](uncategorized/MockInsertHandler.md)

MockInsertHandler is used to mock the insert operation

### [MockRecordQueryHandler](uncategorized/MockRecordQueryHandler.md)

This class is responsible for handling record SOQL queries to the mock database

### [MockSOQLHandler](uncategorized/MockSOQLHandler.md)

Base class for handling SOQL queries to the mock database

### [MockUndeleteHandler](uncategorized/MockUndeleteHandler.md)

MockUndeleteHandler is used to mock the Database.UndeleteResult class and the Database.undelete method

### [MockUpdateHandler](uncategorized/MockUpdateHandler.md)

MockUpdateHandler is used to mock the update operation in the database

### [MockUpsertHandler](uncategorized/MockUpsertHandler.md)

MockUpsertHandler is used to mock the upsert operation in the database

### [NDaysAgoComparable](uncategorized/NDaysAgoComparable.md)

Comparable class for N_DAYS_AGO

### [Next90DaysComparable](uncategorized/Next90DaysComparable.md)

Comparable class for NEXT_90_DAYS

### [NextFiscalYearComparable](uncategorized/NextFiscalYearComparable.md)

Comparable for the NEXT_FISCAL_YEAR date literal

### [NextMonthComparable](uncategorized/NextMonthComparable.md)

Comparable class for NEXT_MONTH

### [NextNDaysComparable](uncategorized/NextNDaysComparable.md)

Comparable class for NEXT_N_DAYS

### [NextNFiscalYearsComparable](uncategorized/NextNFiscalYearsComparable.md)

Compare the date field value with the NEXT_N_FISCAL_YEARS:N token

### [NextNQuartersComparable](uncategorized/NextNQuartersComparable.md)

Comparable for the NEXT_N_QUARTERS token

### [NextNWeeksComparable](uncategorized/NextNWeeksComparable.md)

Comparable class for NEXT_N_WEEKS

### [NextQuarterComparable](uncategorized/NextQuarterComparable.md)

Compares the NEXT_QUARTER token

### [NextWeekComparable](uncategorized/NextWeekComparable.md)

Comparable class for NEXT_WEEK

### [NFiscalYearsAgoComparable](uncategorized/NFiscalYearsAgoComparable.md)

Compares a date to N fiscal years ago

### [NMonthsAgoComparable](uncategorized/NMonthsAgoComparable.md)

Comparable class for N_MONTHS_AGO

### [Node](uncategorized/Node.md)

: Returns a string representation of the AST

### [NodeBuilder](uncategorized/NodeBuilder.md)

: Builder class for the Node class, used to create a Node

### [NodeService](uncategorized/NodeService.md)

Service class for manipulating and describing the nodes of the AST created by the parser 
each method is a static method that takes in a TopLevelNodes

### [NodeType](uncategorized/NodeType.md)

This class is responsible for handling the NodeType constants

### [NotInHandler](uncategorized/NotInHandler.md)

Handles the NotIn operator

### [NullParser](uncategorized/NullParser.md)

NullParser is a parser for null values.

### [NumberParser](uncategorized/NumberParser.md)

NumberParser is a parser for numeric values.

### [ObjectComparator](uncategorized/ObjectComparator.md)

This class is used to compare two generic objects of the same type.

### [OffsetHandlerFactory](uncategorized/OffsetHandlerFactory.md)

This class is responsible for creating the appropriate offset handler based on the query type.

### [OffsetOptions](uncategorized/OffsetOptions.md)

Options class for the Offset class

### [OffsetParser](uncategorized/OffsetParser.md)

This class is responsible for parsing the offset clause of a query

### [OperatorHandlerFactory](uncategorized/OperatorHandlerFactory.md)

Provides a factory for creating operator handlers.

### [OperatorParser](uncategorized/OperatorParser.md)

This class is responsible for parsing operators in the query string.

### [OrderByHandler](uncategorized/OrderByHandler.md)

Abstract class for OrderByHandler

### [OrderByHandlerFactory](uncategorized/OrderByHandlerFactory.md)

Factory class for creating OrderByHandler instances

### [OrderByOptions](uncategorized/OrderByOptions.md)

Options class for OrderBy

### [OrderByParser](uncategorized/OrderByParser.md)

This class is responsible for parsing the ORDER BY clause of a SOQL query.

### [OrganizationSingleton](uncategorized/OrganizationSingleton.md)

Singleton for the Organization object

### [ParentLookupChain](uncategorized/ParentLookupChain.md)

Represents a chain of fields to look up on a parent object

### [ParentLookupResolver](uncategorized/ParentLookupResolver.md)

A class to resolve a parent lookup chain

### [ParentRecordData](uncategorized/ParentRecordData.md)

A class to store data about a parent record

### [ParentSubQuerySelectHandler](uncategorized/ParentSubQuerySelectHandler.md)

Handles the selection of a field that is a parent relationship in a subquery

### [Parser](uncategorized/Parser.md)

The parser breaks down a SOQL query into an AST, to be fed into the parser (MockDatabase)

### [ParserTestUtil](uncategorized/ParserTestUtil.md)

### [ParserUtils](uncategorized/ParserUtils.md)

Contains utility methods for the parser, could probably be refactored out of existance though

### [PolymorphicAttributes](uncategorized/PolymorphicAttributes.md)

Attributes for polymorphic SObject

### [PolymorphicSelectHandler](uncategorized/PolymorphicSelectHandler.md)

Select handler for TYPEOF operator

### [PrimitiveParserFactory](uncategorized/PrimitiveParserFactory.md)

Factory class for primitive parsers

### [ProtoAggregate](uncategorized/ProtoAggregate.md)

before we create an aggregate, wean a proto-aggregate, 
i.e. a Map&lt;String, Object&gt; that will be used to store the aggregate

### [QueriedFieldResolver](uncategorized/QueriedFieldResolver.md)

This class is used to resolve the field in a query

### [QueryParser](uncategorized/QueryParser.md)

This class is responsible for parsing a SOQL query

### [QueryValidator](uncategorized/QueryValidator.md)

Validate the AST of a query, this does not validate the query against the schema, 
but rather checks for invalid queries that are not supported by the SOQL parser

### [RecordLimitHandler](uncategorized/RecordLimitHandler.md)

Limit handler for record limit

### [RecordOffsetHandler](uncategorized/RecordOffsetHandler.md)

Offset handler for records

### [RecordOrderByHandler](uncategorized/RecordOrderByHandler.md)

Order by handler for record data

### [ReferenceFieldComparator](uncategorized/ReferenceFieldComparator.md)

Comparator for two reference fields, checks if they reference the same object

### [Regex](uncategorized/Regex.md)

A class to handle regex operations

### [SaveResultService](uncategorized/SaveResultService.md)

This class is used to create success and failure results for DML operations.

### [SchemaService](uncategorized/SchemaService.md)

this class is intended to handle interactions with the Schema class 
and provide a layer of abstraction for the Schema class, non-mutating 
string arguments to these methods are understood to be case-insensitive 
anything named &quot;getName&quot; are understood to return proper API names 
every argument is understood to be non-null

### [ScopeParser](uncategorized/ScopeParser.md)

This class is responsible for parsing the scope clause of a SOQL query

### [SelectHandlerFactory](uncategorized/SelectHandlerFactory.md)

Factory class to create appropriate select handler based on the field node type

### [SelectParser](uncategorized/SelectParser.md)

Parser for the SELECT clause

### [SObjectComparator](uncategorized/SObjectComparator.md)

This class is used to compare two SObjects based on the fields provided in the constructor.

### [SObjectParser](uncategorized/SObjectParser.md)

Parses an SObject name in a query

### [SoqlEngine](uncategorized/SoqlEngine.md)

This class is response for handling SOQL queries to the mock database

### [StringParser](uncategorized/StringParser.md)

A class to parse a generic string

### [SubParser](uncategorized/SubParser.md)

SubParser is an abstract class that provides helper methods for parsing subqueries.

### [SumCalculator](uncategorized/SumCalculator.md)

Calculates the sum of a field

### [ThisFiscalYearComparable](uncategorized/ThisFiscalYearComparable.md)

Comparable for the THIS_FISCAL_YEAR token

### [ThisMonthComparable](uncategorized/ThisMonthComparable.md)

Comparable class for THIS_MONTH

### [ThisQuarterComparable](uncategorized/ThisQuarterComparable.md)

Comparable class for THIS_QUARTER

### [ThisWeekComparable](uncategorized/ThisWeekComparable.md)

Comparable class for THIS_WEEK

### [ThisYearComparable](uncategorized/ThisYearComparable.md)

Comparable for THIS_YEAR

### [TodayComparable](uncategorized/TodayComparable.md)

Comparable class for TODAY

### [Token](uncategorized/Token.md)

This class is responsible for handling the Token constants

### [TomorrowComparable](uncategorized/TomorrowComparable.md)

Comparable class for TOMORROW

### [TopLevelNodes](uncategorized/TopLevelNodes.md)

This class is used to parse the top level nodes of a SOQL query. 
Designed to refresh the instance if the head node changes, i.e. if a new SOQL query is made.

### [TypeOf](uncategorized/TypeOf.md)

TypeOf is a class that provides a method to determine the type of an object.

### [UpdateTrackingOrViewStatParser](uncategorized/UpdateTrackingOrViewStatParser.md)

This class is responsible for parsing the UPDATE TRACKING or UPDATE VIEWSTAT query

### [ValueListParser](uncategorized/ValueListParser.md)

This class is responsible for parsing a list of values.

### [ValueParser](uncategorized/ValueParser.md)

This class is responsible for parsing values in the query string

### [WhereLogicComparisonResults](uncategorized/WhereLogicComparisonResults.md)

Contains the results of a where logic comparison

### [WhereLogicDateFuncStrategy](uncategorized/WhereLogicDateFuncStrategy.md)

This class is responsible for handling date functions in the WHERE clause

### [WhereLogicHandler](uncategorized/WhereLogicHandler.md)

This class is responsible for handling the WHERE clause logic

### [WhereLogicParentFieldStrategy](uncategorized/WhereLogicParentFieldStrategy.md)

Strategy for getting the field value of a parent field

### [WhereLogicRecordFieldStrategy](uncategorized/WhereLogicRecordFieldStrategy.md)

This class is responsible for handling record fields in the WHERE clause

### [WhereParser](uncategorized/WhereParser.md)

This class is responsible for parsing the WHERE clause of a SOQL query.

### [WithDataCategoryParser](uncategorized/WithDataCategoryParser.md)

This class is used to parse the WITH DATA CATEGORY clause in a SOQL query

### [WithSecurityEnforcedParser](uncategorized/WithSecurityEnforcedParser.md)

This class is responsible for parsing the WITH SECURITY_ENFORCED clause in a SOQL query.

### [YesterdayComparable](uncategorized/YesterdayComparable.md)

Comparable class for YESTERDAY