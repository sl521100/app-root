package com.cnblogs.yjmyzz.utils;

/**
 * Created by jimmy on 2015/5/11.
 */

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Excel导出数据类
 *
 * @author jimmy
 */
public class ExcelExportData {

    /**
     * 导出数据 key:String 表示每个Sheet的名称 value:List<?> 表示每个Sheet里的所有数据行
     */
    private LinkedHashMap<String, List<?>> dataMap;

    /**
     * 每个Sheet里的顶部大标题
     */
    private String[] titles;

    /**
     * 单个sheet里的数据列标题
     */
    private List<String[]> columnNames;

    /**
     * 单个sheet里每行数据的列对应的对象属性名称
     */
    private List<String[]> fieldNames;

    /**
     * 是否显示日期行
     */
    private boolean showDateRow = false;

    /**
     * 是否显示序号栏
     */
    private boolean showSNColumn = false;

    public List<String[]> getFieldNames() {
        return fieldNames;
    }

    public void setFieldNames(List<String[]> fieldNames) {
        this.fieldNames = fieldNames;
    }

    public String[] getTitles() {
        return titles;
    }

    public void setTitles(String[] titles) {
        this.titles = titles;
    }

    public List<String[]> getColumnNames() {
        return columnNames;
    }

    public void setColumnNames(List<String[]> columnNames) {
        this.columnNames = columnNames;
    }

    public LinkedHashMap<String, List<?>> getDataMap() {
        return dataMap;
    }

    public void setDataMap(LinkedHashMap<String, List<?>> dataMap) {
        this.dataMap = dataMap;
    }


    public boolean isShowDateRow() {
        return showDateRow;
    }

    public void setShowDateRow(boolean showDateRow) {
        this.showDateRow = showDateRow;
    }

    public boolean isShowSNColumn() {
        return showSNColumn;
    }

    public void setShowSNColumn(boolean showSNColumn) {
        this.showSNColumn = showSNColumn;
    }
}
