# Reference Guide

## Data Store

### [DataStore](data-store/DataStore.md)

Static data store for records

## DML Engine

### [DmlEngine](dml-engine/DmlEngine.md)

MockDatabaseDMLHandler is used to handle DML operations on the mock database

### [MockDeleteHandler](dml-engine/MockDeleteHandler.md)

MockDeleteHandler is a class that extends MockDMLHandler and overrides the delete methods to simulate the delete operation

### [MockDMLHandler](dml-engine/MockDMLHandler.md)

MockDMLHandler is an abstract class that provides a base class for mocking DML operations.

### [MockInsertHandler](dml-engine/MockInsertHandler.md)

MockInsertHandler is used to mock the insert operation

### [MockUndeleteHandler](dml-engine/MockUndeleteHandler.md)

MockUndeleteHandler is used to mock the Database.UndeleteResult class and the Database.undelete method

### [MockUpdateHandler](dml-engine/MockUpdateHandler.md)

MockUpdateHandler is used to mock the update operation in the database

### [MockUpsertHandler](dml-engine/MockUpsertHandler.md)

MockUpsertHandler is used to mock the upsert operation in the database

### [SaveResultService](dml-engine/SaveResultService.md)

This class is used to create success and failure results for DML operations.

## Mock Database

### [MockDatabase](mock-database/MockDatabase.md)

The MockDatabase class is used to simulate the Salesforce database in Apex unit tests

### [Token](mock-database/Token.md)

This class is responsible for handling the Token constants

## Moxygen

### [Aggregate](moxygen/Aggregate.md)

Aggregate class to represent the result of an aggregate query

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

### [Types](moxygen/Types.md)

Types defined for this package

## Soql Engine

### [AbstractSyntaxTreeWithQuery](soql-engine/AbstractSyntaxTreeWithQuery.md)

Represents and AST as stored in the parser static resources

### [AggregateCalculatorFactory](soql-engine/AggregateCalculatorFactory.md)

Generates an instance of an aggregate calculator based on the type provided

### [AggregateCalculatorOptions](soql-engine/AggregateCalculatorOptions.md)

Options for the AggregateCalculator class

### [AggregateComparator](soql-engine/AggregateComparator.md)

A class to compare two pre-Aggregate based on a set of fields 
(a pre-Aggregate is a ProtoAggregate where the keys are the field names and the values are the field values)

### [AggregateFuncParser](soql-engine/AggregateFuncParser.md)

This class is responsible for parsing aggregate functions

### [AggregateLimitHandler](soql-engine/AggregateLimitHandler.md)

Handles the limit for the aggregate query

### [AggregateOffsetHandler](soql-engine/AggregateOffsetHandler.md)

Handler for offsetting aggregate results

### [AggregateOrderByHandler](soql-engine/AggregateOrderByHandler.md)

Handles the ORDER BY clause for aggregate queries

### [AggregateProcessor](soql-engine/AggregateProcessor.md)

Processor for aggregate functions

### [AggregateQueryHandler](soql-engine/AggregateQueryHandler.md)

This class is responsible for handling the aggregate queries

### [AggregateService](soql-engine/AggregateService.md)

Contains static methods for working with aggregates and proto-aggregates

### [AggregateStandardProcessor](soql-engine/AggregateStandardProcessor.md)

Standard processor for aggregate queries

### [AliasParser](soql-engine/AliasParser.md)

This class is responsible for parsing aliases in the query

### [AliasService](soql-engine/AliasService.md)

Tool for finding the aliases on nodes

### [Attributes](soql-engine/Attributes.md)

Attributes for SObject

### [AverageCalculator](soql-engine/AverageCalculator.md)

Calculates the average of a set of values.

### [BindVariableParser](soql-engine/BindVariableParser.md)

A class to parse a bind variable

### [BooleanLogicHandler](soql-engine/BooleanLogicHandler.md)

A class to handle boolean logic, when it comes to HAVING and WHERE clauses, it&#x27;s all the same except for the comparison

### [BooleanLogicOptions](soql-engine/BooleanLogicOptions.md)

This class is used to store the options for the BooleanLogic class

### [BooleanParser](soql-engine/BooleanParser.md)

A parser for boolean values

### [CalendarMonthCalculator](soql-engine/CalendarMonthCalculator.md)

Calculates the calendar month from a date value

### [CalendarMonthFunc](soql-engine/CalendarMonthFunc.md)

Function to calculate the calendar month of a date or datetime value

### [CalendarQuarterCalculator](soql-engine/CalendarQuarterCalculator.md)

Calculates the calendar month from a date value

### [CalendarQuarterFunc](soql-engine/CalendarQuarterFunc.md)

Function to calculate the calendar quarter of a date or datetime value

### [CalendarYearCalculator](soql-engine/CalendarYearCalculator.md)

Calculates the calendar month from a date value

### [CalendarYearFunc](soql-engine/CalendarYearFunc.md)

Function to calculate the calendar year of a date or datetime value

### [ChildSubQuerySelectHandler](soql-engine/ChildSubQuerySelectHandler.md)

Child subquery select handler

### [ComparableRecordData](soql-engine/ComparableRecordData.md)

Encapsulates the data needed to compare records

### [ComparableService](soql-engine/ComparableService.md)

This class provides the ability to compare fields on SObjects with the mock database

### [CountCalculator](soql-engine/CountCalculator.md)

CountCalculator is a concrete implementation of IAggregateCalculator that calculates the count of records.

### [CountDistinctCalculator](soql-engine/CountDistinctCalculator.md)

CountDistinctCalculator is a class that implements the IAggregateCalculator interface. It calculates the distinct count of a field.

### [CountLimitHandler](soql-engine/CountLimitHandler.md)

Handles the limit for the count of records

### [CountOffsetHandler](soql-engine/CountOffsetHandler.md)

OffsetHandler for Count

### [DateFuncFactory](soql-engine/DateFuncFactory.md)

Factory class to create date functions by name

### [DateFuncs](soql-engine/DateFuncs.md)

Repository of aggregate date functions

### [DateLiteral](soql-engine/DateLiteral.md)

Represents the value and new record field value for a date literal

### [DateLiteralComparable](soql-engine/DateLiteralComparable.md)

Abstract class for date literal comparison

### [DateLiteralComparableFactory](soql-engine/DateLiteralComparableFactory.md)

Factory class for creating DateLiteralComparable instances

### [DateLiteralParser](soql-engine/DateLiteralParser.md)

Generic date literal parser

### [DateParser](soql-engine/DateParser.md)

DateParser is a parser for date values.

### [EqualityHandler](soql-engine/EqualityHandler.md)

Handles the equality operator

### [ExcludesHandler](soql-engine/ExcludesHandler.md)

Handles the excludes operator

### [FieldListParser](soql-engine/FieldListParser.md)

This class is responsible for parsing a list of fields.

### [FieldParser](soql-engine/FieldParser.md)

This class is responsible for parsing a field from a query string.

### [FieldSelectHandler](soql-engine/FieldSelectHandler.md)

FieldSelectHandler is a class that implements ISelectHandler. It is used to handle the selection of a field.

### [FieldSelector](soql-engine/FieldSelector.md)

FieldSelector is a class that is used to select fields from a queried record based on a field node.

### [ForUpdateParser](soql-engine/ForUpdateParser.md)

This class is responsible for parsing the FOR UPDATE clause in a SOQL query

### [ForViewOrReferenceParser](soql-engine/ForViewOrReferenceParser.md)

This class is responsible for parsing the FOR VIEW or FOR REFERENCE clause

### [FromParser](soql-engine/FromParser.md)

Class is responsible for parsing the &#x27;from&#x27; clause of a query

### [GreaterThanHandler](soql-engine/GreaterThanHandler.md)

Handles the greater than operator

### [GreaterThanOrEqualHandler](soql-engine/GreaterThanOrEqualHandler.md)

Handles the greater than or equal operator

### [GroupByParser](soql-engine/GroupByParser.md)

This class is responsible for parsing the GROUP BY clause of a SOQL query

### [HavingLogicHandler](soql-engine/HavingLogicHandler.md)

This class is used to handle the having clause logic

### [HavingParser](soql-engine/HavingParser.md)

This class is responsible for parsing the HAVING clause of a SOQL query.

### [IAggregateCalculator](soql-engine/IAggregateCalculator.md)

Interface for aggregate calculator

### [IdAndReferenceFieldComparator](soql-engine/IdAndReferenceFieldComparator.md)

This class is used to compare two fields to determine if one is a reference to the other

### [IDateFunc](soql-engine/IDateFunc.md)

Interface for date functions

### [IdFieldComparator](soql-engine/IdFieldComparator.md)

Id Field Comparator

### [IdFieldComparatorFactory](soql-engine/IdFieldComparatorFactory.md)

Returns a comparator for the given field types, compares ID fields (i.e. ID, Reference)

### [ILimitHandler](soql-engine/ILimitHandler.md)

Interface for limit handler

### [IncludesHandler](soql-engine/IncludesHandler.md)

Handles the includes operator

### [InequalityHandler](soql-engine/InequalityHandler.md)

Handles the inequality operator

### [InHandler](soql-engine/InHandler.md)

Handler for IN operator

### [Intermediary](soql-engine/Intermediary.md)

: Class to hold the head of a parsed query and the remaining subquery

### [IOffsetHandler](soql-engine/IOffsetHandler.md)

Interface for offset handler

### [IOperatorHandler](soql-engine/IOperatorHandler.md)

comparison handlers for WHERE and HAVING clauses

### [ISelectHandler](soql-engine/ISelectHandler.md)

Interface for handling select operations

### [IWhereLogicComparisonStrategy](soql-engine/IWhereLogicComparisonStrategy.md)

Strategy inreferace for WHERE logic comparison

### [Last90DaysComparable](soql-engine/Last90DaysComparable.md)

Comparable class for LAST_90_DAYS

### [LastFiscalYearComparable](soql-engine/LastFiscalYearComparable.md)

Comparable for the LAST_FISCAL_YEAR date literal

### [LastMonthComparable](soql-engine/LastMonthComparable.md)

Comparable class for LAST_MONTH

### [LastNDaysComparable](soql-engine/LastNDaysComparable.md)

Comparable class for LAST_N_DAYS

### [LastNFiscalQuartersComparable](soql-engine/LastNFiscalQuartersComparable.md)

Comparable class for LAST_N_FISCAL_QUARTERS

### [LastNFiscalYearsComparable](soql-engine/LastNFiscalYearsComparable.md)

Comparable class for LAST_N_FISCAL_YEARS

### [LastNWeeksComparable](soql-engine/LastNWeeksComparable.md)

Comparable class for LAST_N_WEEKS

### [LastQuarterComparable](soql-engine/LastQuarterComparable.md)

Compares a date field to the last quarter

### [LastWeekComparable](soql-engine/LastWeekComparable.md)

Comparable class for LAST_WEEK

### [LessThanHandler](soql-engine/LessThanHandler.md)

Handles the less than operator

### [LessThanOrEqualHandler](soql-engine/LessThanOrEqualHandler.md)

Handles the LessThanOrEqual operator

### [LikeHandler](soql-engine/LikeHandler.md)

Handles the LIKE operator

### [LimitHandlerFactory](soql-engine/LimitHandlerFactory.md)

Used to create a limit handler based on the query type

### [LimitOptions](soql-engine/LimitOptions.md)

The options to be passed into an ILimitHandler

### [LimitParser](soql-engine/LimitParser.md)

This class is responsible for parsing the limit clause of a query

### [MaxCalculator](soql-engine/MaxCalculator.md)

calculates the MAX value of a field for an aggregate result

### [MinCalculator](soql-engine/MinCalculator.md)

Calculates the minimum value of a field

### [MockAggregateQueryHandler](soql-engine/MockAggregateQueryHandler.md)

This class is responsible for handling aggregate SOQL queries to the mock database

### [MockCountQueryHandler](soql-engine/MockCountQueryHandler.md)

This class is responsible for handling count SOQL queries to the mock database

### [MockRecordQueryHandler](soql-engine/MockRecordQueryHandler.md)

This class is responsible for handling record SOQL queries to the mock database

### [MockSOQLHandler](soql-engine/MockSOQLHandler.md)

Base class for handling SOQL queries to the mock database

### [NDaysAgoComparable](soql-engine/NDaysAgoComparable.md)

Comparable class for N_DAYS_AGO

### [Next90DaysComparable](soql-engine/Next90DaysComparable.md)

Comparable class for NEXT_90_DAYS

### [NextFiscalYearComparable](soql-engine/NextFiscalYearComparable.md)

Comparable for the NEXT_FISCAL_YEAR date literal

### [NextMonthComparable](soql-engine/NextMonthComparable.md)

Comparable class for NEXT_MONTH

### [NextNDaysComparable](soql-engine/NextNDaysComparable.md)

Comparable class for NEXT_N_DAYS

### [NextNFiscalYearsComparable](soql-engine/NextNFiscalYearsComparable.md)

Compare the date field value with the NEXT_N_FISCAL_YEARS:N token

### [NextNQuartersComparable](soql-engine/NextNQuartersComparable.md)

Comparable for the NEXT_N_QUARTERS token

### [NextNWeeksComparable](soql-engine/NextNWeeksComparable.md)

Comparable class for NEXT_N_WEEKS

### [NextQuarterComparable](soql-engine/NextQuarterComparable.md)

Compares the NEXT_QUARTER token

### [NextWeekComparable](soql-engine/NextWeekComparable.md)

Comparable class for NEXT_WEEK

### [NFiscalYearsAgoComparable](soql-engine/NFiscalYearsAgoComparable.md)

Compares a date to N fiscal years ago

### [NMonthsAgoComparable](soql-engine/NMonthsAgoComparable.md)

Comparable class for N_MONTHS_AGO

### [Node](soql-engine/Node.md)

: Returns a string representation of the AST

### [NodeBuilder](soql-engine/NodeBuilder.md)

: Builder class for the Node class, used to create a Node

### [NodeService](soql-engine/NodeService.md)

Service class for manipulating and describing the nodes of the AST created by the parser 
each method is a static method that takes in a TopLevelNodes

### [NodeType](soql-engine/NodeType.md)

This class is responsible for handling the NodeType constants

### [NotInHandler](soql-engine/NotInHandler.md)

Handles the NotIn operator

### [NullParser](soql-engine/NullParser.md)

NullParser is a parser for null values.

### [NumberParser](soql-engine/NumberParser.md)

NumberParser is a parser for numeric values.

### [NYearsAgoComparable](soql-engine/NYearsAgoComparable.md)

Comparable class for N_YEARS_AGO

### [ObjectComparator](soql-engine/ObjectComparator.md)

This class is used to compare two generic objects of the same type.

### [OffsetHandlerFactory](soql-engine/OffsetHandlerFactory.md)

This class is responsible for creating the appropriate offset handler based on the query type.

### [OffsetOptions](soql-engine/OffsetOptions.md)

Options class for the Offset class

### [OffsetParser](soql-engine/OffsetParser.md)

This class is responsible for parsing the offset clause of a query

### [OperatorHandlerFactory](soql-engine/OperatorHandlerFactory.md)

Provides a factory for creating operator handlers.

### [OperatorParser](soql-engine/OperatorParser.md)

This class is responsible for parsing operators in the query string.

### [OrderByHandler](soql-engine/OrderByHandler.md)

Abstract class for OrderByHandler

### [OrderByHandlerFactory](soql-engine/OrderByHandlerFactory.md)

Factory class for creating OrderByHandler instances

### [OrderByOptions](soql-engine/OrderByOptions.md)

Options class for OrderBy

### [OrderByParser](soql-engine/OrderByParser.md)

This class is responsible for parsing the ORDER BY clause of a SOQL query.

### [ParentLookupChain](soql-engine/ParentLookupChain.md)

Represents a chain of fields to look up on a parent object

### [ParentLookupResolver](soql-engine/ParentLookupResolver.md)

A class to resolve a parent lookup chain

### [ParentRecordData](soql-engine/ParentRecordData.md)

A class to store data about a parent record

### [ParentSubQuerySelectHandler](soql-engine/ParentSubQuerySelectHandler.md)

Handles the selection of a field that is a parent relationship in a subquery

### [Parser](soql-engine/Parser.md)

The parser breaks down a SOQL query into an AST, to be fed into the parser (MockDatabase)

### [ParserTestUtil](soql-engine/ParserTestUtil.md)

Test utilites for the parser

### [ParserUtils](soql-engine/ParserUtils.md)

Contains utility methods for the parser, could probably be refactored out of existance though

### [PolymorphicAttributes](soql-engine/PolymorphicAttributes.md)

Attributes for polymorphic SObject

### [PolymorphicSelectHandler](soql-engine/PolymorphicSelectHandler.md)

Select handler for TYPEOF operator

### [PrimitiveParserFactory](soql-engine/PrimitiveParserFactory.md)

Factory class for primitive parsers

### [QueriedFieldResolver](soql-engine/QueriedFieldResolver.md)

This class is used to resolve the field in a query

### [QueryParser](soql-engine/QueryParser.md)

This class is responsible for parsing a SOQL query

### [QueryValidator](soql-engine/QueryValidator.md)

Validate the AST of a query, this does not validate the query against the schema, 
but rather checks for invalid queries that are not supported by the SOQL parser

### [RecordLimitHandler](soql-engine/RecordLimitHandler.md)

Limit handler for record limit

### [RecordOffsetHandler](soql-engine/RecordOffsetHandler.md)

Offset handler for records

### [RecordOrderByHandler](soql-engine/RecordOrderByHandler.md)

Order by handler for record data

### [ReferenceFieldComparator](soql-engine/ReferenceFieldComparator.md)

Comparator for two reference fields, checks if they reference the same object

### [ScopeParser](soql-engine/ScopeParser.md)

This class is responsible for parsing the scope clause of a SOQL query

### [SelectHandlerFactory](soql-engine/SelectHandlerFactory.md)

Factory class to create appropriate select handler based on the field node type

### [SelectParser](soql-engine/SelectParser.md)

Parser for the SELECT clause

### [SObjectComparator](soql-engine/SObjectComparator.md)

This class is used to compare two SObjects based on the fields provided in the constructor.

### [SObjectParser](soql-engine/SObjectParser.md)

Parses an SObject name in a query

### [SoqlEngine](soql-engine/SoqlEngine.md)

This class is response for handling SOQL queries to the mock database

### [StringParser](soql-engine/StringParser.md)

A class to parse a generic string

### [SubParser](soql-engine/SubParser.md)

SubParser is an abstract class that provides helper methods for parsing subqueries.

### [SumCalculator](soql-engine/SumCalculator.md)

Calculates the sum of a field

### [ThisFiscalYearComparable](soql-engine/ThisFiscalYearComparable.md)

Comparable for the THIS_FISCAL_YEAR token

### [ThisMonthComparable](soql-engine/ThisMonthComparable.md)

Comparable class for THIS_MONTH

### [ThisQuarterComparable](soql-engine/ThisQuarterComparable.md)

Comparable class for THIS_QUARTER

### [ThisWeekComparable](soql-engine/ThisWeekComparable.md)

Comparable class for THIS_WEEK

### [ThisYearComparable](soql-engine/ThisYearComparable.md)

Comparable for THIS_YEAR

### [TodayComparable](soql-engine/TodayComparable.md)

Comparable class for TODAY

### [TomorrowComparable](soql-engine/TomorrowComparable.md)

Comparable class for TOMORROW

### [TopLevelNodes](soql-engine/TopLevelNodes.md)

This class is used to parse the top level nodes of a SOQL query. 
Designed to refresh the instance if the head node changes, i.e. if a new SOQL query is made.

### [UpdateTrackingOrViewStatParser](soql-engine/UpdateTrackingOrViewStatParser.md)

This class is responsible for parsing the UPDATE TRACKING or UPDATE VIEWSTAT query

### [ValueListParser](soql-engine/ValueListParser.md)

This class is responsible for parsing a list of values.

### [ValueParser](soql-engine/ValueParser.md)

This class is responsible for parsing values in the query string

### [WhereLogicComparisonResults](soql-engine/WhereLogicComparisonResults.md)

Contains the results of a where logic comparison

### [WhereLogicDateFuncStrategy](soql-engine/WhereLogicDateFuncStrategy.md)

This class is responsible for handling date functions in the WHERE clause

### [WhereLogicHandler](soql-engine/WhereLogicHandler.md)

This class is responsible for handling the WHERE clause logic

### [WhereLogicParentFieldStrategy](soql-engine/WhereLogicParentFieldStrategy.md)

Strategy for getting the field value of a parent field

### [WhereLogicRecordFieldStrategy](soql-engine/WhereLogicRecordFieldStrategy.md)

This class is responsible for handling record fields in the WHERE clause

### [WhereParser](soql-engine/WhereParser.md)

This class is responsible for parsing the WHERE clause of a SOQL query.

### [WithDataCategoryParser](soql-engine/WithDataCategoryParser.md)

This class is used to parse the WITH DATA CATEGORY clause in a SOQL query

### [WithSecurityEnforcedParser](soql-engine/WithSecurityEnforcedParser.md)

This class is responsible for parsing the WITH SECURITY_ENFORCED clause in a SOQL query.

### [YesterdayComparable](soql-engine/YesterdayComparable.md)

Comparable class for YESTERDAY

## Utilities

### [AggregateBuilder](utilities/AggregateBuilder.md)

Creates Aggregate objects from ProtoAggregates

### [ApexTypes](utilities/ApexTypes.md)

A class that contains the names of the Apex types.

### [Common](utilities/Common.md)

Common utility class for basic operations, should not contain complex code

### [DynamicCast](utilities/DynamicCast.md)

DynamicCast is a class that provides a method to cast a value to a specified type.

### [fflib_IDGenerator](utilities/fflib_IDGenerator.md)

Generates fake Salesforce Ids for testing purposes

### [GMT](utilities/GMT.md)

Salesforce is insanely inconsistent about dates and date times, this class returns values in GMT

### [NotFoundException](utilities/NotFoundException.md)

Generic exception for when something is not found

### [OrganizationSingleton](utilities/OrganizationSingleton.md)

Singleton for the Organization object

### [ParsingException](utilities/ParsingException.md)

Custom exception for parsing errors

### [ProtoAggregate](utilities/ProtoAggregate.md)

before we create an aggregate, wean a proto-aggregate, 
i.e. a Map&lt;String, Object&gt; that will be used to store the aggregate

### [Regex](utilities/Regex.md)

A class to handle regex operations

### [SchemaService](utilities/SchemaService.md)

this class is intended to handle interactions with the Schema class 
and provide a layer of abstraction for the Schema class, non-mutating 
string arguments to these methods are understood to be case-insensitive 
anything named &quot;getName&quot; are understood to return proper API names 
every argument is understood to be non-null

### [TypeOf](utilities/TypeOf.md)

TypeOf is a class that provides a method to determine the type of an object.

### [ValidationException](utilities/ValidationException.md)

This class is responsible for handling validation exceptions