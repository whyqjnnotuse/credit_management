package com.example.springboot.service.impl;

import com.example.springboot.entity.Management;
import com.example.springboot.mapper.ManagementMapper;
import com.example.springboot.service.IManagementService;
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
public class ManagementServiceImpl extends ServiceImpl<ManagementMapper, Management> implements IManagementService {

}
