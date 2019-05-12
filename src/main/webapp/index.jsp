<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" charset="utf-8">
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

<!-- jquery是其他js的依赖，所以必须放在最上面 -->
<script src="lib/jquery/jquery.js"></script>

<!-- ZUI 标准版压缩后的 JavaScript 文件 -->
<script src="js/zui.min.js"></script>
<script src="js/zui.lite.js"></script>
<script src="js/zui.lite.min.js"></script>
<script src="js/zui.js"></script>

<!-- 文件上传 -->
<script src="lib/uploader/zui.uploader.js"></script>
<script src="lib/uploader/zui.uploader.min.js"></script>
<link rel="stylesheet" href="lib/uploader/zui.uploader.css">
<link rel="stylesheet" href="lib/uploader/zui.uploader.min.css">



<script type="text/javascript">
	$(document).ready(function() {
		//依赖于jQuery的代码
	
	});

	function check() {
		if (form1.username.value == "") {
			alert("用户名不可为空!");
			form1.username.focus();
			return false;
		}
		if (form1.telephone.value == "") {
			alert("手机号码不可为空!");
			form1.telephone.focus();
			return false;
		}
		if (form1.file1.value == "" && form1.file2.value == ""
				&& form1.file3.value == "") {
			alert("你没有选择文件！");
			form1.file1.focus();
			return false;
		} else {
			var flag = 2;
			if (form1.file1.value != "") {
				if (form1.file1.value.indexOf("doc") > 0
						|| form1.file1.value.indexOf("docx") > 0
						|| form1.file1.value.indexOf("ppt") > 0
						|| form1.file1.value.indexOf("pptx") > 0
						|| form1.file1.value.indexOf("pdf") > 0) {
					//flag=2
				} else {
					flag = 1;
					form1.file1.focus();
				}
			}

			if (form1.file2.value != "") {
				if ((form1.file2.value.indexOf("doc") > 0
						|| form1.file2.value.indexOf("docx") > 0
						|| form1.file2.value.indexOf("ppt") > 0
						|| form1.file2.value.indexOf("pptx") > 0 || form1.file2.value
						.indexOf("pdf") > 0)) {
					//flag=2
				} else {
					flag = 1;
					form1.file2.focus();
				}
			}
			if (form1.file3.value != "") {
				if (form1.file3.value.indexOf("doc") > 0
						|| form1.file3.value.indexOf("docx") > 0
						|| form1.file3.value.indexOf("ppt") > 0
						|| form1.file3.value.indexOf("pptx") > 0
						|| form1.file3.value.indexOf("pdf") > 0) {
					//flag=2
				} else {
					flag = 1;
					form1.file3.focus();
				}
			}
			if (flag == 1) {
				alert("你选择的文件不支持打印！");

				return false;
			}
			;
		}

		var sm, hy, cp;
		if (form1.shuangmian.value == "shuangmian") {
			sm = "双面";
		} else if (form1.shuangmian.value == "danmian") {
			sm = "单面";
		} else
			sm = form1.shuangmian.value;
		;

		if (form1.heyi.value == "yiheyi") {
			hy = "一合一";
		} else if (form1.heyi.value == "liuheyi") {
			hy = "六合一";
		} else if (form1.heyi.value == "baheyi") {
			hy = "八合一";
		} else
			hy = form1.heyi.value;

		if (form1.copies.value == "one") {
			cp = "1份";
		} else if (form1.copies.value == "two") {
			cp = "2份";
		} else if (form1.copies.value == "three") {
			cp = "3份";
		}
		like = window.confirm("打印方式：" + sm + "," + hy + "," + cp);
		if (like == true)
			//　document.write("谢谢你的夸奖");//确定
			return true;//确定打印
		else {
			return false;
		}
		//  document.write("谢谢您的使用！");//取消
	}

	/*
	 function checkFile(el){
	 var files = el.files;  //获取选择的文件对象
	 var allowTypes = ["application/msword","application/pdf","application/vnd.openxmlformats-officedocument.wordprocessingml.document","application/vnd.ms-powerpoint","application/vnd.openxmlformats-officedocument.presentationml.presentation"]; //允许上传的文件类型
	 var maxFileSize = 5 * 1024 * 1024;  //允许上传的单个文件的大小限制，最大能上传50M
	 var allowUpload = true; //经过校验之后是否允许上传
	 var errorMessage = "";  //校验文件之后，文件不符合要求的提示信息
	
	 for(var i=0; i< files.length; i++){
	 var fileName = files[i].name;    //文件名
	 var fileType = files[i].type;    //文件类型
	 var fileSize = files[i].size;    //文件大小，单位为byte（字节）
	
	 var typeAccepted = false;
	 for(var j = 0; j < allowTypes.length; j++){
	 if(allowTypes[j] == fileType){
	 typeAccepted = true;
	 break;
	 }
	 }
	 if(typeAccepted != true){
	 errorMessage += fileName + "不是图片，只能上传图片！"+fileType;
	 allowUpload = false;
	 }
	 else
	 alet(fileName);
	
	 if(typeAccepted && fileSize > maxFileSize){
	 errorMessage += fileName+"的文件大小超出了50M限制！";
	 allowUpload = false;
	 }
	 }
	
	 if(allowUpload != true){
	 el.outerHTML = el.outerHTML; //清空选择的文件
	 alert(errorMessage);
	 }
	
	 }
	 */
	function checkFile(el) {

		document.getElementById('content').innerHTML = "";
		var t_files = el.files;
		console.log(t_files);
		console.log(t_files.length);
		var str = '';
		var allowTypes = [
				"application/msword",
				"application/pdf",
				"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
				"application/vnd.ms-powerpoint",
				"application/vnd.openxmlformats-officedocument.presentationml.presentation" ]; //允许上传的文件类型
		var maxFileSize = 30 * 1024 * 1024; //允许上传的单个文件的大小限制，最大能上传30M
		var allowUpload = true; //经过校验之后是否允许上传
		var errorMessage = ""; //校验文件之后，文件不符合要求的提示信息

		for (var i = 0; i < t_files.length; i++) {
			var fileName = t_files[i].name; //文件名
			var fileType = t_files[i].type; //文件类型
			var fileSize = t_files[i].size; //文件大小，单位为byte（字节）

			var typeAccepted = false;
			for (var j = 0; j < allowTypes.length; j++) {
				if (allowTypes[j] == fileType) {
					typeAccepted = true;
					break;
				}
			}
			if (typeAccepted == true) {

				str += '<li>' + fileName + '</li>';
				allowUpload = true;

			} else {
				errorMessage += fileName + "格式不对！";
				allowUpload = false;
				break;
			}

			if (typeAccepted && fileSize > maxFileSize) {
				errorMessage += fileName + "的文件大小超出了5M限制！";
				allowUpload = false;
			}
		}

		if (allowUpload != true) {
			this.outerHTML = this.outerHTML; //清空选择的文件
			alert(errorMessage);
			document.getElementById('content').innerHTML = errorMessage;
		} else {
			document.getElementById('content').innerHTML = str;
		}

	}

	function showPreview(source) {
		var arrs = $(source).val().split('\\');
		var filename = arrs[arrs.length - 1];
		$(".show").html(filename);
		var file = source.files[0];
		var total = file.size;
		if (window.FileReader) {
			var fr = new FileReader();
			fr.onprogress = function(e) {
				$(".progress1").show();
				$("#Progress").val((e.loaded / total) * 100)
			};
			fr.onabort = function() {
				layer.msg("文件上传中断,请重试")
			};
			fr.onerror = function() {
				layer.msg("文件上传出错，请重试")
			};
			fr.onload = function() {
				$(".progress1").hide();
				layer.msg("文件上传成功")
			};
			fr.readAsDataURL(file);
		}
	}
</script>


</head>
<body style="margin-top: 10px;">


	<div class="container">




		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<!-- 导航头部 -->
				<div class="navbar-header">
					<!-- 移动设备上的导航切换按钮 -->
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse-example">
						<span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span
							class="icon-bar"></span> <span class="icon-bar"></span>
					</button>
					<!-- 品牌名称或logo -->
					<a class="navbar-brand" href="#">在线云打印</a>
				</div>
				<!-- 导航项目 -->
				<div class="collapse navbar-collapse navbar-collapse-example">
					<!-- 一般导航项目 -->
					<ul class="nav navbar-nav">
						<li class="active"><a href="your/nice/url">书单</a></li>
						<li><a href="login.jsp">登录</a></li>

						<!-- 导航中的下拉菜单 -->
						<li class="dropdown"><a href="your/nice/url"
							class="dropdown-toggle" data-toggle="dropdown">管理 <b
								class="caret"></b></a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="your/nice/url">任务</a></li>

							</ul></li>
					</ul>
				</div>
				<!-- END .navbar-collapse -->
			</div>
		</nav>







		<!-- 
<ul class="nav nav-primary nav-justified" style="margin-top: 10px;margin-bottom:10px" >
  <li class="active"><a href="your/noce/url">首页</a></li>
  <li><a href="your/noce/url">动态 <span class="label label-badge label-success">4</span></a></li>
 <li class=><a href="your/noce/url">登录</a></li>
</ul>
 -->

		<div class="panel panel-success">
			<div class="panel-heading">温馨提示</div>
			<div class="panel-body">
				<ol>
					<li>目前支持Word，Ppt，Pdf三种格式的文档。即后缀名为doc，docx，ppt，pptx，pdf的文档！</li>
					<li>最新苹果手机系统用户需要先将文件放到云盘，之后再从云盘选择文件。</li>
					<li>为防止恶意打印，用户需要先与管理员联系（QQ:3227556776），核实身份信息。以后填上自己名字与号码即可打印。</li>
					<li>打印入口关注微信公众号：尖斌卡</li>
					<li>手机的QQ浏览器支持同时选择多个文件。</li>
					<li><b>温馨提示：由于office2003,2007,2010,2016等各个版本及WPS之间的兼容性有点点偏差。表格，文档格式要求很高的建议先使用WPS把word,ppt转成PDF格式，然后再上传。保证打印的格式正确。</b><a
						href="https://zhidao.baidu.com/question/510244573.html"
						target="_blank">word转pdf操作指导</a></li>
					<li><a href="https://smallpdf.com/word-to-pdf" target="_blank">在线Word转Pdf网站</a></li>
				</ol>
			</div>
		</div>


		<form name="form1" onSubmit="return check()"
			action="${pageContext.request.contextPath}/servlet"
			enctype="multipart/form-data" method="post">




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



			<div class="panel panel-success">
				<div class="panel-heading">文档选择</div>
				<div class="panel-body">
					<ul>

						<!-- ZUi上传组件 -->
						<div id='uploaderExample' class="uploader" data-ride="uploader"
							data-url="${pageContext.request.contextPath}/uploadFile">
							<div class="uploader-message text-center">
								<div class="content"></div>
								<button type="button" class="close">×</button>
							</div>
							<div class="uploader-files file-list file-list-lg"
								data-drag-placeholder="请拖拽文件到此处"></div>
							<div class="uploader-actions">
								<div class="uploader-status pull-right text-muted"></div>
								<button type="button" class="btn btn-link uploader-btn-browse">
									<i class="icon icon-plus"></i> 选择文件
								</button>
								<button type="button" class="btn btn-link uploader-btn-start">
									<i class="icon icon-cloud-upload"></i> 开始上传
								</button>
							</div>
						</div>



						<!-- 原生上传框架 -->

						<!-- 
						<li><div style="color: #3280FC;">
								<input id="test" type="file" name="file1" multiple
									class="form-control" onchange="checkFile(this)"><br />
							</div></li>
						<li><div style="color: #3280FC;">
								<input type="file" name="file2" class="form-control"
									onchange="showPreview(this)"><br />
							</div></li>
						<li><div style="color: #3280FC;">
								<input type="file" name="file3" class="form-control"><br />
							</div></li>

						<li style="list-style-type: none"><div
								style="color: #3280FC;">
								<ul id="content"></ul>
							</div></li>
							
							 -->
							
						<div class="radio">
							<label> <input type="radio" name="shuangmian"
								value="shuangmian" checked> 双面打印

							</label> <label> <input type="radio" name="shuangmian"
								value="danmian"> 单面打印
							</label>
						</div>



						<div class="radio">
							<label> <input type="radio" name="heyi" value="yiheyi"
								checked> 一面一页
							</label> <label style="margin-top: 10px"> <input type="radio"
								name="heyi" value="liuheyi"> 六面一页
							</label> <label style="margin-top: 10px"> <input type="radio"
								name="heyi" value="baheyi"> 八面一页
							</label> <br /> <select style="margin-top: 10px" name="copies">
								<option value="one" selected>1份&nbsp;&nbsp;</option>
								<option value="two">2份&nbsp;&nbsp;</option>
								<option value="three">3份&nbsp;&nbsp;</option>
							</select>

						</div>




					</ul>
				</div>
			</div>

			<button style="color: #FFFFFF; background-color: #3280FC;"
				class="btn btn-block " type="submit">确认提交打印</button>
		</form>
		<hr />
		<div align="center" style="margin-bottom: 10px">
			我的链接： <a href="about.jsp" target="_blank">关于打印</a><br />
			<!--  a href="http://www.cup.edu.cn/" target="_blank">中国石油大学北京</a> <br/-->
			版权所有@2018 &nbsp;傲寒宏志&nbsp; 京ICP备18028985号<br />管理员邮箱：aohanhongzhi@126.com<br />
			地址：帝都皇城脚下，东经：116° &nbsp;&nbsp;北纬：23°
		</div>


		<!-- jQuery (ZUI中的Javascript组件依赖于jQuery) -->
		<!--  script src="//code.jquery.com/jquery-1.11.0.min.js"></script-->
		<!-- ZUI Javascript组件
		<script src="js/zui.min.js"></script> -->
	</div>
	<!-- script>
var test = document.getElementById('test');
test.addEventListener('change', function() {
	 document.getElementById('content').innerHTML = "";
    var t_files = this.files;
    console.log(t_files);
    var str = '';
	 var allowTypes = ["application/msword","application/pdf","application/vnd.openxmlformats-officedocument.wordprocessingml.document","application/vnd.ms-powerpoint","application/vnd.openxmlformats-officedocument.presentationml.presentation"]; //允许上传的文件类型
	 var maxFileSize = 5 * 1024 * 1024;  //允许上传的单个文件的大小限制，最大能上传50M
	 var allowUpload = true; //经过校验之后是否允许上传
	 var errorMessage = "";  //校验文件之后，文件不符合要求的提示信息
	 
	 for(var i=0; i< t_files.length; i++){
	      var fileName = t_files[i].name;    //文件名
	      var fileType = t_files[i].type;    //文件类型
	      var fileSize = t_files[i].size;    //文件大小，单位为byte（字节）
	      
	      var typeAccepted = false;
	      for(var j = 0; j < allowTypes.length; j++){
	    	  if(allowTypes[j] == fileType){
                  typeAccepted = true;
                  break;
	    	  }
	      }
	      if(typeAccepted == true){
	    	  
	    	  str += '<li>' + fileName +fileType+'</li>';
	    	  allowUpload=true;
	    	  
	      }else{
	    	  errorMessage += fileName + "格式不对！";
	    	  allowUpload = false;
	    	  break;
	      }
	      
	      if(typeAccepted && fileSize > maxFileSize){
	    	  errorMessage += fileName+"的文件大小超出了5M限制！";
	    	  allowUpload = false;
	      }
	 }
	 
	 if(allowUpload != true){
		 this.outerHTML = this.outerHTML; //清空选择的文件
		 alert(errorMessage);
		 document.getElementById('content').innerHTML = errorMessage;
	 }else
		 {
		    document.getElementById('content').innerHTML = str;
		 }
    
    
    
    
    
    
}, false);
</script>
	 -->
</body>

</html>