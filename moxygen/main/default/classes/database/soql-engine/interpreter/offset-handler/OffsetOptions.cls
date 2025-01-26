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
 * @description Options class for the Offset class
 * @author Zackary Frazier
 * @since 3/23/2024
 * @group Soql Engine
 */
public with sharing class OffsetOptions {
    public Integer offset;
    public Types.SOQL type;
    public Object obj;

    /**
     * @description Sets the offset value for the query
     * @param offset `Integer`
     * @return  `OffsetOptions`
     */
    public OffsetOptions setOffset(Integer offset) {
        this.offset = offset;
        return this;
    }

    /**
     * @description Getter for the offset value
     * @return  `Integer`
     */
    public Integer getOffset() {
        return this.offset;
    }

    /**
     * @description Setter for the type of query
     * @param type `Types.SOQL`
     * @return  `OffsetOptions`
     */
    public OffsetOptions setType(Types.SOQL type) {
        this.type = type;
        return this;
    }

    /**
     * @description Getter for the type of query
     * @return  `Types.SOQL`
     */
    public Types.SOQL getType() {
        return this.type;
    }

    /**
     * @description Setter for the object to be used in the query
     * @param obj `List<ProtoAggregate> | List<SObject> | Integer`
     * @return  `OffsetOptions`
     */
    public OffsetOptions setObj(Object obj) {
        this.obj = obj;
        return this;
    }

    /**
     * @description Getter for the object to be used in the query
     * @return  `Object`
     */
    public Object getObj() {
        return this.obj;
    }
}
