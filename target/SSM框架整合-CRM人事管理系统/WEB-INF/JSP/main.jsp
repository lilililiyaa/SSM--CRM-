<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2020/5/18
  Time: 15:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>CRM后台管理系统</title>
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
    <script type="text/javascript">
        /*获取查看的页码，并放到表单隐藏域里*/
        function subPage(page) {
            document.getElementById("pageNum").value=page;
            subForm();
        }
        /*提交表单*/
        function subForm() {
            document.getElementById("queryForm").submit();
        }


    </script>
    <script>
        function dian() {
            location.href="/CC/toAdd";
        }
        function qx() {
            var text= document.getElementById("All").innerHTML;
            if (text=='全选'){
                var a= document.getElementsByName("selectCuId");
                for (var i=0;i<a.length;i++){
                    a[i].checked=true;
                }
                document.getElementById("All").innerHTML="取消";

            }else if(text=="取消"){
                var a= document.getElementsByName("selectCuId");
                for (var i=0;i<a.length;i++){
                    a[i].checked=false;
                }
                document.getElementById("All").innerHTML="全选";
            }
        }

        function sc() {
            //获取选中的多选框
            var b=[];
            //拿到全部的多选框
            var a= document.getElementsByName("selectCuId");
            //遍历所有的多选框
            for (var i=0;i<a.length;i++){
                if (a[i].checked==true){
                    b.push(a[i]);
                }
            }
            if (b.length<=0){
                alert("请选择你想删除的数据");
            } else {
                if (confirm("你确定要删除吗？")==true){
                    //到controller的删除的方法
                    document.getElementById("queryForm").setAttribute("action","/customeController/doDel");
                    document.getElementById("queryForm").submit();
                }
            }

        }

        function xg() {
            //获取选中的多选框的个数
            var count=0;
            //1.拿到所有多选框
            var a=document.getElementsByName("selectCuId");
            for (var i=0;i<a.length;i++){
                if (a[i].checked==true){
                    count++;
                }
            }
            //2.判断
            if (count>1){
                alert("只能选择一条数据进行修改");
            } else if (count<1){
                alert("请选择你要修改的值");
            } else {
                //正常情况可以去修改页面的controller
                document.getElementById("queryForm").setAttribute("action","/customeController/toUpdate");
                document.getElementById("queryForm").submit();
            }
        }
    </script>

</head>
<body>
<h1>客户信息列表</h1>
<div class="content">
    <form:form modelAttribute="customer" action="/customeController/findForSearch" id="queryForm">
        <%--去传页码--%>
        <input type="hidden" name="pageNum" id="pageNum">
        <div>
            <button type="button" id="queryBtn" onclick="subForm()">查询</button>
            <input type="button" onclick="dian()" value="新增">
            <button id="update" type="button" onclick="xg();">修改</button>
            <button id="delete" type="button" onclick="sc()">删除</button>
        </div>
        <br>
        <div>
            <span>客户编号</span>
            <c:if test="${customer.customerId!=0}">
                <form:input path="customerId"/>&nbsp;
            </c:if>
            <c:if test="${customer.customerId==0}">
                <input type="text" id="customerId" name="customerId">
            </c:if>
            <span>客户名称</span>
            <form:input path="customerName"></form:input><br><br>
            <span>客户信息来源</span>
            <form:select path="customerSourse">
                <form:option value="">请选择</form:option>
                <form:option value="A">电话营销</form:option>
                <form:option value="B">网络营销</form:option>
            </form:select>
            <span>创建日期</span>
            <input type="date" id="cusDateBegin" name="cusDateBegin" value="${cusDateBegin}">
            <input type="date" id="cusDateEnding" name="cusDateEnding"  value="${cusDateEnding}">
            <button type="button" id="query" onclick="subForm()">开始查询</button>
        </div>
        <br><br>
        <table border="1px" cellpadding="5" cellspacing="0">
            <tr>
                <td width="5%" align="center" id="All" onclick="qx()">全选</td>
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

        </table>
        <br><br>
        <%--分页--%>
        <div>
            共有${totalRows} 条数据，共有${totalPage}页，当前为第${pageNum}页<br>
            <ul class="pagination">
                    <%--上一页--%>
                <c:if test="${pageNum>1}" >
                    <li><a href="javascript:void(0)" onclick="subPage(${pageNum-1})"><<</a></li>
                </c:if>
                <c:if test="${pageNum==1}" >
                    <li><<</li>
                </c:if>
                    <%--中间页--%>
                    <%--总页数小于等于5页--%>
                <c:choose>
                    <c:when test="${totalPage<=5}">
                        <c:set var="begin" value="1"></c:set>
                        <c:set var="end" value="${totalPage}" ></c:set>
                    </c:when>
                    <%--页数大于5页--%>
                    <c:otherwise>
                        <c:set var="begin" value="${pageNum-1}"></c:set>
                        <c:set var="end" value="${pageNum+3}"></c:set>
                        <%--如果当前第一页，最大页为5--%>
                        <c:if test="${begin-1<=0}">
                            <c:set var="begin" value="1"></c:set>
                            <c:set var="end" value="5"></c:set>
                        </c:if>
                        <%--end大于总页数，设置begin=总页数-4--%>
                        <c:if test="${end>totalPage}">
                            <c:set var="begin" value="${totalPage-4}"></c:set>
                            <c:set var="end" value="${totalPage}"></c:set>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                    <%--遍历显示中间页码--%>
                <c:forEach var="i" begin="${begin}" end="${end}">
                    <c:choose>
                        <%--当前页选中不能显示超链接--%>
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
                    <li><a href="javascript:void(0)" onclick="subPage(${pageNum+1})">>></a></li>
                </c:if>
                <c:if test="${pageNum==totalPage}">
                    <li>>></li>
                </c:if>

            </ul>
                <%--分页结束--%>


        </div>
    </form:form>
</div>


</body>
</html>
