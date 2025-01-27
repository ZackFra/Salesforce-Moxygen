interface QueryResponse extends SalesforceResponse {
    result: {
        totalSize: number,
        done: boolean,
        records: any[]
    }
}