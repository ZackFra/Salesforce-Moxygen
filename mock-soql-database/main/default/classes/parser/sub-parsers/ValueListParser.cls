public inherited sharing class ValueListParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        
        Intermediary value = new ValueParser().parse(query);
        query = value.subquery;
        query = skipWhitespace(query);
        
        if(lookahead(query, 1) == ',') {
            query = consume(query, ',');
            Intermediary restOfList = parse(query);
            value.head.left = restOfList.head;
            value.subquery = restOfList.subquery;
        }
        query = value.subquery;
        return new Intermediary(
            new NodeBuilder()
            .setId('value list')
            .setNodeType('value list')
            .setLeft(value.head)
            .build(),
            query
        );
    }
}