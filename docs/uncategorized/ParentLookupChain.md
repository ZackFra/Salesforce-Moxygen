# ParentLookupChain Class

Represents a chain of fields to look up on a parent object

**Since** 

11/25/2024

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
| fieldLookupChain | String | ,[object Object] |

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
| finalField | String | ,[object Object] |
| fieldParts | List&lt;String&gt; | ,[object Object] |

## Methods
### `getFieldParts()`

Get the field parts to look up

#### Signature
```apex
public List<String> getFieldParts()
```

#### Return Type
**List&lt;String&gt;**

,[object Object]

---

### `getFinalField()`

Get the final field to look up

#### Signature
```apex
public String getFinalField()
```

#### Return Type
**String**

,[object Object]