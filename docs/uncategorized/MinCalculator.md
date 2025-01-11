# MinCalculator Class

Calculates the minimum value of a field

**Since** 

3/23/2024

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `MinCalculator(options)`

Constructor

#### Signature
```apex
public MinCalculator(AggregateCalculatorOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [AggregateCalculatorOptions](AggregateCalculatorOptions.md) |  |

## Methods
### `calculate()`

Calculates the minimum value of a field

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

calculate the min of the `alias` field passed into options, 
for the records associated with the `aggregateResult` passed into options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]