# WhereLogicRecordFieldStrategy Class

This class is responsible for handling record fields in the WHERE clause

**Since** 

11/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[IWhereLogicComparisonStrategy](IWhereLogicComparisonStrategy.md)

## Methods
### `getFieldValue(record, fieldNode)`

Get the field value from the record when the field node is for a record field

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