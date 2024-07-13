/**
 * @description This class generates JSON resources for testing 
 * @author Zackary Frazier
 * @since 7/13/2024
 */
public without sharing class StaticResources {
    public static List<MetadataService.SaveResult> createJsonResourceForMockSoqlQuery(String fullName, String query) {
        Parser p = new Parser();
        Node node = p.parse(query);
        String body = JSON.serialize(
            new Map<String, Object> {
                'query' => query,
                'ast' => node
            }
        );
        return createJsonResource(fullName, body);
    }

    public static List<MetadataService.SaveResult> createJsonResource(String fullName, String body) {
        MetadataService.MetadataPort service = createService();    
        MetadataService.StaticResource staticResource = new MetadataService.StaticResource();
        staticResource.fullName = fullName;
        staticResource.contentType = 'application/json';
        staticResource.cacheControl = 'public';
        staticResource.content = EncodingUtil.base64Encode(Blob.valueOf(body));
        List<MetadataService.SaveResult> results = service.createMetadata(new List<MetadataService.Metadata> { staticResource });
        return results;
    }

    private static MetadataService.MetadataPort createService() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
}