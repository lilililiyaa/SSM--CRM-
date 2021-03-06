package com.swjd.service;

import com.swjd.bean.User;
import com.swjd.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserMapperImpl implements UserService{
    @Autowired
    UserMapper userMapper;

    @Override
    public User login(User user) {
        return userMapper.findUserByuNamePwd(user);
    }

    @Override
    public int findUserId(String uname) {
        return userMapper.findUserId(uname);
    }
}
