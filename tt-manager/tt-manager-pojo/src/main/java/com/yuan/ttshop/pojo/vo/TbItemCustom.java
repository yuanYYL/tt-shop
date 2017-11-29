package com.yuan.ttshop.pojo.vo;

import com.yuan.ttshop.pojo.po.TbItem;

/**
 * User: Administrator
 * Date: 2017/11/21
 * Time: 14:06
 * Version:V1.0
 */
public class TbItemCustom extends TbItem{
    /**
     * 商品种类
     */
    private String catName;
    /**
     * 商品状态
     */
    private String statusName;

    /**
     * 商品价格(转格式)
     * @return
     */
    private String priceView;
    private String content;
    private String paramData;
    private Double priceEdit;

    public Double getPriceEdit() {
        return priceEdit;
    }

    public void setPriceEdit(Double priceEdit) {
        this.priceEdit = priceEdit;
    }

    public String getParamData() {
        return paramData;
    }

    public void setParamData(String paramData) {
        this.paramData = paramData;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPriceView() {
        return priceView;
    }

    public void setPriceView(String priceView) {
        this.priceView = priceView;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
}
