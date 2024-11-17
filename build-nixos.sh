
TARGETSYSTEM=$1
TYPE=$2
echo "$TARGETSYSTEM"
echo "$TYPE"
BUILDHOST="root@192.168.178.87"
echo $REMOTEADDRESS
if [[ "$TARGETSYSTEM" == "rd-nb-nixos" ]]; then
    if [[ "$TYPE" == "dotfiles" ]]; then
	echo "Updating flake.lock"
	nix flake lock --update-input dotfiles
    else
	echo "Not flake update"
	if [[ "$TYPE" == "remote" ]]; then
	    sudo nixos-rebuild switch --flake .#rd-nb-nixos --build-host $BUILDHOST
	else
	    sudo nixos-rebuild switch --flake .#rd-nb-nixos
	fi
    fi
elif [[ "$TARGETSYSTEM" == "steamdeck-nixos" ]]; then
    REMOTEADDRESS="root@192.168.178.191"
    if [[ "$TYPE" == "remote" ]]; then
	sudo nixos-rebuild switch --flake .#steamdeck-nixos --build-host ${BUILDHOST} --target-host ${REMOTEADDRESS} --use-remote-sudo
    else
	sudo nixos-rebuild switch --flake .#steamdeck-nixos
    fi
elif [[ "$TARGETSYSTEM" == "nb-media" ]]; then
    REMOTEADDRESS="root@192.168.178.190"
    if [[ "$TYPE" == "remote" ]]; then
	sudo nixos-rebuild switch --flake .#nb-media --build-host $BUILDHOST --target-host $REMOTEADDRESS
    else
	sudo nixos-rebuild switch --flake .#nb-media
    fi
elif [[ "$TARGETSYSTEM" == "testvm-hetzner" ]]; then
    if [[ "$TYPE" == "remote" ]]; then
	sudo nixos-rebuild switch --flake .#testvm-hetzner --build-host $BUILDHOST --target-host $REMOTEADDRESS
    else
	sudo nixos-rebuild switch --flake .#testvm-hetzner
    fi
elif [[ "$TARGETSYSTEM" == "gaming-nixos" ]]; then
    REMOTEADDRESS="root@192.168.178.87"
    if [[ "$TYPE" == "remote" ]]; then
	sudo nixos-rebuild switch --flake .#gaming-nixos --build-host $BUILDHOST --target-host $REMOTEADDRESS 
    else
	sudo nixos-rebuild switch --flake .#gaming-nixos
    fi

fi
