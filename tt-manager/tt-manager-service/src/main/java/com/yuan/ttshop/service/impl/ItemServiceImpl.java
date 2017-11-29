package com.yuan.ttshop.service.impl;


import com.yuan.ttshop.dao.TbItemCustomMapper;
import com.yuan.ttshop.dao.TbItemDescMapper;
import com.yuan.ttshop.dao.TbItemMapper;
import com.yuan.ttshop.dao.TbItemParamItemMapper;
import com.yuan.ttshop.dto.Order;
import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.*;

import com.yuan.ttshop.pojo.vo.QueryVo;
import com.yuan.ttshop.pojo.vo.TbItemCustom;
import com.yuan.ttshop.service.ItemService;
import com.yuan.ttshop.utils.IDUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @Autowired
    private TbItemDescMapper tbitemdescdao;
    @Autowired
    private TbItemParamItemMapper paramItemDao;
    @Override
    public TbItem getById(Long itemId) {

        return itemDao.selectByPrimaryKey(itemId);
    }

    @Override
    public int deleteItems(List<Long> ids) {
        TbItemExample example=new TbItemExample();
        TbItemExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ids);
        TbItem item=new TbItem();
        //将商品状态设为3(删除)
        item.setStatus((byte) 3);
        int i = itemDao.updateByExampleSelective(item, example);
        return i;
    }

    @Override
    public int putAwayItems(List<Long> ids) {
        TbItemExample example=new TbItemExample();
        TbItemExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ids);
        TbItem item=new TbItem();
        //将商品状态为1(正常)
        item.setStatus((byte) 1);
        int i = itemDao.updateByExampleSelective(item, example);
        return i;
    }

    @Override
    public int soldOutItems(List<Long> ids) {
        TbItemExample example=new TbItemExample();
        TbItemExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ids);
        TbItem item=new TbItem();
        //将商品状态为2(下架)
        item.setStatus((byte) 2);
        int i = itemDao.updateByExampleSelective(item, example);
        return i;
    }
    //添加了@Transactional这个注解方法叫做事务方法，事务方法并不是越多越好，凡是涉及查询的方法要求不加@Transactional
    //@Transactional尽量精细化，以后会经常调用一些第三方的接口，那么建议调用第三方接口的内容不要加到事务方法中，可以另外添加方法进行解耦操作
   @Transactional
    @Override
    public int saveItem(TbItem item, String content,String paramData) {
        long itemId = IDUtils.getItemId();
        item.setId(itemId);
        item.setStatus((byte) 1);
        item.setCreated(new Date());
        item.setUpdated(new Date());
        int i = itemDao.insert(item);

        TbItemDesc tbItemDesc=new TbItemDesc();
        tbItemDesc.setItemId(itemId);
        tbItemDesc.setItemDesc(content);
        tbItemDesc.setCreated(new Date());
        tbItemDesc.setUpdated(new Date());
        i+=tbitemdescdao.insert(tbItemDesc);

       TbItemParamItem itemParamItem=new TbItemParamItem();
       itemParamItem.setItemId(itemId);
       itemParamItem.setParamData(paramData);
       itemParamItem.setCreated(new Date());
       itemParamItem.setUpdated(new Date());
       i+= paramItemDao.insert(itemParamItem);
       return i;
    }
    @Transactional
    @Override
    public int updateItem(TbItem item, String content, String paramData) {
        item.setUpdated(new Date());
        TbItemExample example=new TbItemExample();
        TbItemExample.Criteria criteria = example.createCriteria();
        criteria.andIdEqualTo(item.getId());
        int i = itemDao.updateByExampleSelective(item, example);
        TbItemDesc tbItemDesc=new TbItemDesc();
        tbItemDesc.setItemDesc(content);
        tbItemDesc.setUpdated(new Date());
        TbItemDescExample example1=new TbItemDescExample();
        TbItemDescExample.Criteria criteria1 = example1.createCriteria();
        criteria1.andItemIdEqualTo(item.getId());
        i+=tbitemdescdao.updateByExampleSelective(tbItemDesc,example1);
        TbItemParamItem itemParamItem=new TbItemParamItem();
        itemParamItem.setUpdated(new Date());
        itemParamItem.setParamData(paramData);
        TbItemParamItemExample itemParamItemExample=new TbItemParamItemExample();
        TbItemParamItemExample.Criteria criteria2 = itemParamItemExample.createCriteria();
        criteria2.andItemIdEqualTo(item.getId());
        i+=paramItemDao.updateByExampleSelective(itemParamItem, itemParamItemExample);
        return i;
    }

    @Override
    public Result<TbItemCustom> findByPage(Page page, Order order, QueryVo vo) {
        Map<String,Object> map=new HashMap<>();
        map.put("page",page);
        map.put("order",order);
        map.put("query",vo);
        long total = customDao.findCount(map);
        List<TbItemCustom> list = customDao.findItemByPage(map);
        Result<TbItemCustom> result=new Result<TbItemCustom>();
        result.setTotal(total);
        result.setRows(list);
        return result;
    }

    @Override
    public TbItemCustom findById(Long cid) {
        TbItemCustom tbItemCustom = customDao.findItemById(cid);
        return tbItemCustom;
    }

}
