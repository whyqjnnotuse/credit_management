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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.springboot.common.Result;
import org.springframework.web.multipart.MultipartFile;
import com.example.springboot.entity.User;
import com.example.springboot.utils.TokenUtils;

import com.example.springboot.service.IManagementService;
import com.example.springboot.entity.Management;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 
 *
 */
@RestController
@RequestMapping("/management")
public class ManagementController {

    @Resource
    private IManagementService managementService;

    private final String now = DateUtil.now();

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Management management) {
        if (management.getId() == null) {
            //management.setTime(DateUtil.now());
            //management.setUser(TokenUtils.getCurrentUser().getUsername());
        }
        managementService.saveOrUpdate(management);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        managementService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        managementService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(managementService.list());
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(managementService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam(required = false) Long userCode,
                           @RequestParam(required = false) String username,
                           @RequestParam(required = false) Long contractId,
                           @RequestParam(required = false) Long loanId,
                           @RequestParam(required = false) String creditRecipients,
                           @RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<Management> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (userCode != null) {
            queryWrapper.eq("user_code", userCode); // 使用精确匹配
        }
        if (username != null && !username.isEmpty()) {
            queryWrapper.like("username", username); // 使用模糊匹配
        }
        if (contractId != null) {
            queryWrapper.eq("contract_id", contractId); // 使用精确匹配
        }
        if (loanId != null) {
            queryWrapper.eq("loan_id", loanId); // 使用精确匹配
        }
        if (creditRecipients != null && !creditRecipients.isEmpty()) {
            queryWrapper.like("credit_recipients", creditRecipients); // 使用模糊匹配
        }
//        User currentUser = TokenUtils.getCurrentUser();
//        if (currentUser.getRole().equals("ROLE_USER")) {
//            queryWrapper.eq("user", currentUser.getUsername());
//        }
        return Result.success(managementService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    /**
    * 导出接口
    */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<Management> list = managementService.list();
        // 筛选并映射需要导出的字段
//        List<Map<String, Object>> exportData = new ArrayList<>();
//
//        for (Management management : list) {
//            Map<String, Object> managementData = new LinkedHashMap<>();
//            managementData.put("客户代码", management.getUserCode());
//            managementData.put("客户名称", management.getUsername());
//            managementData.put("信贷对象", management.getCreditRecipients());
//            managementData.put("业务品种", management.getOperationType());
//            managementData.put("借款凭证编号", management.getLoanId());
//            managementData.put("合同号", management.getContractId());
//            managementData.put("档案移交时间", management.getHandoverTime());
////            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
////            dateFormat.format(management.getHandoverTime());
//            // 添加其他需要导出的字段...
//            exportData.add(managementData);
//        }



        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("userCode","客户代码");
        writer.addHeaderAlias("username","客户名称");
        writer.addHeaderAlias("creditRecipients","信贷对象");
        writer.addHeaderAlias("operationType","业务品种");
        writer.addHeaderAlias("loanId","借款凭证编号");
        writer.addHeaderAlias("archiveLocation","档案位置");
        writer.addHeaderAlias("contractId","合同号");
        writer.addHeaderAlias("handoverTime","档案移交时间");
//
        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("档案管理信息表", "UTF-8");
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
        List<Management> list = reader.readAll(Management.class);

        managementService.saveBatch(list);
        return Result.success();
    }

    private User getUser() {
        return TokenUtils.getCurrentUser();
    }

}

