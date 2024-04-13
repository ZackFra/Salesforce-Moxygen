public inherited sharing class UpdateTrackingOrViewStatParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(query.length() == 0) {
            return null;
        }
        if(lookahead(query, 6) != 'update') {
            return null;
        }
        
        query = consume(query, 'update ');
        query = skipWhitespace(query);

        if(lookahead(query, 8) != 'tracking' && lookahead(query, 4) != 'view') {
            return null;
        }

        String updateType = 'tracking';
        if(lookahead(query, 8) == 'viewstat') {
            updateType = 'viewstat';
        }

        query = consume(query, updateType);

        // so it is either UPDATE VIEW or UPDATE TRACKING
        throw new QueryException('UPDATE ' + updateType.toUpperCase() + ' is not supported by the mock SOQL parser');
    }
}