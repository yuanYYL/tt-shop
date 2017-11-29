package com.yuan.ttshop.service;

import com.yuan.ttshop.dto.TreeNode;

import java.util.List;

/**
 * User: Administrator
 * Date: 2017/11/23
 * Time: 19:44
 * Version:V1.0
 */
public interface ItemCatService {
    List<TreeNode> listItemCatsForTree(Long parentId);
}
