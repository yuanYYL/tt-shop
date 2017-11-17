package com.yuan.ttshop.service.impl;

import com.yuan.ttshop.dao.TbItemMapper;
import com.yuan.ttshop.pojo.po.TbItem;
import com.yuan.ttshop.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * User: Administrator
 * Date: 2017/11/17
 * Time: 17:51
 * Version:V1.0
 */
@Service
public class ItemServiceImpl implements ItemService {
    @Autowired
    private TbItemMapper itemDao;
    @Override
    public TbItem getById(Long itemId) {

        return itemDao.selectByPrimaryKey(itemId);
    }
}
