public inherited sharing class FieldParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        Map<String, String> dataMap = getFieldName(query);
        String fieldName = dataMap.get('fieldName');
        query = dataMap.get('subquery');
        
        Node head = new NodeBuilder()
            .setId(fieldName)
            .setNodeType('field')
            .build();

        return new Intermediary(head, query);
    }
}