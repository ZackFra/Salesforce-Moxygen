# SObjectComparator Class

This class is used to compare two SObjects based on the fields provided in the constructor.

**Since**

3/23/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Implements**

Comparator<SObject>

## Constructors
### `SObjectComparator(fields)`

Constructor

#### Signature
```apex
public SObjectComparator(Map<String,Map<String,String>> fields)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fields | Map<String,Map<String,String>> | A map of field names and whether they&#x27;re ASC or DESC |

## Methods
### `compare(a, b)`

`SUPPRESSWARNINGS`

Compare two SObjects based on the fields provided in the constructor

#### Signature
```apex
public Integer compare(SObject a, SObject b)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| a | SObject | The first SObject |
| b | SObject | The second SObject |

#### Return Type
**Integer**

Integer