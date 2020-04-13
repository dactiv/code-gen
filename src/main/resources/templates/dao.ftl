package ${basePackage}.dao;

import com.github.dactiv.xiaoshamu.commons.BasicCurdDao;
import ${basePackage}.dao.entity.${table.entityName};
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * ${table.tableComment}数据访问
 *
 * @author maurice
 *
 * @since ${.now}
 */
@Mapper
@Repository
public interface ${table.entityName}Dao extends BasicCurdDao<${table.entityName}, ${table.primaryKeyJavaTypeName}> {

}
