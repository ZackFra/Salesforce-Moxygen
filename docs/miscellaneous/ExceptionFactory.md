# ExceptionFactory Class

Factory class for creating exceptions

**Since** 

11/24/2024

**Author** Zackary Frazier

## Methods
### `createIllegalFieldNameException(fieldName)`

Generates an `IllegalArgumentException` for an invalid field name

#### Signature
```apex
public static IllegalArgumentException createIllegalFieldNameException(String fieldName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| fieldName | String | `String` |

#### Return Type
**IllegalArgumentException**

,[object Object]

---

### `createIllegalNullException(argName)`

Generates an `IllegalArgumentException` for a null argument

#### Signature
```apex
public static IllegalArgumentException createIllegalNullException(String argName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| argName | String | `String` |

#### Return Type
**IllegalArgumentException**

,[object Object]

---

### `createIllegalDateFormatException(dateFormat)`

Generates an `IllegalArgumentException` for an invalid date format

#### Signature
```apex
public static IllegalArgumentException createIllegalDateFormatException(String dateFormat)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dateFormat | String | `String` |

#### Return Type
**IllegalArgumentException**

,[object Object]

---

### `createIllegalDateTimeFormatException(dateTimeFormat)`

Generates an `IllegalArgumentException` for an invalid date time format

#### Signature
```apex
public static IllegalArgumentException createIllegalDateTimeFormatException(String dateTimeFormat)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dateTimeFormat | String | `String` |

#### Return Type
**IllegalArgumentException**

,[object Object]

---

### `createIllegalTimeFormatException(timeFormat)`

Generates an `IllegalArgumentException` for an invalid time format

#### Signature
```apex
public static IllegalArgumentException createIllegalTimeFormatException(String timeFormat)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| timeFormat | String | `String` |

#### Return Type
**IllegalArgumentException**

,[object Object]