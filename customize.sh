#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.199.77/g' package/base-files/files/bin/config_generate

#2. Modify Hostname
sed -i '/uci commit system/i\uci set system.@system[0].hostname='OpenwrtBP'' package/lean/default-settings/files/zzz-default-settings

#3. 设置密码为空
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g' /etc/shadow

#4. Modify builder
sed -i "s/OpenWrt /0xACE7 build $(TZ=UTC-3 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

#5. Change luci list name
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-turboacc/po/zh-cn/turboacc.po
mv feeds/small8/luci-theme-argonne/htdocs/luci-static/argonne/img/argon.svg feeds/small8/luci-theme-argonne/htdocs/luci-static/argonne/img/argonne.svg
#sed -i 's/"Argon 主题设置"/"主题设置"/g' feeds/kenzo/luci-app-argon-config/po/zh-cn/argon-config.po
sed -i 's/"Argonne 主题设置"/"主题设置"/g' feeds/small8/luci-app-argonne-config/po/zh-cn/argonne-config.po
        
#6. Change dns server
sed -i "2i # network config" package/lean/default-settings/files/zzz-default-settings
sed -i "3i uci set network.lan.dns='127.0.0.1'"  package/lean/default-settings/files/zzz-default-settings

#7. Replacement Argon to main theme
#sed -i 's/default Bootstrap theme/default Argon theme/g' feeds/luci/collections/luci/Makefile
#sed -i 's/+luci-theme-bootstrap/+luci-theme-argon/g' feeds/luci/collections/luci/Makefile

#8. Update dnscrypt-proxy2 2.0.45 to 2.1.1
rm -rf feeds/packages/net/dnscrypt-proxy2
git clone https://github.com/0xACE8/ace-packages.git feeds/packages/net/dnscrypt-proxy2

#9. Change to my banner
sudo rm package/base-files/files/etc/banner
wget https://raw.githubusercontent.com/0xACE8/OP-Build-x64-UEFI/main/banner -O package/base-files/files/etc/banner
