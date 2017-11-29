package com.yuan.ttshop.service.impl;

import com.sun.org.apache.regexp.internal.RE;
import com.yuan.ttshop.dao.TbItemParamCustomMapper;
import com.yuan.ttshop.dao.TbItemParamMapper;
import com.yuan.ttshop.dto.Order;
import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.TbItemParam;
import com.yuan.ttshop.pojo.po.TbItemParamExample;
import com.yuan.ttshop.pojo.vo.TbItemParamCustom;
import com.yuan.ttshop.service.ItemParamService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: Administrator
 * Date: 2017/11/24
 * Time: 15:34
 * Version:V1.0
 */
@Service
public class ItemParamServiceImpl implements ItemParamService {

    @Autowired
    private TbItemParamCustomMapper itemParamCustomDao;
    @Autowired
    private TbItemParamMapper itemParamDao;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public Result<TbItemParamCustom> findByPage(Page page, Order order) {
        Result<TbItemParamCustom> result = null;
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("page", page);
            map.put("order", order);
            long count = itemParamCustomDao.findCount(map);
            List<TbItemParamCustom> list = itemParamCustomDao.findParamByPage(map);
            result = new Result<>();
            result.setTotal(count);
            result.setRows(list);

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            e.printStackTrace();
        }

        return result;
    }

    @Transactional
    @Override
    public int addItemParam(Long cid, String paramData) {
        int i = 0;
        try {
            TbItemParam itemParam = new TbItemParam();
            itemParam.setItemCatId(cid);
            itemParam.setParamData(paramData);
            itemParam.setCreated(new Date());
            itemParam.setUpdated(new Date());
            i = itemParamDao.insert(itemParam);

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            e.printStackTrace();
        }
        return i;
    }

    @Override
    public TbItemParam findByParam(Long cid) {
        TbItemParam tbItemParam=new TbItemParam();
        TbItemParamExample example = new TbItemParamExample();
        TbItemParamExample.Criteria criteria = example.createCriteria();
        criteria.andItemCatIdEqualTo(cid);
        List<TbItemParam> list = itemParamDao.selectByExampleWithBLOBs(example);
        if (list != null && list.size() > 0) {
            tbItemParam=list.get(0);
        }
        return tbItemParam;
    }
}
