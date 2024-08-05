package com.example.springboot.controller;

import cn.hutool.core.date.DateUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelWriter;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletOutputStream;
import java.net.URLEncoder;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.io.InputStream;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.springboot.common.Result;
import org.springframework.web.multipart.MultipartFile;
import com.example.springboot.entity.User;
import com.example.springboot.utils.TokenUtils;

import com.example.springboot.service.ICombinedTableService;
import com.example.springboot.entity.CombinedTable;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;
/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 
 *
 */
@RestController
@RequestMapping("/combinedTable")
public class CombinedTableController {

    @Resource
    private ICombinedTableService combinedTableService;

    private final String now = DateUtil.now();

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody CombinedTable combinedTable) {
        if (combinedTable.getUserCode() == null) {
            //combinedTable.setTime(DateUtil.now());
            //combinedTable.setUser(TokenUtils.getCurrentUser().getUsername());
        }
        combinedTableService.saveOrUpdate(combinedTable);
        return Result.success();
    }

    @DeleteMapping("/{user_code}")
    public Result delete(@PathVariable Integer user_code) {
        combinedTableService.removeById(user_code);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> user_code) {
        combinedTableService.removeByIds(user_code);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(combinedTableService.list());
    }

    @GetMapping("/{user_code}")
    public Result findOne(@PathVariable Integer user_code) {
        return Result.success(combinedTableService.getById(user_code));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam(required = false) Long userCode,
                           @RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<CombinedTable> queryWrapper = new QueryWrapper<>();
//        queryWrapper.orderByDesc("user_code");
        if (userCode != null) {
            queryWrapper.eq("user_code", userCode); // 使用精确匹配
        }
//        User currentUser = TokenUtils.getCurrentUser();
//        if (currentUser.getRole().equals("ROLE_USER")) {
//            queryWrapper.eq("user", currentUser.getUsername());
//        }
        return Result.success(combinedTableService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    /**
    * 导出接口
    */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<CombinedTable> list = combinedTableService.list();
        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);

        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("未交档案信息表", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        out.close();
        writer.close();

        }

    /**
     * excel 导入
     * @param file
     * @throws Exception
     */
    @PostMapping("/import")
    public Result imp(MultipartFile file) throws Exception {
        InputStream inputStream = file.getInputStream();
        ExcelReader reader = ExcelUtil.getReader(inputStream);
        // 通过 javabean的方式读取Excel内的对象，但是要求表头必须是英文，跟javabean的属性要对应起来
        List<CombinedTable> list = reader.readAll(CombinedTable.class);

        combinedTableService.saveBatch(list);
        return Result.success();
    }

    private User getUser() {
        return TokenUtils.getCurrentUser();
    }

    /**
     * 合并表数据的接口
     */
    @PostMapping("/merge")
    public Result mergeTables() {
            combinedTableService.combineTables();
            return Result.success();
    }
}

