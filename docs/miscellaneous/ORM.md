# ORM Class

ORM class is responsible for creating and returning the Selector and DML objects 
ORM is short for Object Relationshal Mapping, i.e. Salesforce&#x27;s database

## Methods
### `isUnitTest()`

Returns if the current context is a unit test

#### Signature
```apex
public static Boolean isUnitTest()
```

#### Return Type
**Boolean**

,[object Object]

---

### `isBacktickReplacementEnabled()`

Returns whether backtick replacement is enabled

#### Signature
```apex
public static Boolean isBacktickReplacementEnabled()
```

#### Return Type
**Boolean**

,[object Object]

---

### `disableBacktickReplacement()`

Sets the isBacktickReplaceEnabled flag to false

#### Signature
```apex
public static void disableBacktickReplacement()
```

#### Return Type
**void**

---

### `enableBacktickReplacement()`

Sets the isBacktickReplaceEnabled flag to true

#### Signature
```apex
public static void enableBacktickReplacement()
```

#### Return Type
**void**

---

### `validateUnitTestContext()`

Validates that the current context is a unit test

#### Signature
```apex
public static void validateUnitTestContext()
```

#### Return Type
**void**

#### Throws
NoAccessException: