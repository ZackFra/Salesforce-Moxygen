# LimitOptions Class

The options to be passed into an ILimitHandler

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Fields
### `limitSize`

#### Signature
```apex
public limitSize
```

#### Type
Integer

---

### `obj`

#### Signature
```apex
public obj
```

#### Type
Object

---

### `type`

#### Signature
```apex
public type
```

#### Type
Types.SOQL

## Methods
### `getLimitSize()`

Getter for the limit size

#### Signature
```apex
public Integer getLimitSize()
```

#### Return Type
**Integer**

,[object Object]

---

### `getObj()`

Getter for the object to be used in the query

#### Signature
```apex
public Object getObj()
```

#### Return Type
**Object**

,[object Object]

---

### `getType()`

Getter for the type of query

#### Signature
```apex
public Types.SOQL getType()
```

#### Return Type
**Types.SOQL**

,[object Object]

---

### `setLimitSize(limitSize)`

Setter for the limit size

#### Signature
```apex
public LimitOptions setLimitSize(Integer limitSize)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| limitSize | Integer | `Integer` |

#### Return Type
**[LimitOptions](LimitOptions.md)**

,[object Object]

---

### `setObj(obj)`

Sets the object to be used in the query

#### Signature
```apex
public LimitOptions setObj(Object obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | Object | `List<ProtoAggregate> | List<SObject> | Integer` |

#### Return Type
**[LimitOptions](LimitOptions.md)**

,[object Object]

---

### `setType(type)`

Setter for the type of query

#### Signature
```apex
public LimitOptions setType(Types.SOQL type)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | Types.SOQL | `MockDatabase.Types.SOQL` |

#### Return Type
**[LimitOptions](LimitOptions.md)**

,[object Object]