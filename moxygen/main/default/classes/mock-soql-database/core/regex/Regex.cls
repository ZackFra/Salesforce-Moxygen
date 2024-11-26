public with sharing class Regex {
    public Boolean matches(String str, String regexPattern) {
        Pattern ptrn = Pattern.compile(regexPattern);
        Matcher matcher = ptrn.matcher(str);
        return matcher.matches();
    }
}