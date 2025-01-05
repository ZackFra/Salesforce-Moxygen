build:
	cd scripts/go/instance_upgrade && go mod tidy && GOOS=darwin GOARCH=arm64 go build -o bin/main && chmod +x bin/main
github:
	cd scripts/go/instance_upgrade && go mod tidy && GOOS=linux GOARCH=amd64 go build -o bin/main && chmod +x bin/main