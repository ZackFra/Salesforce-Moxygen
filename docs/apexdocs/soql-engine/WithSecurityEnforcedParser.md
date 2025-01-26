# WithSecurityEnforcedParser Class

This class is responsible for parsing the WITH SECURITY_ENFORCED clause in a SOQL query.

**Since** 

4/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[SubParser](SubParser.md)

## Methods
### `parse(query)`

Parses the WITH SECURITY_ENFORCED clause in a SOQL query

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