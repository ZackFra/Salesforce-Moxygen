# QueryValidator Class

`SUPPRESSWARNINGS`

Validate the AST of a query, this does not validate the query against the schema, 
but rather checks for invalid queries that are not supported by the SOQL parser

## Constructors
### `QueryValidator(topLevelNodes)`

: Constructor

#### Signature
```apex
public QueryValidator(TopLevelNodes topLevelNodes)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| topLevelNodes | [TopLevelNodes](TopLevelNodes.md) | : the top level nodes of the query |

## Methods
### `validate()`

: given a select node, validate whether this query can be performed

#### Signature
```apex
public void validate()
```

#### Return Type
**void**

#### Throws
QueryException: : if the query is invalid