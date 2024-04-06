/**
 * @description Interface for handling select operations 
 * @author Zackary Frazier
 * @since 3/23/2024
 */
public interface ISelectHandler {
    /**
     * @description Handles the select operation 
     * @return  `SObject`
     */
    SObject handleSelect();
}