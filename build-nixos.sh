
TARGETSYSTEM=$1
BUILDSYSTEM=$2

if [[ "$TARGETSYSTEM" == "rd-nb-nixos" ]]; then
    sudo nixos-rebuild switch --flake .#rd-nb-nixos
elif [[ "$TARGETSYSTEM" == "steamdeck-nixos" ]]; then
    REMOTEADDRESS="root@192.168.178.191"
    if [[ "BUILDSYSTEM" == "remote" ]]; then
	sudo nixos-rebuild --build-host chaapp@102.168.178.87 --target-host $REMOTEADDRESS switch --flake .#steamdeck-nixos
    else
	sudo nixos-rebuild --build-host "" --target-host $REMOTEADDRESS switch --flake .#steamdeck-nixos
    fi
elif [[ "$TARGETSYSTEM" == "nb-media" ]]; then
    REMOTEADDRESS="root@192.168.178.190"
    if [[ "BUILDSYSTEM" == "remote" ]]; then
	sudo nixos-rebuild --build-host $REMOTEADDRESS --target-host $REMOTEADDRESS switch --flake .#nb-media
    else
	sudo nixos-rebuild --build-host "" --target-host $REMOTEADDRESS switch --flake .#nb-media
    fi
elif [[ "$TARGETSYSTEM" == "testvm-hetzner" ]]; then
    REMOTEADDRESS="root@188.245.177.242"
    if [[ "BUILDSYSTEM" == "remote" ]]; then
	sudo nixos-rebuild --build-host $REMOTEADDRESS --target-host $REMOTEADDRESS switch --flake .#testvm-hetzner
    else
	sudo nixos-rebuild --build-host "" --target-host $REMOTEADDRESS switch --flake .#testvm-hetzner
    fi

fi 
