# ParentRecordData Class
`virtual`

A class to store data about a parent record

**Since** 

11/28/2024

**Author** Zackary Frazier

## Methods
### `getFieldApiName()`

Get the field API name

#### Signature
```apex
public String getFieldApiName()
```

#### Return Type
**String**

,[object Object]

---

### `getFieldRelationshipName()`

Get the field relationship name

#### Signature
```apex
public String getFieldRelationshipName()
```

#### Return Type
**String**

,[object Object]

---

### `getIsPolymorphic()`

Get if the relationship is polymorphic

#### Signature
```apex
public Boolean getIsPolymorphic()
```

#### Return Type
**Boolean**

,[object Object]

---

### `getObjApiName()`

Get the object API name

#### Signature
```apex
public String getObjApiName()
```

#### Return Type
**String**

,[object Object]

---

### `getParentObjApiName()`

Get the parent object API name

#### Signature
```apex
public String getParentObjApiName()
```

#### Return Type
**String**

,[object Object]

---

### `getParentRecord()`

Get the parent record

#### Signature
```apex
public SObject getParentRecord()
```

#### Return Type
**SObject**

,[object Object]

---

### `getParentRecordId()`

Get the parent record Id

#### Signature
```apex
public Id getParentRecordId()
```

#### Return Type
**Id**

,[object Object]

## Classes
### Builder Class

Builder for ParentRecordData

**Implements**

[IBuilder](../interfaces/IBuilder.md)

#### Methods
##### `setFieldApiName(fieldApiName)`

Set the field API name

###### Signature
```apex
public Builder setFieldApiName(String fieldApiName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldApiName | String |  |

###### Return Type
**Builder**

,[object Object]

---

##### `setFieldRelationshipName(fieldRelationshipName)`

Set the field relationship name

###### Signature
```apex
public Builder setFieldRelationshipName(String fieldRelationshipName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldRelationshipName | String |  |

###### Return Type
**Builder**

,[object Object]

---

##### `setParentObjApiName(parentObjApiName)`

Set the parent object API name

###### Signature
```apex
public Builder setParentObjApiName(String parentObjApiName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| parentObjApiName | String |  |

###### Return Type
**Builder**

,[object Object]

---

##### `setObjApiName(objApiName)`

Set the object API name

###### Signature
```apex
public Builder setObjApiName(String objApiName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| objApiName | String |  |

###### Return Type
**Builder**

,[object Object]

---

##### `setParentRecord(parentRecord)`

Set the parent record

###### Signature
```apex
public Builder setParentRecord(SObject parentRecord)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| parentRecord | SObject |  |

###### Return Type
**Builder**

,[object Object]

---

##### `setIsPolymorphic(isPolymorphic)`

Set if the relationship is polymorphic

###### Signature
```apex
public Builder setIsPolymorphic(Boolean isPolymorphic)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| isPolymorphic | Boolean |  |

###### Return Type
**Builder**

,[object Object]

---

##### `build()`

Build the ParentRecordData

###### Signature
```apex
public ParentRecordData build()
```

###### Return Type
**[ParentRecordData](ParentRecordData.md)**

,[object Object]