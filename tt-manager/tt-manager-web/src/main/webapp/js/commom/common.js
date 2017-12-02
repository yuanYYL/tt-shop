
var ttshop = {
    //点击导航树上的动作
    registerMenuEvent: function () {
        var _this = this;
        $('#menu .easyui-tree').tree({
            onClick: function (node) {
                var href = node.attributes.href;
                _this.addTab(node.text,href);
            }
        });
    },
    //添加选项卡
    addTab:function(title,href) {
        if ($('#tab').tabs('exists', title)) {
            $('#tab').tabs('select', title)
        } else {
            $('#tab').tabs('add', {
                title: title,
                href: href,
                closable: true
            });
        }
    },
    closeTab:function (text) {

            $('#tab').tabs('close',text);
}

};