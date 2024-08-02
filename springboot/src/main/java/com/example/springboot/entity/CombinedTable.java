package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

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
@TableName("combined_table")
@ApiModel(value = "CombinedTable对象", description = "")
public class CombinedTable implements Serializable {

    private static final long serialVersionUID = 1L;

    private String username;
    @TableId(value = "user_code", type = IdType.AUTO)
    private Long userCode;
    private String creditRecipients;

    private String operationType;

    private String loanId;

    private String archiveLocation;

    private Long contractId;

    private LocalDate handoverTime;

    private String LendingInstitution;

    private BigDecimal loanAmount;

    private LocalDate loanDate;

    private LocalDate lastDate;

    private String file;


}
