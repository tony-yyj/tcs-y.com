# 发布脚本，需要从jenkins中下载，然后复制到对应的项目中

npm run build

rm -rf *.tar.gz

tar zcvf dist.tar.gz ./dist


scp ./dist.tar.gz root@121.41.40.138:/data/wwwroot/tcs-y.com/

ssh -tt root@121.41.40.138 << remotessh
cd /data/wwwroot/tcs-y.com/
rm -rf dist
tar zxvf dist.tar.gz
exit;
remotessh  