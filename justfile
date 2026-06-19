hostname := `hostname`

default:
	@just --list

switch:
	cd {{justfile_directory()}} && sudo nixos-rebuild switch --flake .#{{hostname}}

build:
	cd {{justfile_directory()}} && nixos-rebuild build --flake #{{hostname}}

update:
	cd {{justfile_directory()}} && nix flake update

fmt:
	cd {{justfile_directory()}} && find . -name '*.nix' -exec nixfmt {} +

clean:
	sudo nix-collect-garbage -d

