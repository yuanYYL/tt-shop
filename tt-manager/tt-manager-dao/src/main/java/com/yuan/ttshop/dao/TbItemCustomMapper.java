package com.yuan.ttshop.dao;

import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.pojo.po.TbItem;

import java.util.List;

/**
 * User: Administrator
 * Date: 2017/11/20
 * Time: 21:02
 * Version:V1.0
 */
public interface TbItemCustomMapper {
    long findCount(Page page);
    List<TbItem> findItemByPage(Page page);
}
