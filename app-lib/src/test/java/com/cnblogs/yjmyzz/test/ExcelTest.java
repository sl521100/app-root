package com.cnblogs.yjmyzz.test;

import java.io.FileOutputStream;
import java.util.*;

import com.cnblogs.yjmyzz.utils.ExcelExportData;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.junit.Test;
import com.cnblogs.yjmyzz.test.domain.AwbDto;
import com.cnblogs.yjmyzz.utils.ExcelUtil;
import com.cnblogs.yjmyzz.utils.FileUtil;

public class ExcelTest {

    @Test
    public void testExcel() throws Exception {

        List<String[]> columNames = new ArrayList<String[]>();
        columNames.add(new String[]{"运单号", "代理人", "价格", "创建日期"});
        columNames.add(new String[]{"运单号", "代理人", "价格", "创建日期"});

        List<String[]> fieldNames = new ArrayList<String[]>();
        fieldNames.add(new String[]{"awbNumber", "agent", "price", "createDate"});
        fieldNames.add(new String[]{"awbNumber", "agent", "price", "createDate"});

        LinkedHashMap<String, List<?>> map = new LinkedHashMap<String, List<?>>();
        map.put("运单月报(1月)", getData1());
        map.put("运单月报(2月)", getData2());


        ExcelExportData setInfo = new ExcelExportData();
        setInfo.setDataMap(map);
        setInfo.setFieldNames(fieldNames);
        setInfo.setTitles(new String[]{"航空运单报表1", "航空运单报表2"});
        setInfo.setColumnNames(columNames);

        // 将需要导出的数据输出到文件
        System.out.println(ExcelUtil.export2File(setInfo, "r:/test.xls"));

    }

    private List<AwbDto> getData1() {
        List<AwbDto> data = new ArrayList<AwbDto>();
        Random rnd = new Random();
        for (int i = 0; i < 1000; i++) {
            data.add(new AwbDto("112-" + FileUtil.leftPad(i + "", 8, '0'), "张三", rnd.nextDouble() * 100, new Date()));
        }
        return data;
    }

    private List<AwbDto> getData2() {
        List<AwbDto> data = new ArrayList<AwbDto>();
        Random rnd = new Random();
        for (int i = 0; i < 1000; i++) {
            data.add(new AwbDto("999-" + FileUtil.leftPad(i + "", 8, '0'), "李四", rnd.nextDouble() * 100, new Date()));
        }
        return data;
    }

    @Test
    public void testExcelExport() throws Exception {

        // 创建excel
        HSSFWorkbook wb = new HSSFWorkbook();

        // 创建sheet
        HSSFSheet sheet = wb.createSheet("运单数据");

        // 创建一行
        HSSFRow rowTitle = sheet.createRow(0);

        // 创建标题栏样式
        HSSFCellStyle styleTitle = wb.createCellStyle();
        styleTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 居中
        HSSFFont fontTitle = wb.createFont();
        // 宋体加粗
        fontTitle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        fontTitle.setFontName("宋体");
        fontTitle.setFontHeight((short) 200);
        styleTitle.setFont(fontTitle);

        // 在行上创建1列
        HSSFCell cellTitle = rowTitle.createCell(0);

        // 列标题及样式
        cellTitle.setCellValue("运单号");
        cellTitle.setCellStyle(styleTitle);

        // 在行上创建2列
        cellTitle = rowTitle.createCell(1);
        cellTitle.setCellValue("代理人");
        cellTitle.setCellStyle(styleTitle);

        HSSFCellStyle styleCenter = wb.createCellStyle();
        styleCenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 居中

        // 取数据
        List<AwbDto> data = getData1();

        for (int i = 0; i < data.size(); i++) {

            AwbDto item = data.get(i);
            HSSFRow row = sheet.createRow(i + 1);

            HSSFCell cell = row.createCell(0);
            cell.setCellValue(item.getAwbNumber());
            cell.setCellStyle(styleCenter);

            cell = row.createCell(1);
            cell.setCellValue(item.getAgent());
            cell.setCellStyle(styleCenter);
        }

        FileOutputStream fout = new FileOutputStream("r:/awb.xls");
        wb.write(fout);
        fout.close();
        wb.close();

        //System.out.println("导出完成！");
    }

}
