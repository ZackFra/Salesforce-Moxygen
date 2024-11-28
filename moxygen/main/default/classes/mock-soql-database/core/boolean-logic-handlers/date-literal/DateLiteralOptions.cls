/**
 * @description Options for the DateLiteral class 
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public virtual class DateLiteralOptions {
    Schema.DisplayType fieldType;
    Node valueNode;
    Object fieldValue;
    Object recordFieldValue;

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected DateLiteralOptions() {}

    /**
     * @description Returns the field type 
     * @return  `Schema.DisplayType`
     */
    public Schema.DisplayType getFieldType() {
        return fieldType;
    }

    /**
     * @description Returns the value node 
     * @return  `Node`
     */
    public Node getValueNode() {
        return valueNode;
    }

    /**
     * @description Returns the field value 
     * @return  `Object`
     */
    public Object getFieldValue() {
        return fieldValue;
    }

    /**
     * @description Returns the record field value 
     * @return  `Object`
     */
    public Object getRecordFieldValue() {
        return recordFieldValue;
    }

    /**
     * @description Builder for the DateLiteralOptions class 
     */
    public class Builder implements IBuilder {
        DateLiteralOptions options = new DateLiteralOptions();

        /**
         * @description Sets the field type
         * @param fieldType `Schema.DisplayType`
         * @return  `Builder`
         */
        public Builder setFieldType(Schema.DisplayType fieldType) {
            options.fieldType = fieldType;
            return this;
        }

        /**
         * @description Set the value node
         * @param valueNode `Node`
         * @return  `Builder`
         */
        public Builder setValueNode(Node valueNode) {
            options.valueNode = valueNode;
            return this;
        }

        /**
         * @description Set the field value
         * @param fieldValue `Object`
         * @return  `Builder`
         */
        public Builder setFieldValue(Object fieldValue) {
            options.fieldValue = fieldValue;
            return this;
        }

        /**
         * @description Set the record field value
         * @param recordFieldValue `Object`
         * @return  `Builder`
         */
        public Builder setRecordFieldValue(Object recordFieldValue) {
            options.recordFieldValue = recordFieldValue;
            return this;
        }

        /**
         * @description Builds the DateLiteralOptions object
         * @return  `DateLiteralOptions`
         */
        public DateLiteralOptions build() {
            return options;
        }
    }
}