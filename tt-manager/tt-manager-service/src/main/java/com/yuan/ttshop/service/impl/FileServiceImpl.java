package com.yuan.ttshop.service.impl;

import com.yuan.ttshop.service.FileService;
import com.yuan.ttshop.utils.FtpUtils;
import com.yuan.ttshop.utils.IDUtils;
import com.yuan.ttshop.utils.Prop;
import com.yuan.ttshop.utils.PropKit;
import org.joda.time.DateTime;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * User: Administrator
 * Date: 2017/11/30
 * Time: 21:47
 * Version:V1.0
 */
@Service
public class FileServiceImpl implements FileService {
    @Override
    public Map<String, Object> fielupload(MultipartFile upfile) {
        Map<String, Object> map = new HashMap<>();
        try {
            //读取vsftpd配置文件 ftp.properties要在类路径之下
            Prop pro = PropKit.use("ftp.properties");
            String host = pro.get("ftp.host");
            Integer port = pro.getInt("ftp.port");
            String username = pro.get("ftp.username");
            String password = pro.get("ftp.password");
            //文件上传的基本路径
            String basePath = pro.get("ftp.basepath");
            //按照当前时间生成作为文件存放的文件夹
            String filePath = new DateTime().toString("/yyyy/MM/dd");
            //旧文件名加后缀
            String originalFilename = upfile.getOriginalFilename();
            //文件类型
            String fileType = originalFilename.substring(originalFilename.lastIndexOf("."));
            //新的文件名
            String newFileName = IDUtils.genImageName();
            //得到新的文件加后缀
            newFileName = newFileName + fileType;
            //输入流
            InputStream inputStream = inputStream = upfile.getInputStream();
            //将图片上传到vsftpd服务器上
            boolean b=FtpUtils.uploadFile(host, port, username, password, basePath, filePath, newFileName, inputStream);
            if(b){
                //如果上传成功
                map.clear();
                map.put("state","SUCCESS");
                map.put("title", newFileName);
                map.put("original", originalFilename);
                map.put("type", fileType);
                map.put("url",filePath+"/"+newFileName);
                map.put("size", upfile.getSize());
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }
}
