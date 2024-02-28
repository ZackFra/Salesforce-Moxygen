Account acct = new Account(
    Id = '0011a00000Bb9ZzAAJ',
    Name = 'Test Account'
);

System.debug(Database.insert(acct, true));