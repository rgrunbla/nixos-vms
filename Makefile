.PHONY: build_standalone

build: check-env
	@echo "Building VM $(MACHINE)";
	$(eval BUILD_PATH=$(shell nix-build src/images.nix -A standalone.eval --no-out-link --arg nixosConfiguration nixos-config/machines/$(MACHINE)/configuration.nix))
	cp $(BUILD_PATH)/*.qcow2 ./$(MACHINE).qcow2
	chmod u+w ./$(MACHINE).qcow2

run: check-env build
	@echo "Running VM $(MACHINE)"
	$(shell nix-build src/images.nix -A standalone.run --no-out-link --arg nixosConfiguration nixos-config/machines/$(MACHINE)/configuration.nix)

check-env:
ifndef MACHINE
	$(error MACHINE is undefined)
endif
