<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>

<body>
    <input type="file" multiple="multiple" id="test">
    <ul id='content'></ul>
</body>
<script>
var test = document.getElementById('test');
test.addEventListener('change', function() {
    var t_files = this.files;
    console.log(t_files);
    var str = '';
    for (var i = 0, len = t_files.length; i < len; i++) {
        console.log(t_files[i]);
        str += '<li>名称：' + t_files[i].name + '大小' + t_files[i].size / 1024 + 'KB</li>';
    };
    document.getElementById('content').innerHTML = str;
}, false);
</script>

</html>