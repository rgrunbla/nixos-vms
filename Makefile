.PHONY: build_standalone

build_standalone: check-env
	@echo "Building VM $(MACHINE)"
	nix-build src/images.nix -A standalone.eval --no-out-link --arg nixosConfiguration nixos-config/machines/$(MACHINE)/configuration.nix

check-env:
ifndef MACHINE
	$(error MACHINE is undefined)
endif
