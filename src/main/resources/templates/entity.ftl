<#macro getPrefix javaTypeName=""><#if javaTypeName == "Boolean">is<#else>get</#if></#macro>
package ${basePackage}.dao.entity;

<#if table.hasDate()>
import java.util.Date;
</#if>
<#if table.hasBigDecimal()>
import java.math.BigDecimal;
</#if>
import org.apache.ibatis.type.Alias;
import com.github.dactiv.xiaoshamu.commons.IntegerIdEntity;
<#--
import javax.persistence.*;
import io.swagger.annotations.*;
import javax.validation.constraints.*;
-->

/**
 * <p>${table.tableComment}实体类</p>
 * <p>Table: ${table.tableName} - ${table.tableComment}</p>
 *
 * @author maurice
 *
 * @since ${.now}
 */
<#--
@Table(name="${table.tableName}")
-->
@Alias("${table.entityVarName}")
public class ${table.entityName} extends IntegerIdEntity {

	private static final long serialVersionUID = 1L;

	public ${table.entityName}() {
	}

<#list table.columns as column>
    <#if ignoreProperties?seq_contains(column.javaVarName) == false>
    /**
     * ${column.columnComment}
     */
    <#--
    @Column(name="${column.columnName}")
	@ApiModelProperty(value = "${column.columnComment}")
	-->
    private ${column.javaTypeName} ${column.javaVarName};

    </#if>
</#list>

<#list table.columns as column>
    <#if ignoreProperties?seq_contains(column.javaVarName) == false>

     /**
      * 获取${column.columnComment}
      */
    public ${column.javaTypeName} <@getPrefix javaTypeName=column.javaTypeName />${column.javaName}(){
        return this.${column.javaVarName};
    }

	 /**
      * 设置${column.columnComment}
      *
      * @param ${column.javaVarName}
      */
    public void set${column.javaName}(${column.javaTypeName} ${column.javaVarName}){
        this.${column.javaVarName} = ${column.javaVarName};
    }
    </#if>
</#list>
}