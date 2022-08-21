#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.199.99/g' package/base-files/files/bin/config_generate

#2. Modify Hostname
sed -i '/uci commit system/i\uci set system.@system[0].hostname='OpenwrtBP'' package/lean/default-settings/files/zzz-default-settings

#3. 设置密码为空
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

#4. Modify builder
sed -i "s/OpenWrt /0xACE7 build $(TZ=UTC-3 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

#5. Change luci list name
#sed -i 's/"Argon 主题设置"/"主题设置"/g' feeds/kenzo/luci-app-argon-config/po/zh-cn/argon-config.po
sed -i 's/"Argonne 主题设置"/"主题设置"/g' feeds/small8/luci-app-argonne-config/po/zh-cn/argonne-config.po
mv feeds/small8/luci-theme-argonne/htdocs/luci-static/argonne/img/argon.svg feeds/small8/luci-theme-argonne/htdocs/luci-static/argonne/img/argonne.svg
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

#6. Change dns server
sed -i "2i # network config" package/lean/default-settings/files/zzz-default-settings
sed -i "3i uci set network.lan.dns='127.0.0.1'"  package/lean/default-settings/files/zzz-default-settings
sed -i "4i uci set network.lan.delegate='0'" package/lean/default-settings/files/zzz-default-settings
sed -i "5i uci set network.lan.gateway='192.168.1.1'" package/lean/default-settings/files/zzz-default-settings
sed -i "6i # ipv6 network config" package/lean/default-settings/files/zzz-default-settings
sed -i "7i uci set network.lan6='interface'" package/lean/default-settings/files/zzz-default-settings
sed -i "8i uci set network.lan6.proto='dhcpv6'" package/lean/default-settings/files/zzz-default-settings
sed -i "9i uci set network.lan6.ifname='eth0'" package/lean/default-settings/files/zzz-default-settings
sed -i "10i uci set network.lan6.delegate='0'" package/lean/default-settings/files/zzz-default-settings
sed -i "11i uci set network.lan6.reqaddress='try'" package/lean/default-settings/files/zzz-default-settings
sed -i "12i uci set network.lan6.reqprefix='auto'" package/lean/default-settings/files/zzz-default-settings
sed -i "13i uci set network.lan6.peerdns='0'" package/lean/default-settings/files/zzz-default-settings
sed -i "14i uci set network.lan6.dns='::1'" package/lean/default-settings/files/zzz-default-settings

#7. Replacement Argon to main theme
#sed -i 's/default Bootstrap theme/default Argon theme/g' feeds/luci/collections/luci/Makefile
#sed -i 's/+luci-theme-bootstrap/+luci-theme-argon/g' feeds/luci/collections/luci/Makefile

#8. Update dnscrypt-proxy2 2.0.45 to 2.1.1
#rm -rf feeds/packages/net/dnscrypt-proxy2
#git clone https://github.com/0xACE8/ace-packages.git feeds/packages/net/

#8. Update hysteria 0.9.6 to 0.9.7
#sed -i 's/"0.9.6"/"0.9.7"/g' feeds/passwall/hysteria/Makefile

#10. Change to my banner
sudo rm package/base-files/files/etc/banner
wget https://raw.githubusercontent.com/0xACE8/OP-Build-x64-UEFI/main/banner -O package/base-files/files/etc/banner
