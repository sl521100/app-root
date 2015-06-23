package com.cnblogs.yjmyzz.test;

import com.cnblogs.yjmyzz.domain.BaseBean;
import com.cnblogs.yjmyzz.utils.NetworkUtil;
import org.junit.Test;

/**
 * Created by jimmy on 2015/2/12.
 */
public class NetworkUtilTest extends BaseBean {

    @Test
    public void test() {
        logger.debug(NetworkUtil.getHostAddress());
        logger.debug(NetworkUtil.getHostName());
    }
}
