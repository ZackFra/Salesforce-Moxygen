# CountDistinctCalculator Class

CountDistinctCalculator is a class that implements the IAggregateCalculator interface. It calculates the distinct count of a field.

**Since** 

3/23/2024

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `CountDistinctCalculator(options)`

Constructor for the CountDistinctCalculator class.

#### Signature
```apex
public CountDistinctCalculator(AggregateCalculatorOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [AggregateCalculatorOptions](AggregateCalculatorOptions.md) |  |

## Methods
### `calculate()`

This method calculates the distinct count of a field.

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

Returns the distinct count of the records passed in as `aggregateResult` in options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]