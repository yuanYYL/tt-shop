<%--
  User: Administrator
  Date: 2017/11/20
  Time: 20:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<table id="dg"></table>
<script>
    $('#dg').datagrid({
        //请求服务器端数据
        url:'items',
        //请求方式，默认是POST
        method: 'get',
        //是否显示分页工具栏
        pagination: true,
        fit: true,
        //列属性
        columns:[[
            {field:'id',title:'代码',width:100},
            {field:'title',title:'名称',width:100},
            {field:'num',title:'价格',width:100,align:'right'}
        ]]
    });
</script>
</body>
</html>
