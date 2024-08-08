package com.example.springboot.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelWriter;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletOutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
//import jdk.internal.icu.impl.StringPrepDataReader;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.springboot.common.Result;
import org.springframework.web.multipart.MultipartFile;
import com.example.springboot.entity.User;
import com.example.springboot.utils.TokenUtils;

import com.example.springboot.service.IDetailService;
import com.example.springboot.entity.Detail;

import org.springframework.web.bind.annotation.RestController;

import com.alibaba.excel.EasyExcel;
import java.io.File;
import java.util.List;

import static org.apache.commons.lang3.StringUtils.isNumeric;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author
 *
 */
@RestController
@RequestMapping("/detail")
public class DetailController {

    @Resource
    private IDetailService detailService;

    private final String now = DateUtil.now();

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Detail detail) {
        if (detail.getUserCode() == null) {
            //detail.setTime(DateUtil.now());
            //detail.setUser(TokenUtils.getCurrentUser().getUsername());
        }
        detailService.saveOrUpdate(detail);
        return Result.success();
    }

    @DeleteMapping("/{user_code}")
    public Result delete(@PathVariable Integer userCode) {
        detailService.removeById(userCode);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> userCode) {
        detailService.removeByIds(userCode);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(detailService.list());
    }

    @GetMapping("/{user_code}")
    public Result findOne(@PathVariable Integer user_code) {
        return Result.success(detailService.getById(user_code));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam(required = false) String clientName,
                           @RequestParam(required = false) String lendingInstitution,
                           @RequestParam(required = false) Long userCode,
                           @RequestParam(required = false) Long loanContractId,
                           @RequestParam(required = false) Long loanVoucherId,
                           @RequestParam(required = false) String businessVariety,
                           @RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<Detail> queryWrapper = new QueryWrapper<>();
//        queryWrapper.orderByDesc("id");
        if (clientName != null && !clientName.isEmpty()) {
            queryWrapper.like("client_name", clientName); // 使用模糊匹配
        }
        if (lendingInstitution != null && !lendingInstitution.isEmpty()) {
            queryWrapper.like("lending_institution", lendingInstitution); // 使用模糊匹配
        }
        if (businessVariety != null && !businessVariety.isEmpty()) {
            queryWrapper.like("business_variety", businessVariety); // 使用模糊匹配
        }
        if (userCode != null) {
            queryWrapper.eq("user_code", userCode); // 使用精确匹配
        }
        if (loanContractId != null) {
            queryWrapper.eq("loan_contract_id", loanContractId); // 使用精确匹配
        }
        if (loanVoucherId != null) {
            queryWrapper.eq("loan_voucher_id", loanVoucherId); // 使用精确匹配
        }

        return Result.success(detailService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    /**
    * 导出接口
    */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<Detail> list = detailService.list();
        // 创建一个日期格式化器
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/M/d");

        // 对列表中的日期字段进行格式化
        for (Detail detail : list) {
            Date loanDate = detail.getLoanDate();
            if (loanDate != null) {
                detail.setLoanDate(formatter.parse(formatter.format(loanDate)));
            }
            Date lastDate = detail.getLastDate();
            if (lastDate != null) {
                detail.setLastDate(formatter.parse(formatter.format(lastDate)));
            }
        }
        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("lendingInstitution","放款机构");
        writer.addHeaderAlias("clientName","客户名称");
        writer.addHeaderAlias("userCode","客户代码");
        writer.addHeaderAlias("loanContractId","借款合同编号");
        writer.addHeaderAlias("loanVoucherId","借款凭证编号");
        writer.addHeaderAlias("businessVariety","业务品种");
        writer.addHeaderAlias("loanAmount","借款金额");
        writer.addHeaderAlias("loanDate","借款日期");
        writer.addHeaderAlias("lastDate","到期日期");
        writer.addHeaderAlias("file","文件");

        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("档案入库信息表", "UTF-8");
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
        // 日期格式
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        InputStream inputStream = file.getInputStream();
        ExcelReader reader = ExcelUtil.getReader(inputStream);
        // 方式2：忽略表头的中文，直接读取表的内容
        List<List<Object>> list = reader.read(1);
        List<Detail> details = CollUtil.newArrayList();
        for (List<Object> row : list) {
            Detail detail = new Detail();
            detail.setLendingInstitution(row.get(0).toString());
            detail.setClientName(row.get(1).toString());
            detail.setUserCode(Long.parseLong(row.get(2).toString()));
//            detail.setLoanContractId(Long.parseLong(row.get(4).toString()));
//            detail.setLoanVoucherId(Long.parseLong(row.get(5).toString()));
            String loanContractIdStr = row.get(3).toString();
            if (isNumeric(loanContractIdStr)) {
                detail.setLoanContractId(Long.parseLong(loanContractIdStr));
            } else {
                System.err.println("Invalid number format for loanContractId: " + loanContractIdStr);
                continue; // 跳过该记录
            }

            String loanVoucherIdStr = row.get(4).toString();
            if (isNumeric(loanVoucherIdStr)) {
                detail.setLoanVoucherId(Long.parseLong(loanVoucherIdStr));
            } else {
                System.err.println("Invalid number format for loanVoucherId: " + loanVoucherIdStr);
                continue; // 跳过该记录
            }
            detail.setBusinessVariety(row.get(5).toString());
            String loanAmountStr = row.get(6).toString();
            try {
                detail.setLoanAmount(new BigDecimal(loanAmountStr));
            } catch (NumberFormatException e) {
                System.err.println("Invalid number format for loanAmount: " + loanAmountStr);
                continue; // 跳过该记录
            }

            try {
                Date loanDate = dateFormat.parse(row.get(7).toString());
                detail.setLoanDate(loanDate);
            } catch (ParseException e) {
                System.err.println("Invalid date format for loanDate: " + row.get(7).toString());
                continue; // 跳过该记录
            }

            try {
                Date lastDate = dateFormat.parse(row.get(8).toString());
                detail.setLastDate(lastDate);
            } catch (ParseException e) {
                System.err.println("Invalid date format for lastDate: " + row.get(8).toString());
                continue; // 跳过该记录
            }
            detail.setFile(row.get(9).toString());
            details.add(detail);
        }
//        for (Detail detail : list) {
//            System.out.println(detail);
//        }
        detailService.saveBatch(details);
        return Result.success(true);
    }

    private User getUser() {
        return TokenUtils.getCurrentUser();
    }

}

