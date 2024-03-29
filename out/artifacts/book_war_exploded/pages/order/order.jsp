<%@ page contentType="text/html;charset=utf-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的订单</title>
    <%-- 用静态包含的方式加载 common里面的header页面  base标签 css样式， jQuery文件--%>
    <%@ include file="/pages/common/header.jsp"%>
    <%--	<base href="http://localhost:8080/book/">--%>
    <%--<link type="text/css" rel="stylesheet" href="static/css/style.css" >--%>
    <style type="text/css">
        h1 {
            text-align: center;
            margin-top: 200px;
        }
    </style>
</head>
<body>

<div id="header">
    <img class="logo_img" alt="" src="static/img/logo.gif">
    <span class="wel_word">我的订单</span>
    <%-- 静态包含登录成功之后的菜单--%>
    <%@ include file="/pages/common/login_success_menu.jsp" %>
</div>

<div id="main">

    <table>
        <tr>
            <td>日期</td>
            <td>金额</td>
            <td>状态</td>
            <td>详情</td>
        </tr>
        <tr>
            <td>2015.04.23</td>
            <td>90.00</td>
            <td>未发货</td>
            <td><a href="#">查看详情</a></td>
        </tr>

        <tr>
            <td>2015.04.20</td>
            <td>20.00</td>
            <td>已发货</td>
            <td><a href="#">查看详情</a></td>
        </tr>

        <tr>
            <td>2014.01.23</td>
            <td>190.00</td>
            <td>已完成</td>
            <td><a href="#">查看详情</a></td>
        </tr>
    </table>


</div>

<%--<div id="bottom">--%>
<%--	<span>--%>
<%--		尚硅谷书城.Copyright &copy;2015--%>
<%--	</span>--%>
<%--</div>--%>
<%--使用静态inlcude 引入--%>
<%@ include file="/pages/common/footer.jsp" %>
</body>
</html>