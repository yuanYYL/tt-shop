package com.yuan.ttshop.dao;

import com.yuan.ttshop.pojo.vo.TbItemCustom;

import java.util.List;
import java.util.Map;

/**
 * User: Administrator
 * Date: 2017/11/20
 * Time: 21:02
 * Version:V1.0
 */
public interface TbItemCustomMapper {
    //long findCount(@Param("query") QueryVo vo);
    //List<TbItemCustom> findItemByPage(@Param("page") Page page, @Param("order") Order order,@Param("query")QueryVo vo);
    long findCount(Map<String ,Object> map);
    List<TbItemCustom> findItemByPage(Map<String,Object> map);

    TbItemCustom findItemById(Long cid);
}
