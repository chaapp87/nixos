
TARGETSYSTEM=$1
TYPE=$2

if [[ "$TARGETSYSTEM" == "rd-nb-nixos" ]]; then
    if [[ "$TYPE" == "dotfiles" ]]; then
	echo "Updating flake.lock"
	nix flake lock --update-input dotfiles
    else
	echo "Not flake update"
	if [[ "$TYPE" == "remote" ]]; then
	    sudo nixos-rebuild --build-host "root@192.168.178.87" switch --flake .#rd-nb-nixos
	else
	    sudo nixos-rebuild switch --flake .#rd-nb-nixos
	fi
    fi
elif [[ "$TARGETSYSTEM" == "steamdeck-nixos" ]]; then
    REMOTEADDRESS="root@192.168.178.191"
    if [[ "TYPE" == "remote" ]]; then
	sudo nixos-rebuild --build-host "root@192.168.178.87" --targ-host $REMOTEADDRESS switch --flake .#steamdeck-nixos
    else
	sudo nixos-rebuild switch --flake .#steamdeck-nixos
    fi
elif [[ "$TARGETSYSTEM" == "nb-media" ]]; then
    REMOTEADDRESS="root@192.168.178.190"
    if [[ "TYPE" == "remote" ]]; then
	sudo nixos-rebuild --build-host "root@192.168.178.87" --target-host $REMOTEADDRESS switch --flake .#nb-media
    else
	sudo nixos-rebuild switch --flake .#nb-media
    fi
elif [[ "$TARGETSYSTEM" == "testvm-hetzner" ]]; then
    REMOTEADDRESS="root@188.245.177.242"
    if [[ "TYPE" == "remote" ]]; then
	sudo nixos-rebuild --build-host "root@192.168.178.87" --target-host $REMOTEADDRESS switch --flake .#testvm-hetzner
    else
	sudo nixos-rebuild switch --flake .#testvm-hetzner
    fi
elif [[ "$TARGETSYSTEM" == "gaming-nixos" ]]; then
    REMOTEADDRESS="root@192.168.178.87"
    if [[ "TYPE" == "remote" ]]; then
	sudo nixos-rebuild --build-host "root@192.168.178.87" --target-host $REMOTEADDRESS switch --flake .#gaming-nixos
    else
	sudo nixos-rebuild switch --flake .#gaming-nixos
    fi

fi
