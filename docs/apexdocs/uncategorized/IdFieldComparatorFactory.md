# IdFieldComparatorFactory Class

Returns a comparator for the given field types, compares ID fields (i.e. ID, Reference)

**Since** 

3/23/2024

**Author** Zackary Frazier

## Methods
### `create(field1, field2)`

`SUPPRESSWARNINGS`

Creates a comparator for the given field types

#### Signature
```apex
public static Comparator<Schema.SObjectField> create(Schema.SObjectField field1, Schema.SObjectField field2)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field1 | Schema.SObjectField |  |
| field2 | Schema.SObjectField |  |

#### Return Type
**Comparator&lt;Schema.SObjectField&gt;**

,[object Object]

#### Throws
IllegalArgumentException: