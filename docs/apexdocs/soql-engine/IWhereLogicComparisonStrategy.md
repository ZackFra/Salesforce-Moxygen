# IWhereLogicComparisonStrategy Interface

Strategy inreferace for WHERE logic comparison

**Since**

11/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `getFieldValue(record, fieldNode)`

Retrieve the field value from the record based on the field node

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