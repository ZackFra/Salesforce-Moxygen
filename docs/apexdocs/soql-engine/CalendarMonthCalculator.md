# CalendarMonthCalculator Class

Calculates the calendar month from a date value

**Since**

4/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `CalendarMonthCalculator(options)`

Constructor for the CalendarMonthCalculator class

#### Signature
```apex
public CalendarMonthCalculator(AggregateCalculatorOptions options)
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

Calculate the calendar month of field passed in as `alias` in options, 
for the grouped records of the `aggregateResult` passed into options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]