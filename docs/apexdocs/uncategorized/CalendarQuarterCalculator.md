# CalendarQuarterCalculator Class

Calculates the calendar month from a date value

**Since** 

4/28/2024

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](../soql-engine/IAggregateCalculator.md)

## Constructors
### `CalendarQuarterCalculator(options)`

Constructor for the CalendarQuarterCalculaotr class

#### Signature
```apex
public CalendarQuarterCalculator(AggregateCalculatorOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [AggregateCalculatorOptions](../soql-engine/AggregateCalculatorOptions.md) |  |

## Methods
### `calculate()`

Calculates the average of a set of values.

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

Calculate the calendar quarter of field passed in as `alias` in options, 
for the grouped records of the `aggregateResult` passed into options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]