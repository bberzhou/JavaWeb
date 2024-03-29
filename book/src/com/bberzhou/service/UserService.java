package com.bberzhou.service;

import com.bberzhou.pojo.User;

/**
 * @description: userService 处理用户的业务逻辑，
 * @author: bberzhou@gmail.com
 * @date: 8/4/2021
 * Create By Intellij IDEA
 */
public interface UserService {


    /**
     *  注册新用户业务
     * @param user
     */

    public void registerUser(User user);

    /**
     *  用户登录业务
     * @param user
     * @return 如果返回null ，说明登录失败，返回有值，是登录成功
     */
    public User login(User user);

    /**
     *  检查用户名是否可以用
     * @param username
     * @return  返回true表示用户名已存在，返回false 表示用户名可用
     */
    public boolean existUsername(String username);
}
