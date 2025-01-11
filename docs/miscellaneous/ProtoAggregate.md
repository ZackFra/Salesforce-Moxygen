# ProtoAggregate Class

before we create an aggregate, wean a proto-aggregate, 
i.e. a Map&lt;String, Object&gt; that will be used to store the aggregate

**Since** 

3/23/2024

**Author** Zackary Frazier

## Fields
### `prototype`

#### Signature
```apex
public prototype
```

#### Type
Map&lt;String,Object&gt;

## Constructors
### `ProtoAggregate(prototype)`

Constructor

#### Signature
```apex
public ProtoAggregate(Map<String,Object> prototype)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| prototype | Map&lt;String,Object&gt; |  |

---

### `ProtoAggregate()`

Constructor

#### Signature
```apex
public ProtoAggregate()
```

## Methods
### `put(key, value)`

put a key-value pair in the proto-aggregate

#### Signature
```apex
public void put(String key, Object value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String |  |
| value | Object |  |

#### Return Type
**void**

---

### `get(key)`

get a value from the proto-aggregate

#### Signature
```apex
public Object get(String key)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String |  |

#### Return Type
**Object**

,[object Object]

---

### `remove(key)`

remove a key-value pair from the proto-aggregate

#### Signature
```apex
public void remove(String key)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String |  |

#### Return Type
**void**

---

### `clear()`

clear the proto-aggregate

#### Signature
```apex
public void clear()
```

#### Return Type
**void**

---

### `size()`

get the size of the proto-aggregate

#### Signature
```apex
public Integer size()
```

#### Return Type
**Integer**

,[object Object]

---

### `isEmpty()`

check if the proto-aggregate is empty

#### Signature
```apex
public Boolean isEmpty()
```

#### Return Type
**Boolean**

,[object Object]

---

### `containsKey(key)`

check if the proto-aggregate contains a key

#### Signature
```apex
public Boolean containsKey(String key)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| key | String |  |

#### Return Type
**Boolean**

,[object Object]

---

### `keySet()`

check if the proto-aggregate contains a value

#### Signature
```apex
public Set<String> keySet()
```

#### Return Type
**Set&lt;String&gt;**

,[object Object]

---

### `values()`

get the values of the proto-aggregate

#### Signature
```apex
public List<Object> values()
```

#### Return Type
**List&lt;Object&gt;**

,[object Object]

---

### `getPrototype()`

Returns the proto-aggregate as a `Map<String, Object>`

#### Signature
```apex
public Map<String,Object> getPrototype()
```

#### Return Type
**Map&lt;String,Object&gt;**

,[object Object]

---

### `getRecords()`

Gets the internal list of records that comprise of this proto-aggregate

#### Signature
```apex
public List<SObject> getRecords()
```

#### Return Type
**List&lt;SObject&gt;**

,[object Object]

---

### `addRecord(record)`

Adds a record to the internal list of records

#### Signature
```apex
public void addRecord(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject | `SObject` |

#### Return Type
**void**