/**
 * @description Types defined for this package
 * @author Zackary Frazier
 * @since 3/9/2024
 * @group Moxygen
 */
public with sharing class Types {
    /**
     * @description The type of DML operation that was performed
     */
    public enum DML {
        INSERTED,
        UPDATED,
        UPSERTED,
        DELETED,
        UNDELETED
    }

    /**
     * @description The type of SOQL query that was performed
     */
    public enum SOQL {
        RECORD,
        AGGREGATE,
        COUNT
    }
}
