package com.example.springboot.service;

import com.example.springboot.entity.CombinedTable;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 
 */
public interface ICombinedTableService extends IService<CombinedTable> {
    // 定义必要的服务方法
    void combineTables();
}
