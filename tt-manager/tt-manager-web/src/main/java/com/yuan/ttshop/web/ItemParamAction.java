package com.yuan.ttshop.web;

import com.yuan.ttshop.dto.Order;
import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.TbItemParam;
import com.yuan.ttshop.pojo.vo.TbItemParamCustom;
import com.yuan.ttshop.service.ItemParamService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * User: Administrator
 * Date: 2017/11/24
 * Time: 15:36
 * Version:V1.0
 */
@Controller
public class ItemParamAction {

    @Autowired
    private ItemParamService itemParamService;

    private Logger logger= LoggerFactory.getLogger(this.getClass());

    @ResponseBody
    @RequestMapping(value = "/itemParams",method = RequestMethod.GET)
    public Result<TbItemParamCustom> findByPage(Page page, Order order){
        Result<TbItemParamCustom> list=null;
        try{
           list= itemParamService.findByPage(page,order);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            e.printStackTrace();
        }
        return list;
    }

    @ResponseBody
    @RequestMapping(value = "/itemParam",method = RequestMethod.POST)
    public int addItemParam(@Param("cid") Long cid,@Param("paramData") String paramData){
        int i=0;
        try {
            i=itemParamService.addItemParam(cid,paramData);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            e.printStackTrace();
        }
        return i;

    }
    @ResponseBody
    @RequestMapping(value = "/itemParam/{cid}",method = RequestMethod.GET)
    public TbItemParam findItemParam(@PathVariable("cid") Long cid){
        TbItemParam itemParam=null;
        try {
            itemParam=itemParamService.findByParam(cid);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            e.printStackTrace();
        }

        return itemParam;
    }

}
