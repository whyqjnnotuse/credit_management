package com.example.springboot.service.impl;

import com.example.springboot.entity.Post;
import com.example.springboot.mapper.PostMapper;
import com.example.springboot.service.IPostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 
 *
 */
@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements IPostService {

}
