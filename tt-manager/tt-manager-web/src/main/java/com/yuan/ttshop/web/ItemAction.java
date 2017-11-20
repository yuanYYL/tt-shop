package com.yuan.ttshop.web;

import com.yuan.ttshop.dto.Page;
import com.yuan.ttshop.dto.Result;
import com.yuan.ttshop.pojo.po.TbItem;
import com.yuan.ttshop.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public Result<TbItem> findByPage(Page page){
        Result<TbItem> result = itemService.findByPage(page);
        return result;
    }
}
