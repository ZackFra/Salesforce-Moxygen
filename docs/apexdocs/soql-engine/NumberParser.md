# NumberParser Class

NumberParser is a parser for numeric values.

**Since** 

11/28/2024

**Group** Soql Engine

**Author** Zackary Frazier

**Inheritance**

[SubParser](SubParser.md)

## Methods
### `parse(query)`

Parses a numeric value from a query string.

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

#### Throws
[ParsingException](../utilities/ParsingException.md): 

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