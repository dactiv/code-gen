package com.easy.jcode;

import com.easy.jcode.execute.TableHandler;
import com.easy.jcode.execute.TemplateHandler;
import com.easy.jcode.model.Table;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class JavaCodeRunner implements CommandLineRunner {

    private static final Logger LOGGER = LoggerFactory.getLogger(JavaCodeRunner.class);

    @Autowired
    private TableHandler tableHandler;
    @Autowired
    private TemplateHandler templateHandler;

    @Autowired
    private JavaCodeProperties javaCodeProperties;

    @Override
    public void run(String... args) throws Exception {

        String currnetDic = Thread.currentThread().getContextClassLoader().getResource(".").getPath();
        StringBuilder targetDic = new StringBuilder();
        targetDic.append(currnetDic.substring(0, currnetDic.indexOf("easy-jcode")));
        targetDic.append("easy-jcode");
        targetDic.append(File.separator).append("output");

        //删除输出文件夹
        File dic = new File(targetDic.toString());
        if (dic.exists() && dic.isDirectory()) {
            FileUtils.deleteDirectory(dic);
        }

        targetDic.append(File.separator).append("src");
        targetDic.append(File.separator).append("main");
        targetDic.append(File.separator);

        String baseDic = javaCodeProperties.getBasePackage().replace(".", File.separator);
        StringBuilder javaDic = new StringBuilder(targetDic.toString());
        javaDic.append("java").append(File.separator);
        javaDic.append(baseDic).append(File.separator);

        StringBuilder resDic = new StringBuilder(targetDic.toString());
        resDic.append("resources").append(File.separator);

        try {

            List<Table> includeMapperTableList = new ArrayList<>();

            for (String tableName : javaCodeProperties.getTableNames()) {
                //获取表信息
                Table table = tableHandler.getTableInfo(tableName);
                if (table == null) {
                    continue;
                }

                //生成实体类
                if (javaCodeProperties.isGenEntity()) {
                    templateHandler.genEntity(javaDic.toString(), table);
                }

                //生成 数据层
                if (javaCodeProperties.isGenDao()) {
                    templateHandler.genDao(javaDic.toString(), table);
                }

                //生成 XML
                if (javaCodeProperties.isGenMapperXml()) {
                    templateHandler.genMapperXml(resDic.toString(), table);
                    includeMapperTableList.add(table);
                }

                //生成Service
                if (javaCodeProperties.isGenService()) {
                    templateHandler.genService(javaDic.toString(), table);
                }

                //生成Service
                if (javaCodeProperties.isGenController()) {
                    templateHandler.genController(javaDic.toString(), table);
                }

            }
            //生成 公共引入XML
            if (javaCodeProperties.isGenMapperXml() && CollectionUtils.isNotEmpty(includeMapperTableList)) {
                templateHandler.genIncludeMapperXml(resDic.toString(), includeMapperTableList);
            }
        } catch (Exception e) {
            LOGGER.error("生成出错", e);
        }

    }


}
