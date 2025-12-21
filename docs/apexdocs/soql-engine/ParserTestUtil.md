# ParserTestUtil Class

`ISTEST`

Test utilites for the parser

**Since**

1/26/2025

**Group** Soql Engine

**Author** Zackary Frazier

## Methods
### `assertExceptionIsNotThrown(query)`

Given a query, this method will test it and check if an exception is not thrown

#### Signature
```apex
public static void assertExceptionIsNotThrown(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String |  |

#### Return Type
**void**

---

### `assertExceptionIsThrown(query)`

Given a query, this method will test it and check if an exception is thrown

#### Signature
```apex
public static void assertExceptionIsThrown(String query)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String |  |

#### Return Type
**void**

---

### `assertExceptionIsThrownWithMessage(query, message)`

Assert that an exception is thrown with a specific message

#### Signature
```apex
public static void assertExceptionIsThrownWithMessage(String query, String message)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| query | String | `String` |
| message | String | `String` |

#### Return Type
**void**

---

### `assertStaticResource(srName)`

Given a static resouce name, this method will parsse and compare its query 
against its listed AST

#### Signature
```apex
public static void assertStaticResource(String srName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| srName | String |  |

#### Return Type
**void**

---

### `assertStaticResources(srNames)`

Assert muliple static resources align with their queries

#### Signature
```apex
public static void assertStaticResources(List<String> srNames)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| srNames | List<String> |  |

#### Return Type
**void**