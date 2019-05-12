<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type"  charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>在线云打印</title>
	<!-- ZUI 标准版压缩后的 CSS 文件 -->
	<link rel="stylesheet" href="css/zui.min.css">
	<link rel="stylesheet" href="css/zui.css">
	<link rel="stylesheet" href="css/zui.lite.css">
	<link rel="stylesheet" href="css/zui.lite.min.css">
	<link rel="stylesheet" href="css/zui-theme.css">
	<link rel="stylesheet" href="css/zui-theme.min.css">
	<!-- ZUI Javascript 依赖 jQuery
	<script src="lib/jquery/jquery.js"></script>
	<!-- ZUI 标准版压缩后的 JavaScript 文件 
	<script src="js/zui.min.js"></script>
	<script src="js/zui.lite.js"></script>
	<script src="js/zui.lite.min.js"></script>
	<script src="js/zui.js"></script>
	 -->
	
</head>
<body style="margin-top:10px;">

	<div class="container">

		
		<div class="panel panel-success">
			<div class="panel-heading">
				上传结果
			</div>
			<div class="panel-body">
				<p><font size="5">hello， ${name}</font></p>
				<p><font size="5">${message}</font></p>
				<p>59秒后返回首页。</p>
				
			</div>
			<div style="margin:0 auto;">
			<img src="wechat.png" width="200px" height="200px" class="img-rounded" alt="圆角图片">
			</div>
		</div>
		<%  response.setHeader("Refresh", "59;url=index.jsp ");  %>
		<hr/>
	<div  align="center" style="margin-bottom:10px">
			我的链接： <a href="about.jsp" target="_blank">关于打印</a><br/> <!--  a href="http://www.cup.edu.cn/" target="_blank">中国石油大学北京</a> <br/-->
		  版权所有@2018 &nbsp;傲寒宏志&nbsp; 京ICP备18028985号<br/>管理员邮箱：aohanhongzhi@126.com<br/>
		  地址：帝都皇城脚下，东经：116°  &nbsp;&nbsp;北纬：23°
		</div>
	
		 <!-- jQuery (ZUI中的Javascript组件依赖于jQuery)
		<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	    <!-- ZUI Javascript组件 
		<script src="js/zui.min.js"></script> -->
	</div>
	
</body>

</html>