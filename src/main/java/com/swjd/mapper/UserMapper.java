package com.swjd.mapper;

import com.swjd.bean.User;

public interface UserMapper {
    /*public abstract User findUserByUnamePwd(User user);*/
    public abstract User findUserByuNamePwd(User user);

    //根据登录名查询id的方法
    public abstract int findUserId(String userName);
}
