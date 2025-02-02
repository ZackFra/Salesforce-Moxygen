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
 * @group Mock Database
 */
public with sharing class Token {
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

    public final static List<String> OPERATORS = new List<String>{
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

    public final static List<String> PROTECTED_KEYWORDS = new List<String>{
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
    public final static List<String> DATE_FUNCS = new List<String>{
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
    public final static String LAST_MONTH_LITERAL = 'last_month';
    public final static String THIS_MONTH_LITERAL = 'this_month';
    public final static String NEXT_MONTH_LITERAL = 'next_month';
    public final static String LAST_90_DAYS_LITERAL = 'last_90_days';
    public final static String NEXT_90_DAYS_LITERAL = 'next_90_days';
    public final static String LAST_N_DAYS_LITERAL = 'last_n_days';
    public final static String NEXT_N_DAYS_LITERAL = 'next_n_days';
    public final static String N_DAYS_AGO_LITERAL = 'n_days_ago';
    public final static String NEXT_N_WEEKS_LITERAL = 'next_n_weeks';
    public final static String LAST_N_WEEKS_LITERAL = 'last_n_weeks';
    public final static String N_MONTHS_AGO_LITERAL = 'n_months_ago';
    public final static String THIS_QUARTER_LITERAL = 'this_quarter';
    public final static String LAST_QUARTER_LITERAL = 'last_quarter';
    public final static String NEXT_QUARTER_LITERAL = 'next_quarter';
    public final static String NEXT_N_QUARTERS_LITERAL = 'next_n_quarters';
    public final static String THIS_YEAR_LITERAL = 'this_year';
    public final static String THIS_FISCAL_YEAR_LITERAL = 'this_fiscal_year';
    public final static String LAST_N_FISCAL_YEARS_LITERAL = 'last_n_fiscal_years';
    public final static String NEXT_FISCAL_YEAR_LITERAL = 'next_fiscal_year';
    public final static String LAST_FISCAL_YEAR_LITERAL = 'last_fiscal_year';
    public final static String NEXT_N_FISCAL_YEARS = 'next_n_fiscal_years';
    public final static String N_FISCAL_YEARS_AGO = 'n_fiscal_years_ago';
    public final static String N_YEARS_AGO = 'n_years_ago';
    public final static String LAST_N_FISCAL_QUARTERS = 'last_n_fiscal_quarters';
    public final static String NEXT_FISCAL_QUARTER = 'next_fiscal_quarter';

    public final static Set<String> DATE_LITERAL_TOKENS = new Set<String>{
        TODAY_LITERAL,
        YESTERDAY_LITERAL,
        TOMORROW_LITERAL,
        LAST_WEEK_LITERAL,
        THIS_WEEK_LITERAL,
        NEXT_WEEK_LITERAL,
        LAST_MONTH_LITERAL,
        THIS_MONTH_LITERAL,
        NEXT_MONTH_LITERAL,
        LAST_90_DAYS_LITERAL,
        NEXT_90_DAYS_LITERAL,
        LAST_N_DAYS_LITERAL,
        NEXT_N_DAYS_LITERAL,
        N_DAYS_AGO_LITERAL,
        NEXT_N_WEEKS_LITERAL,
        LAST_N_WEEKS_LITERAL,
        N_MONTHS_AGO_LITERAL,
        THIS_QUARTER_LITERAL,
        LAST_QUARTER_LITERAL,
        NEXT_QUARTER_LITERAL,
        NEXT_N_QUARTERS_LITERAL,
        THIS_YEAR_LITERAL,
        THIS_FISCAL_YEAR_LITERAL,
        LAST_N_FISCAL_YEARS_LITERAL,
        NEXT_FISCAL_YEAR_LITERAL,
        LAST_FISCAL_YEAR_LITERAL,
        NEXT_N_FISCAL_YEARS,
        N_FISCAL_YEARS_AGO,
        N_YEARS_AGO,
        LAST_N_FISCAL_QUARTERS,
        NEXT_FISCAL_QUARTER
    };
}
