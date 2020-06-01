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
    <script>
        /*获取你要查看的页码，并且放到表单隐藏域中*/
        function subPage(page) {
            document.getElementById("pageNum").value=page;
            subForm();
        }

        /*查询按钮提交表单*/
        function subForm() {
            document.getElementById("queryForm").setAttribute("action","/customeController/findForSearch");
            document.getElementById("queryForm").submit();
        }

        /*新增按钮提交表单*/
        function add() {
            document.getElementById("queryForm").setAttribute("action","/customeController/toAdd");
            document.getElementById("queryForm").submit();
        }
        function add2() {
            window.location.href="/customeController/toAdd";
        }

        /*全选与全不选功能*/
        function qx() {
            //获取元素里面的文本内容-拿全选两字
            var text=document.getElementById("All").innerHTML;
            if (text=='全选'){
                var a=document.getElementsByName("selectCuId");
                for (var i=0;i<a.length;i++){
                    //遍历多选框
                    a[i].checked=true;
                }
                document.getElementById("All").innerHTML="取消";
            }else if (text=='取消'){
                var a=document.getElementsByName("selectCuId");
                for (var i=0;i<a.length;i++){
                    //遍历多选框
                    a[i].checked=false;
                }
                document.getElementById("All").innerHTML="全选";
            }
        }

        /*删除按钮提交表单*/
        /*function sc() {
            //获取是选中状态的多选框
            var b=[];
            //获取所有的多选框
            var a=document.getElementsByName("selectCustomerId");
            //遍历所有的多选框
            for (var i=0;i<a.length;i++){
                if (a[i].checked==true){
                    //添加到b中去
                    b.push(a[i]);
                }
            }
            //判断b的长度
            if (b.length<=0){
                alert("请选择你想删除的数据")
            }else {
                //确认删除框
                if (confirm("你确定要删除吗？")==true){
                    //到controller删除的方法去
                    document.getElementById("queryForm").setAttribute("action","/customeController/doDelete");
                    document.getElementById("queryForm").submit();
                }
            }
        }*/

        // 删除
        function sc() {
            // 获取要选中的多选框（存选中状态的多选框）
            var b=[];
            //获取所有多选框
            var a=document.getElementsByName("selectCuId");
            for (var i=0;i<a.length;i++){
                if (a[i].checked==true){
                    b.push(a[i]);
                }
            }
            if (b.length<=0){
                alert("请选择你要删除的数据");
            }else {
                if (confirm("确认要删除它吗？")==true){
                    //到删除的方法里面去controller
                    /*window.location.href="/customerController/doDelete"*/
                    document.getElementById("queryForm").setAttribute("action","/customerController/doDel");
                    document.getElementById("queryForm").submit();
                }
            }
        }

        //修改
        function xf() {
            //获取选中的多选框的个数
            var count=0;//用于表示多选框选中的个数
            //1.拿到所有的多选框
            var a=document.getElementsByName("selectCuId");
            for (var i=0;i<a.length;i++){
                if (a[i].checked==true){
                    count++;
                }
            }
            //2.判断-只能选中一个
            if (count>1){
                alert("只能选择一条数据进行修改");
            }else if (count<1){
                alert("请选择你要修改的数据");
            }else {
                //正常情况可到达修改页面
                document.getElementById("queryForm").setAttribute("action","/customerController/toUpdate");
                document.getElementById("queryForm").submit();
            }
        }
    </script>

    <%--<script type="text/javascript" src="../../js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript">
        //全选
        var oall=document.getElementById("All");
        var oid=document.getElementsByName("selectCustomerId");
        oall.onclick=function () {
            for (var i=0;i<oid.length;i++){
                //所有选择框和全选一致
                oid[i].checked=oall.checked;
            }
        };
        //点击复选框
        for (var i=0;i<oid.length;i++){
            oid[i].onclick=function () {
                //判断是否全部选中，遍历
                for (var j=0;j<oid.length;j++){
                    if (oid[j].checked==false){
                        oall.checked=false;
                        break;
                    }else {
                        oall.checked=true;
                    }
                }
            };
        }
        //点击删除
        $("#del").click(function () {
            var ids="";
            var n=0;
            for (var i=0;i<oid.length;i++){
                if (oid[i].checked==true){
                    var id=oid[i].value;
                    if (n==0){
                        ids+="ids="+id;
                    }else {
                        ids+="&ids="+id;
                    }
                    n++;
                }
            }
            //上面会拼接出一个名为ids的数组ids=1&ids=2&ids=3&ids=4……
            $.get("/customeController/doDelete",ids,function (date) {
                if (date=="\"ok\""){
                    alert("删除成功！");
                    //删除成功后，调用action方法刷新页面信息
                    location.href="/customeController/findForSearch";
                }else {
                    alert("删除失败！");
                }
            });
        });
    </script>--%>
</head>
<body>
<%--<h3 style="color: darksalmon;">欢迎您！成功进入CRM人事管理系统！！</h3>
<a href="/toLogin">亲请登录</a><br>
<a href="/toCar">我的购物车</a><br>
<a href="/toTaotao">我的淘宝</a><br>
<a href="/logOut">退出账户</a>--%>

<h1>客户信息列表</h1>
<div class="content">
    <form:form modelAttribute="customer" method="post" id="queryForm">
       <!--传递页码-->
        <input type="hidden" name="pageNum" id="pageNum">
        <div>
            <%--<button id="queryBtn">查询</button>--%>
            <input type="button" id="addBtn" onclick="add2();" value="新增" >
            <button type="button" id="addBtn" onclick="add();">新增</button>
            <button id="updateBtn" onclick="xf();">修改</button>
                <button id="deleteBtn"type="button" onclick="sc()">删除</button>
                <button id="del">批量删除</button>
        </div><br>
        <div>
            <span>客户编号：</span>
            <c:if test="${customer.customerId!=0}">
                <form:input path="customerId"/>&nbsp;
            </c:if>
            <c:if test="${customer.customerId==0}">
                <input type="text" id="customerId" name="customerId">
            </c:if>
            <span>&nbsp;客户名称：</span>
            <form:input path="customerName"/><br><br>
            <span>客户信息来源：</span>
            <form:select path="customerSourse">
                <form:option value="">--请选择--</form:option>
                <form:option value="A">电话营销</form:option>
                <form:option value="B">网络营销</form:option>
            </form:select>&nbsp;
            <span>&nbsp;创建日期：</span>
            <input type="date" id="customerDateBegin" name="customerDateBegin" value="${customerDateBegin}">-
            <input type="date" id="customerDateEnd" name="customerDateEnd" value="${customerDateEnd}">&nbsp;
            <button id="queryBtn" onclick="subPage(1);">&nbsp;开始查询</button>
        </div><br>
        <table border="1px" cellpadding="5" cellspacing="0">
            <tr>
                <td width="5%" align="center" id="All" onclick="qx();">全选</td>
                <td width="15%" align="center">客户编号</td>
                <td width="15%" align="center">客户名称</td>
                <td width="15%" align="center">客户负责人</td>
                <td width="18%" align="center">客户信息来源</td>
                <td width="18%" align="center">客户所属行业</td>
                <td width="23%" align="center">创建日期</td>
            </tr>
            <c:forEach items="${list}" var="c">
                <tr>
                    <td width="5%" align="center"><input type="checkbox" id="selectCuId" name="selectCuId" value="${c.customerId}"></td>
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
                    <li><a href="javascript:void(0)" onclick="subPage(${pageNum-1})"><<</a></li>
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
                            <li><a href="javascript:void(0)" onclick="subPage(${i})">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <%--下一页--%>
                <c:if test="${pageNum<totalPage}">
                    <%--当前页小于5--%>
                    <li><a href="javascript:void(0)" onclick="subPage(${pageNum+1})">>></a></li>
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
