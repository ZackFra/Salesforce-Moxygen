# Regex Class

A class to handle regex operations

**Since** 

11/27/2024

**Author** Zackary Frazier

## Methods
### `matches(str, regexPattern)`

Returns whether a string matches a regex pattern

#### Signature
```apex
public Boolean matches(String str, String regexPattern)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| str | String | `String` |
| regexPattern | String | `String` |

#### Return Type
**Boolean**

,[object Object]

---

### `getGroups(str, regexPattern)`

Get the groups from a regex pattern

#### Signature
```apex
public List<String> getGroups(String str, String regexPattern)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| str | String | `String` |
| regexPattern | String | `String` |

#### Return Type
**List&lt;String&gt;**

,[object Object]