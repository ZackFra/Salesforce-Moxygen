# QueryParser Class

`SUPPRESSWARNINGS`

This class is responsible for parsing a SOQL query

**Since** 

4/12/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[SubParser](SubParser.md)

## Methods
### `parse(query)`

`SUPPRESSWARNINGS`

Parses a SOQL query

#### Signature
```apex
public override Intermediary parse(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String |  |

#### Return Type
**[Intermediary](Intermediary.md)**

,[object Object]

#### Throws
[ParsingException](../exceptions/ParsingException.md): 

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