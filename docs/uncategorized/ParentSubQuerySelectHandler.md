# ParentSubQuerySelectHandler Class

Handles the selection of a field that is a parent relationship in a subquery

**Since** 

3/23/2024

**Author** Zackary Frazier

**Implements**

[ISelectHandler](ISelectHandler.md)

## Constructors
### `ParentSubQuerySelectHandler(fSelector)`

Constructor for ParentSubQuerySelectHandler

#### Signature
```apex
public ParentSubQuerySelectHandler(FieldSelector fSelector)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fSelector | [FieldSelector](FieldSelector.md) |  |

## Methods
### `handleSelect()`

Selects the field from the queried record

#### Signature
```apex
public SObject handleSelect()
```

#### Return Type
**SObject**

,[object Object]