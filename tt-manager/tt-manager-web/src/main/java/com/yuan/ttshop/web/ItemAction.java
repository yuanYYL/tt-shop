package com.yuan.ttshop.web;

import com.yuan.ttshop.dto.Order;
import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.TbItem;
import com.yuan.ttshop.pojo.vo.QueryVo;
import com.yuan.ttshop.pojo.vo.TbItemCustom;
import com.yuan.ttshop.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * User: Administrator
 * Date: 2017/11/17
 * Time: 17:45
 * Version:V1.0
 */
@Controller
public class ItemAction {
    @Autowired
    private ItemService itemService;

    @ResponseBody
    @RequestMapping(value = "/item/{itemId}", method = RequestMethod.GET)
    public TbItem getById(@PathVariable("itemId") Long itemId) {
        return itemService.getById(itemId);
    }

    @ResponseBody
    @RequestMapping("/items")
    public Result<TbItemCustom> findByPage(Page page, Order order, QueryVo vo) {
        Result<TbItemCustom> result = itemService.findByPage(page,order,vo);
        return result;

    }
    //删除商品
    @ResponseBody
    @RequestMapping(value = "/items/delete", method = RequestMethod.POST)
    public int deleteItemsById(@RequestParam("ids[]") List<Long> ids) {
        int data = itemService.deleteItems(ids);
        return data;
    }
    //下架
    @ResponseBody
    @RequestMapping(value = "/items/putaway", method = RequestMethod.POST)
    public int putAwayItems(@RequestParam("ids[]") List<Long> ids) {
        int data = itemService.putAwayItems(ids);
        return data;
    }
    //上架
    @ResponseBody
    @RequestMapping(value = "/items/soldout", method = RequestMethod.POST)
    public int soldOutItems(@RequestParam("ids[]") List<Long> ids) {
        int data = itemService.soldOutItems(ids);
        return data;
    }
    //保存商品
    @ResponseBody
    @RequestMapping(value = "/item",method = RequestMethod.POST)
    public int saveItem(TbItem item,String content,String paramData){
        int i=itemService.saveItem(item,content,paramData);
        return i;
    }
    //跳转编辑商品页面
    @RequestMapping("/itemEdit")
    public String itemEdit(@RequestParam("cid") Long cid, HttpServletRequest request){
        TbItemCustom itemCustom=itemService.findById(cid);
        request.getSession().setAttribute("item",itemCustom);
        return "item-edit";
    }
    //编辑商品
    @ResponseBody
    @RequestMapping("/item/edit")
    public int updateItem(TbItem item,String content,String paramData){
        int i=itemService.updateItem(item,content,paramData);
        return i;
    }

}
