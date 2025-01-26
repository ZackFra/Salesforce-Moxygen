# PolymorphicSelectHandler Class

`SUPPRESSWARNINGS`

Select handler for TYPEOF operator

**Since** 

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[ISelectHandler](ISelectHandler.md)

## Constructors
### `PolymorphicSelectHandler(fSelector)`

Constructor

#### Signature
```apex
public PolymorphicSelectHandler(FieldSelector fSelector)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fSelector | [FieldSelector](FieldSelector.md) |  |

## Methods
### `handleSelect()`

`SUPPRESSWARNINGS`

Handles the TYPEOF operator in a SELECT statement

#### Signature
```apex
public SObject handleSelect()
```

#### Return Type
**SObject**

,[object Object]

#### Throws
QueryException: