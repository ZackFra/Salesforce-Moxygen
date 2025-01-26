/*
 * MIT License
 *
 * Copyright (c) 2024 Zackary Frazier
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

/**
 * @description Factory class to create appropriate select handler based on the field node type
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public with sharing class SelectHandlerFactory {
    private FieldSelector fSelector;

    /**
     * @description Constructor
     * @param fSelector
     */
    public SelectHandlerFactory(FieldSelector fSelector) {
        this.fSelector = fSelector;
    }

    /**
     * @description Creates appropriate select handler based on the field node type
     * @return  `ISelectHandler`
     */
    public ISelectHandler createHandler() {
        Node fieldNode = fSelector.fieldNode;

        Boolean isTypeOf = (fieldNode.nodeType == 'typeof');
        Boolean isChildSubQuery = (fieldNode.nodeType == 'subquery');
        Boolean isParentSubQuery = (fieldNode.id.contains('.'));

        if (isTypeOf) {
            return new PolymorphicSelectHandler(fSelector);
        } else if (isChildSubQuery) {
            return new ChildSubQuerySelectHandler(fSelector);
        } else if (isParentSubQuery) {
            return new ParentSubQuerySelectHandler(fSelector);
        } else {
            return new FieldSelectHandler(fSelector);
        }
    }
}
