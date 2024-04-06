/**
 * @description This class is used to create test data for the test classes
 */
@IsTest
public class TestDataFactory {

    final static Integer SALESFORCE_INTEGRATION_LICENSES = 1;
    final static Integer SALESFORCE_LICENSES = 2;
    final static Integer ANALYTICS_CLOUD_LICENSES = 3;
    final static Integer ANALYTICS_CLOUD_INTEGRATION_LICENSES = 2;
    final static Integer CHATTER_FREE_LICENSES = 5000;
    final static Integer EXTERNAL_APPS_LICENSES = 20;
    final static Integer SALESFORCE_PLATFORM_LICENSES = 3;
    final static Integer CUSTOMER_COMMUNITY_LOGIN_LICENSES = 5;
    final static Integer XORG_PROXY_LICENSES = 2;
    final static Integer WORK_COM_LICENSES = 3;
    final static Integer CUSTOMER_PORTAL_MANAGER_CUSTOM_LICENSES = 5;
    final static Integer IDENTITY_LICENSES = 10;
    final static Integer CUSTOMER_COMMUNITY_PLUS_LICENSES = 5;
    final static Integer FORCE_COM_APP_SUBSCRIPTION_LICENSES = 5;
    final static Integer CUSTOMER_COMMUNITY_PLUS_LOGIN_LICENSES = 5;
    final static Integer PARTNER_APP_SUBSCRIPTION_LICENSES = 5;
    final static Integer EXTERNAL_IDENTITY_LICENSES = 5;
    final static Integer PARTNER_COMMMUNITY_LICENSES = 5;
    final static Integer PARTNER_COMMUNITY_LOGIN_LICENSES = 5;
    final static Integer CUSTOMER_COMMUNITY_LICENSES = 5;
    final static Integer FORCE_COM_FREE_LICENSES = 2;
    final static Integer CHATTER_EXTERNAL_LICENSES = 500;
    final static Integer HIGH_VOLUME_CUSTOMER_PORTAL_LICENSES = 10;
    final static Integer AUTHENTICATE_WEBSITE_LICENSES = 10;
    final static Integer EXTERNAL_APPS_LOGIN_LICENSES = 20;
    final static Integer CHATTER_MODERATOR_LICENSES = 10;
    final static Integer CUSTOMER_PORTAL_MANAGER_STANDARD_LICENSES = 5;
    final static Integer SILVER_PARTNER_LICENSES = 5;

    final static List<UserLicenseData> USER_LICENSE_DATA = new List<UserLicenseData> {
        new UserLicenseData('Salesforce Integration', SALESFORCE_INTEGRATION_LICENSES),
        new UserLicenseData('Salesforce', SALESFORCE_LICENSES),
        new UserLicenseData('Analytics Cloud', ANALYTICS_CLOUD_LICENSES),
        new UserLicenseData('Chatter Free', CHATTER_FREE_LICENSES),
        new UserLicenseData('External Apps', EXTERNAL_APPS_LICENSES),
        new UserLicenseData('Salesforce Platform', SALESFORCE_PLATFORM_LICENSES),
        new UserLicenseData('Customer Community Login', CUSTOMER_COMMUNITY_LOGIN_LICENSES),
        new UserLicenseData('XOrg Proxy User', XORG_PROXY_LICENSES),
        new UserLicenseData('Work.com', WORK_COM_LICENSES),
        new UserLicenseData('Customer Portal Manager Custom', CUSTOMER_PORTAL_MANAGER_CUSTOM_LICENSES),
        new UserLicenseData('Identity', IDENTITY_LICENSES),
        new UserLicenseData('Customer Community Plus', CUSTOMER_COMMUNITY_PLUS_LICENSES),
        new UserLicenseData('Force.com App Subscription', FORCE_COM_APP_SUBSCRIPTION_LICENSES),
        new UserLicenseData('Customer Community Plus Login', CUSTOMER_COMMUNITY_PLUS_LOGIN_LICENSES),
        new UserLicenseData('Partner App Subscription', PARTNER_APP_SUBSCRIPTION_LICENSES),
        new UserLicenseData('External Identity', EXTERNAL_IDENTITY_LICENSES),
        new UserLicenseData('Partner Community', PARTNER_COMMMUNITY_LICENSES),
        new UserLicenseData('Partner Community Login', PARTNER_COMMUNITY_LOGIN_LICENSES),
        new UserLicenseData('Customer Community', CUSTOMER_COMMUNITY_LICENSES),
        new UserLicenseData('Force.com Free', FORCE_COM_FREE_LICENSES),
        new UserLicenseData('Chatter External', CHATTER_EXTERNAL_LICENSES),
        new UserLicenseData('High Volume Customer Portal', HIGH_VOLUME_CUSTOMER_PORTAL_LICENSES),
        new UserLicenseData('Analytics Cloud Integration', ANALYTICS_CLOUD_INTEGRATION_LICENSES),
        new UserLicenseData('Authenticated Website', AUTHENTICATE_WEBSITE_LICENSES),
        new UserLicenseData('External Apps Login', EXTERNAL_APPS_LOGIN_LICENSES),
        new UserLicenseData('Chatter Moderator', CHATTER_MODERATOR_LICENSES),
        new UserLicenseData('Customer Portal Manager Standard', CUSTOMER_PORTAL_MANAGER_STANDARD_LICENSES),
        new UserLicenseData('Silver Partner', SILVER_PARTNER_LICENSES)
    };


    final static List<ProfileData> PROFILE_DATA = new List<ProfileData> {
        new ProfileData('Analytics Cloud Integration User', 'Salesforce'),
        new ProfileData('Analytics Cloud Security User', 'Salesforce'),
        new ProfileData('Authenticated Website', 'Authenticated Website'),
        new ProfileData('B2B Reordering Portal Buyer Profile', 'External Apps Login'),
        new ProfileData('Chatter External User', 'Chatter External'),
        new ProfileData('Chatter Free User', 'Chatter Free'),
        new ProfileData('Chatter Moderator User', 'Chatter Moderator'),
        new ProfileData('Contract Manager', 'Salesforce'),
        new ProfileData('Cross Org Data Proxy User', 'XOrg Proxy User'),
        new ProfileData('Custom: Marketing Profile', 'Salesforce'),
        new ProfileData('Custom: Sales Profile', 'Salesforce'),
        new ProfileData('Custom: Support Profile', 'Salesforce'),
        new ProfileData('Customer Community Login User', 'Customer Community Login'),
        new ProfileData('Customer Community Plus Login User', 'Customer Community Plus Login'),
        new ProfileData('Customer Community Plus User', 'Customer Community Plus'),
        new ProfileData('Customer Community User', 'Customer Community'),
        new ProfileData('Customer Portal Manager Custom', 'Customer Portal Manager Custom'),
        new ProfileData('Customer Portal Manager Standard', 'Customer Portal Manager Standard'),
        new ProfileData('External Apps Login User', 'External Apps'),
        new ProfileData('External Identity User', 'External Identity'),
        new ProfileData('Force.com - App Subscription User', 'Force.com App Subscription'),
        new ProfileData('Force.com - Free User', 'Force.com Free'),
        new ProfileData('Gold Partner User', 'Partner Community'),
        new ProfileData('High Volume Customer User', 'High Volume Customer Portal'),
        new ProfileData('Identity User', 'Identity'),
        new ProfileData('Marketing User', 'Salesforce'),
        new ProfileData('Minimum Access - API Only Integrations', 'Salesforce Integration'),
        new ProfileData('Minimum Access - Salesforce', 'Salesforce'),
        new ProfileData('Partner App Subscription User', 'Partner App Subscription'),
        new ProfileData('Partner Community Login User', 'Partner Community Login'),
        new ProfileData('Partner Community User', 'Partner Community'),
        new ProfileData('Read Only', 'Salesforce'),
        new ProfileData('Salesforce API Only System Integrations', 'Salesforce Integration'),
        new ProfileData('Silver Partner User', 'Silver Partner'),
        new ProfileData('Solution Manager', 'Salesforce'),
        new ProfileData('Standard Platform User', 'Salesforce Platform'),
        new ProfileData('Standard User', 'Salesforce'),
        new ProfileData('System Administrator', 'Salesforce'),
        new ProfileData('Work.com Only User', 'Work.com')
    };

    /**
     * @description create a standard set of accounts for testing,
     * creates the same test accounts as in a trailhead module
     * @return List<Account> list of accounts
     */
    public static List<Account> createTrailheadAccounts() {
    /**
     *  NumberOfEmployees Account Number Name                                AnnualRevenue
     *  1000              CD451796       Edge Communications                 1000              
        9000              CD656092       Burlington Textiles Corp of America 9000              
        2680              CC213425       Pyramid Construction Inc.           2680              
        120               CC634267       Dickenson plc                       120               
        5600              CD439877       Grand Hotels & Resorts Ltd          5600              
        145000            CD355118       United Oil & Gas Corp.              145000            
        12300             CC947211       Express Logistics and Transport     12300             
        39000             CD736025       University of Arizona               39000             
        24000             CD355119-A     United Oil & Gas, UK                24000             
        3000              CD355120-B     United Oil & Gas, Singapore         3000              
        265               CC978213       GenePoint                           265               
        null              null           sForce                              null              
        null              null           Sample Account for Entitlements     null 
    */
        Account a = new Account(NumberOfEmployees = 1000, AccountNumber = 'CD451796', Name = 'Edge Communications', AnnualRevenue = 139000000, BillingState='TX');
        Account b = new Account(NumberOfEmployees = 9000, AccountNumber = 'CD656092', Name = 'Burlington Textiles Corp of America', AnnualRevenue = 350000000, BillingState = 'NC');
        Account c = new Account(NumberOfEmployees = 2680, AccountNumber = 'CC213425', Name = 'Pyramid Construction Inc.', AnnualRevenue = 950000000);
        Account d = new Account(NumberOfEmployees = 120, AccountNumber = 'CC634267', Name = 'Dickenson plc', AnnualRevenue = 50000000, BillingState = 'KS');
        Account e = new Account(NumberOfEmployees = 5600, AccountNumber = 'CD439877', Name = 'Grand Hotels & Resorts Ltd', AnnualRevenue = 500000000, BillingState = 'IL');
        Account f = new Account(NumberOfEmployees = 145000, AccountNumber = 'CD355118', Name = 'United Oil & Gas Corp.', AnnualRevenue = 5600000000.0, BillingState = 'NY');
        Account g = new Account(NumberOfEmployees = 12300, AccountNumber = 'CC947211', Name = 'Express Logistics and Transport', AnnualRevenue = 950000000.0, BillingState = 'OR');
        Account h = new Account(NumberOfEmployees = 39000, AccountNumber = 'CD736025', Name = 'University of Arizona', BillingState = 'AZ');
        Account i = new Account(NumberOfEmployees = 24000, AccountNumber = 'CD355119-A', Name = 'United Oil & Gas, UK', BillingState = 'UK');
        Account j = new Account(NumberOfEmployees = 3000, AccountNumber = 'CD355120-B', Name = 'United Oil & Gas, Singapore', BillingState = 'Singapore');
        Account k = new Account(NumberOfEmployees = 265, AccountNumber = 'CC978213', Name = 'GenePoint', AnnualRevenue = 30000000.0, BillingState = 'CA');
        Account l = new Account(Name = 'sForce', BillingState = 'CA');
        Account m = new Account(Name = 'Sample Account for Entitlements');

        List<Account> acctList = new List<Account>{a, b, c, d, e, f, g, h, i, j, k, l, m};
        return acctList;
    }

    /**
     * @description Stores the data for the UserLicense object
     */
    private class UserLicenseData {
        public String name;
        public Integer totalLicenses;
        
        /**
         * @description ProfileData constructor
         * @param name 
         * @param totalLicenses 
         */
        public UserLicenseData(String name, Integer totalLicenses) {
            this.name = name;
            this.totalLicenses = totalLicenses;
        }
    }

    private static void createTrailheadUserLicenses(MockDatabase db) {
        List<UserLicense> userLicenses = new List<UserLicense>();
        for(UserLicenseData u : USER_LICENSE_DATA) {
            UserLicense userLicense = new UserLicense(
                Name = u.name, 
                Status = 'Active',
                TotalLicenses = u.totalLicenses
            );
            userLicenses.add(userLicense);
        }
        db.doInsert(userLicenses);
    }
    private class ProfileData {
        public String name;
        public String userLicenseName;
        
        /**
         * @description ProfileData constructor 
         * @param name 
         * @param userLicenseName 
         */
        public ProfileData(String name, String userLicenseName) {
            this.name = name;
            this.userLicenseName = userLicenseName;
        }
    }

    private static void createTrailheadProfiles(MockDatabase db) {
        List<UserLicense> userLicenses= (List<UserLicense>) db.query(
            'SELECT Name, Id ' + 
            'FROM UserLicense '
        );

        List<Profile> profiles = new List<Profile>();
        for(ProfileData p : PROFILE_DATA) {
            Id userLicenseId;
            for(UserLicense a : userLicenses) {
                if(a.Name == p.userLicenseName) {
                    userLicenseId = a.Id;
                    break;
                }
            }
            Profile profile = new Profile(
                Name = p.name, 
                UserLicenseId = userLicenseId
            );
            profiles.add(profile);
        }
        db.doInsert(profiles);
    }

    private static void createTrailheadUserRoles(MockDatabase db) {
        UserRole ceoRole = new UserRole(
                Name = 'CEO', 
                PortalType = 'None', 
                RollupDescription = 'This is the CEO role', 
                DeveloperName = 'CEO',
                OpportunityAccessForAccountOwner = 'Read/Write'
        );
        db.doInsert(ceoRole);

        UserRole cfoRole = new UserRole(
            Name = 'CFO', 
            PortalType = 'None', 
            RollupDescription = 'This is the CFO role', 
            DeveloperName = 'CFO',
            ParentRoleId = ceoRole.Id,
            OpportunityAccessForAccountOwner = 'Read/Write'
        );
        UserRole cooRole = new UserRole(
            Name = 'COO', 
            PortalType = 'None', 
            RollupDescription = 'This is the COO role', 
            DeveloperName = 'COO',
            ParentRoleId = ceoRole.Id,
            OpportunityAccessForAccountOwner = 'Read/Write'
        );

        UserRole svpCsutomerServiceRole = new UserRole(
            Name = 'SVP, Customer Service & Support', 
            PortalType = 'None', 
            RollupDescription = 'This is the SVP role', 
            DeveloperName = 'SVP_Customer_Service_Support',
            ParentRoleId = ceoRole.Id,
            OpportunityAccessForAccountOwner = 'Read/Write'
        );

        UserRole svpHumanResourcesRole = new UserRole(
            Name = 'SVP, Human Resources', 
            PortalType = 'None', 
            RollupDescription = 'This is the SVP role', 
            DeveloperName = 'SVP_Human_Resources',
            ParentRoleId = ceoRole.Id,
            OpportunityAccessForAccountOwner = 'Read/Write'
        );

        UserRole svpSalesMarketingRole = new UserRole(
            Name = 'SVP, Sales & Marketing', 
            PortalType = 'None', 
            RollupDescription = 'This is the SVP role', 
            DeveloperName = 'SVP_Sales_Marketing',
            ParentRoleId = ceoRole.Id,
            OpportunityAccessForAccountOwner = 'Read/Write'
        );

        List<UserRole> secondLevelRoles = new List<UserRole> {
            cfoRole, cooRole, svpCsutomerServiceRole, svpHumanResourcesRole, svpSalesMarketingRole
        };
        db.doInsert(secondLevelRoles);
    }

    /**
     * @description Create trailhead users 
     * @param db 
     */
    public static void createTrailheadUsers(MockDatabase db) {
        UserRole ceoRole = ((List<UserRole>) db.query('SELECT Name, Id FROM UserRole WHERE Name = \'CEO\''))[0];
        UserRole svpSalesMarketingRole = ((List<UserRole>) db.query('SELECT Name, Id FROM UserRole WHERE Name = \'SVP, Sales & Marketing\''))[0];
        Profile prof = ((List<Profile>) db.query('SELECT Name, Id FROM Profile WHERE Name = \'System Administrator\''))[0];
        User u = new User(
            FirstName = 'John', 
            LastName = 'Doe', 
            Email = 'fakeemail@email.com',
            Username = 'fakeemail@email.com',
            Alias = 'JD',
            ProfileId = prof.Id,
            UserRoleId = ceoRole.Id,
            CommunityNickname = 'JDoe',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            IsActive = true,
            DigestFrequency = 'None',
            ReceivesInfoEmails = false,
            ReceivesAdminInfoEmails = false,
            DefaultGroupNotificationFrequency = 'N'
        );
        User u2 = new User(
            FirstName = 'Jason', 
            LastName = 'Bourne', 
            Email = 'fakeemail1@email.com',
            Username = 'fakeemail1@email.com',
            Alias = 'JB',
            ProfileId = prof.Id,
            UserRoleId = svpSalesMarketingRole.Id,
            CommunityNickname = 'JBourne',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            IsActive = true,
            DigestFrequency = 'None',
            ReceivesInfoEmails = false,
            ReceivesAdminInfoEmails = false,
            DefaultGroupNotificationFrequency = 'N'
        );
        List<User> userList = new List<User> {
            u, u2
        };
        db.doInsert(userList);
    }

    /**
     * @description Create trailhead data
     * @param db 
     */
    public static void createUsers(MockDatabase db) {
        createTrailheadUserLicenses(db);
        createTrailheadProfiles(db);
        createTrailheadUserRoles(db);
        createTrailheadUsers(db);
    }
}