default: test

test:
	go test -failfast -race -coverpkg=./... -covermode=atomic -coverprofile=coverage.txt ./... -run . -timeout=5m

coverage:
	go tool cover -html=coverage.txt

lint:
	golangci-lint run ./...

pre:
	pre-commit run --all-files

license:
	addlicense -c "Tim <tbckr>" -l MIT -s -v \
        -ignore "dist/**" \
        -ignore ".idea/**" \
        -ignore ".task/**" \
        -ignore ".github/licenses.tmpl" \
        -ignore "licenses/*" \
        -ignore "venv/*" \
        .

.PHONY: test coverage lint pre license