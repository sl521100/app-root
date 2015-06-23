package com.cnblogs.yjmyzz.test;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import com.cnblogs.yjmyzz.domain.BaseBean;
import org.junit.Test;

import com.cnblogs.yjmyzz.utils.FileUtil;

public class FileUtilTest extends BaseBean {

    @Test
    public void testGetDir() throws IOException {
        String d = "D:\\yangjm\\Code\\CTAS\\JAVAEE\\ccsp-bill\\ctas";
//        ArrayList<File> dirs1 = FileUtil.getAllDirectory(d);
//        for (File f : dirs1) {
//            logger.debug(f.getPath());
//        }
//        logger.debug("-------------------------");
        ArrayList<File> dirs2 = FileUtil.getAllDirectory(d, true);
        for (File f : dirs2) {
            logger.debug(f.getPath());
        }
        logger.debug("-------------------------");
        FileUtil.delete(dirs2);
    }

    @Test
    public void testFileSplitAndMerge() throws IOException,
            InterruptedException {

        //System.out.println(FileUtil.currentWorkDir);

        StringBuilder sb = new StringBuilder();

        long originFileSize = 1024 * 1024 * 100;// 100M
        int blockFileSize = 1024 * 1024 * 15;// 15M

        // 生成大文件
        for (int i = 0; i < originFileSize; i++) {
            sb.append("A");
        }

        String fileName = FileUtil.currentWorkDir + "target\\origin.myfile";
        //System.out.println(fileName);
        //System.out.println(FileUtil.write(fileName, sb.toString()));

        // 追加点内容
        sb.setLength(0);
        sb.append("0123456789");
        FileUtil.append(fileName, sb.toString());

        //FileUtil fileUtil = new FileUtil();

        // 将origin.myfile按blockFileSize拆分
        FileUtil.splitBySize(fileName, blockFileSize);

        Thread.sleep(2000);// 稍等2秒，等前面的小文件全都写完

        // 合并成新文件
        FileUtil.mergePartFiles(FileUtil.currentWorkDir + "target", ".part",
                blockFileSize, FileUtil.currentWorkDir + "target\\new.myfile");

    }
}
