.PHONY: all
all: test fmt swag

.PHONY: lint
lint:
	@echo "[golangci-lint] Running golangci-lint..."
	@golangci-lint run 2>&1
	@echo "------------------------------------[Done]"

.PHONY: test
test:
	@echo "[test] Running go test..."
	@go test ./... -coverprofile coverage.txt 2>&1
	@go tool cover -html=coverage.txt
	@echo "------------------------------------[Done]"

.PHONY: fmt
fmt:
	@echo "[fmt] Formatting go project..."
	@gofmt -s -w . 2>&1
	@echo "------------------------------------[Done]"

.PHONY: swag
swag:
	@echo "[swag] Running swag..."
	@swag init --generalInfo entry/common_service_entry.go --output assets/sw/config --propertyStrategy camelcase --markdownFiles assets/docs
	@rm -rf assets/sw/config/docs.go
	@echo "------------------------------------[Done]"