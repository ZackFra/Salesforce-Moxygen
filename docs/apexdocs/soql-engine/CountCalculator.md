# CountCalculator Class

CountCalculator is a concrete implementation of IAggregateCalculator that calculates the count of records.

**Since** 

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `CountCalculator(options)`

Constructor for CountCalculator

#### Signature
```apex
public CountCalculator(AggregateCalculatorOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [AggregateCalculatorOptions](AggregateCalculatorOptions.md) |  |

## Methods
### `calculate()`

Calculates the count of records

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](../utilities/ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

Returns the count of records for the `aggregateResult` passed into options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]