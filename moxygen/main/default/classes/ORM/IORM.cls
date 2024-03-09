/**
 * @description Interface for ORM 
 * @author Zackary Frazier
 * @since 3/9/2024
 */
public interface IORM {
    /**
     * @description Returns the `ISelector` object 
     * @return  `ISelector`
     */
    ISelector getSelector();
    /**
     * @description Returns the `IDML` object 
     * @return  `IDML`
     */
    IDML getDML();
}