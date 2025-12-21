# WhereLogicComparisonResults Class
`virtual`

Contains the results of a where logic comparison

**Since**

11/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `getFinalField()`

Get the final field

#### Signature
```apex
public String getFinalField()
```

#### Return Type
**String**

,[object Object]

---

### `getIsPolymorphicTypeField()`

Get if the field is &quot;THE&quot; polymorphic type field

#### Signature
```apex
public Boolean getIsPolymorphicTypeField()
```

#### Return Type
**Boolean**

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

### `getRecordFieldValue()`

Get the record field value

#### Signature
```apex
public Object getRecordFieldValue()
```

#### Return Type
**Object**

,[object Object]

## Classes
### Builder Class

Builder class for WhereLogicComparisonResults

#### Methods
##### `setFinalField(finalField)`

Set the final field

###### Signature
```apex
public Builder setFinalField(String finalField)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| finalField | String |  |

###### Return Type
**Builder**

,[object Object]

---

##### `setRecordFieldValue(recordFieldValue)`

Set the record field value

###### Signature
```apex
public Builder setRecordFieldValue(Object recordFieldValue)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordFieldValue | Object |  |

###### Return Type
**Builder**

,[object Object]

---

##### `setIsPolymorphicTypeField(isPolymorphicTypeField)`

Set if the field is &quot;THE&quot; polymorphic type field

###### Signature
```apex
public Builder setIsPolymorphicTypeField(Boolean isPolymorphicTypeField)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| isPolymorphicTypeField | Boolean |  |

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

##### `build()`

Build the `WhereLogicComparisonResults`

###### Signature
```apex
public WhereLogicComparisonResults build()
```

###### Return Type
**[WhereLogicComparisonResults](WhereLogicComparisonResults.md)**

,[object Object]