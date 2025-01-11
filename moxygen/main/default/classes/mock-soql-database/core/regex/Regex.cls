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
        if (matcherCache.containsKey(regexPattern)) {
            Matcher matcher = matcherCache.get(regexPattern);
            matcher.reset(str);
            return matcher.matches();
        }
        Pattern ptrn = Pattern.compile(regexPattern);
        Matcher matcher = ptrn.matcher(str);
        matcherCache.put(regexPattern, matcher);
        return matcher.matches();
    }

    /**
     * @description Get the groups from a regex pattern
     * @param str `String`
     * @param regexPattern `String`
     * @return  `List<String>`
     */
    public List<String> getGroups(String str, String regexPattern) {
        if (matcherCache.containsKey(regexPattern)) {
            return getGroupsFromCache(str, regexPattern);
        }
        return getGroupsAndUpdateCache(str, regexPattern);
    }

    private List<String> getGroupsAndUpdateCache(
        String str,
        String regexPattern
    ) {
        Pattern ptrn = Pattern.compile(regexPattern);
        Matcher matcher = ptrn.matcher(str);
        matcherCache.put(regexPattern, matcher);
        if (!matcher.matches()) {
            throw new ValidationException('No match found for ' + regexPattern);
        }
        List<String> groups = new List<String>();
        for (Integer i = 0; i < matcher.groupCount(); i++) {
            groups.add(matcher.group(i));
        }
        return groups;
    }

    private List<String> getGroupsFromCache(String str, String regexPattern) {
        Matcher matcher = matcherCache.get(regexPattern);
        matcher.reset(str);
        if (!matcher.matches()) {
            throw new ValidationException('No match found for ' + regexPattern);
        }
        List<String> groups = new List<String>();
        for (Integer i = 0; i < matcher.groupCount(); i++) {
            groups.add(matcher.group(i));
        }
        return groups;
    }
}
