package com.yuan.ttshop.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * User: Administrator
 * Date: 2017/11/20
 * Time: 14:01
 * Version:V1.0
 */
@Controller
public class IndexAction {
    @RequestMapping("/")
    public String index(){
        return  "index";
    }
    @RequestMapping("/{pageAction}")
    public String itemAdd(@PathVariable("pageAction") String page){
        return page;
    }
}
