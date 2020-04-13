package ${basePackage}.service;

import ${basePackage}.dao.entity.${table.entityName};
import ${basePackage}.dao.${table.entityName}Dao;

import com.github.dactiv.xiaoshamu.commons.exception.ServiceException;
import com.github.dactiv.xiaoshamu.commons.page.Page;
import com.github.dactiv.xiaoshamu.commons.page.PageRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 *
 * ${table.tableComment}管理服务
 *
 * @author maurice
 *
 * @since ${.now}
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ${table.entityName}Service {

    @Autowired
    private ${table.entityName}Dao ${table.entityVarName}Dao;

    /**
     * 保存${table.tableComment}实体
     *
     * @param ${table.entityVarName} ${table.tableComment}实体
     */
    public void save${table.entityName}(${table.entityName} ${table.entityVarName}) {
        if (Objects.nonNull(${table.entityVarName}.getId())) {
            insert${table.entityName}(${table.entityVarName});
        } else {
            update${table.entityName}(${table.entityVarName});
        }
    }

    /**
     * 新增${table.tableComment}实体
     *
     * @param ${table.entityVarName} ${table.tableComment}实体
     */
    public void insert${table.entityName}(${table.entityName} ${table.entityVarName}) {
        ${table.entityVarName}Dao.insert(${table.entityVarName});
    }

    /**
     * 更新${table.tableComment}实体
     *
     * @param ${table.entityVarName} ${table.tableComment}实体
     */
    public void update${table.entityName}(${table.entityName} ${table.entityVarName}) {
        ${table.entityVarName}Dao.update(${table.entityVarName});
    }

    /**
     * 删除${table.tableComment}实体
     *
     * @param id 主键 id
     */
    public void delete${table.entityName}(${table.primaryKeyJavaTypeName} id) {
        ${table.entityVarName}Dao.delete(id);
    }

    /**
     * 删除${table.tableComment}实体
     *
     * @param ids 主键 id 集合
     */
    public void delete${table.entityName}(List<${table.primaryKeyJavaTypeName}> ids) {
        for (${table.primaryKeyJavaTypeName} id : ids) {
            delete${table.entityName}(id);
        }
    }

    /**
     * 获取${table.tableComment}实体
     *
     * @param id 主键 id
     * @return ${table.tableComment}实体
     */
    public ${table.entityName} get${table.entityName}(${table.primaryKeyJavaTypeName} id) {
        return ${table.entityVarName}Dao.get(id);
    }

    /**
     * 获取${table.tableComment}实体
     *
     * @param filter 过滤条件
     *
     * @return ${table.tableComment}实体
     */
    public ${table.entityName} get${table.entityName}ByFilter(Map<String, Object> filter) {

        List<${table.entityName}> result = find${table.entityName}List(filter);

        if (result.size() > 1) {
        throw new ServiceException("通过条件[" + filter + "]查询出来的记录大于" + result.size() + "条,并非单一记录");
        }

        Iterator<${table.entityName}> iterator = result.iterator();
        return iterator.hasNext() ? iterator.next() : null;
    }

    /**
     * 根据过滤条件查找${table.tableComment}实体
     *
     * @param filter 过滤条件
     * @return ${table.tableComment}实体集合
     */
    public List<${table.entityName}> find${table.entityName}List(Map<String, Object> filter) {
        return ${table.entityVarName}Dao.find(filter);
    }

    /**
     * 查找${table.tableComment}实体分页数据
     *
     * @param pageRequest 分页请求
     * @param filter 过滤条件
     *
     * @return 分页实体
     */
    public Page<${table.entityName}> find${table.entityName}Page(PageRequest pageRequest, Map<String, Object> filter) {

        filter.putAll(pageRequest.getOffsetMap());

        List<${table.entityName}> data = find${table.entityName}List(filter);

        return new Page<>(pageRequest, data);
    }

}
