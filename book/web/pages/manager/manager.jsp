<%@ page contentType="text/html;charset=utf-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
    <%-- 用静态包含的方式加载 common里面的header页面  base标签 css样式， jQuery文件--%>
    <%@ include file="/pages/common/header.jsp"%>
    <%--	<base href="http://localhost:8080/book/">--%>
    <%--<link type="text/css" rel="stylesheet" href="../../static/css/style.css" >--%>
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
    <span class="wel_word">后台管理系统</span>
    <%--<div>--%>
    <%--    <a href="book_manager.jsp">图书管理</a>--%>
    <%--    <a href="order_manager.jsp">订单管理</a>--%>
    <%--    <a href="../../index.jsp">返回商城</a>--%>
    <%--</div>--%>
    <%@ include file="/pages/common/manager_menu.jsp"%>
</div>

<div id="main">
    <h1>欢迎管理员进入后台管理系统</h1>
</div>

<%--<div id="bottom">--%>
<%--		<span>--%>
<%--			尚硅谷书城.Copyright &copy;2015--%>
<%--		</span>--%>
<%--</div>--%>
<%--使用静态inlcude 引入--%>
<%@ include file="/pages/common/footer.jsp"%>
</body>
</html>