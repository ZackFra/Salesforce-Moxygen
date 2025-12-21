# SelectHandlerFactory Class

Factory class to create appropriate select handler based on the field node type

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Constructors
### `SelectHandlerFactory(fSelector)`

Constructor

#### Signature
```apex
public SelectHandlerFactory(FieldSelector fSelector)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fSelector | [FieldSelector](FieldSelector.md) |  |

## Methods
### `createHandler()`

Creates appropriate select handler based on the field node type

#### Signature
```apex
public ISelectHandler createHandler()
```

#### Return Type
**[ISelectHandler](ISelectHandler.md)**

,[object Object]