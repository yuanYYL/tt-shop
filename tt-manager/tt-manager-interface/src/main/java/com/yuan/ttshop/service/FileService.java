package com.yuan.ttshop.service;

import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * User: Administrator
 * Date: 2017/11/30
 * Time: 21:46
 * Version:V1.0
 */
public interface FileService {
    Map<String,Object> fielupload(MultipartFile upfile);
}
