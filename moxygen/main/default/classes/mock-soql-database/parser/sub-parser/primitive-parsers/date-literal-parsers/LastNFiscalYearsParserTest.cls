@isTest
public with sharing class LastNFiscalYearsParserTest {
    @isTest
    static void ensureLastNDaysIsParseable() {
        String tkn = 'LAST_N_FISCAL_YEARS:5';
        LastNFiscalYearsParser parser = new LastNFiscalYearsParser();
        Intermediary intermediary = parser.parse(tkn);

        Assert.areEqual('', intermediary.subquery, 'Subquery should be empty');
        Assert.areEqual(tkn.toLowerCase(), intermediary.head.id, 'Id should be last_n_fiscal_years:5');
        Assert.areEqual(NodeType.DATE_LITERAL, intermediary.head.nodeType, 'Node type should be DATE_LITERAL');
        Assert.isNull(intermediary.head.left, 'Left should be null');
        Assert.isNull(intermediary.head.right, 'Right should be null');
    }
}