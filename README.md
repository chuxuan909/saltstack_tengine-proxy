# 使用saltstack的state来部署tengine反向代理
## 功能介绍
- 部署后，tengine可以本地处理静态的图片和css、js、html文件请求，将动态的jsp、php文件发送给后端负载主机集群处理；当tengine本地无静态文件时，先从后端服务器中获取，并缓存到本地，之后直接从本地缓存响应静态请求。
- 后端负载主机ip和负载方式配置，需要修改upstream.conf文件（tomcat对应jsp处理集群、apache对应php处理集群）

## 注意事项
1. 需要安装saltstack自动运维工具，安装完成后，直接运行tengine.sls模块即可实现部署。

## 配置文件介绍
- tengine.sls 和 top.sls
   - saltstack的master端的入口文件和模块文件
- intengine.sh
   - tengine反向代理的安装部署脚本
- 404.html
   - 简单的网页404界面html文件
- anti-theft_chain.conf
   - tengine防盗链配置文件
- nginx
   - tengine启动脚本
- nginx.conf
   - tengine主配置文件
- upstream.conf
   - 负载主机集群配置文件
- enable-php.conf
   - 本地处理php请求配置文件，如果php不在本地tengine服务器处理，删除此文件
- proxy-file.conf
   - 静态文件代理配置文件
- proxy-jsp.conf
   - jsp文件代理配置文件
- proxy-php.conf
   - php文件代理配置文件
