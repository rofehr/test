FROM debian:stretch
MAINTAINER MLD Team <team@minidvblinux.de>

ARG DEBIAN_FRONTEND=noninteractive

# update und core Pakete installieren
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
    make git-core software-properties-common locales locales-all nano

# MLD Pakete holen
RUN git clone http://minidvblinux.de/git-5/MLD.git MLD \
 && cd MLD \
 && for name in ISO LOGO apt base btrfs busybox dpkg hid init initramfs kernel ldconfig network psplash ssh syslinux udev vfat xfs; do make checkout name=$name; done

# MLD Paket Abhängigkeiten installieren
RUN cd MLD \
 && apt-get install -y $(make deps)
