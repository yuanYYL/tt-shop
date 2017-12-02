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
<div id="itemListToolbar">
    <div style="padding: 5px; background-color: #fff;">
        <label>商品标题：</label>
        <input class="easyui-textbox" type="text" id="title">
        <label>商品状态：</label>
        <select id="status" class="easyui-combobox" style="width: 100px" >
            <option value="0">全部</option>
            <option value="1">正常</option>
            <option value="2">下架</option>
        </select>
        <!--http://www.cnblogs.com/wisdomoon/p/3330856.html-->
        <!--注意：要加上type="button",默认行为是submit-->
        <!--注意：不管<a>还是<button>只要添加class="easyui-linkbutton"，那么他们的外观样式是一样的-->
        <button onclick="searchForm()" type="button" class="easyui-linkbutton">搜索</button>
    </div>
    <div>
        <button onclick="add()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</button>
        <button onclick="edit()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</button>
        <button onclick="remove()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</button>
        <button onclick="down()" class="easyui-linkbutton" data-options="iconCls:'icon-down',plain:true">下架</button>
        <button onclick="up()" class="easyui-linkbutton" data-options="iconCls:'icon-up',plain:true">上架</button>
    </div>
</div>
<table id="dg"></table>
<script>
//    var toolbarArray=[{
//        iconCls: 'icon-add',
//        text:"添加",
//        handler: function(){
//            console.log("add");
//        }
//    },{
//        iconCls: 'icon-edit',
//        text:"编辑",
//        handler: function(){}
//    },{
//        iconCls: 'icon-remove',
//        text:'删除',
//        handler: function(){
//            var rows=$("#dg").datagrid("getSelections");
//            if(rows.length==0){
//                //没有选择任何记录
//                $.messager.alert('警告','请选择至少一条数据','warning');
//                return;
//            }
//            $.messager.confirm('确认','确定删除记录？',function (r) {
//                if(r){
//                    //定义一个数组用户存放选择的记录的id号
//                    var ids=[];
//                    for(var i=0;i<rows.length;i++){
//                        ids.push(rows[i].id);
//                    }
//                    $.post(
//                        //url，提交给后台谁去处理
//                        'items/delete',
//                        //data，提交什么到后台，ids
//                        {'ids[]':ids},
//                        function (data) {
//                            if(data>0){
//                                $('#dg').datagrid("reload");
//                            }
//                        }
//
//                    );
//                }
//            })
//
//        }
//    },{
//        iconCls: 'icon-up',
//        text:"上架",
//        handler: function(){
//            var rows=$("#dg").datagrid("getSelections");
//            if(rows.length==0){
//                $.messager.alert("警告","至少选择一条记录","warning");
//                return;
//            }
//            $.messager.confirm("确认","是否确人上架商品？",function (r) {
//                if(r){
//                    var ids=[];
//                    for(var i=0;i<rows.length;i++){
//                        ids.push(rows[i].id);
//                    }
//                    $.post(
//                        'items/putaway',
//                        {'ids[]':ids},
//                        function (data) {
//                            if(data>0){
//                                $('#dg').datagrid("reload");
//                            }
//                        }
//                    );
//                }
//            })
//
//        }
//    },{
//        iconCls: 'icon-down',
//        text:"下架",
//        handler: function(){
//            var rows=$('#dg').datagrid('getSelections');
//            if(rows.length==0){
//                $.messager.alert('警告','至少选择一条记录','warning');
//                return;
//            }
//            $.messager.confirm('确认','是否上架商品？',function (r) {
//                if(r){
//                    var ids=[];
//                    for(var i=0;i<rows.length;i++){
//                        ids.push(rows[i].id);
//                    }
//                    $.post(
//                        'items/soldout',
//                        {'ids[]':ids},
//
//                        function (data) {
//                            if(data>0){
//                                $('#dg').datagrid('reload');
//                            }
//                        }
//                    );
//                }
//            })
//        }
//    }
//
//    ];
    function searchForm() {
        $('#dg').datagrid('load',{
            title:$('#title').val(),
            status:$('#status').combobox('getValue')
        });
    }

    function add() {
        debugger;
        ttshop.closeTab("新增商品");
        ttshop.addTab("新增商品","item-add");
    }
    function edit() {
        var rows=$('#dg').datagrid('getSelected');
        if(rows.length>1){
            $.messager.alert('警告','一次只能编辑一条数据','warning');
            return ;
        }
        if(rows.length==0){
            $.messager.alert('警告','请选择一条数据','warning');
            return;
        }
        $.messager.confirm('提示','确认编辑记录？',function (r) {
           if(r){
               ttshop.closeTab('商品编辑');
               ttshop.addTab('商品编辑','itemEdit?cid='+rows.id);

           }
        });
    }
    function remove() {
        var rows=$("#dg").datagrid("getSelections");
            if(rows.length==0){
                //没有选择任何记录
                $.messager.alert('警告','请选择至少一条数据','warning');
                return;
            }
            $.messager.confirm('确认','确定删除记录？',function (r) {
                if(r){
                    //定义一个数组用户存放选择的记录的id号
                    var ids=[];
                    for(var i=0;i<rows.length;i++){
                        ids.push(rows[i].id);
                    }
                    $.post(
                        //url，提交给后台谁去处理
                        'items/delete',
                        //data，提交什么到后台，ids
                        {'ids[]':ids},
                        function (data) {
                            if(data>0){
                                $('#dg').datagrid("reload");
                            }
                        }

                    );
                }
            })
    }
    function up() {
        var rows=$("#dg").datagrid("getSelections");
            if(rows.length==0){
                $.messager.alert("警告","至少选择一条记录","warning");
                return;
            }
            $.messager.confirm("确认","是否确人上架商品？",function (r) {
                if(r){
                    var ids=[];
                    for(var i=0;i<rows.length;i++){
                        ids.push(rows[i].id);
                    }
                    $.post(
                        'items/putaway',
                        {'ids[]':ids},
                        function (data) {
                            if(data>0){
                                $('#dg').datagrid("reload");
                            }
                        }
                    );
                }
            })
    }
    function down() {
        var rows=$('#dg').datagrid('getSelections');
            if(rows.length==0){
                $.messager.alert('警告','至少选择一条记录','warning');
                return;
            }
            $.messager.confirm('确认','是否上架商品？',function (r) {
                if(r){
                    var ids=[];
                    for(var i=0;i<rows.length;i++){
                        ids.push(rows[i].id);
                    }
                    $.post(
                        'items/soldout',
                        {'ids[]':ids},

                        function (data) {
                            if(data>0){
                                $('#dg').datagrid('reload');
                            }
                        }
                    );
                }
            })
    }

    $('#dg').datagrid({
        //多列排序
        multiSort:true,
        //请求服务器端数据
        url:'items',
        //请求方式，默认是POST
        method: 'get',
        //设置pageSize
        pageSize:20,
        //是否显示分页工具栏
        pagination: true,
        //添加工具栏
        //toolbar:toolbarArray,
        toolbar:'#itemListToolbar',
       //充满父容器
        fit: true,
        //列属性
        columns:[[
            //复选框
            {field:'ck',checkbox:true},
            {field:'id',title:'商品编号',sortable:true},
            {field:'title',title:'商品名称',sortable:true},
            {field:'sellPoint',title:'商品卖点'},
            {field:'catName',title:'商品种类'},
            {field:'priceView',title:'商品价格'},
            {field:'created',title:'创建时间',formatter:function (value) {
                return moment(value).format("L");
            }},
            {field:'updated',title:'更改时间',formatter:function (value) {
                return moment(value).format("L");
            }},
            // {field:'statusName',title:'商品状态'},
            {field:'status',title:'商品状态',formatter:function(value,row,index){
//              console.group("商品状态");
//               console.log(value);
//               console.log(row);
//               console.log(index);
//              console.groupEnd();
                        switch (value){
                            case 1:
                                    return '正常';
                                    break;
                            case 2:
                                    return '下架';
                                    break;
                            case 3:
                                    return '删除';
                                    break;
                            default:
                                    return '未知';

                        }

            }}
        ]]
    });
</script>
</body>
</html>
