# OffsetOptions Class

Options class for the Offset class

**Since** 

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Fields
### `obj`

#### Signature
```apex
public obj
```

#### Type
Object

---

### `offset`

#### Signature
```apex
public offset
```

#### Type
Integer

---

### `type`

#### Signature
```apex
public type
```

#### Type
Types.SOQL

## Methods
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

### `getOffset()`

Getter for the offset value

#### Signature
```apex
public Integer getOffset()
```

#### Return Type
**Integer**

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

### `setObj(obj)`

Setter for the object to be used in the query

#### Signature
```apex
public OffsetOptions setObj(Object obj)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| obj | Object | `List<ProtoAggregate> | List<SObject> | Integer` |

#### Return Type
**[OffsetOptions](OffsetOptions.md)**

,[object Object]

---

### `setOffset(offset)`

Sets the offset value for the query

#### Signature
```apex
public OffsetOptions setOffset(Integer offset)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| offset | Integer | `Integer` |

#### Return Type
**[OffsetOptions](OffsetOptions.md)**

,[object Object]

---

### `setType(type)`

Setter for the type of query

#### Signature
```apex
public OffsetOptions setType(Types.SOQL type)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| type | Types.SOQL | `Types.SOQL` |

#### Return Type
**[OffsetOptions](OffsetOptions.md)**

,[object Object]