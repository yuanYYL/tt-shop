package com.yuan.ttshop.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * 封装排序的请求参数
 * User: Administrator
 * Date: 2017/11/22
 * Time: 14:11
 * Version:V1.0
 */
public class Order {
    /**
     * 要排序的字段
     */
    private String sort;
    /**
     * 排序方式desc asc
     */
    private String order;

    /**
     * 多列排序
     */
   // private List<String> orderParams;

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    /**
     * 将多列排序的参数按组的形式存入list集合中
     * @return
     */
    public List<String> getOrderParams() {
        String[] sorts = this.sort.split(",");
        String[] orders = this.order.split(",");
        List<String> list=new ArrayList<String>();
        for (int i = 0; i < sorts.length; i++) {
            String s = sorts[i] + " " + orders[i];
            list.add(s);
        }
        return list;
    }
}
