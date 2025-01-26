# CalendarYearCalculator Class

Calculates the calendar month from a date value

**Since** 

5/5/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `CalendarYearCalculator(options)`

Constructor for the CalendarMonthCalculator class

#### Signature
```apex
public CalendarYearCalculator(AggregateCalculatorOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [AggregateCalculatorOptions](AggregateCalculatorOptions.md) |  |

## Methods
### `calculate()`

Calculates the average of a set of values.

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](../utilities/ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

Calculate the calendar year of the field passed in as the `alias` in options, 
for the record associated with the `aggregateResult` passed into options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]