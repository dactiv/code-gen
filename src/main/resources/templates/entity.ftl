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
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;
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

<#list table.columns as column>
    <#if ignoreProperties?seq_contains(column.javaVarName) == false>
    /**
     * ${column.columnComment}
     */
    private ${column.javaTypeName} ${column.javaVarName};

    </#if>
</#list>
    /**
     *
     * ${table.tableComment}实体类
     *
     */
    public ${table.entityName}() {
    }
<#list table.columns as column>
    <#if ignoreProperties?seq_contains(column.javaVarName) == false>

    /**
     * 获取${column.columnComment}
     *
     * @return ${column.javaTypeName}
     */
    public ${column.javaTypeName} <@getPrefix javaTypeName=column.javaTypeName />${column.javaName}(){
        return this.${column.javaVarName};
    }

	/**
     * 设置${column.columnComment}
     *
     * @param ${column.javaVarName} ${column.columnComment}
     */
    public void set${column.javaName}(${column.javaTypeName} ${column.javaVarName}){
        this.${column.javaVarName} = ${column.javaVarName};
    }
    </#if>
</#list>

    /**
     * 获取唯一索引查询条件
     *
     * @return 查询条件
     */
    @JsonIgnore
    public Map<String, Object> getUniqueFilter() {
        Map<String, Object> filter = new LinkedHashMap<>();
<#list table.columns as column>
    <#if column.unique>
        if (Objects.nonNull(this.${column.javaVarName}) && !"".equals(this.${column.javaVarName}<#if column.javaTypeName != "String">.toString()</#if>)) {
            filter.put("${column.javaVarName}Eq", get${column.javaName}());
        }
    </#if>
</#list>
        return filter;
    }

    // -------------------- 将代码新增添加在这里，以免代码重新生成后覆盖新增内容 -------------------- //
}