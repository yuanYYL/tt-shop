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
<div class="easyui-panel" title="新增商品" data-options="fit:true">
    <form id="itemAddForm" method="post">
        <div style="margin-left: 300px;margin-bottom: 20px;margin-top: 20px">
            <input name="cid" id="cid" style="width:40%" data-options="label:'商品条目:'">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px;margin-top: 20px">
            <input class="easyui-textbox" name="title" style="width:40%" data-options="label:'商品标题:',required:true">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px">
            <input class="easyui-textbox" name="sellPoint" style="width:40%;height: 60px"
                   data-options="label:'商品卖点:',multiline:true,validType:'length[0,100]'">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px">
            <input class="easyui-numberbox" name="priceView" id="priceView" style="width:40%"
                   data-options="label:'商品价格:',required:true,min:0,precision:2">
            <input id="price" name="price" type="hidden">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px">
            <input class="easyui-numberbox" name="num" style="width:40%"
                   data-options="label:'商品库存:',required:true,min:0,max:9999,precision:0">
        </div>
        <div style="margin-left: 300px;margin-bottom: 20px">
            <input class="easyui-textbox" type="text" name="barcode" style="width:40%"
                   data-options="label:'条形码:',validType:'length[0,30]'">
        </div>
        <div>
            <!-- 加载编辑器的容器 -->
            <script id="container" name="content" type="text/plain">商品描述</script>
        </div>
        <div>
            <p class="param_Show" style="display: none;margin-left: 200px;font-size: 18px;">规格参数:</p>
            <div style="margin-left: 300px;margin-bottom: 20px" class="paramShow">
            </div>
        </div>
        <%--规格参数--%>
        <div><input id="paramData" name="paramData" style="display: none;">
        </div>
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
    var ue = UE.getEditor("container");

    $('#cid').combotree({
        //检索远程数据的URL地址
        url: 'itemCats?parentId=0',
        required: true,
        //检索数据的HTTP方法，默认是POST请求
        method: 'get',
        onBeforeExpand: function (node) {
            //获取当前树
            //获取当前树控件的属性
            var options = $('#cid').combotree('tree').tree('options');
            //修改控件属性url变成新的nodeid
            options.url = 'itemCats?parentId=' + node.id;
        },
        onBeforeSelect: function (node) {
            //判断是否为叶子节点
            var isLeaf = $('#cid').tree('isLeaf', node.target);
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
            url: 'item',
            //表单提交之前被触发，如果返回false终止提交
            onSubmit: function () {
                //处理价格
                $('#price').val($('#priceView').val() * 100);
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
                    $.messager.alert('消息', '添加成功！！', 'info');
                    ttshop.addTab('查询商品', 'item-list');
                    ttshop.closeTab('新增商品');
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
