# O-Saft Docker Container

This repository contains a Docker container for the [OWASP SSL advanced forensic tool](https://github.com/OWASP/O-Saft).

## Usage

    docker run punkstar/o-saft +check www.nicksays.co.uk

## Development

The container is configured an entrypoint of `perl /opt/osaft/o-saft.pl`.  If you want to jump into the container then you'll need to override the entrypoint at runtime using `--entrypoint`, for example:

    $ docker run -it --entrypoint=bash punkstar/o-saft
    root@2791d357b433:/opt/osaft#
