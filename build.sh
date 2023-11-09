#!/bin/bash
CRTDIR=$(pwd)

repo=$1     #仓库地址
branch=$2   #分支
config=$3   #配置文件


if [ ! -n "$repo" ]; then
    repo=https://github.com/openwrt/openwrt.git
fi

if [ ! -n "$branch" ]; then
    branch=main
fi

if [ ! -n "$config" ]; then
    config=gl-mt6000.config
fi

git clone -b $branch $repo ~/openwrt

cp -rf feeds.conf ~/openwrt
cp -rf $config ~/openwrt/.config

cd ~/openwrt
./scripts/feeds update -a && ./scripts/feeds install -a
make defconfig

make -j$(expr $(nproc) + 1) V=s