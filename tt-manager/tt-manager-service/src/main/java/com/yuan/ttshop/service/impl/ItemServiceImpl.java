package com.yuan.ttshop.service.impl;

import com.yuan.ttshop.dao.TbItemCustomMapper;
import com.yuan.ttshop.dao.TbItemMapper;
import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.TbItem;
import com.yuan.ttshop.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    @Autowired
    private TbItemCustomMapper customDao;
    @Override
    public TbItem getById(Long itemId) {

        return itemDao.selectByPrimaryKey(itemId);
    }

    @Override
    public Result<TbItem> findByPage(Page page) {
        long total = customDao.findCount(page);
        List<TbItem> list = customDao.findItemByPage(page);
        Result<TbItem> result=new Result<TbItem>();
        result.setTotal(total);
        result.setRows(list);
        return result;
    }
}
