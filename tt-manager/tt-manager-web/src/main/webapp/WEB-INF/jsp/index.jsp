<%--
  User: Administrator
  Date: 2017/11/20
  Time: 14:03
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="js/jquery-easyui-1.5/themes/bootstrap/easyui.css">
    <link rel="stylesheet" href="js/jquery-easyui-1.5/themes/icon.css">
    <link rel="stylesheet" href="css/common.css">
</head>
<body class="easyui-layout">
<div data-options="region:'north',title:'天天商城后台管理系统',collapsible:false"></div>
<div data-options="region:'south',title:'系统版本：2.0',collapsible:false"></div>
<div data-options="region:'west'" style="width:200px;">
    <div id="menu" class="easyui-accordion" style="width:300px;height:200px;">
        <div title="商品管理" data-options="iconCls:'icon-save',selected:true" style="padding:10px 0;">
            <ul class="easyui-tree">
                <li data-options="attributes:{'href':'item-add'}">新增商品</li>
                <li data-options="attributes:{'href':'item-list'}">查询商品</li>
                <li data-options="attributes:{'href':'item-param-add'}">新增规格参数</li>
                <li data-options="attributes:{'href':'item-param-list'}">查询规格参数</li>
            </ul>
        </div>
        <div title="网站内容管理" data-options="iconCls:'icon-reload'" style="padding:10px 0;">
            <ul class="easyui-tree">
                <li data-options="attributes:{'href':'content-category'}">内容分类管理</li>
                <li data-options="attributes:{'href':'content'}">内容管理</li>
            </ul>
        </div>
        <div title="索引库管理" data-options="iconCls:'icon-tip'" style="padding: 10px 0;" >
           <ul class="easyui-tree">
            <li data-options="attributes:{'href':'index-item'}">solr索引库维护</li>
            </ul>
        </div>
    </div>

</div>
<div  data-options="region:'center'" style="padding:5px;background:#eee;">
    <div id="tab" class="easyui-tabs" data-options="fit:true">
        <div title="欢迎页面" style="padding:20px;">111</div>
    </div>
</div>


<!-- jquery -->
<script src="js/jquery-easyui-1.5/jquery.min.js"></script>
<!-- jquery easyui -->
<script src="js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script src="js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<%--添加数据转换moment--%>
<script src="js/moment/moment-with-locales.js"></script>
<%--自己写的js--%>
<script src="js/commom/common.js"></script>
<%--添加富文本编辑器的相关文件--%>
<script src="js/ueditor/ueditor.config.js"></script>
<script src="js/ueditor/ueditor.all.js"></script>
<script>
    moment.locale("zh_cn");
</script>


<script>
   ttshop.registerMenuEvent();

    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl = function(action) {
        if (action == 'uploadimage') {
            return 'http://localhost:8080/ttshop/file/upload';
        }else {
            return this._bkGetActionUrl.call(this, action);
        }
    }
</script>

<%--<script>--%>

<%--//    $(function () {--%>
<%--//        //约定大于配置：定义DOM对象的时候，一般定义为tree--%>
<%--//        //定义的是一个jquery对象的话，一般定义为$tree--%>
<%--//        var $tree = $('#menu .easyui-tree');--%>
<%--//        $tree.tree({--%>
<%--//            onClick: function (node) {--%>
<%--//                if($('#tabs').tabs('exists',node.text)){--%>
<%--//                    //选项卡存在--%>
<%--//                    $('#tabs').tabs('select',node.text)--%>
<%--//                }else{--%>
<%--//                    //新增选项卡--%>
<%--//                    $('#tabs').tabs('add', {--%>
<%--//                        title: node.text,--%>
<%--//                        href: node.attributes.href,--%>
<%--//                        closable: true--%>
<%--//                    });--%>
<%--//                }--%>
<%--//            }--%>
<%--//        });--%>
<%--//    });--%>
<%--</script>--%>
</body>
</html>
