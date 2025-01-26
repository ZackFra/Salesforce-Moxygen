# Intermediary Class

: Class to hold the head of a parsed query and the remaining subquery

**Group** Soql Engine

## Fields
### `head`

#### Signature
```apex
public head
```

#### Type
[Node](Node.md)

---

### `subquery`

#### Signature
```apex
public subquery
```

#### Type
String

## Constructors
### `Intermediary(head, subquery)`

: Constructor for an Intermediary

#### Signature
```apex
public Intermediary(Node head, String subquery)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| head | [Node](Node.md) | : Node, the head of the parsed query |
| subquery | String | : String, the remaining subquery |