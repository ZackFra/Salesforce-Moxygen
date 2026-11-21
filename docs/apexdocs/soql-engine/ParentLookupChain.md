# ParentLookupChain Class

Represents a chain of fields to look up on a parent object

**Since**

11/25/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Constructors
### `ParentLookupChain(fieldLookupChain)`

Constructor for ParentLookupChain

#### Signature
```apex
public ParentLookupChain(String fieldLookupChain)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldLookupChain | String | `String` |

---

### `ParentLookupChain(finalField, fieldParts)`

Constructor for ParentLookupChain

#### Signature
```apex
public ParentLookupChain(String finalField, List<String> fieldParts)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| finalField | String | `String` |
| fieldParts | List<String> | `List<String>` |

## Methods
### `getFieldParts()`

Get the field parts to look up

#### Signature
```apex
public List<String> getFieldParts()
```

#### Return Type
**List<String>**

`List<String>`

---

### `getFinalField()`

Get the final field to look up

#### Signature
```apex
public String getFinalField()
```

#### Return Type
**String**

`String`