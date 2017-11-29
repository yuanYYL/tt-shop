package com.yuan.ttshop.web;

import com.yuan.ttshop.dto.TreeNode;
import com.yuan.ttshop.service.ItemCatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;


/**
 * User: Administrator
 * Date: 2017/11/23
 * Time: 19:41
 * Version:V1.0
 */
@Controller
public class ItemCatAction {
    private Logger logger= LoggerFactory.getLogger(this.getClass());

    @Autowired
    private ItemCatService itemCatService;
    @ResponseBody
    @RequestMapping(value = "/itemCats",method = RequestMethod.GET)
    public List<TreeNode> listItemCatsForTree(@RequestParam("parentId") Long parentId){
        List<TreeNode> list=null;
        try {
            list=itemCatService.listItemCatsForTree(parentId);
        }catch (Exception e){
            logger.error(e.getMessage(),e);
            e.printStackTrace();
        }
        return list;
    }


}
