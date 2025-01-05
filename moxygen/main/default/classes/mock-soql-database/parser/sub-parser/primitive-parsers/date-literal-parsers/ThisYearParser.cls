public with sharing class ThisYearParser extends DateLiteralParser {
    public override Intermediary parse(String query) {
        return parse(query, Token.THIS_YEAR_LITERAL);
    }
}