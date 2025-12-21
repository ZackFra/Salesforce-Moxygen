# AggregateCalculatorFactory Class

Generates an instance of an aggregate calculator based on the type provided

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `getCalculator(type, options)`

Generates an instance of an aggregate calculator based on the type provided

#### Signature
```apex
public static IAggregateCalculator getCalculator(String type, AggregateCalculatorOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | String |  |
| options | [AggregateCalculatorOptions](AggregateCalculatorOptions.md) |  |

#### Return Type
**[IAggregateCalculator](IAggregateCalculator.md)**

,[object Object]

#### Throws
AggregateCalculatorException: