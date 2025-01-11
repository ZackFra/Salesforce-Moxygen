# RelationshipBuilder Class

RelationshipBuilder class to build parent and child relationships

**Group** Moxygen

## Methods
### `relateChildren()`

Create a new ChildRelationshipBuilder instance

#### Signature
```apex
public ChildRelationshipBuilder relateChildren()
```

#### Return Type
**ChildRelationshipBuilder**

ChildRelationshipBuilder

---

### `relateParent()`

Create a new ParentRelationshipBuilder instance

#### Signature
```apex
public ParentRelationshipBuilder relateParent()
```

#### Return Type
**ParentRelationshipBuilder**

ParentRelationshipBuilder

## Classes
### ParentRelationshipBuilder Class

ParentRelationshipBuilder class to build parent relationships

#### Methods
##### `setParent(parent)`

Set the parent SObject to be related

###### Signature
```apex
public ParentRelationshipBuilder setParent(SObject parent)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| parent | SObject | SObject to be related |

###### Return Type
**ParentRelationshipBuilder**

ParentRelationshipBuilder

---

##### `setChild(child)`

Set the child SObject to be related

###### Signature
```apex
public ParentRelationshipBuilder setChild(SObject child)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| child | SObject | SObject to be related |

###### Return Type
**ParentRelationshipBuilder**

ParentRelationshipBuilder

---

##### `setRelationshipName(relationshipName)`

Set the relationship name

###### Signature
```apex
public ParentRelationshipBuilder setRelationshipName(String relationshipName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| relationshipName | String | Relationship name |

###### Return Type
**ParentRelationshipBuilder**

ParentRelationshipBuilder

---

##### `setRelationshipField(relationshipField)`

Set the relationship field

###### Signature
```apex
public ParentRelationshipBuilder setRelationshipField(String relationshipField)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| relationshipField | String | Relationship field |

###### Return Type
**ParentRelationshipBuilder**

ParentRelationshipBuilder

---

##### `build()`

Build the parent relationship

###### Signature
```apex
public SObject build()
```

###### Return Type
**SObject**

SObject

###### Throws
IllegalArgumentException: 

### ChildRelationshipBuilder Class

ChildRelationshipBuilder class to build child relationships

#### Methods
##### `setParent(parent)`

Set the parent SObject to be related

###### Signature
```apex
public ChildRelationshipBuilder setParent(SObject parent)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| parent | SObject | SObject to be related |

###### Return Type
**ChildRelationshipBuilder**

ChildRelationshipBuilder

---

##### `setChildren(children)`

Set the children SObjects to be related

###### Signature
```apex
public ChildRelationshipBuilder setChildren(List<SObject> children)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| children | List&lt;SObject&gt; | SObjects to be related |

###### Return Type
**ChildRelationshipBuilder**

ChildRelationshipBuilder

---

##### `setRelationshipName(relationshipName)`

Set the relationship name

###### Signature
```apex
public ChildRelationshipBuilder setRelationshipName(String relationshipName)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| relationshipName | String | Relationship name |

###### Return Type
**ChildRelationshipBuilder**

ChildRelationshipBuilder

---

##### `setRelationshipField(relationshipField)`

Set the relationship field

###### Signature
```apex
public ChildRelationshipBuilder setRelationshipField(String relationshipField)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| relationshipField | String | Relationship field |

###### Return Type
**ChildRelationshipBuilder**

ChildRelationshipBuilder

---

##### `build()`

Build the child relationship

###### Signature
```apex
public SObject build()
```

###### Return Type
**SObject**

SObject

###### Throws
IllegalArgumentException: