package com.swjd.service;

import com.swjd.bean.Customer;
import com.swjd.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CustomerServiceImpl implements CustomerService{
    @Autowired
    CustomerMapper customerMapper;

    @Override
    public List<Customer> getList() {
        return customerMapper.getAll();
    }

    @Override
    public List<Customer> findForSearch(Map<String, String> map) {
        //把参数拿出来-业务逻辑操作
        //获取当前是第几页
        String pageNum=map.get("page");//规定page是当前页数
        //获取每页的条数
        String rows=map.get("rows");//规定rows是每页条数
        int row=Integer.parseInt(rows);//string转为int

        //如果没有收到page，表示这是第一次访问，需显示第一页
        if (pageNum==null||pageNum.equals("")){
            pageNum="1";
        }
        int pagenum=Integer.parseInt(pageNum);//string转为int

        //计算开始的下标
        int start=(pagenum-1)*row;

        return customerMapper.findForSearch(map,start,row);
    }

    @Override
    public int findForCount(Map<String, String> map) {
        return customerMapper.findForCount(map);
    }
}
