package com.swjd.service;

import com.swjd.bean.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {
    //获取所有数据
    public abstract List<Customer> getList();

    //条件分页
    public abstract List<Customer> findForSearch(Map<String,String> map);

    //总记录数(满足条件)
    public abstract int findForCount(Map<String,String> map);
}
