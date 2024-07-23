package com.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
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
@ApiModel(value = "Post对象", description = "")
public class Post implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("职位名称")
    private String name;

    @ApiModelProperty("职位类型")
    private String portstype;

    @ApiModelProperty("薪资")
    private String salary;

    @ApiModelProperty("学历要求")
    private String degree;

    @ApiModelProperty("工作城市")
    private String workplace;

    @ApiModelProperty("截至时间")
    private String ddls;

    @ApiModelProperty("工作福利")
    private String welfares;

    @ApiModelProperty("职位描述")
    private String describes;

    @ApiModelProperty("任职要求")
    private String requires;

    @ApiModelProperty("工作地址")
    private String address;

    @ApiModelProperty("公司名称")
    private String companyname;

    @ApiModelProperty("公司行业")
    private String industry;

    @ApiModelProperty("公司类型")
    private String type;

    @ApiModelProperty("图标")
    private String picture;

    @ApiModelProperty("公司id")
    private Integer cid;


}
