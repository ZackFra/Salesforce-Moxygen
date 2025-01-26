# WhereLogicParentFieldStrategy Class

Strategy for getting the field value of a parent field

**Since** 

11/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IWhereLogicComparisonStrategy](IWhereLogicComparisonStrategy.md)

## Methods
### `getFieldValue(record, fieldNode)`

Get the field value of a parent field

#### Signature
```apex
public WhereLogicComparisonResults getFieldValue(SObject record, Node fieldNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject | `SObject` |
| fieldNode | [Node](Node.md) | `Node` |

#### Return Type
**[WhereLogicComparisonResults](WhereLogicComparisonResults.md)**

,[object Object]