# AverageCalculator Class

Calculates the average of a set of values.

**Since** 

3/23/2024

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `AverageCalculator(options)`

Constructor for the AverageCalculator class

#### Signature
```apex
public AverageCalculator(AggregateCalculatorOptions options)
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
**[ProtoAggregate](ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

Calculate the average for the field specified in the `alias` field of options, 
of the grouped records of the `aggregateResult` field of options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]