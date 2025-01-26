# IOperatorHandler Interface

comparison handlers for WHERE and HAVING clauses

**Since** 

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `handle(sObjectFieldValue, fieldValue)`

Handles the comparison of the field value and the sObject field value

#### Signature
```apex
public Boolean handle(Object sObjectFieldValue, Object fieldValue)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjectFieldValue | Object | `Object` |
| fieldValue | Object | `Object` |

#### Return Type
**Boolean**

,[object Object]