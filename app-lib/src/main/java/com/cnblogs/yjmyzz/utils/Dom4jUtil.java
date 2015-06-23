package com.cnblogs.yjmyzz.utils;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.apache.http.protocol.HTTP;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.dom4j.tree.DefaultComment;
import org.springframework.util.StringUtils;

public class Dom4jUtil extends BaseBean {

    private Dom4jUtil(){
        //工具类无需对象实例化
    }

    public static final String xmlnsHeader = "<?xml version=\"1.0\" encoding=\""
            + HTTP.UTF_8 + "\"?>";

    /**
     * 根据xml输入字符串获取Document
     *
     * @param xml
     * @return
     */

    public static Document getDocument(String xml) throws Exception {
        SAXReader saxReader = new SAXReader();
        Document document = saxReader.read(new ByteArrayInputStream(xml
                .getBytes(HTTP.UTF_8)));
        return document;
    }

    /**
     * 根据xml输入，得到Element对象
     *
     * @param nodeXml
     * @return
     * @throws Exception
     */
    public static Element getElement(String nodeXml) throws Exception {
        Document document = getDocument(nodeXml);
        return document.getRootElement();
    }

    /**
     * appendElement附加到srcElement
     *
     * @param srcElement
     * @param appendElement
     * @return
     */
    public static Element appendElement(Element srcElement,
                                        Element appendElement) {
        srcElement.add((Element) appendElement.clone());
        return srcElement;
    }

    /**
     * 删除指定的唯一节点
     *
     * @param doc
     * @param singleNodeXPath
     * @return
     * @throws Exception
     */
    public static String deleteSingleNode(String docXml, String singleNodeXPath)
            throws Exception {
        Document doc = getDocument(docXml);
        Element ele = (Element) doc.selectSingleNode(singleNodeXPath);
        if (ele != null) {
            ele.getParent().remove(ele);
            return formatDocument(doc);
        }
        return docXml;
    }

    /**
     * format xml input string
     *
     * @param xml
     * @return
     * @throws DocumentException
     * @throws IOException
     */
    public static String formatXml(String xml) throws Exception {
        return formatXml(xml, true);
    }

    public static String formatDocument(Document doc) throws Exception {
        return formatDocument(doc, false);
    }

    /**
     * 格式化输出Document
     *
     * @param doc
     * @param isFormat
     * @return
     * @throws Exception
     */

    public static String formatDocument(Document doc, boolean isFormat)
            throws Exception {
        // 创建输出格式
        OutputFormat format = null;
        if (isFormat) {
            format = OutputFormat.createPrettyPrint();
        } else {
            format = OutputFormat.createCompactFormat();
        }

        format.setTrimText(false);// 保留类似<a> </a>中的空格
        format.setNewLineAfterDeclaration(false);// 第一行后不要插入空行
        format.setEncoding(HTTP.UTF_8);// 制定输出xml的编码类型

        StringWriter writer = new StringWriter();
        // 创建一个文件输出流
        XMLWriter xmlwriter = new XMLWriter(writer, format);
        // 将格式化后的xml串写入到文件
        xmlwriter.write(doc);
        String returnValue = writer.toString();
        writer.close();

        return StringUtils.replace(returnValue, xmlnsHeader, "");
    }

    /**
     * 格式化xml输入字符串
     *
     * @param xml
     * @param isFormat
     * @return
     * @throws Exception
     */
    public static String formatXml(String xml, boolean isFormat)
            throws Exception {
        return formatDocument(getDocument(xml), isFormat);
    }

    /**
     * 删除xml中的空白节点
     *
     * @param xml
     * @return
     */
    public static String deleteEmptyNode(String xml) {
        // 顺带去除回车，换行，Tab符号等干扰信息
        // 2014-05-06 yjm: 空格某些时候，有特殊业务含义(比如BKD时，SEG上第一次选择了配额，后来想把配额清空，就必须传入<ID>
        // </ID>//
        xml = xml.replaceAll("(\r\n|\r|\n|\n\r|\r\n\t|\n\r\t|\t)", "");

        // 开始处理
        try {

            Document document = getDocument(xml);
            while (true) {
                @SuppressWarnings("unchecked")
                List<Element> list = document.selectNodes("//*[not(node())]");

                // 特例:
                // /REQUEST/ECIBOK-INP/LOCAL-DATA/DETAIL/AWB-INFO/CREATION/DATE
                // /REQUEST/ECIBOK-INP/LOCAL-DATA/DETAIL/AWB-INFO/CREATION/TIME
                // 传输中文时，上面这二个空节点必须保留
                if (list != null && list.size() > 0) {
                    for (int i = list.size() - 1; i >= 0; i--) {
                        String path = list.get(i).getPath();
                        if (path.endsWith("LOCAL-DATA/DETAIL/AWB-INFO/CREATION/DATE")
                                || path.endsWith("LOCAL-DATA/DETAIL/AWB-INFO/CREATION/TIME")) {
                            list.remove(i);
                        }
                    }
                }

                if (list == null || list.size() <= 0) {
                    break;
                }
                for (Element e : list) {
                    e.getParent().remove(e);
                }
            }
            // 去掉注释
            @SuppressWarnings("unchecked")
            List<DefaultComment> comments = document.selectNodes("//comment()");
            for (DefaultComment e : comments) {
                e.getParent().remove(e);
            }

            xml = formatDocument(document, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return xml;
    }

}
