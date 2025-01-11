# ORM Class

ORM class is the state manager for the Moxygen library. 
It is responsble for managing the state of the library&#x27;s settings and context. 
It&#x27;s named ORM because Salesforce is an ORM, and unfortunately, the Database namespace 
is already taken.

**Group** Moxygen

## Methods
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