/**
 * @description A class to handle regex operations
 * @author Zackary Frazier
 * @since 11/27/2024
 */
public with sharing class Regex {
    /**
     * @description Returns whether a string matches a regex pattern 
     * @param str `String`
     * @param regexPattern `String` 
     * @return  `Boolean`
     */
    public Boolean matches(String str, String regexPattern) {
        Pattern ptrn = Pattern.compile(regexPattern);
        Matcher matcher = ptrn.matcher(str);
        return matcher.matches();
    }
}