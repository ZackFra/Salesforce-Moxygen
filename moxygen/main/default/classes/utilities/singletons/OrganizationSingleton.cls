/**
 * @description Singleton for the Organization object
 * @author Zackary Frazier
 * @since 1/7/2025
 * @group Utilities
 */
public with sharing class OrganizationSingleton {
    static Organization org;

    /**
     * @description Gets the Organization object
     * @return  `Organization`
     * @exception ValidationException
     */
    public static Organization getInstance() {
        if (org != null) {
            return org;
        }

        if (Schema.sObjectType.Organization.isAccessible()) {
            org = [
                SELECT FiscalYearStartMonth
                FROM Organization
                LIMIT 1
            ];
        } else {
            throw new ValidationException(
                'You do not have permission to access the Organization object.'
            );
        }
        return org;
    }
}
