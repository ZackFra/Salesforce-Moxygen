public virtual class DateLiteralOptions {

    protected DateLiteralOptions() {}

    Schema.DisplayType fieldType;
    Node valueNode;
    Object fieldValue;
    Object recordFieldValue;

    public Schema.DisplayType getFieldType() {
        return fieldType;
    }

    public Node getValueNode() {
        return valueNode;
    }

    public Object getFieldValue() {
        return fieldValue;
    }

    public Object getRecordFieldValue() {
        return recordFieldValue;
    }

    public class Builder implements IBuilder {
        DateLiteralOptions options = new DateLiteralOptions();

        public Builder setFieldType(Schema.DisplayType fieldType) {
            options.fieldType = fieldType;
            return this;
        }

        public Builder setValueNode(Node valueNode) {
            options.valueNode = valueNode;
            return this;
        }

        public Builder setFieldValue(Object fieldValue) {
            options.fieldValue = fieldValue;
            return this;
        }

        public Builder setRecordFieldValue(Object recordFieldValue) {
            options.recordFieldValue = recordFieldValue;
            return this;
        }

        public DateLiteralOptions build() {
            return options;
        }
    }
}