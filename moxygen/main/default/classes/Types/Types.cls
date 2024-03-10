/**
 * @description Types defined for this package 
 * @author Zackary Frazier
 * @since 3/9/2024
 */
public inherited sharing class Types {
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
}