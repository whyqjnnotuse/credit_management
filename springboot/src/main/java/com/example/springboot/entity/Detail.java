package com.example.springboot.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

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
@ApiModel(value = "Detail对象", description = "")
public class Detail implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long userCode;

    private LocalDate lastDate;

    private String lendingInstitution;

    private LocalDate loanDate;

    private BigDecimal loanAmount;

    private String clientName;

    private Long loanContractId;

    private Long loanVoucherId;

    private String businessVariety;


}
