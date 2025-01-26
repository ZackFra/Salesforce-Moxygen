/**
 * @description A class to resolve a parent lookup chain
 * @author Zackary Frazier
 * @since 11/28/2024
 * @group Soql Engine
 */
public with sharing class ParentLookupResolver {
    /**
     * @description split a parent lookup chain into its parts
     * @param fieldLookupChain `String`
     * @return  `ParentLookupChain`
     */
    public ParentLookupChain splitParentLookupChain(String fieldLookupChain) {
        List<String> fieldParts = fieldLookupChain.split('\\.');
        String finalField = fieldParts[fieldParts.size() - 1];
        fieldParts.remove(fieldParts.size() - 1);
        return new ParentLookupChain(finalField, fieldParts);
    }

    /**
     * @description A class to resolve a parent lookup chain
     */
    public class ParentLookupChain {
        private String finalField;
        private List<String> fieldParts;

        /**
         * @description Constructor for a parent lookup chain
         * @param finalField `String`
         * @param fieldParts `List<String>`
         */
        public ParentLookupChain(String finalField, List<String> fieldParts) {
            this.finalField = finalField;
            this.fieldParts = fieldParts;
        }

        /**
         * @description Get the final field
         * @return  `String`
         */
        public String getFinalField() {
            return finalField;
        }

        /**
         * @description Get the field parts
         * @return  `List<String>`
         */
        public List<String> getFieldParts() {
            return fieldParts;
        }
    }
}
