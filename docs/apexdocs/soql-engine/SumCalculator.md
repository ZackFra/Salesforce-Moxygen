# SumCalculator Class

Calculates the sum of a field

**Since** 

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `SumCalculator(options)`

Constructor

#### Signature
```apex
public SumCalculator(AggregateCalculatorOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [AggregateCalculatorOptions](AggregateCalculatorOptions.md) |  |

## Methods
### `calculate()`

Calculates the sum of a field

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](../utilities/ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

return the sum of the `alias` field passed into options 
for the records in `aggregateResult` passed into options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]