# Common Class

Common utility class for basic operations, should not contain complex code

**Since**

3/22/2024

**Group** Utilities

**Author** Zackary Frazier

## Methods
### `dateTimeToApexString(dt)`

Converts a date time to an Apex string

#### Signature
```apex
public static String dateTimeToApexString(DateTime dt)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dt | DateTime | - DateTime |

#### Return Type
**String**

String - Apex date time string

---

### `dateTimeToSoqlString(dt)`

Converts a date time to a SOQL string

#### Signature
```apex
public static String dateTimeToSoqlString(DateTime dt)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dt | DateTime | - DateTime |

#### Return Type
**String**

String - SOQL date time string

---

### `dateToSoqlString(d)`

Converts a date to a SOQL string

#### Signature
```apex
public static String dateToSoqlString(Date d)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| d | Date | - Date |

#### Return Type
**String**

String - SOQL date string

---

### `mapFromRecord(record)`

Converts an SObject to a map

#### Signature
```apex
public static Map<String,Object> mapFromRecord(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject | `SObject` |

#### Return Type
**Map<String,Object>**

,[object Object]

---

### `nullCheck(args)`

Method to check if a field is null

#### Signature
```apex
public static void nullCheck(Map<String,Object> args)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| args | Map<String,Object> | - Argument object containing the field and field name |

#### Return Type
**void**

#### Throws
IllegalArgumentException: if the field is null

---

### `parseDate(dateString)`

parse a date string into an SF date

#### Signature
```apex
public static Date parseDate(String dateString)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dateString | String | - date string in the format YYYY-MM-DD |

#### Return Type
**Date**

,[object Object], - SF date

#### Throws
QueryException: if the date string is not in the correct format

---

### `parseDateTime(dateTimeString)`

`SUPPRESSWARNINGS`

parse a date time string into an SF date time

#### Signature
```apex
public static DateTime parseDateTime(String dateTimeString)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| dateTimeString | String | - date time string in one of the three formats |

#### Return Type
**DateTime**

DateTime - SF date time

#### Throws
QueryException: if the date time string is not in the correct format

---

### `parseTime(timeString)`

parse a time string into an SF time

#### Signature
```apex
public static Time parseTime(String timeString)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| timeString | String | - time string in the format hh:mm:ss.SSSZ |

#### Return Type
**Time**

Time - SF time

#### Throws
IllegalArgumentException: if the time string is not in the correct format

---

### `putReadOnlyField(record, fieldName, value)`

Puts a value into a read-only field of an SObject

#### Signature
```apex
public static SObject putReadOnlyField(SObject record, String fieldName, Object value)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject | `SObject` |
| fieldName | String | `String` |
| value | Object | `Object` |

#### Return Type
**SObject**

,[object Object]

---

### `putReadOnlyFields(record, fieldValuePairs)`

Puts a map of values into read-only fields of an SObject

#### Signature
```apex
public static SObject putReadOnlyFields(SObject record, Map<String,Object> fieldValuePairs)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject | `SObject` |
| fieldValuePairs | Map<String,Object> | `Map<String, Object>` |

#### Return Type
**SObject**

,[object Object]

---

### `recordFromMap(recordMap, sObjectType)`

Converts a Map&lt;String, Object&gt; to an SObject

#### Signature
```apex
public static SObject recordFromMap(Map<String,Object> recordMap, String sObjectType)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| recordMap | Map<String,Object> | `Map<String, Object>` |
| sObjectType | String | `String` |

#### Return Type
**SObject**

,[object Object]