package com.yuan.ttshop.pojo.vo;

import com.yuan.ttshop.pojo.po.TbItemParam;

/**
 * User: Administrator
 * Date: 2017/11/24
 * Time: 14:17
 * Version:V1.0
 */
public class TbItemParamCustom extends TbItemParam {

    private String ItemCatName;

    private String paramData;

    @Override
    public String getParamData() {
        return paramData;
    }

    @Override
    public void setParamData(String paramData) {
        this.paramData = paramData;
    }

    public String getItemCatName() {
        return ItemCatName;
    }

    public void setItemCatName(String itemCatName) {
        ItemCatName = itemCatName;
    }
}
