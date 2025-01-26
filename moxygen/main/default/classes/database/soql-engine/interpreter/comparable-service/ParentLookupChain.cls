/**
 * @description Represents a chain of fields to look up on a parent object
 * @author Zackary Frazier
 * @since 11/25/2024
 * @group Soql Engine
 */
public class ParentLookupChain {
    private String finalField;
    private List<String> fieldParts;

    /**
     * @description Constructor for ParentLookupChain
     * @param fieldLookupChain `String`
     */
    public ParentLookupChain(String fieldLookupChain) {
        List<String> fieldParts = fieldLookupChain.split('\\.');
        String finalField = fieldParts[fieldParts.size() - 1];
        fieldParts.remove(fieldParts.size() - 1);
        this.finalField = finalField;
        this.fieldParts = fieldParts;
    }

    /**
     * @description Constructor for ParentLookupChain
     * @param finalField `String`
     * @param fieldParts `List<String>`
     */
    public ParentLookupChain(String finalField, List<String> fieldParts) {
        this.finalField = finalField;
        this.fieldParts = fieldParts;
    }

    /**
     * @description Get the final field to look up
     * @return  `String`
     */
    public String getFinalField() {
        return finalField;
    }

    /**
     * @description Get the field parts to look up
     * @return  `List<String>`
     */
    public List<String> getFieldParts() {
        return fieldParts.clone();
    }
}
