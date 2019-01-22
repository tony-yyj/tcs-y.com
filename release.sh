#!/bin/sh bash
# 发布脚本，需要从jenkins中下载，然后复制到对应的项目中
# 发布工程目录
PROJ_DIR="$WORKSPACE"
# jenkins中： 执行shell bash deploy.sh
# 验证是否是root用户
if [ `whoami` = "root" ];then
    echo "root用户！"
else
    echo "非root用户！"
fi
echo "---------------开始构建-----------------------"

# 网站的访问目录为/data/wwwroot/tcs-y.com/public.
# 在访问目录下保留node_modules，以免除npm install 耗费时间
# 保留目录：db.json node_modules public    themes
# 删除目录：_config.yml package-lock.json README.md source package.json scaffolds                
# 进入项目文件删除原有的配置和src
cd '/data/wwwroot/tcs-y.com'
rm -rf 'src' 'index.html' 'package.json' 'tsconfig.json' 'webpack.config.js'
echo "---------------开始拷贝-----------------------"
# 开始拷贝
cp -r $PROJ_DIR/src '/data/wwwroot/tcs-y.com/'
cp -r $PROJ_DIR/index.html '/data/wwwroot/tcs-y.com/'
cp -r $PROJ_DIR/package.json '/data/wwwroot/tcs-y.com/'
cp -r $PROJ_DIR/tsconfig.json '/data/wwwroot/tcs-y.com/'
cp -r $PROJ_DIR/webpack.json '/data/wwwroot/tcs-y.com/'

echo "---------------拷贝结束-----------------------"

echo "---------------初始化npm-----------------------"
npm i
echo "---------------npm结束-----------------------"

echo "---------------打包开始-----------------------"
npm run build
echo "---------------打包结束-----------------------"