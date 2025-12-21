# OffsetHandlerFactory Class

This class is responsible for creating the appropriate offset handler based on the query type.

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `createHandler()`

Creates an offset handler

#### Signature
```apex
public IOffsetHandler createHandler()
```

#### Return Type
**[IOffsetHandler](IOffsetHandler.md)**

,[object Object]

#### Throws
OffsetHandlerException: 

---

### `setObj(obj)`

Setter for the offsetted object

#### Signature
```apex
public OffsetHandlerFactory setObj(Object obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | Object | `List<ProtoAggregate> | List<SObject> | Integer` |

#### Return Type
**[OffsetHandlerFactory](OffsetHandlerFactory.md)**

,[object Object]

---

### `setOffsetNode(offsetNode)`

Setter for the offset node

#### Signature
```apex
public OffsetHandlerFactory setOffsetNode(Node offsetNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| offsetNode | [Node](Node.md) | `Node` |

#### Return Type
**[OffsetHandlerFactory](OffsetHandlerFactory.md)**

,[object Object]

---

### `setParams(params)`

Setter for the bind parameters

#### Signature
```apex
public OffsetHandlerFactory setParams(Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| params | Map<String,Object> | `Map<String, Object>` |

#### Return Type
**[OffsetHandlerFactory](OffsetHandlerFactory.md)**

,[object Object]

---

### `setType(type)`

Setter for the query type

#### Signature
```apex
public OffsetHandlerFactory setType(Types.SOQL type)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | Types.SOQL | `Types.SOQL` |

#### Return Type
**[OffsetHandlerFactory](OffsetHandlerFactory.md)**

,[object Object]