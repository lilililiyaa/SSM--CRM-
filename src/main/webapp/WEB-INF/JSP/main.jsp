<%--
  Created by IntelliJ IDEA.
  User: 86183
  Date: 2020/5/18
  Time: 18:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>CRM首页</title>
    <style type="text/css">
        .content {
            width: 950px;
        }

        #All:hover {
            cursor: pointer;
        }

        .content table input {
            width: 15px;
            height: 15px;
        }

        .pagination li{
            list-style-type: none;
            float: left;
            padding: 10px;
        }
    </style>

</head>
<body>
<%--<h3 style="color: darksalmon;">欢迎您！成功进入CRM人事管理系统！！</h3>
<a href="/toLogin">亲请登录</a><br>
<a href="/toCar">我的购物车</a><br>
<a href="/toTaotao">我的淘宝</a><br>
<a href="/logOut">退出账户</a>--%>

<h1>客户信息列表</h1>
<div class="content">
    <form:form modelAttribute="customer" method="post" action="" id="queryFor">
        <div>
            <%--<button id="queryBtn">查询</button>--%>
            <button id="addBtn">新增</button>
            <button id="updateBtn">修改</button>
            <button id="deleteBtn">删除</button>
        </div><br>
        <div>
            <span>客户编号：</span>
            <c:if test="${customer.customerId!=0}">
                <form:input path="customerId"/>&nbsp;
            </c:if>
            <input type="text" id="customerId" name="customerId">
            <span>&nbsp;客户名称：</span>
            <form:input path="customerName"/><br><br>
            <span>客户信息来源：</span>
            <form:select path="customerSourse">
                <form:option value="">--请选择--</form:option>
                <form:option value="A">电话营销</form:option>
                <form:option value="B">网络营销</form:option>
            </form:select>&nbsp;
            <span>&nbsp;创建日期：</span>
            <input type="date" id="customerDateBegin" name="customerDateBegin">-
            <input type="date" id="customerDateEnd" name="customerDateEnd">&nbsp;
            <button id="queryBtn">&nbsp;开始查询</button>
        </div><br>
        <table border="1px" cellpadding="5" cellspacing="0">
            <tr>
                <td width="5%" align="center" id="All">全选</td>
                <td width="15%" align="center">客户编号</td>
                <td width="15%" align="center">客户名称</td>
                <td width="15%" align="center">客户负责人</td>
                <td width="18%" align="center">客户信息来源</td>
                <td width="18%" align="center">客户所属行业</td>
                <td width="23%" align="center">创建日期</td>
            </tr>
            <c:forEach items="${list}" var="c">
                <tr>
                    <td width="5%" align="center"><input type="checkbox" name="selectCustomerId"></td>
                    <td width="15%" align="center">${c.customerId}</td>
                    <td width="15%" align="center">${c.customerName}</td>
                    <td width="15%" align="center">${c.customerUserName}</td>
                    <td width="18%" align="center">${c.customerSourseDict}</td>
                    <td width="18%" align="center">${c.customerIndustryDict}</td>
                    <td width="23%" align="center">${c.customerDate}</td>
                </tr>
            </c:forEach>
        </table><br>

        <!--分页部分开始-->
        <div>
            共有${totalRows}条数据，共有${totalPage}页，当前为第${pageNum}页<br>
            <ul class="pagination">
                <%--上一页--%>
                <c:if test="${pageNum>1}">
                    <li><a href="#"><<</a></li>
                </c:if>
                <c:if test="${pageNum==1}">
                    <li><<</li>
                </c:if>

                <!--中间页-->
                <!--判断总页数-->
                <c:choose>
                    <%--总页数小于等于5页--%>
                    <c:when test="${totalPage<=5}">
                        <%--开始页码--%>
                        <c:set var="begin" value="1"/>
                        <%--结束页--%>
                        <c:set var="end" value="${totalPage}"/>
                    </c:when>
                    <%--总页数大于5页--%>
                    <c:otherwise>
                        <c:set var="begin" value="${pageNum-1}"/>
                        <c:set var="end" value="${pageNum+3}"/>

                        <%--如果当前是第一页，最大页为5--%>
                        <c:if test="${begin-1<=0}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="5"/>
                        </c:if>

                        <%--end大于总页数，设置begin=总页数-4--%>
                        <c:if test="${end>totalPage}">
                            <c:set var="begin" value="${totalPage-4}"/>
                            <c:set var="end" value="${totalPage}"/>
                        </c:if>
                    </c:otherwise>
                </c:choose>

                <%--遍历显示中间页码--%>
                <c:forEach var="i" begin="${begin}" end="${end}">

                    <c:choose>
                        <%--当前页，选中--%>
                        <c:when test="${i==pageNum}">
                            <li>${i}</li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="#">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <%--下一页--%>
                <c:if test="${pageNum<totalPage}">
                    <%--当前页小于5--%>
                    <li><a href="#">>></a></li>
                </c:if>
                <c:if test="${pageNum==totalPage}">
                    <%--当前页等于5--%>
                    <li>>></li>
                </c:if>

            </ul>
        </div>
        <!--分页结束-->

    </form:form>
</div>

</body>
</html>
