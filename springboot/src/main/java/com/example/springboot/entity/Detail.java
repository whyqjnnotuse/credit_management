package com.example.springboot.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;

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
    @TableId(value = "user_code", type = IdType.AUTO)
    @ApiModelProperty("客户代码")
    private Long userCode;
    @ApiModelProperty("到期日期")
    private Date lastDate;
    @ApiModelProperty("放款机构")
    private String lendingInstitution;
    @ApiModelProperty("借款日期")
    private Date loanDate;
    @ApiModelProperty("借款金额")
    private BigDecimal loanAmount;
    @ApiModelProperty("客户名称")
    private String clientName;
    @ApiModelProperty("借款合同编号")
    private Long loanContractId;
    @ApiModelProperty("借款凭证编号")
    private Long loanVoucherId;
    @ApiModelProperty("业务品种")
    private String businessVariety;
    @ApiModelProperty("文件")
    private String file;


}
