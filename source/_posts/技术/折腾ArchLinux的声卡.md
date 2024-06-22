---
title: 折腾ArchLinux的声卡
date: 2023-03-24 22:13:06
tags:
---
[原文地址](https://td-sky.github.io/posts/archlinux-voice/)

写于 2022-01-19
声卡驱动
音频管理器
声卡驱动
```bash
$ sudo pacman -S sof-firmware
```
音频管理器
## 本体 及 会话/策略管理器
```bash
$ sudo pacman -S pipewire wireplumber
```

## 替代老牌音频调节器的前端

```bash
$ sudo pacman -S pipewire-pulse pipewire-alsa pipewire-jack
```
重开终端，启用相关服务：

## 启用Pipewire相关服务：

```bash
$ systemctl enable pipewire --user
$ systemctl enable pipewire-pulse --user
graph LR;

alsa[alsa-lib]
alsa-card-profiles;
alsa-topology-conf-->alsa;
alsa-ucm-conf-->alsa;
alsa-->zita-alsa-pcmi;
alsa-->alsa-plugins;
alsa-->alsa-utils;

pw[pipewire]
mgr[wireplumber]
pw-->mgr;
mgr-->pipewire-alsa;
mgr-->pipewire-pulse;
mgr-->pipewire-jack;
```