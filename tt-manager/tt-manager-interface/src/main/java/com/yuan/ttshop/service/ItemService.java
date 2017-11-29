package com.yuan.ttshop.service;

import com.yuan.ttshop.dto.Order;
import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.TbItem;
import com.yuan.ttshop.pojo.vo.QueryVo;
import com.yuan.ttshop.pojo.vo.TbItemCustom;

import java.util.List;

/**
 * User: Administrator
 * Date: 2017/11/17
 * Time: 17:47
 * Version:V1.0
 */
public interface ItemService {
    TbItem getById(Long itemId);

    /**
     * 查询所有商品并分页
     * @param page
     * @return
     */
    Result<TbItemCustom> findByPage(Page page, Order order, QueryVo vo);

    /**
     * 删除商品(本质是更新，将商品status设为3)
     * @param ids
     * @return
     */
    int deleteItems(List<Long> ids);

    /**
     * 上架商品
     * @param ids
     * @return
     */
    int putAwayItems(List<Long> ids);

    /**
     * 下架商品
     * @param ids
     * @return
     */
    int soldOutItems(List<Long> ids);

    /**
     * 添加商品
     * @param item
     * @param content
     * @return
     */
    int saveItem(TbItem item, String content,String paramData);

    /**
     * 编辑商品
     * @param cid
     * @return
     */
    TbItemCustom findById(Long cid);

    /**
     * 更新商品信息
     * @param item
     * @param content
     * @param paramData
     * @return
     */
    int updateItem(TbItem item, String content, String paramData);
}
