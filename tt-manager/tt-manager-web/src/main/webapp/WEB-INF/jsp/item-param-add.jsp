<%--
  User: Administrator
  Date: 2017/11/24
  Time: 19:26
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="easyui-panel" title="商品规格参数模板详情" data-options="fit:true">

    <form class="form" id="itemParamAddForm" name="itemParamAddForm" method="post">
        <table style="width:100%;">
            <tr>
                <td class="label">商品类目：</td>
                <td>
                    <input id="catid" name="catid" style="width:200px;">
                </td>
            </tr>
            <tr>
                <td class="label">规格参数：</td>
                <td>
                    <button class="easyui-linkbutton" onclick="addGroup()" type="button"
                            data-options="iconCls:'icon-add'">添加分组
                    </button>
                    <ul id="item-param-group">

                    </ul>
                    <ul id="item-param-group-template" style="display:none;">
                        <li>
                            <input  name="group" >
                            <button title="添加参数" class="easyui-linkbutton" onclick="addParam(this)" type="button"
                                    data-options="iconCls:'icon-add'"></button>
                            <button title="删除分组" class="easyui-linkbutton" onclick="delGroup(this)" type="button"
                                    data-options="iconCls:'icon-cancel'"></button>
                            <ul class="item-param">
                                <li>
                                    <input name="param">
                                    <button title="删除参数" class="easyui-linkbutton" onclick="delParam(this)"
                                            type="button" data-options="iconCls:'icon-cancel'"></button>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button class="easyui-linkbutton" onclick="submitForm()" type="button"
                            data-options="iconCls:'icon-ok re'">保存
                    </button>
                    <button class="easyui-linkbutton" onclick="clearForm()" type="button"
                            data-options="iconCls:'icon-undo'">重置
                    </button>
                </td>
            </tr>
        </table>
    </form>
</div>
<script>
    $('#catid').combotree({
        //检索远程数据的URL地址
        url: 'itemCats?parentId=0',
        required: true,
        //检索数据的HTTP方法，默认是POST请求
        method: 'get',
        onBeforeExpand: function (node) {
            var options = $('#catid').combotree('tree').tree('options');
            options.url = 'itemCats?parentId=' + node.id;
        },
        onBeforeSelect: function (node) {
            var isLeaf = $('#catid').tree('isLeaf', node.target);
            if (!isLeaf) {
                $.messager.alert('警告', '请选择最终类目', 'warning');
                return false;
            }
        }
    });

    //添加分组
    function addGroup() {
        var groups = $('#item-param-group-template li').eq(0).clone();
        $('#item-param-group').append(groups);
    }

    //   添加参数
    function addParam(obj) {
        var params = $('#item-param-group-template .item-param li').eq(0).clone();
        $(obj).parent().find('.item-param').append(params);
    }

    //    删除分组
    function delGroup(obj) {
        $(obj).parent().remove();
    }

    //    删除参数
    function delParam(obj) {
        $(obj).parent().remove();
    }

    function submitForm() {
        var groupValues = [];
        var $groups = $('#item-param-group [name=group]');
        $groups.each(function (i, n) {
            var paramValues = [];
            var $params = $(n).parent().find('.item-param [name=param]');
            $params.each(function (_i, _n) {
                var pval = $(_n).val();
                if ($.trim(pval).length > 0) {
                    paramValues.push(pval);
                }
            });
            var obj = {};
            var gval = $(n).val();
            obj.group = gval;
            obj.params = paramValues;
            if ($.trim(gval).length > 0 && paramValues.length > 0) {
                groupValues.push(obj);
            }
        });
//        $.post(
//            'itemParam?cid='+$('#cid').combotree('getValue'),
//            {'paramData':JSON.stringify(groupValues)},
//            function (data) {
//                if(data>0){
//                    ttshop.closeTab('新增规格参数');
//                    ttshop.closeTab('查询规格参数');
//                    ttshop.addTab('查询规格参数','item-param-list');
//                    $.messager.alert('提示','保存成功！','info');
//                }
//            }
//        );
        $('#itemParamAddForm').form('submit', {
            url: 'itemParam?cid=' + $('#catid').combotree('getValue')+'&paramData='+JSON.stringify(groupValues),
            onSubmit: function () {
                var bool=$('#itemParamAddForm').form('validate');
                if(!bool||groupValues.length==0){
                    $.messager.alert('警告','请填写完整','warning');
                    return false;
                }
                return true ;
            },
            success: function (data) {
                if (data > 0) {
                                                                                            ttshop.closeTab('新增规格参数');
                    ttshop.closeTab('查询规格参数');
                    ttshop.addTab('查询规格参数', 'item-param-list');
                    $.messager.alert('提示', '保存成功！', 'info');
                }
            }


        });

    }
    function clearForm() {
        $('#itemParamAddForm').form('reset');
    }

</script>
