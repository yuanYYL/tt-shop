package com.yuan.ttshop.service;

import com.yuan.ttshop.dto.Order;
import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.TbItemParam;
import com.yuan.ttshop.pojo.vo.TbItemParamCustom;

/**
 * User: Administrator
 * Date: 2017/11/24
 * Time: 15:33
 * Version:V1.0
 */
public interface ItemParamService {
    /**
     * 规格参数：分页并查询所有
     * @param page
     * @param order
     * @return
     */
    Result<TbItemParamCustom> findByPage(Page page, Order order);

    /**
     * 添加规格参数
     * @param cid
     * @param paramData
     * @return
     */
    int addItemParam(Long cid, String paramData);

    /**
     * 查询规格参数
     * @param cid
     * @return
     */
    TbItemParam findByParam(Long cid);
}
