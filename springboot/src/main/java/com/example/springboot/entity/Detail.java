package com.example.springboot.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import com.alibaba.excel.annotation.ExcelProperty;
/**
 * <p>
 * 
 * </p>
 *
 * @author 
 *
 */
@Getter
@Setter
@ApiModel(value = "Detail对象", description = "")
public class Detail implements Serializable {

    private static final long serialVersionUID = 1L;
    @TableId(value = "id", type = IdType.AUTO)
    @ExcelProperty("id")
    private Integer id;
    @ExcelProperty("客户代码")
    private Long userCode;
    @ExcelProperty("到期日期")
    private LocalDate lastDate;
    @ExcelProperty("放款机构")
    private String lendingInstitution;
    @ExcelProperty("借款日期")
    private LocalDate loanDate;
    @ExcelProperty("借款金额")
    private BigDecimal loanAmount;
    @ExcelProperty("客户名称")
    private String clientName;
    @ExcelProperty("借款合同编号")
    private Long loanContractId;
    @ExcelProperty("借款凭证编号")
    private Long loanVoucherId;
    @ExcelProperty("业务品种")
    private String businessVariety;


}
