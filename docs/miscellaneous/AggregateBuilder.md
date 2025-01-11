# AggregateBuilder Class

Creates Aggregate objects from ProtoAggregates

**Since** 

3/23/2024

**Author** Zackary Frazier

## Methods
### `setProtoAggregates(protoAggregates)`

Setter for proto-aggregates

#### Signature
```apex
public AggregateBuilder setProtoAggregates(List<ProtoAggregate> protoAggregates)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| protoAggregates | List&lt;ProtoAggregate&gt; | the proto-aggregates |

#### Return Type
**[AggregateBuilder](AggregateBuilder.md)**

the aggregate builder

---

### `setTopLevelNodes(topLevelNodes)`

sets the top level nodes

#### Signature
```apex
public AggregateBuilder setTopLevelNodes(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) | the top level nodes |

#### Return Type
**[AggregateBuilder](AggregateBuilder.md)**

the aggregate builder

---

### `setParams(params)`

sets the params

#### Signature
```apex
public AggregateBuilder setParams(Map<String,Object> params)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| params | Map&lt;String,Object&gt; | the bind params |

#### Return Type
**[AggregateBuilder](AggregateBuilder.md)**

the aggregate builder

---

### `build()`

Remove the fields that are not in the select clause

#### Signature
```apex
public List<Aggregate> build()
```

#### Return Type
**List&lt;Aggregate&gt;**

The cleaned up aggregate result list