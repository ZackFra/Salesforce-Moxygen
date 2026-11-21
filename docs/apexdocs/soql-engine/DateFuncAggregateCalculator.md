# DateFuncAggregateCalculator Class

Calculates a SOQL date function for an aggregate query

**Since**

11/21/2026

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IAggregateCalculator](IAggregateCalculator.md)

## Constructors
### `DateFuncAggregateCalculator(options, dateFunc)`

Constructor

#### Signature
```apex
public DateFuncAggregateCalculator(AggregateCalculatorOptions options, String dateFunc)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [AggregateCalculatorOptions](AggregateCalculatorOptions.md) | Aggregate calculator options |
| dateFunc | String | Date function name, such as day_in_month |

## Methods
### `calculate()`

Calculate the date function for the value in options

#### Signature
```apex
public ProtoAggregate calculate()
```

#### Return Type
**[ProtoAggregate](../utilities/ProtoAggregate.md)**

`ProtoAggregate`

---

### `calculateForField()`

Calculate the date function for the first grouped record

#### Signature
```apex
public Object calculateForField()
```

#### Return Type
**Object**

`Object`