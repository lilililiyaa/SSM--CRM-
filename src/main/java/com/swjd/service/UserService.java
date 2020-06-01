package com.swjd.service;

import com.swjd.bean.User;

public interface UserService {
    public abstract User login(User user);

    public abstract int findUserId(String uname);
}
