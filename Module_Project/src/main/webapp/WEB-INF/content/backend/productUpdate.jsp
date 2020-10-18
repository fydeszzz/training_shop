<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="urlPrefix" value="/backend/productManage" />
<c:url var="productUrl" value="${urlPrefix}" />

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
.w3-table-all{
	left:0;
	right:0;
	margin:auto;
	top:100px;
	width:50%;
	position:absolute;
}
</style>

<form:form modelAttribute="modelAttribute" method="POST">
<table class="w3-table-all">
	<tbody>
		<thead>
	      <tr class="w3-deep-purple">
	        <th colspan="3">
	        	<span style="font-weight:bold">修改商品資料</span>
	        </th>
	      </tr>
    	</thead>
		<tr style="height:200px">
    		<td>商品圖片</td>
    		<td></td>
    		<td></td>
    	</tr>
		<tr>
			<td>商品編號：</td>
			<td>${modelAttribute.id}</td>
			<td></td>
		</tr>
		<tr>
			<td>商品名稱：</td>
			<td><form:input type="text" path="product_name" required="required"></form:input></td>
			<td></td>
		</tr>
		<tr>
			<td>商品描述：</td>
			<td><form:textarea path="detail" rows="5" cols="40" required="required"></form:textarea></td>
			<td></td>
		</tr>
		<tr>
			<td>商品標籤：</td>
			<td>
			<form:select path="tag">
				<form:option value="1">湯底</form:option>
				<form:option value="2">肉類</form:option>
				<form:option value="3">海鮮</form:option>
				<form:option value="4">蔬菜</form:option>
				<form:option value="5">火鍋料</form:option>
				<form:option value="6">甜點</form:option>
				<form:option value="7">飲料</form:option>
			</form:select>
			</td>
			<td></td>
		</tr>
		<tr>
			<td>價格：</td>
			<td><form:input type="text" path="price" required="required"></form:input></td>
			<td></td>
		</tr>
		<tr>
			<td>庫存數量：</td>
			<td><form:input type="text" path="storage" required="required"></form:input></td>
			<td></td>
		</tr>
		<tr>
			<td>商品狀態</td>
			<td>
			<form:select path="shelf">
				<form:option value="0">下架</form:option>
				<form:option value="1">上架</form:option>
			</form:select>
			</td>
			<td></td>
		</tr>
		<tr>
		<td><button type="submit">確認修改</button></td>
		<td></td>
		<td></td>
		</tr>
	</tbody>
</table>
</form:form>

<!-- upload file -->
<div class="uploadForm">
<form name="uploadForm" id="uploadForm" method="post" 
            enctype="multipart/form-data">
        
        <img id="Preview" src="/Module_Project/resources/img/item${modelAttribute.id}.png" style="width: 150px; height: 150px">
        <input type="file" name="file" id="picUpload" accept=".png, .jpg, .jpeg"/>
		<input type="submit" value="上傳" class="btnUpload" rel="${modelAttribute.id}" style="display:none"/>
		<input type="text" id="productId" value="${modelAttribute.id}" style="display:none">
</form>
</div>

<p>
	<button id="btnBack" class="w3-btn w3-blue-grey">回商品後台首頁</button>
</p>

<script type="text/javascript">
	
	// 回商品後台首頁
	$('#btnBack').click(function() {
		window.location.replace('${productUrl}');
	});
	
	//上傳商品圖片立刻顯示
	$('#picUpload').on("change", function () {
	        var file = $('#picUpload')[0].files[0];
	        var reader = new FileReader;
	        reader.onload = function (e) {
	            $('#Preview').attr('src', e.target.result);
	        };
	        reader.readAsDataURL(file);
	        productEdit = true
	    });
	    $("#Preview").on("click", function() {
	        $("#picUpload").click();
	    })
	    
	// 上傳圖片
	$('form#uploadForm').submit(function(event) {
		event.preventDefault();
		
		var productid = $('#productId').val();
		console.log("productid= " + productid);
		
		$.ajax({
			url: '${pageContext.request.contextPath}/backend/productManage/uploadFile?id=' + productid,
			type: 'POST',
			data: new FormData($('#uploadForm')[0]),
			contentType: false,
			processData: false,
			success: function(data) {
				if (data == 'success'){
					console.log("done");
				} else {
					alert("上傳失敗");
				}
			}
		});
	})  

	// 修改資料
	$('form#modelAttribute').submit(function(event) {
		event.preventDefault();
	
		$.ajax({
			url: '${formUrl}',
			type: 'POST',
			data: $('form#modelAttribute').serialize(),
			success: function(data, textStatus, xhr) {
				$(".btnUpload").trigger("click");
				alert("修改成功");
				window.location.replace('${productUrl}');
			},
			error: function(xhr, textStatus, exception){
				alert("發生錯誤");
				window.location.href ="";
			}
		});
	});

</script>
