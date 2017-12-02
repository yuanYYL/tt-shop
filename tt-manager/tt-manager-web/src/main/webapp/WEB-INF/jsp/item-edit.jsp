<%--
  User: Administrator
  Date: 2017/11/20
  Time: 20:00
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div style="margin:20px 0;"></div>
<div class="easyui-panel" title="商品编辑" data-options="fit:true">
    <form id="itemAddForm" method="post">
        <div style="margin-left: 300px;margin-bottom: 20px;margin-top: 20px">
            <input name="editid" id="editid" style="width:40%" data-options="label:'商品条目:'">
            <input name="id" id="id" style="display: none" value="${item.id}">
            <p id="catNum" style="display: none;">${item.cid}</p>
            <p id="catName" style="display: none;">${item.catName}</p>
            <p id="pData" style="display: none;">${item.paramData}</p>
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px;margin-top: 20px">
            <input class="easyui-textbox" name="title" style="width:40%" data-options="label:'商品标题:',required:true"
                   value="${item.title}">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px">
            <input class="easyui-textbox" name="sellPoint" style="width:40%;height: 60px"
                   data-options="label:'商品卖点:',multiline:true,validType:'length[0,100]'" value="${item.sellPoint}">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px">
            <input class="easyui-numberbox" name="priceEdit" id="priceEdit" style="width:40%"
                   data-options="label:'商品价格:',required:true,min:0,precision:2" value="${item.priceEdit}">
            <input id="price" name="price" type="hidden">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px">
            <input class="easyui-numberbox" name="num" style="width:40%"
                   data-options="label:'商品库存:',required:true,min:0,max:9999,precision:0" value="${item.num}">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px">
            <input class="easyui-textbox" type="text" name="barcode" style="width:40%"
                   data-options="label:'条形码:',validType:'length[0,30]'" value="${item.barcode}">
        </div>
        <div>
            <!-- 加载编辑器的容器 -->
            <script id="container" name="content" type="text/plain"></script>
        </div>
        <div>
            <p class="param_Show" style="display: none;margin-left: 200px;font-size: 18px;">规格参数:</p>
            <div style="margin-left: 300px;margin-bottom: 20px" class="paramShow">
            </div>
        </div>
        <%--规格参数--%>
        <div><input id="paramData" name="paramData" style="display: none;">
        </div>

        <code id="testcontent" style="display:none;">
            ${item.content }
        </code>

    </form>
    <div style="padding:5px 0;margin-left: 50px">
        <button onclick="submitForm()" class="easyui-linkbutton" type="button"
                data-options="iconCls:'icon-ok'">保存
        </button>
        <button onclick="clearForm()" class="easyui-linkbutton" type="button"
                data-options="iconCls:'icon-undo'">重置
        </button>
    </div>

</div>

<script>


    //初始化富文本编辑器
    UE.delEditor("container")
    var ue = UE.getEditor('container', {
        initialFrameWidth: 1000,
        initialFrameHeight: 300,
        serverUrl: 'file/upload'
    });

    //向富文本中赋值
    $(function () {
        window.setTimeout(setContent, 1000);//一秒后再调用赋值方法
    });

    function setContent() {
        UE.getEditor('container').execCommand('insertHtml', $('#testcontent').html());
    }


    $('#editid').combotree({
        //检索远程数据的URL地址
        url: 'itemCats?parentId=0',
        required: true,
        //检索数据的HTTP方法，默认是POST请求
        method: 'get',
        editable: true,
        //页面加载成功后，选择商品条目
        onLoadSuccess: function (node, data) {
            $('#editid').combotree('setValue', {id: $('#catNum').html(), text: $('#catName').html()});
            //判断该商品是否有规格参数，有则生成规格参数并向里面填值
            $.get(
                'itemParam/' + $('#catNum').html(),
                function (data) {
                    //拿到dataParam json字符串
                    var pData = $('#pData').html();
                    //转换成json对象
                    pData = JSON.parse(pData);
                    var $div = $('#itemAddForm .paramShow');
                    var $table = $('<table>');
                    $div.empty().append($table);
                    if (data) {
                        var paramData = data.paramData;
                        paramData = JSON.parse(paramData);
                        $.each(paramData, function (i, n) {
                            var $group = $('<tr><td id="group" style="color: indianred;">' + n.group + '</td>');
                            $table.append($group);
                            if (n.params) {
                                $.each(n.params, function (j, paramName) {
                                    $('#')
                                    //alert(pData[i].params[j].v)
                                    var $params = $('<tr><td id="param">' + paramName + '</td><td><input></td></tr>');
                                    $group.append($params);
                                    //向规格参数中赋值
                                    var g = $('.paramShow [id=group]');
                                    var p = $(g[i]).parent().find('[id=param]');
                                    $(p[j]).next('td').find('input').val(pData[i].params[j].v);
                                });
                            }
                        });

                        $('#itemAddForm .param_Show').show();
                    }
                },
                'json'
            );
        },


        onBeforeExpand: function (node) {
            //获取当前树
            //获取当前树控件的属性
            var options = $('#editid').combotree('tree').tree('options');
            //修改控件属性url变成新的nodeid
            options.url = 'itemCats?parentId=' + node.id;
        },

        onBeforeSelect: function (node) {
            //判断是否为叶子节点
            var isLeaf = $('#editid').tree('isLeaf', node.target);
            if (!isLeaf) {
                //不是叶子节点
                $.messager.alert('警告', '请选择最终类目', 'warning');
                return false;
            } else {
                // console.log(node.id);
                $.get(
                    'itemParam/' + node.id,
                    function (data) {
                        var $div = $('#itemAddForm .paramShow');
                        var $table = $('<table>');
                        $div.empty().append($table);
                        if (data) {
                            var paramData = data.paramData;
                            paramData = JSON.parse(paramData);
                            $.each(paramData, function (i, n) {
                                var $group = $('<tr><td id="group" style="color: indianred;">' + n.group + '</td>');
                                $table.append($group);
                                if (n.params) {
                                    $.each(n.params, function (j, paramName) {
                                        var $params = $('<tr><td id="param">' + paramName + '</td><td><input></td></tr>');
                                        $group.append($params);
                                    });
                                }
                            });
                            $('#itemAddForm .param_Show').show();
                        }
                    },
                    'json'
                );
                $('#itemAddForm .param_Show').hide();
                $('#itemAddForm .paramShow').empty();
            }
        }


    });


    //表单提交动作
    function submitForm() {
        $("#itemAddForm").form('submit', {
            //表单提交后交给谁处理
            url: 'item/edit',
            //表单提交之前被触发，如果返回false终止提交
            onSubmit: function () {
                //处理价格
                $('#price').val($('#priceEdit').val() * 100);
                //规格参数
                var groupValue = [];
                var $group = $('.paramShow [id=group]');
                $group.each(function (i, n) {
                    var paramValue = [];
                    var groupName = $(n).text();
                    // alert(groupName);
                    var $param = $(n).parent().find('[id=param]');
                    $param.each(function (_i, _n) {
                        var paramName = $(_n).text();

                        var $input = $(_n).next('td').find('input');
                        var inputValue = $input.val();
                        //alert(paramName+':'+inputValue);
                        var _obj = {};
                        _obj.k = paramName;
                        _obj.v = inputValue;
                        paramValue.push(_obj);
                    });
                    var obj = {};
                    obj.group = groupName;
                    obj.params = paramValue;
                    groupValue.push(obj);
                });
                groupValue = JSON.stringify(groupValue);
                //alert(groupValue);
                $('#paramData').val(groupValue);
                return $("#itemAddForm").form('validate');
            },
            //表单提交成功后触发，而非item处理成功后触发
            success: function (data) {
                if (data > 0) {
                    ttshop.closeTab('查询商品');
                    ttshop.closeTab('商品编辑');
                    ttshop.addTab('查询商品', 'item-list');
                    $.messager.alert('消息', '修改成功！！', 'info');
                }
            }
        })
    }

    function clearForm() {
        $('#itemAddForm').form('reset');
    }
</script>

</body>
</html>
