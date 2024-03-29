<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>书城首页</title>
    <%-- 用静态包含的方式加载 common里面的header页面  base标签 css样式， jQuery文件--%>
    <%@ include file="/pages/common/header.jsp" %>
    <%--<link type="text/css" rel="stylesheet" href="static/css/style.css" >--%>
    <%--    用静态包含的方式加载 common里面的页面  css样式， jQuery文件--%>
    <script>
        //  页面加载完成之后，点击购物车，绑定单击事件
        $(function () {
            $(".addToCart").click(function () {
                //  单击之后，通过 this 对象，获取bookId 的 value值
                let bookId = $(this).attr("bookId");
                location.href = "http://localhost:8080/book/cartServlet?action=addItem&id=" + bookId;
            })
        })
    </script>
</head>
<body>

<div id="header">
    <img class="logo_img" alt="" src="static/img/logo.gif">
    <span class="wel_word">网上书城</span>
    <div>
        <%--
            这里登录和注册，通过session来判断之后，看是否需要显示这个

         --%>
        <%-- 如果用户还没有登录，那么就显示登录和注册这两个菜单--%>
        <c:if test="${empty sessionScope.user.username}">
            <a href="pages/user/login.jsp">登录</a> |
            <a href="pages/user/regist.jsp">注册</a> &nbsp;&nbsp;
        </c:if>
        <%-- 如果用户已经登录了，就应该显示登录用户的信息--%>
        <c:if test="${not empty sessionScope.user.username}">
            <span>欢迎<span class="um_span">${sessionScope.user.username}</span>光临尚硅谷书城</span>
            <a href="pages/order/order.jsp">我的订单</a>
            <a href="userServlet2?action=logout">注销</a>&nbsp;&nbsp;
        </c:if>
        <a href="pages/cart/cart.jsp">购物车</a>
        <a href="pages/manager/manager.jsp">后台管理</a>
    </div>
</div>
<div id="main">
    <div id="book">
        <div class="book_cond">
            <form action="client/bookServlet" method="post">
                <input type="hidden" name="action" value="pageByPrice">
                价格：<input id="min" type="text" name="min" value="${param.min}"> 元 -
                <input id="max" type="text" name="max" value="${param.max}"> 元
                <input type="submit" value="查询"/>
            </form>
        </div>
        <div style="text-align: center">
            <%-- 或者通过判断 totalCount 也是可以的--%>
            <c:if test="${empty sessionScope.cart.items}">
                <%-- 购物车为空的输出--%>
                <div>
                        <%--    通过CartSelvet 中的addItem() 方法中 给session设置的lastName 来获取最后加入购物车的姓名--%>
                    您刚刚将<span style="color: red">当前购物车为空</span>加入到了购物车中
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.cart.items}">
                <%-- 购物车非为空的输出--%>
                <%--    总的商品数量也是 通过session 域中的cart 获取--%>
                <span>您的购物车中有${sessionScope.cart.totalCount}件商品</span>
                <div>
                        <%--    通过CartSelvet 中的addItem() 方法中 给session设置的lastName 来获取最后加入购物车的姓名--%>
                    您刚刚将<span style="color: red">${sessionScope.lastName}</span>加入到了购物车中
                </div>
            </c:if>
        </div>
        <%--遍历输出 request域中的page里面的items属性--%>
        <c:forEach items="${requestScope.page.items}" var="book">

            <div class="b_list">
                <div class="img_div">
                    <img class="book_img" alt="" src="${book.imgPath}"/>
                </div>
                <div class="book_info">
                    <div class="book_name">
                        <span class="sp1">书名:</span>
                        <span class="sp2">${book.name}</span>
                    </div>
                    <div class="book_author">
                        <span class="sp1">作者:</span>
                        <span class="sp2">${book.author}</span>
                    </div>
                    <div class="book_price">
                        <span class="sp1">价格:</span>
                        <span class="sp2">${book.price}</span>
                    </div>
                    <div class="book_sales">
                        <span class="sp1">销量:</span>
                        <span class="sp2">${book.sales}</span>
                    </div>
                    <div class="book_amount">
                        <span class="sp1">库存:</span>
                        <span class="sp2">${book.stock}</span>
                    </div>
                    <div class="book_add">
                            <%-- 添加的时候带上图书的 id --%>
                        <button class="addToCart" bookId="${book.id}">加入购物车</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <%--    使用 include 引入公共部分--%>
    <%@ include file="/pages/common/page_nav.jsp" %>

</div>

<%--<div id="bottom">--%>
<%--	<span>--%>
<%--		尚硅谷书城.Copyright &copy;2015--%>
<%--	</span>--%>
<%--</div>--%>
<%--使用静态inlcude 引入页脚的内容--%>
<%@ include file="/pages/common/footer.jsp" %>
</body>
</html>