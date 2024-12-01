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
 * @description This class is responsible for handling the Token constants 
 * @author Zackary Frazier
 * @since 5/5/2024
 */
public inherited sharing class Token {
    public final static String LPAREN = '(';
    public final static String RPAREN = ')';
    public final static String WHITESPACE = ' ';
    public final static String COMMA = ',';
    public final static String SINGLE_QUOTE = '\'';
    public final static String COLON = ':';
    public final static String DOT = '.';


    public final static String XEQUALS = '=';
    public final static String XINCLUDES = 'includes';
    public final static String XEXCLUDES = 'excludes';
    public final static String XLIKE = 'like';
    public final static String XNOT_EQUALS = '!=';
    public final static String XALT_NOT_EQUALS = '<>';
    public final static String XLESS_THAN_OR_EQUALS = '<=';
    public final static String XGREATER_THAN_OR_EQUASL = '>=';
    public final static String XIN = 'in';
    public final static String XNOT_IN = 'not in';
    public final static String XGREATER_THAN = '>';
    public final static String XLESS_THAN = '<';

    public final static String XTYPEOF = 'typeof';
    public final static String XEND = 'end';
    public final static String XWHEN = 'when';
    public final static String XELSE = 'else';
    public final static String XTHEN = 'then';


    public final static List<String> OPERATORS = new List<String> {
        XEQUALS,
        XINCLUDES,
        XEXCLUDES,
        XLIKE,
        XNOT_EQUALS,
        XALT_NOT_EQUALS,
        XLESS_THAN_OR_EQUALS,
        XGREATER_THAN_OR_EQUASL,
        XIN,
        XNOT_IN,
        XGREATER_THAN,
        XLESS_THAN
    };

    public final static String XFROM = 'from';
    public final static String XSELECT = 'select';
    public final static String XWHERE = 'where';
    public final static String XGROUP = 'group';
    public final static String XBY = 'by';
    public final static String XORDER = 'order';
    public final static String XASC = 'asc';
    public final static String XDESC = 'desc';
    public final static String XHAVING = 'having';

    public final static List<String> PROTECTED_KEYWORDS = new List<String> {
        XFROM,
        XSELECT,
        XWHERE,
        XGROUP,
        XBY,
        XORDER,
        XASC,
        XDESC,
        XHAVING
    };

    public final static String XAND = 'and';
    public final static String XOR = 'or';
    public final static String XNOT = 'not';

    public final static String CALENDAR_YEAR = 'calendar_year';
    public final static String CALENDAR_MONTH = 'calendar_month';
    public final static String CALENDAR_QUARTER = 'calendar_quarter';
    public final static List<String> DATE_FUNCS = new List<String> {
        CALENDAR_YEAR,
        CALENDAR_MONTH,
        CALENDAR_QUARTER
    };

    public final static String COUNT_DISTINCT = 'count_distinct';
    public final static String COUNT = 'count';
    public final static String SUM = 'sum';
    public final static String AVG = 'avg';
    public final static String MIN = 'min';
    public final static String MAX = 'max';

    public final static String INCLUDES = 'includes';

    public final static String ROLLUP = 'rollup';
    public final static String CUBE = 'cube';

    public final static String XTRUE = 'true';
    public final static String XFALSE = 'false';
    public final static String XNULL = 'null';

    public final static String TODAY_LITERAL = 'today';
    public final static String YESTERDAY_LITERAL = 'yesterday';
    public final static String TOMORROW_LITERAL = 'tomorrow';
    public final static String LAST_WEEK_LITERAL = 'last_week';
    public final static String THIS_WEEK_LITERAL = 'this_week';
    public final static String NEXT_WEEK_LITERAL = 'next_week';
}