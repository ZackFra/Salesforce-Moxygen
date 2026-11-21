# ParentLookupResolver Class

A class to resolve a parent lookup chain

**Since**

11/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `splitParentLookupChain(fieldLookupChain)`

split a parent lookup chain into its parts

#### Signature
```apex
public ParentLookupChain splitParentLookupChain(String fieldLookupChain)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldLookupChain | String | `String` |

#### Return Type
**[ParentLookupChain](ParentLookupChain.md)**

`ParentLookupChain`

## Classes
### ParentLookupChain Class

A class to resolve a parent lookup chain

#### Constructors
##### `ParentLookupChain(finalField, fieldParts)`

Constructor for a parent lookup chain

###### Signature
```apex
public ParentLookupChain(String finalField, List<String> fieldParts)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| finalField | String | `String` |
| fieldParts | List<String> | `List<String>` |

#### Methods
##### `getFinalField()`

Get the final field

###### Signature
```apex
public String getFinalField()
```

###### Return Type
**String**

`String`

---

##### `getFieldParts()`

Get the field parts

###### Signature
```apex
public List<String> getFieldParts()
```

###### Return Type
**List<String>**

`List<String>`