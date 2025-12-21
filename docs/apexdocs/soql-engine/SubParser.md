# SubParser Class
`abstract`

`SUPPRESSWARNINGS`

SubParser is an abstract class that provides helper methods for parsing subqueries.

**Since**

4/12/2024

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `parse(query)`

Parses a subquery and returns an `Intermediary` object.

#### Signature
```apex
public abstract Intermediary parse(String query)
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