public with sharing class NextNQuartersParser extends DateLiteralParser {
    public override Intermediary parse(String query) {
        return parseNDays(query, Token.NEXT_N_QUARTERS_LITERAL);
    }
}