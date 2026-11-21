# ParentRecordData Class
`virtual`

A class to store data about a parent record

**Since**

11/28/2024

**Group** Soql Engine

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

`String`

---

### `getFieldRelationshipName()`

Get the field relationship name

#### Signature
```apex
public String getFieldRelationshipName()
```

#### Return Type
**String**

`String`

---

### `getIsPolymorphic()`

Get if the relationship is polymorphic

#### Signature
```apex
public Boolean getIsPolymorphic()
```

#### Return Type
**Boolean**

`Boolean`

---

### `getObjApiName()`

Get the object API name

#### Signature
```apex
public String getObjApiName()
```

#### Return Type
**String**

`String`

---

### `getParentObjApiName()`

Get the parent object API name

#### Signature
```apex
public String getParentObjApiName()
```

#### Return Type
**String**

`String`

---

### `getParentRecord()`

Get the parent record

#### Signature
```apex
public SObject getParentRecord()
```

#### Return Type
**SObject**

`SObject`

---

### `getParentRecordId()`

Get the parent record Id

#### Signature
```apex
public Id getParentRecordId()
```

#### Return Type
**Id**

`Id`

## Classes
### Builder Class

Builder for ParentRecordData

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

`Builder`

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

`Builder`

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

`Builder`

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

`Builder`

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

`Builder`

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

`Builder`

---

##### `build()`

Build the ParentRecordData

###### Signature
```apex
public ParentRecordData build()
```

###### Return Type
**[ParentRecordData](ParentRecordData.md)**

`ParentRecordData`