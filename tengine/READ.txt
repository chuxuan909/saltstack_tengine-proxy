新增模块：
1.ngx_cache_purge
ngx_cache_purge是第三方模块，用于清理nginx内置模块（proxy_cache）缓存。就像CDN的清理缓存的url命令一样。 

2.ngx_http_reqstat_module
这个模块计算定义的变量，根据变量值分别统计Tengine的运行状况。
可以监视的运行状况有：连接数、请求数、各种响应码范围的请求数、输入输出流量、rt、upstream访问等。

3.http_upstream_check_module
为Tengine提供主动式后端服务器健康检查的功能



测试功能：
1. 反向代理
  - 图片第一次从后端服务器读取，缓存到nginx服务器，之后相同的图片请求直接从nginx服务器中取
    当请求到nginx服务中没有的时，再从后端服务器中取，并缓存到nginx服务器
  - 遇到jsp请求，直接将请求转发到后端的tomcat服务器
2. 负载均衡测试
  - 图片读取
  - 轮询和哈希
3. 后端自动检测
  - 后端服务down===>自动剔除出负载均衡集群
  - 后端服务恢复===>检测到rise状态后（每3秒检测一次，检测2此后为rise状态）重新加入负载均衡集群

  
  
其他：
1. 版本隐藏
server_tag off;
server_info off;
server_tokens off;