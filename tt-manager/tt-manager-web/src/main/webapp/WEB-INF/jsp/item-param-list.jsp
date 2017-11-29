<%--
  User: Administrator
  Date: 2017/11/24
  Time: 13:53
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="toolbar">
    <div>
        <button type="button" onclick="add()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</button>
        <button type="button" onclick="edit()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</button>
        <button type="button" onclick="del()" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">删除</button>
    </div>
</div>
<table id="table"></table>

<script>
    $(function(){

        //列表
        $('#table').datagrid({
            title: '商品规格模板列表',
            //请求方式，默认是POST
            method: 'get',
            url:'itemParams',
            fit: true,
            rownumbers: true,
            pagination: true,
            pageSize:10,
            toolbar: '#toolbar',
            columns:[[
                {field:'ck', checkbox: true},
                {field:'id',title:'ID', sortable: true},
                /* {field:'itemCatId',title:'商品类目ID'}, */
                {field:'itemCatName',title:'商品类目'},
                {field:'paramData',title:'规格(只显示分组名称)', formatter:function(value,row,index){
                    //js中把字符串转换为对象（反序列化）
                    //js中把对象转换字符串（序列化）
                    var jsonObject=JSON.parse(value);
                    var arr=[];
                    $.each(jsonObject,function (i,n) {
                        arr.push(n.group);
                    });
                    return arr.join(',');
                }},
                {field:'created',title:'创建日期', formatter:function(value,row,index){
                    return moment(value).format('YYYY年MM月DD日,hh:mm:ss');
                }},
                {field:'updated',title:'更新日期', formatter:function(value,row,index){
                    return moment(value).format('YYYY年MM月DD日,hh:mm:ss');
                }}
            ]]

        });
    });
    function add(){
        ttshop.closeTab("新增规格参数");
        ttshop.addTab('新增规格参数', 'item-param-add');
    }
    function edit(){

    }
    function del(){
        //ttshop.executeOperation('未选中商品规格模板!', '确定删除所选商品规格模板吗？', 'item/param/delete?');
    }
</script>
