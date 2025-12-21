# AggregateLimitHandler Class

Handles the limit for the aggregate query

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

[ILimitHandler](ILimitHandler.md)

## Constructors
### `AggregateLimitHandler(options)`

Constructor for the AggregateLimitHandler

#### Signature
```apex
public AggregateLimitHandler(LimitOptions options)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| options | [LimitOptions](LimitOptions.md) | ,[object Object] |

## Methods
### `handleLimit()`

Handles the limit for the aggregate query

#### Signature
```apex
public Object handleLimit()
```

#### Return Type
**Object**

,[object Object], - The object with the limit applied