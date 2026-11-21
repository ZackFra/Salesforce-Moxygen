# ComparableRecordData Class
`virtual`

Encapsulates the data needed to compare records

**Since**

11/24/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `getComparableFieldName()`

Get the comparable field name

#### Signature
```apex
public String getComparableFieldName()
```

#### Return Type
**String**

`String`

---

### `getComparableRecord()`

Get the comparable record

#### Signature
```apex
public SObject getComparableRecord()
```

#### Return Type
**SObject**

`SObject`

---

### `getIsPolymorphic()`

Get whether the relationship is polymorphic

#### Signature
```apex
public Boolean getIsPolymorphic()
```

#### Return Type
**Boolean**

`Boolean`

---

### `getRelationshipName()`

Get the relationship name

#### Signature
```apex
public String getRelationshipName()
```

#### Return Type
**String**

`String`

## Classes
### Builder Class

Builder class for ComparableRecordData

#### Methods
##### `setComparableRecord(comparableRecord)`

Set the comparable record

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

`Builder`

---

##### `setComparableFieldName(comparableFieldName)`

Set the comparable field name

###### Signature
```apex
public Builder setComparableFieldName(String comparableFieldName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| comparableFieldName | String | `String` |

###### Return Type
**Builder**

`Builder`

---

##### `setRelationshipName(relationshipName)`

Set the relationship name

###### Signature
```apex
public Builder setRelationshipName(String relationshipName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| relationshipName | String | `String` |

###### Return Type
**Builder**

`Builder`

---

##### `setIsPolymorphic(isPolymorphic)`

Set whether the relationship is polymorphic

###### Signature
```apex
public Builder setIsPolymorphic(Boolean isPolymorphic)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| isPolymorphic | Boolean | `Boolean` |

###### Return Type
**Builder**

`Builder`

---

##### `build()`

Returns the built object

###### Signature
```apex
public ComparableRecordData build()
```

###### Return Type
**[ComparableRecordData](ComparableRecordData.md)**

`ComparableRecordData`