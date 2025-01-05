package main

import (
	"encoding/json"
	"fmt"
	"os"
	"root/models"
)

func main() {
	instanceUpgradeRaw, err := os.ReadFile(os.Args[1])
	if err != nil {
		panic(err)
	}
	salesforceResponse := models.SalesforceResponse{}
	json.Unmarshal(instanceUpgradeRaw, &salesforceResponse)
	fmt.Printf("::warning::%s", salesforceResponse.Result.Message)
}
