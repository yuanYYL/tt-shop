package com.yuan.ttshop.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * User: Administrator
 * Date: 2017/11/17
 * Time: 17:09
 * Version:V1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao-test.xml"})
public class TbUserMapperTest {
    @Autowired
    private TbUserMapper userDao;
    @Test
    public void testSelectByPrimaryKey() throws Exception {
        System.out.println(userDao.selectByPrimaryKey(5L));
    }

}