# QueriedFieldResolver Class
`virtual`

This class is used to resolve the field in a query

**Since** 

11/24/2024

**Author** Zackary Frazier

## Methods
### `resolve()`

Resolves the comparable record data from a queried field lookup chain string

#### Signature
```apex
public ComparableRecordData resolve()
```

#### Return Type
**[ComparableRecordData](ComparableRecordData.md)**

,[object Object]

## Classes
### Builder Class

This class is used to build a `QueriedFieldResolver`

**Implements**

[IBuilder](../interfaces/IBuilder.md)

#### Methods
##### `setFieldLookupChain(fieldLookupChain)`

Sets the field lookup chain

###### Signature
```apex
public Builder setFieldLookupChain(String fieldLookupChain)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldLookupChain | String | `String` |

###### Return Type
**Builder**

,[object Object]

---

##### `setComparableRecord(comparableRecord)`

Sets the comparable record

###### Signature
```apex
public Builder setComparableRecord(SObject comparableRecord)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| comparableRecord | SObject | `SObject` |

###### Return Type
**Builder**

,[object Object]

---

##### `build()`

Builds the `QueriedFieldResolver`

###### Signature
```apex
public QueriedFieldResolver build()
```

###### Return Type
**[QueriedFieldResolver](QueriedFieldResolver.md)**

,[object Object]