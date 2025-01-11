# Aggregate Class

Aggregate class to represent the result of an aggregate query

**Since** 

4/5/2024

**Author** Zackary Frazier

## Constructors
### `Aggregate(ar)`

Standard constructor, creates an Aggregate object from an AggregateResult

#### Signature
```apex
public Aggregate(AggregateResult ar)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| ar | AggregateResult | the AggregateResult to create the Aggregate from |

---

### `Aggregate(data)`

Constructor for testing purposes, creates an Aggregate object from a Map

#### Signature
```apex
public Aggregate(Map<String,Object> data)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| data | Map&lt;String,Object&gt; | the data to create the Aggregate from |

---

### `Aggregate(ar)`

Constructor for testing purposes, creates an Aggregate object from a ProtoAggregate

#### Signature
```apex
public Aggregate(ProtoAggregate ar)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| ar | [ProtoAggregate](ProtoAggregate.md) |  |

## Methods
### `get(field)`

get the value of a field

#### Signature
```apex
public Object get(String field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | String | the field to get |

#### Return Type
**Object**

the value of the field

---

### `toString()`

get the value of the aggregate as a String

#### Signature
```apex
public override String toString()
```

#### Return Type
**String**

the value of the field as a string