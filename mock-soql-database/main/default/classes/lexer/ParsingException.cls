/**
 * @description Custom exception for parsing errors 
 * @author Zackary Frazier
 * @since 4/9/2024
 */
public inherited sharing class ParsingException extends Exception {
    /**
     * @description Constructor for a ParsingException
     * @param message `String` the message to display
     * @param expected : `String` the expected token
     */
    public ParsingException(String message, String expected) {
        if(expected == null) {
            this.setMessage('Unkown parsing exception, "' + message + '" could not be parsed.');
        } else {
            this.setMessage('Parsing exception, expected "' + expected + '", instead saw "' + message + '".');
        }
    }
}