interface OrgDisplayResponse extends SalesforceResponse {
    result: {
        id: string,
        apiVersion: string,
        accessToken: string,
        instanceUrl: string,
        username: string,
        clientId: string,
        connectedStatus: string,
        alias: string
    }
}