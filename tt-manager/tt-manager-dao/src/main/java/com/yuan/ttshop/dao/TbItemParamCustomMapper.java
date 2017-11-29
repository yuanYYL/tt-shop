package com.yuan.ttshop.dao;


import com.yuan.ttshop.pojo.vo.TbItemParamCustom;

import java.util.List;
import java.util.Map;

/**
 * User: Administrator
 * Date: 2017/11/24
 * Time: 14:20
 * Version:V1.0
 */
public interface TbItemParamCustomMapper {

    public long findCount(Map<String,Object> map);

    public List<TbItemParamCustom> findParamByPage(Map<String,Object> map);

}
