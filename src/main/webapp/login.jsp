<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>登录</title>
<meta http-equiv="Content-Type" charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- ZUI 标准版压缩后的 CSS 文件 -->
<link rel="stylesheet" href="css/zui.min.css">
<link rel="stylesheet" href="css/zui.css">
<link rel="stylesheet" href="css/zui.lite.css">
<link rel="stylesheet" href="css/zui.lite.min.css">
<link rel="stylesheet" href="css/zui-theme.css">
<link rel="stylesheet" href="css/zui-theme.min.css">

<script src="lib/jquery/jquery.js"></script>

<!-- ZUI 标准版压缩后的 JavaScript 文件 -->
<script src="js/zui.min.js"></script>
<script src="js/zui.lite.js"></script>
<script src="js/zui.lite.min.js"></script>
<script src="js/zui.js"></script>


</head>
<body>
		<div class="container">
		
		
			<div class="panel panel-success">
				<div class="panel-heading">用户信息</div>
				<div class="panel-body">
					<div class="input-control has-label-left">
						<input id="inputAccountExample2" type="text" name="username"
							class="form-control" placeholder="真实姓名"> <label
							for="inputAccountExample2" class="input-control-label-left">名字:</label>
					</div>
					<hr />
					<div class="input-control has-label-left">
						<input id="inputAccountExample2" type="text" name="telephone"
							class="form-control" placeholder="Tel"> <label
							for="inputAccountExample2" class="input-control-label-left">电话:</label>
					</div>


				</div>
			</div>
			
			
			
			<button class="btn btn-block " type="button">登录</button>
			<button class="btn btn-block " type="button">注册</button>
		
		
		</div>

</body>
</html>