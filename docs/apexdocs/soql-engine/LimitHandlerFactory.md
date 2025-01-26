# LimitHandlerFactory Class

Used to create a limit handler based on the query type

**Since** 

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `createHandler()`

Creates the appropriate limit handler based on the query type

#### Signature
```apex
public ILimitHandler createHandler()
```

#### Return Type
**[ILimitHandler](ILimitHandler.md)**

,[object Object]

#### Throws
LimitHandlerException: 

---

### `setLimitNode(limitNode)`

Sets the limit node

#### Signature
```apex
public LimitHandlerFactory setLimitNode(Node limitNode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| limitNode | [Node](Node.md) | `Node` |

#### Return Type
**[LimitHandlerFactory](LimitHandlerFactory.md)**

,[object Object]

---

### `setObj(obj)`

Sets the object to which the limit is applied

#### Signature
```apex
public LimitHandlerFactory setObj(Object obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | Object | `List<ProtoAggregate> | List<SObject> | Integer` |

#### Return Type
**[LimitHandlerFactory](LimitHandlerFactory.md)**

,[object Object]

---

### `setParams(params)`

Sets the params for a queryWithBinds call

#### Signature
```apex
public LimitHandlerFactory setParams(Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| params | Map&lt;String,Object&gt; | `Map<String, Object>` |

#### Return Type
**[LimitHandlerFactory](LimitHandlerFactory.md)**

,[object Object]

---

### `setType(type)`

Sets the type of the query

#### Signature
```apex
public LimitHandlerFactory setType(Types.SOQL type)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | Types.SOQL | `Types.SOQL` |

#### Return Type
**[LimitHandlerFactory](LimitHandlerFactory.md)**

,[object Object]