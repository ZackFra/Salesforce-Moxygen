/**
 * @description RelationshipBuilder class to build parent and child relationships
 */
public inherited sharing class RelationshipBuilder {
    /**
     * @description ParentRelationshipBuilder class to build parent relationships
     */
    public class ParentRelationshipBuilder {
        SObject parent;
        SObject child;
        String relationshipName;
        String relationshipField;

        /**
         * @description Set the parent SObject to be related
         * @param parent SObject to be related
         * @return ParentRelationshipBuilder
         */
        public ParentRelationshipBuilder setParent(SObject parent) {
            this.parent = parent;
            return this;
        }

        /**
         * @description Set the child SObject to be related
         * @param child SObject to be related
         * @return ParentRelationshipBuilder
         */
        public ParentRelationshipBuilder setChild(SObject child) {
            this.child = child;
            return this;
        }

        /**
         * @description Set the relationship name
         * @param relationshipName Relationship name
         * @return ParentRelationshipBuilder
         */
        public ParentRelationshipBuilder setRelationshipName(String relationshipName) {
            this.relationshipName = relationshipName;
            return this;
        }

        /**
         * @description Set the relationship field
         * @param relationshipField Relationship field
         * @return ParentRelationshipBuilder
         */
        public ParentRelationshipBuilder setRelationshipField(String relationshipField) {
            this.relationshipField = relationshipField;
            return this;
        }

        /**
         * @description Build the parent relationship
         * @return SObject
         * @throws IllegalArgumentException
         */
        public SObject build() {
            Map<String, Object> args = new Map<String, Object> {
                'parent' => parent,
                'child' => child,
                'relationshipName' => relationshipName,
                'relationshipField' => relationshipField
            };
            Common.nullCheck(args);

            String childApiName = SchemaService.getSObjectName(child);

            Map<String, Object> childMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(child));
            childMap.put(relationshipName, parent);
            childMap.put(relationshipField, parent.Id);
            return (SObject) JSON.deserialize(
                JSON.serialize(childMap), 
                Type.forName(childApiName)
            );
        }
    }

    /**
     * @description ChildRelationshipBuilder class to build child relationships
     */
    public class ChildRelationshipBuilder {
        SObject parent;
        List<SObject> children;
        String relationshipName;
        String relationshipField;

        /**
         * @description Set the parent SObject to be related
         * @param parent SObject to be related
         * @return ChildRelationshipBuilder
         */
        public ChildRelationshipBuilder setParent(SObject parent) {
            this.parent = parent;
            return this;
        }

        /**
         * @description Set the children SObjects to be related
         * @param children SObjects to be related
         * @return ChildRelationshipBuilder
         */
        public ChildRelationshipBuilder setChildren(List<SObject> children) {
            this.children = children;
            return this;
        }

        /**
         * @description Set the relationship name
         * @param relationshipName Relationship name
         * @return ChildRelationshipBuilder
         */
        public ChildRelationshipBuilder setRelationshipName(String relationshipName) {
            this.relationshipName = relationshipName;
            return this;
        }

        /**
         * @description Set the relationship field
         * @param relationshipField Relationship field
         * @return ChildRelationshipBuilder
         */
        public ChildRelationshipBuilder setRelationshipField(String relationshipField) {
            this.relationshipField = relationshipField;
            return this;
        }

        /**
         * @description Build the child relationship
         * @return SObject
         * @throws IllegalArgumentException
         */
        public SObject build() {
            Map<String, Object> args = new Map<String, Object> {
                'parent' => parent,
                'children' => children,
                'relationshipName' => relationshipName,
                'relationshipField' => relationshipField
            };
            Common.nullCheck(args);

            String parentApiName = SchemaService.getSObjectName(parent);

            Map<String, Object> parentMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(parent));
            
            for(SObject child : children) {
                child.put(relationshipField, parent.Id);
            }

            Map<String, Object> subQueryResult = new Map<String, Object> {
                'records' => children,
                'totalSize' => children.size(),
                'done' => true
            };
            parentMap.put(relationshipName, subQueryResult);

            return (SObject) JSON.deserialize(
                JSON.serialize(parentMap), 
                Type.forName(parentApiName)
            );
        }
    }

    /**
     * @description Create a new ChildRelationshipBuilder instance
     * @return ChildRelationshipBuilder
     */
    public ChildRelationshipBuilder relateChildren() {
        return new ChildRelationshipBuilder();
    }

    /**
     * @description Create a new ParentRelationshipBuilder instance
     * @return ParentRelationshipBuilder
     */
    public ParentRelationshipBuilder relateParent() {
        return new ParentRelationshipBuilder();
    }
}