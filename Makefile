all: build

build:
	@docker build --tag=bunnyfu/openfire .

release: build
	@docker build --tag=bunnyfu/openfire:$(shell cat VERSION) .
