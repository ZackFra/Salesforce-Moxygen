/**
 * @description Interface for parsing clauses in a query
 * @author Zackary Frazier
 * @since 4/9/2024
 */
public interface ClauseParser {
    Intermediary parse(String query);
}