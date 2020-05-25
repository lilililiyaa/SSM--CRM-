package com.swjd.controller;

import com.swjd.bean.Customer;
import com.swjd.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customeController")
public class CustomeController {
    @Autowired
    CustomerService customerService;

    //要能够跳转到主页面，并且带数据
    @RequestMapping("/toMain")
    public String toMain(Model model){
        //准备数据
        List<Customer> list=new ArrayList<>();
        list=customerService.getList();
        model.addAttribute("list",list);
        Customer customer=new Customer();
        model.addAttribute("customer",customer);
        return "main";
    }

    @RequestMapping("/findForSearch")
    public String findForSearch(@RequestParam Map<String,String> param, Model model, ModelMap modelMap){
        //假设第一次访问

        //每页显示的数据条数
        String rows="5";
        param.put("rows",rows);
        //查询出来的数据
        List<Customer> list=customerService.findForSearch(param);
        //总条数
        int totalRows=customerService.findForCount(param);
        //当前页数
        int pageNum=1;
        //总页数
        int totalPage=0;
        if (totalRows % Integer.parseInt(rows)==0){
            //可以整除
            totalPage=totalRows / Integer.parseInt(rows);
        }else {
            //除不尽
            totalPage=totalRows / Integer.parseInt(rows)+1;
        }

        modelMap.put("list",list);//传值
        modelMap.put("totalRows",totalRows);//总条数
        modelMap.put("pageNum",pageNum);//当前页数
        modelMap.put("totalPage",totalPage);//总页数

        Customer customer=new Customer();
        model.addAttribute("customer",customer);

        return "main";
    }
}
