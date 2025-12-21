# AggregateQueryHandler Class

This class is responsible for handling the aggregate queries

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Constructors
### `AggregateQueryHandler(topLevelNodes)`

Constructor

#### Signature
```apex
public AggregateQueryHandler(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) |  |

#### Throws
AggregateQueryException: 

## Methods
### `finish()`

Finish the processing of the aggregate query

#### Signature
```apex
public List<ProtoAggregate> finish()
```

#### Return Type
**List<ProtoAggregate>**

,[object Object]

---

### `processRecord(databaseRecord)`

Process the record

#### Signature
```apex
public void processRecord(SObject databaseRecord)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| databaseRecord | SObject |  |

#### Return Type
**void**

## Classes
### AggregateQueryException Class

Exception class for Aggregate Query