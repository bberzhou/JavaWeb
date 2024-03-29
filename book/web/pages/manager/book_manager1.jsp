<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

    <%--
            此页面是解决修改和添加在同一个页面，如何动态调method的方法二
            不通过 method 的方法

            因为修改的时候会带有一个参数，而删除的时候不带参数
            则可以判断是否是带有 id 这个参数，如果有 id这个参数就是修改操作，如果没有id这个参数就是添加操作




    --%>
    <meta charset="UTF-8">
    <title>图书管理</title>
    <%-- 用静态包含的方式加载 common里面的header页面  base标签 css样式， jQuery文件--%>
    <%@ include file="/pages/common/header.jsp"%>
    <%--	<base href="http://localhost:8080/book/">--%>
    <%--<link type="text/css" rel="stylesheet" href="../../static/css/style.css" >--%>
    <script>
        <%-- 页面加载成功之后--%>
        $(function () {
            //  获取a 标签 带有 deleteClass 的id
            //  给删除的a 标签绑定一个单击事件，用于删除的确认信息提示操作
            $("a.deleteClass").click(function () {

                /**
                 *  confirm 方法是确认提示框函数
                 *  参数是它的提示内容
                 *  它有两个按钮，一个是确认，一个是取消
                 *  返回true 表示点击了确认，返回false 表示点击取消
                 *
                 *  在事件的function函数中，有一个this对象，这个this对象，是当前正在响应事件的dom对象，
                 *  所以可以通过这个对象获取一些信息。
                 *  通过this获取其父元素 td,再获取td 父元素 tr，然后获取tr的第一个元素td 里面的文本值
                 *  find("td:first")，查找td的第一个 first ，使用jQuery
                 *
                 *
                 */
                return confirm("确定要删除【"+$(this).parent().parent().find("td:first").text()+"】吗？")
                // return false 会阻止元素的默认行为 ==== 不提交请求, return true 就是直接正常的进行事件操作

            })
        })
    </script>
</head>
<body>

<div id="header">
    <img class="logo_img" alt="" src="static/img/logo.gif">
    <span class="wel_word">图书管理系统</span>
    <%@ include file="/pages/common/manager_menu.jsp"%>
</div>

<div id="main">
    <table>
        <tr>
            <td>名称</td>
            <td>价格</td>
            <td>作者</td>
            <td>销量</td>
            <td>库存</td>
            <td colspan="2">操作</td>
        </tr>

        <c:forEach items="${requestScope.bookList}" var="book">
            <tr>
                <td>${book.name}</td>
                <td>${book.price}</td>
                <td>${book.author}</td>
                <td>${book.sales}</td>
                <td>${book.stock}</td>
                <td><a href="manager/bookServlet?action=getBook&id=${book.id}">修改</a></td>
                    <%--
                        注意这里删除的一个小技巧，因为查询的时候，是将所有的Book对象都查询出来并且放入到request域中的，
                        所以可以直接在前端通过EL表达式获取到对应那个Book对象的ID，传入给后台，后台再通过id来调用deleteById进行删除

                        这里并做一个JS判断，弹框提示是否删除
                    --%>
                <td><a class="deleteClass" href="manager/bookServlet?action=delete&id=${book.id}">删除</a></td>
            </tr>

        </c:forEach>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><a href="pages/manager/book_edit.jsp">添加图书</a></td>
        </tr>
    </table>
</div>

<%@ include file="/pages/common/footer.jsp"%>
</body>
</html>