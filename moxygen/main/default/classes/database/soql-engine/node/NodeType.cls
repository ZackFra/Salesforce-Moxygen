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
 * @description This class is responsible for handling the NodeType constants
 * @author Zackary Frazier
 * @since 5/5/2024
 * @group Soql Engine
 */
public with sharing class NodeType {
    public final static String AGGREGATE_FUNCTION = 'aggregate function';

    public final static String XFROM = 'from';
    public final static String XSELECT = 'select';
    public final static String XWHERE = 'where';
    public final static String XGROUP_BY = 'group by';
    public final static String XORDER = 'order';
    public final static String XASC = 'asc';
    public final static String XDESC = 'desc';
    public final static String XHAVING = 'having';

    public final static String XAND = 'and';
    public final static String XOR = 'or';
    public final static String XNOT = 'not';

    public final static String XTYPEOF = 'typeof';
    public final static String XEND = 'end';
    public final static String XWHEN = 'when';
    public final static String XELSE = 'else';

    public final static String CONDITONAL_SUBEXPRESSION = 'conditional subexpression';
    public final static String SUBQUERY = 'subquery';

    public final static String OPERATOR = 'operator';

    public final static String FIELD = 'field';
    public final static String SF_OBJECT = 'object';

    public final static String XSTRING = 'string';
    public final static String XBOOLEAN = 'boolean';
    public final static String XBIND_VARIABLE = 'bind variable';
    public final static String XNULL = 'null';
    public final static String XNUMBER = 'number';

    public final static String BIND_VAR = 'bind variable';

    public final static String DATE_LITERAL = 'date literal';
    public final static String VALUE_LIST = 'value list';
}
