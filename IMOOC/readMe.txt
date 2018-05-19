1、项目中图片和视频要访问本地磁盘路径
	图片：D:\imooc\images\图片名
	视频：D:\imooc\video\视频名
	
	要设置虚拟目录，也就是说把硬盘上一个目录映射到tomcat的工作目录下，这样才能来访问
	我们在Eclipse中找到服务器，下面有个server.xml文件，点击打开
	在<Host>标签内加入如下代码(这一句代码非常重要)
	<Context crossContext="true" debug="0" docBase="D:\imooc\images" path="/imgUrl" reloadable="true"/>
	<Context crossContext="true" debug="0" docBase="D:\imooc" path="/imgUrl" reloadable="true"/>
	<Context crossContext="true" debug="0" docBase="D:\imooc" path="/videoUrl" reloadable="true"/> 
	其中docBase就是本地电脑的绝对路径
	path就是设置的虚拟路径
	修改完之后需要重启tomcat服务器。
	
	tomcat虚拟路径无法访问中文路径: 解决办法如下：
	
	因为tomcat默认编码不是utf-8，需要设置下；
	需在conf/server.xml文件中<Connector >标签中添加以下内容     URIEncoding="utf-8"
	
    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" URIEncoding="utf-8"/>

	重启tomcat后正常访问；

2、mysql 中创建表时，时间类型为Timestamp的字段  ，在插入、修改、更新时，时间字段会自动更新时间，
	应在navicat中，把创建的comments(评论表)、question(提问表)、note(笔记表)、reply(回复表)几张表，
	打开--设计表--选中时间字段--然后把"根据当前时间戳更新"的勾选状态去掉，
	同时，在后台对这几张表进行插入、修改、更新时，把时间字段 赋值为 当前时间字段，这样数据库就不会更新这个时间字段了
	



/*---------------------------------------
运行方式： 运行项目，在网页中输入http://localhost:8080/IMOOC/就可以访问到了
---------------------------------------*/