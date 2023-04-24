FROM kasmweb/core-ubuntu-jammy:develop

LABEL version="1.0" maintainer="colinchang<zhangcheng5468@gmail.com>"

USER root

# 替换阿里云系统源
COPY $PWD/sources.list /etc/apt/sources.list
COPY $PWD/xunlei_1.0.0.1-myubuntu_amd64.deb /home/kasm-user
RUN apt update && mkdir -p /home/kasm-user/Desktop \

# Chrome
&& apt install -y xdg-utils fonts-liberation libu2f-udev \
&& wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& dpkg -i google-chrome-stable_current_amd64.deb \
&& sed -i 's/Exec=\/usr\/bin\/google-chrome-stable/Exec=\/usr\/bin\/google-chrome-stable --no-sandbox/g' /usr/share/applications/google-chrome.desktop \
&& ln -s /usr/share/applications/google-chrome.desktop /home/kasm-user/Desktop/google-chrome.desktop \

# BaiduNetDisk
&& wget https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.17.7/baidunetdisk_4.17.7_amd64.deb \
&& dpkg -i baidunetdisk_4.17.7_amd64.deb \
&& ln -s /usr/share/applications/baidunetdisk.desktop /home/kasm-user/Desktop/baidunetdisk.desktop \

# Thunder
&& apt install -y libgtk2.0-0 libdbus-glib-1-2 \
&& dpkg -i xunlei_1.0.0.1-myubuntu_amd64.deb \
&& sed -i 's/Exec=\/opt\/thunder\/xunlei\/start.sh/Exec=\/opt\/thunder\/xunlei\/start.sh --no-sandbox/g' /usr/share/applications/xunlei.desktop \
&& ln -s /usr/share/applications/xunlei.desktop /home/kasm-user/Desktop/xunlei.desktop \

# qBittorrent
&& add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable \
&& apt update \
&& apt install -y qbittorrent \
&& ln -s /usr/share/applications/org.qbittorrent.qBittorrent.desktop /home/kasm-user/Desktop/org.qbittorrent.qBittorrent.desktop \

# Visual Studio Code
&& wget https://az764295.vo.msecnd.net/stable/704ed70d4fd1c6bd6342c436f1ede30d1cff4710/code_1.77.3-1681292746_amd64.deb \
&& dpkg -i code_1.77.3-1681292746_amd64.deb \
&& sed -i 's/Exec=\/usr\/share\/code\/code/Exec=\/usr\/share\/code\/code --no-sandbox/g' /usr/share/applications/code.desktop \
&& sed -i 's/Icon=com.visualstudio.code/Icon=\/usr\/share\/code\/resources\/app\/resources\/linux\/code.png/g' /usr/share/applications/code.desktop \
&& ln -s /usr/share/applications/code.desktop /home/kasm-user/Desktop/code.desktop \

&& apt autoremove -y \
&& apt clean \
&& rm -rf *.deb