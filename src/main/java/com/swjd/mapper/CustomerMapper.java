package com.swjd.mapper;

import com.swjd.bean.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CustomerMapper {
    //全查
    public abstract List<Customer> getAll();

    //条件分页查询（条件，当前是从第几条开始，每页多少条）
    public abstract List<Customer> findForSearch(
            @Param("map")Map<String,String> param,
            @Param("page")Integer page,
            @Param("rows")Integer rows
            );

    //总条数（满足条件的总条数,参数：条件）
    public abstract int findForCount(@Param("map")Map<String,String> param);

    //新增
    public abstract int addCustomer(Customer customer);

    //删除
    public abstract int deleteCustomer(int CustomerId);

    //批量删除
    public abstract int deleteCustomerByIds(String[] ids);

    //修改
    public abstract int updateCustomer(Customer customer);

    //查询单个
    public abstract Customer seloneCustomer(int CustomerId);


}
