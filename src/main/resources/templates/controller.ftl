package ${basePackage}.controller;

import com.github.dactiv.xiaoshamu.commons.page.Page;
import com.github.dactiv.xiaoshamu.commons.page.PageRequest;
import com.github.dactiv.xiaoshamu.commons.spring.web.RestResult;
import ${basePackage}.dao.entity.${table.entityName};
import com.github.dactiv.xiaoshamu.message.service.MessageService;
import com.github.dactiv.xiaoshamu.support.security.enumerate.ResourceSource;
import com.github.dactiv.xiaoshamu.support.security.enumerate.ResourceType;
import com.github.dactiv.xiaoshamu.support.security.plugin.Plugin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>${table.tableComment}控制器</p>
 *
 * @author maurice
 *
 * @since ${.now}
 */
@RestController
@RequestMapping("${table.entityVarName}")
@Plugin(
    name = "${table.tableComment}",
    id = "${table.entityVarName}",
    parent = "system",
    type = ResourceType.Menu,
    source = ResourceSource.Console
)
public class ${table.entityName}Controller {

    @Autowired
    private ${table.entityName}Service ${table.entityVarName}Service;

    /**
     * 获取${table.tableComment}分页信息
     *
     * @param pageRequest 分页信息
     * @param filter      过滤条件
     *
     * @return 分页实体
     */
    @RequestMapping("page")
    @Plugin(name = "获取${table.tableComment}分页", source = ResourceSource.Console)
    @PreAuthorize("hasAuthority('prems[${table.entityVarName}:page]')")
    public Page<${table.entityName}> page(PageRequest pageRequest, @RequestParam Map<String, Object> filter) {
        return ${table.entityVarName}Service.find${table.entityName}Page(pageRequest, filter);
    }

    /**
     * 根据条件获取${table.tableComment}
     *
     * @param filter 查询条件
     *
     * @return ${table.tableComment}实体
     */
    @GetMapping("getByFilter")
    @PreAuthorize("isAuthenticated()")
    @Plugin(name = "根据条件获取单个${table.tableComment}", source = ResourceSource.Console)
    public ${table.entityName} getByFilter(@RequestParam Map<String, Object> filter) {
        return ${table.entityVarName}Service.get${table.entityName}ByFilter(filter);
    }

    /**
     * 获取${table.tableComment}
     *
     * @param id ${table.tableComment}主键 ID
     * @return ${table.tableComment}实体
     */
    @RequestMapping("get")
    @PreAuthorize("hasAuthority('prems[${table.entityVarName}:get]')")
    @Plugin(name = "获取${table.tableComment}实体信息", source = ResourceSource.Console)
    public ${table.entityName} get(@RequestParam Integer id) {
        return ${table.entityVarName}Service.get${table.entityName}(id);
    }

    /**
     * 保存${table.tableComment}
     *
     * @param entity ${table.tableComment}实体
     */
    @RequestMapping("save")
    @PreAuthorize("hasAuthority('prems[${table.entityVarName}:save]')")
    @Plugin(name = "保存${table.tableComment}实体", source = ResourceSource.Console, audit = true)
    public RestResult.Result<Map<String, Object>> save(@Valid ${table.entityName} entity) {
        ${table.entityVarName}Service.save${table.entityName}(entity);
        return RestResult.build("保存成功", entity.idEntityToMap());
    }

    /**
     * 删除${table.tableComment}
     *
     * @param ids ${table.tableComment}主键 ID 值集合
     */
    @RequestMapping("delete")
    @PreAuthorize("hasAuthority('prems[${table.entityVarName}:delete]')")
    @Plugin(name = "删除${table.tableComment}实体", source = ResourceSource.Console, audit = true)
    public RestResult.Result<?> delete(@RequestParam List<Integer> ids) {
        ${table.entityVarName}Service.delete${table.entityName}(ids);
        return RestResult.build("删除" + ids.size() + "条记录成功");
    }

<#list table.columns as column>
    <#if column.unique>
    /**
    * 判断${column.columnComment}是否唯一
    *
    * @param ${column.javaVarName} ${column.columnComment}
    *
    * @return true 是，否则 false
    */
    @GetMapping("is${column.javaName}Unique")
    @PreAuthorize("isAuthenticated()")
    @Plugin(name = "判断${column.columnComment}是否唯一", source = ResourceSource.All)
    public boolean is${column.javaName}Unique(@RequestParam ${column.javaTypeName} ${column.javaVarName}) {
        Map<String, Object> filter = new LinkedHashMap<>();
        filter.put("${column.javaVarName}Eq", ${column.javaVarName});
        return ${table.entityVarName}Service.find${table.entityName}List(filter).isEmpty();
    }
    </#if>
</#list>
}
