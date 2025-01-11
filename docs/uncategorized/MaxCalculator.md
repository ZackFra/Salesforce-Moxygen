# MaxCalculator Class

calculates the MAX value of a field for an aggregate result

**Since** 

3/23/2024

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `MaxCalculator(options)`

Constructor

#### Signature
```apex
public MaxCalculator(AggregateCalculatorOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [AggregateCalculatorOptions](AggregateCalculatorOptions.md) |  |

## Methods
### `calculate()`

calculates the MAX value of a field for an aggregate result

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](ProtoAggregate.md)**

,[object Object]

---

### `calculateForField()`

Return the max of the field passed in as `alias` in options, 
for the records passed in as `aggregateResult` of options

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

,[object Object]