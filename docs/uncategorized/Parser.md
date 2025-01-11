# Parser Class

`SUPPRESSWARNINGS`

The parser breaks down a SOQL query into an AST, to be fed into the parser (MockDatabase)

**Since** 

4/6/2024

**Author** Zackary Frazier

## Methods
### `parse(query)`

: Parses a trimmed SOQL query into an AST

#### Signature
```apex
public Node parse(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | : String, the query to parse |

#### Return Type
**[Node](Node.md)**

: Node, the head of the AST