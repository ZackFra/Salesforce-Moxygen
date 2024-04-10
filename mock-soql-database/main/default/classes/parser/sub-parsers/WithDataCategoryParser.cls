public with sharing class WithDataCategoryParser extends SubParser {
    public override Intermediary parse(String query) {
        query = skipWhitespace(query);
        if(lookahead(query, 4) == 'with') {
            throw new QueryException('WITH [DATA CATEGORY] is not supported by the mock SOQL parser');
        }
        return null;
    }
}