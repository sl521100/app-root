package com.cnblogs.yjmyzz.utils;

import com.cnblogs.yjmyzz.domain.BaseBean;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by jimmy on 2015/2/9.
 */
public class MybatisUtil extends BaseBean {

    private MybatisUtil() {
        //工具类无需对象实例化
    }

    /**
     * 执行Delete SQL语句
     *
     * @param sqlSessionFactory
     * @param sqlId
     * @param map
     */
    public static void delete(SqlSessionFactory sqlSessionFactory, String sqlId, Map<String, Object> map) throws Exception {
        SqlSession session = null;
        try {
            session = sqlSessionFactory.openSession(ExecutorType.SIMPLE, false);
            session.delete(sqlId, map);
            session.commit();
            session.clearCache();
            logger.debug("delete执行成功!");
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
            logger.error("delete出错!", e);
            throw (e);
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    /**
     * 批量提交
     *
     * @param sqlSessionFactory
     * @param everyCommitCount  每次提交的记录数
     * @param list
     * @param sqlId
     * @param <T>
     */
    public static <T> void batchCommit(SqlSessionFactory sqlSessionFactory, int everyCommitCount, List<T> list, String sqlId) throws Exception {
        SqlSession session = null;
        try {
            session = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
            int a = everyCommitCount;
            int loop = (int) Math.ceil(list.size() / (double) a);
            List<T> tempList = new ArrayList<T>(a);
            int start, stop;
            for (int i = 0; i < loop; i++) {
                tempList.clear();
                start = i * a;
                stop = Math.min(i * a + a - 1, list.size() - 1);
                for (int j = start; j <= stop; j++) {
                    tempList.add(list.get(j));
                    //logger.info(list.get(j));
                }
                session.insert(sqlId, tempList);
                session.commit();
                session.clearCache();
                logger.info((stop + 1) + " records have been committed ...");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
            logger.error("batchCommit ERROR:", e);
            for (T t : list) {
                logger.error(t.toString());
            }
            throw (e);
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    /**
     * 查询分页数据
     *
     * @param mapperClass
     * @param sqlId
     * @param sqlParameter
     * @param pageIndex
     * @param pageSize
     * @return
     * @throws Exception
     */
    public static List<?> getPageList(SqlSessionFactory sqlSessionFactory, Class<?> mapperClass, String sqlId, Object sqlParameter, int pageIndex, int pageSize) throws Exception {
        SqlSession session = null;
        try {
            //session = sqlSessionFactory.openSession(ExecutorType.SIMPLE, false);
            session = SqlSessionUtils.getSqlSession(sqlSessionFactory);
            if (pageIndex <= 0) {
                pageIndex = 1;
            }
            if (pageSize <= 0) {
                pageSize = 10;
            }
            PageBounds pageBounds = new PageBounds(pageIndex, pageSize);
            return session.selectList(mapperClass.getName() + "." + sqlId,
                    sqlParameter, pageBounds);
        } finally {
            if (session != null) {
                session.close();
            }
        }

    }

}
