public inherited sharing class Token {
    public final static String LPAREN = '(';
    public final static String RPAREN = ')';
    public final static String WHITESPACE = ' ';
    public final static String COMMA = ',';


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

    public final static String XAND = 'and';
    public final static String XOR = 'or';
    public final static String XNOT = 'not';

    public final static String CALENDAR_YEAR = 'calendar_year';
    public final static String CALENDAR_MONTH = 'calendar_month';
    public final static String COUNT_DISTINCT = 'count_distinct';
    public final static String COUNT = 'count';
    public final static String SUM = 'sum';
    public final static String AVG = 'avg';
    public final static String MIN = 'min';
    public final static String MAX = 'max';

    public final static String INCLUDES = 'includes';

    public final static String ROLLUP = 'rollup';
    public final static String CUBE = 'cube';
}