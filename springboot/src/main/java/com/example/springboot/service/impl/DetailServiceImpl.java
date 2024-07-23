package com.example.springboot.service.impl;

import com.example.springboot.entity.Detail;
import com.example.springboot.mapper.DetailMapper;
import com.example.springboot.service.IDetailService;
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
public class DetailServiceImpl extends ServiceImpl<DetailMapper, Detail> implements IDetailService {

}
