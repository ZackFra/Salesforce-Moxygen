/**
 * @description A class to handle regex operations
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class Regex {

    static Map<String, Matcher> matcherCache = new Map<String, Matcher>();
    /**
     * @description Returns whether a string matches a regex pattern 
     * @param str `String`
     * @param regexPattern `String` 
     * @return  `Boolean`
     */
    public Boolean matches(String str, String regexPattern) {
        if(matcherCache.containsKey(regexPattern)) {
            Matcher matcher = matcherCache.get(regexPattern);
            matcher.reset(str);
            return matcher.matches();
        }
        Pattern ptrn = Pattern.compile(regexPattern);
        Matcher matcher = ptrn.matcher(str);
        matcherCache.put(regexPattern, matcher);
        return matcher.matches();
    }
}