wrk-dir := $(shell pwd)
dst-dir := $(CRX_DST_DIR)
pem-dir := $(CRX_PEM_DIR)

ext-name := $(shell basename $(wrk-dir))

$(dst-dir)/$(ext-name).crx: manifest.json
	@echo ID: $(shell openssl rsa -pubout -outform DER -in $(pem-dir)/$(ext-name).pem 2>/dev/null | sha256sum | head -c32 | tr 0-9a-f a-p)
	@cd ..
	@crx3 -p $(pem-dir)/$(ext-name).pem -o $@ $(wrk-dir)

