# ParserUtils Class

Contains utility methods for the parser, could probably be refactored out of existance though

**Since** 

3/23/2024

**Author** Zackary Frazier

## Methods
### `applyCasing(head)`

Lowercases every node&#x27;s id that isn&#x27;t an alias

#### Signature
```apex
public static void applyCasing(Node head)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| head | [Node](Node.md) | `Node` |

#### Return Type
**void**

---

### `consume(query, token)`

: Consumes the first token in the query if it matches the token

#### Signature
```apex
public static String consume(String query, String token)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | : String, the query to consume |
| token | String | : String, the token to consume |

#### Return Type
**String**

: String, the query with the token consumed

#### Throws
[ParsingException](ParsingException.md): : if the token is not the first token in the query

---

### `isNext(query, token)`

Returns whether the query has the token as the next token

#### Signature
```apex
public static Boolean isNext(String query, String token)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| token | String | `String` |

#### Return Type
**Boolean**

,[object Object]

---

### `lookahead(query, numChars)`

: Look ahead at the next numChars characters in the query

#### Signature
```apex
public static String lookahead(String query, Integer numChars)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | : String, the query to look ahead in |
| numChars | Integer | : Integer, the number of characters to look ahead |

#### Return Type
**String**

: String, the next numChars characters in the query

---

### `lookahead(query, numChars, isCaseSensitive)`

Look ahead at the next numChars characters in the query, with case sensitivity

#### Signature
```apex
public static String lookahead(String query, Integer numChars, Boolean isCaseSensitive)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| numChars | Integer | `Integer` |
| isCaseSensitive | Boolean | `Boolean` |

#### Return Type
**String**

,[object Object]

---

### `skipWhitespace(query)`

Skips whitespace in a query string

#### Signature
```apex
public static String skipWhitespace(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |

#### Return Type
**String**

,[object Object]

---

### `validCharForFieldOrObject(character)`

Checks if a character is a valid character for a field or object name

#### Signature
```apex
public static Boolean validCharForFieldOrObject(String character)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| character | String | `String` |

#### Return Type
**Boolean**

,[object Object]