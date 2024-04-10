public inherited sharing class FromParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        query = consume(query, 'from ');
        
        
        Intermediary leftIntermediary = parseObj(query);
		
        return new Intermediary(
        	new NodeBuilder()
            	.setId('from')
            	.setNodeType('from')
            	.setLeft(leftIntermediary.head)
            	.build(),
            leftIntermediary.subquery
        );
    }

    private Intermediary parseObj(String query) {
        query = skipWhitespace(query);
        String objectName = '';
        while(query.length() != 0 && (ParserUtils.validCharForFieldOrObject(query.subString(0, 1)))) {
            objectName += query.subString(0, 1);
            query = query.subString(1);
        }
        return new Intermediary(
        	new NodeBuilder()
            	.setId(objectName)
            	.setNodeType('object')
            	.build(),
            query
        );
    }
}