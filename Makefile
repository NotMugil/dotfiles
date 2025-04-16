USER ?= rei

.PHONY: switch
switch:
	sudo nixos-rebuild switch --flake .#$(USER)

.PHONY: update
update:
	sudo nixos-rebuild switch --upgrade --flake .#$(USER)

.PHONY: gc
gc:
	nix-collect-garbage --delete-older-than 3d

.PHONY: clean
clean:
	nix-collect-garbage -d
