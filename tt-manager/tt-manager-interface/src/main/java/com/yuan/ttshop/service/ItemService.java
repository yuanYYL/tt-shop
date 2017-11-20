package com.yuan.ttshop.service;

import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.TbItem;

/**
 * User: Administrator
 * Date: 2017/11/17
 * Time: 17:47
 * Version:V1.0
 */
public interface ItemService {
    TbItem getById(Long itemId);

    Result<TbItem> findByPage(Page page);
}
