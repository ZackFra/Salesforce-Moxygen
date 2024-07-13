public class AccountService {

    public void updateAcctName(Id accountId) {

        Map<String, Object> binds = new Map<String, Object> {
            'acctId' => accountId
        };

        // one-to-one wrapper around Database.queryWithBinds
        List<Account> acctList = Selector.queryWithBinds(
            'SELECT Name FROM Account WHERE Id = :acctId',
            binds,
            AccessLevel.USER_MODE
        );

        for(Account acct : acctList) {
            acct.Name = 'WOOOO!!!!';
        }

        // one-to-one wrapper around Database.update
        DML.doUpdate(acctList, true);
    }
}