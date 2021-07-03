package day5DAO2;

import Utils.JDBCUtils;
import org.junit.runners.Parameterized;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @description: 封装了针对于数据表的通用的操作，在day4DAO的基础上进行一些升级
 * @author: bberzhou@gmail.com
 * @date: 7/2/2021
 * Create By Intellij IDEA
 */
//  添加一个泛型参数
public abstract class BaseDAO<T> {

    //  因为本身就是对Customers表的操作，可以不在方法里面使用泛型

    //  声明一个
    private Class<T> tClass = null;

    //  但是注意，这里必须得让子类的对象在调用方法之前就要实例化tClass，所以需要使用 构造器或者代码块的方式
//    public BaseDAO(){
//
//    }
    {
        //  先获取当前子类(CustomersDAOImpl)的带泛型的父类(BaseDAO，或者其他的类)，注意这里的this ，
        //  并不是指的BaseDAO,应该是子类在实例化对象时，会自动执行父类里面的静态代码块

        //  获取当前BaseDAO的子类继承的父类中的泛型
        Type genericSuperclass = this.getClass().getGenericSuperclass();
        //  做一个强转
        ParameterizedType parameterizedType = (ParameterizedType) genericSuperclass;
        //  获取了父类的泛型参数  ,这里返回的一个参数数组
        Type[] actualTypeArguments = parameterizedType.getActualTypeArguments();
        tClass = (Class<T>) actualTypeArguments[0];//   泛型的第一个参数，就是当前子类中泛型的具体参数<T>里面的
    }


    //  数据库的通用增删改操作,这里不能查询操作（Version2.0）
    public void update(Connection connection, String sql, Object... args) {
        PreparedStatement preparedStatement = null;
        try {
            //  可变形参，类似数组的操作
            //  因为函数传入一个连接 conn，所以这里就不需要再建了
//            //  获取数据库连接
//            connection = JDBCUtils.getConnection();
            //  1、预编译SQL
            preparedStatement = connection.prepareStatement(sql);
            //  2、循环填充占位符,注意参数下标从1开始
            for (int i = 0; i < args.length; i++) {
                //  小心参数生命错误
                preparedStatement.setObject(i + 1, args[i]);
            }
            //  3、执行
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            //  修改未自动提交数据，主要针对使用数据库连接池的使用
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            //  关闭资源
            JDBCUtils.closeResource(null, preparedStatement);
        }
    }

    //  在类声明<T> 去掉getInstance 里面的  Class<T> tClass, 参数
    //  通用的查询操作，用于返回数据表中的一条记录(一个对象)（Version2.0， 考虑上事务）
    //  这里使用父类声明的泛型，方法本身就不再是泛型方法了，所以不需要 <T>
    public T getInstance(Connection connection,String sql, Object... args) {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);

            }
            resultSet = preparedStatement.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();
            if (resultSet.next()) {
                //  循环遍历结果集元数据

                //  利用泛型来创建运行时类的对象,返回的类型自然就是T类型的

                //  这里的tClass就是BaseDAO子类继承父类的具体泛型（例如Customers）
                T t = tClass.newInstance();
                for (int i = 0; i < columnCount; i++) {
                    //  获取列数据值
                    Object columnValue = resultSet.getObject(i + 1);
                    //  利用metaData获取列名
                    String columnLabel = metaData.getColumnLabel(i + 1);

                    //  给t对象指定的columnName熟悉，赋值为columnValue：通过反射
                    //  反射，通过对象获取类的熟悉
                    //                Field declaredField = t.getClass().getDeclaredField(columnLabel);
                    Field declaredField = tClass.getDeclaredField(columnLabel);
                    declaredField.setAccessible(true);
                    declaredField.set(t, columnValue);
                }

                //  对象赋值完之后，返回该对象
                return t;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //  关闭资源
            JDBCUtils.closeResource(null, preparedStatement, resultSet);
        }
        return null;
    }

    //  通用的查询操作，用于返回查询数据表中的多条记录构成的集合（version 2.0 考虑事务）
    //  返回多个查询结果的情况，这里为了保证事务的一致性，传入一个连接对象
    //  这里使用父类声明的泛型，方法本身就不再是泛型方法了，所以不需要 <T>
    //  这里的方法参数并没有传入具体的Class，是通过泛型 反射的方式来获取当前继承BaseDAO子类的父类泛型
    public List<T> getForList(Connection connection,String sql, Object... args) {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        ResultSetMetaData metaData = null;
        List<T> t = new ArrayList<>();
        try {
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);
            }
            resultSet = preparedStatement.executeQuery();

            metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();
            while (resultSet.next()) {
                //  利用泛型来创建运行时类的对象,返回的类型自然就是T类型的

                //  这里的tClass就是BaseDAO子类继承父类的具体泛型（例如Customers）
                T t1 = tClass.newInstance();
                for (int i = 0; i < columnCount; i++) {
                    String columnLabel = metaData.getColumnLabel(i + 1);

                    Object columnValue = resultSet.getObject(i + 1);
                    Field declaredField = tClass.getDeclaredField(columnLabel);
                    //                Field declaredField = t.getClass().getDeclaredField(columnLabel);
                    declaredField.setAccessible(true);
                    declaredField.set(t1, columnValue);
                }
                //  将查询得到对象添加到list中去
                t.add(t1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //  这里关闭的时候先不关闭连接，等一组操作完了之后，再统一关闭
            JDBCUtils.closeResource(null, preparedStatement, resultSet);
            //  返回一个list集合
        }
        return t;
    }

    //  用于查询特殊值的通用方法
    //  泛型方法，这里就是T类型的
    public <T> T getValue(Connection connection, String sql, Object... args){
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            //  预编译SQL
            ps = connection.prepareStatement(sql);
            //  填充占位符
            for (int i = 0; i < args.length; i++) {
                ps.setObject(i + 1, args[i]);

            }
            //  执行SQL语句
            resultSet = ps.executeQuery();
            //  这里主要是针对的特殊的一些查询操作，例如:SELECT COUNT(*) FROM customers;
            //  只有一列数据的情况，这里返回值可以用Object，但是最好使用泛型来解决
            if (resultSet.next()) {
                //  只有一行数据的情况下
                return (T) resultSet.getObject(1);

            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            //  关闭资源
            JDBCUtils.closeResource(null, ps, resultSet);
            //  如果上面的出现异常，就直接返回null
        }
        return null;
    }
}
