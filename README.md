# 一键脚本 V2ray-ws-tls + Trojan 

一键就完事了，扫描二维码 或者 复制 vmess链接 无需关心复杂的V2ray 配置，websocket + tls 更安全，伪装更好。

* 自动生成 UUID （调用系统UUID库）
* 默认使用 caddy 自动获取证书
* 自动生成 安卓 v2rayNG vmess链接
* 自动生成 iOS shadowrocket vmess链接
* 自动生成 Android v2rayNG 二维码
* 集成 Trojan 自动生成密码（等于UUID）

## 使用方法

 * 提前安装好docker (请将docker升级至[最新版本](https://blog.csdn.net/jeikerxiao/article/details/83628833) )
 * 解析好域名 确认 你的域名正确解析到了你安装的这台服务器
 * 会占用 443 和 80 端口请提前确认没有跑其他的业务 （ lsof -i:80 和 lsof -i:443 能查看）
 * BUILD 容器, v2trj 可以换成自己的镜像名称，或者直接从docker hub上下载相关镜像。

```
sudo docker build -t v2trj .
```

 * 请将下面命令 v2trj sebs.club 和 testV2trj 分别换成自己的镜像名称，域名和节点名称！！！

```
sudo docker run -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  v2trj sebs.club testV2trj
```

 * Trojan 客户端配置文件需要修改 "remote_addr" 字段为自己的域名，密码为之前自动生成的UUID（服务端配置文件在/etc/trojan/config.json）

 * 跑完请复制保存好自己的 节点信息！（真心忘了或者丢了 sudo docker ps -a 查看 container id 然后 sudo docker stop containerID 重新跑就完事 ）

有问题欢迎提issue， 感谢 sebs.club。参考了 caddy docker 和 v2ray 的 docker 感谢！

## 查看节点信息

 * 查看容器ID
 * 进入容器，请将 container-id替换成自己的 容器ID

```
sudo docker exec -it container-id /bin/bash
```
 * 查看节点信息

```
node v2ray.js
```

 * 或者查看log信息
```
sudo docker logs -f container-id --tail 80
```

感谢pengchujin 感谢fake website的作者
