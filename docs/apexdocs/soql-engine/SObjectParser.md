# SObjectParser Class

Parses an SObject name in a query

**Since** 

4/12/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[SubParser](SubParser.md)

## Methods
### `parse(query)`

Parses the object from the &#x27;from&#x27; clause

#### Signature
```apex
public override Intermediary parse(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |

#### Return Type
**[Intermediary](Intermediary.md)**

,[object Object]

---

### `setToken(token)`

*Inherited*

Sets the token for the parser

#### Signature
```apex
public void setToken(String token)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| token | String | `String` |

#### Return Type
**void**