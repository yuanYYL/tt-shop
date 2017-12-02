package com.yuan.ttshop.web;


import com.yuan.ttshop.service.FileService;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Map;

/**
 * User: Administrator
 * Date: 2017/11/30
 * Time: 18:48
 * Version:V1.0
 */
@Controller
public class FileAction {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private FileService fileService;

    //初始化
    @RequestMapping(value = "/file/upload", method = RequestMethod.GET)
    public void config(HttpServletRequest request, HttpServletResponse response) {
        try {
            //设置请求和响应的字符集和内容类型
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json");
            //获得请求中参数
            String action = request.getParameter("action");
            if (StringUtils.isNotBlank(action) && "config".equals(action)) {
                //读取config.json
                InputStream is = this.getClass().getClassLoader().getResourceAsStream("config.json");
                PrintWriter out = response.getWriter();
                IOUtils.copy(is,out,"UTF-8");
            }

        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            e.printStackTrace();
        }
    }

    //文件上传
    @ResponseBody
    @RequestMapping(value = "/file/upload",method = RequestMethod.POST)
    public Map<String,Object> upload(MultipartFile upfile){
        Map<String,Object> map=null;
        try {
            map=fileService.fielupload(upfile);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            e.printStackTrace();
        }
        return map;
    }


}
