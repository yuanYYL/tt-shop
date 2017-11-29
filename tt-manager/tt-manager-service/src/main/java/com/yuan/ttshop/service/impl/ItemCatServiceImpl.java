package com.yuan.ttshop.service.impl;

import com.yuan.ttshop.dao.TbItemCatMapper;
import com.yuan.ttshop.dto.TreeNode;
import com.yuan.ttshop.pojo.po.TbItemCat;
import com.yuan.ttshop.pojo.po.TbItemCatExample;
import com.yuan.ttshop.service.ItemCatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * User: Administrator
 * Date: 2017/11/23
 * Time: 19:44
 * Version:V1.0
 */
@Service
public class ItemCatServiceImpl implements ItemCatService{
    private Logger logger= LoggerFactory.getLogger(this.getClass());
    @Autowired
    private TbItemCatMapper tbItemCatMapper;
    @Override
    public List<TreeNode> listItemCatsForTree(Long parentId) {
        List<TreeNode> list=null;
        try {
            TbItemCatExample example=new TbItemCatExample();
            TbItemCatExample.Criteria criteria = example.createCriteria();
            criteria.andParentIdEqualTo(parentId);
            List<TbItemCat> tbItemCats = tbItemCatMapper.selectByExample(example);
            list=new ArrayList<>();
            for (TbItemCat tbItemCat : tbItemCats) {
                TreeNode treeNode=new TreeNode();
                treeNode.setId(tbItemCat.getId());
                treeNode.setText(tbItemCat.getName());
                treeNode.setState(tbItemCat.getIsParent()?"closed":"open");
                list.add(treeNode);
            }

        }catch (Exception e){
            logger.error(e.getMessage(),e);
            e.printStackTrace();
        }



        return list;
    }
}
