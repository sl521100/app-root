package com.cnblogs.yjmyzz.test;

import com.cnblogs.yjmyzz.utils.FtpUtil;
import com.cnblogs.yjmyzz.utils.RegexUtils;
import org.junit.Test;

import java.util.List;


public class FtpUtilTest {

    @Test
    public void test() throws Exception {
        List<String> files = FtpUtil.getFileNames("172.20.16.61", 21, "tcs", "tcs", "/dev/data/export/");
        for (String s : files) {
            System.out.println(s);
        }
    }

    @Test
    public void testFileName() {
        String s = "R:\\";

        System.out.println(isAbsolutePath(s));
    }

    public boolean isAbsolutePath(String filePath) {
        String temp = filePath.replace("\\", "/");
        return temp.startsWith("/") || RegexUtils.isMatch(temp, "^[A-Za-z]:/");

    }
}
