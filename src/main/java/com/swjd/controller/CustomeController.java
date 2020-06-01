package com.swjd.controller;

import com.swjd.bean.Customer;
import com.swjd.service.CustomerService;
import com.swjd.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customeController")
public class CustomeController {
    @Autowired
    CustomerService customerService;
    @Autowired
    UserService userService;

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
        //假设第三次访问（查按条件查出来的数据的第二页）
        //拿第二次输入条件
        String customerName=param.get("customerName");//客户姓名的条件
        String customerId=param.get("customerId");//客户编号
        if (customerId==null||customerId.equals("")){
            customerId="0";
        }
        String customerSourse=param.get("customerSourse");//客户信息来源
        String customerDateBegin=param.get("customerDateBegin");//开始的日期
        String customerDateEnd=param.get("customerDateEnd");//结束的日期

        model.addAttribute("customerDateBegin",customerDateBegin);
        model.addAttribute("customerDateEnd",customerDateEnd);

        //假设第二次访问（param就已经有内容了）
        //假设第一次访问

        //每页显示的数据条数
        String rows="5";
        param.put("rows",rows);
        //查询出来的数据
        List<Customer> list=customerService.findForSearch(param);
        //总条数
        int totalRows=customerService.findForCount(param);
        //当前页数
        String pageNum=param.get("pageNum");
        //int pageNum=1;
        if (pageNum==null) {
            pageNum="1";
        }
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
        customer.setCustomerName(customerName);
        customer.setCustomerId(Integer.parseInt(customerId));
        customer.setCustomerSourse(customerSourse);

        model.addAttribute("customer",customer);

        return "main";
    }


    //去新增
    @RequestMapping("/toAdd")
    public String toAdd(Model model){
        Customer customer=new Customer();
        model.addAttribute("customer",customer);
        return "add";
    }

    //执行新增
    @RequestMapping("/doAdd")
    public String doAdd(@Valid Customer customer, BindingResult br, HttpSession session){
        if (br.hasErrors()) {
            return "add";
        }
        //因为用户添加的时候没添加日期，所以我们获取系统的时间
        Date date=new Date();
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        String dateStr=format.format(date);
        customer.setCustomerDate(dateStr);

        //获取session里面存的登录名
        String uname=session.getAttribute("activeName").toString();
        int uid=userService.findUserId(uname);
        customer.setCustomerCreateId(uid);
        customer.setCustomerUserId(uid);

        //调用添加的方法
        int num=customerService.addCustomer(customer);
        if (num>0){
            return "redirect:/customeController/findForSearch";
        }else {
            return "error";
        }
    }

    /*//去批量删除
    @RequestMapping("/doDelete")
    public String doDelete(@RequestParam("selectCustomerId") String[] selectCustomerId){
        //String[] ids=customer.getSelectCustomerId();
        *//* System.out.println(selectCustomerId);*//*
        int num=customerService.deleteCustomerByIds(selectCustomerId);
        if (num>0){
            System.out.println("1111==="+num);
            return "redirect:/customerController/findForSearch";

        }else {
            System.out.println("2222==="+num);
            return "redirect:/customerController/findForSearch";
        }

    }*/

    //去删除
    //做批量删除
    @RequestMapping("/doDel")
    /*如果在实体类没有加那个selectCuId属性，则用下面这种方式接收
     * public String doDelete(@RequestParam("selectCuId") String[] selectCuId)*/
    public String doDelete(@RequestParam("selectCuId") String[] selectCuId){
        int num=customerService.deleteCustomerByIds(selectCuId);
        System.out.println("222"+num);
        if (num>0){
            return "redirect:/customeController/findForSearch";
        }

        return "error";
    }

    //准备修改
    @RequestMapping("/toUpdate")
    public String toUpdate(@RequestParam("selectCuId") int selectCuId,Model model){
        //调用单个查询的方法
        Customer customer=customerService.seloneCustomer(selectCuId);
        model.addAttribute("customer",customer);
        return "update";
    }
    //去修改
    @RequestMapping("/doUpdate")
    public String doUpdate(@Valid Customer customer, BindingResult br, HttpSession session){
        if (br.hasErrors()) {
            return "update";
        }
        //因为用户添加的时候没添加日期，所以我们获取系统的时间
        Date date=new Date();
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        String dateStr=format.format(date);
        customer.setCustomerDate(dateStr);

        //获取session里面存的登录名
        String uname=session.getAttribute("activeName").toString();
        int uid=userService.findUserId(uname);
        customer.setCustomerCreateId(uid);
        customer.setCustomerUserId(uid);

        //调用修改的方法
        int num=customerService.updateCustomer(customer);
        if (num>0){
            return "redirect:/customeController/findForSearch";
        }else {
            return "error";
        }
    }
}
