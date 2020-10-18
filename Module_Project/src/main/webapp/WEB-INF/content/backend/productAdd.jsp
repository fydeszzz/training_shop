<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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
		<thead>
	      <tr class="w3-red">
	        <th colspan="3">
	        	<span style="font-weight:bold">新增商品</span>
	        </th>
	      </tr>
    	</thead>
    		<tr style="height:200px">
    			<td>商品圖片</td>
				<td></td>
				<td></td>
    		</tr>
			<tr>
				<td>商品名稱：</td>
				<td>
					<form:input path="product_name" size="20" maxlength="16" required="required" autofocus="autofocus" />
				</td>
				<td></td>
			</tr>
			<tr>
				<td>商品描述：</td>
				<td>
					<form:textarea path="detail" rows="5" cols="40" required="required" />
				</td>
				<td></td>
			</tr>
			<tr>
				<td>分類：</td>
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
				<td>價錢：</td>
				<td>
					<form:input path="price" required="required"></form:input>
				</td>
				<td></td>
			</tr>
			<tr>
				<td>庫存：</td>
				<td>
					<form:input path="storage" required="required"></form:input>
				</td>
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
				<td colspan="3" style="text-align:center">
					<button type="submit">送出</button>
					<button type="reset">清除</button>
				</td>
			</tr>
			
	</table>
			<button id="btnBack" class="w3-btn w3-blue-grey">回商品後台首頁</button>	
</form:form>

<!-- upload file -->
<div class="uploadForm">
<form name="uploadForm" id="uploadForm" method="post" 
            enctype="multipart/form-data">
        
        <img id="Preview" src="https://i.imgur.com/aQRV2SP.png" 
        style="width: 150px; height: 150px;">    
       	
        <input type="file" name="file" id="picUpload" accept=".png, .jpg, .jpeg"/>
		<input type="submit" value="上傳" class="btnUpload" style="display:none"/>
</form>
</div>

<script type="text/javascript">

// 回商品後台首頁
$('#btnBack').click(function() {
	window.location.href = '${productUrl}';
});

//上傳商品圖片立刻顯示
$('#picUpload').on("change", function () {
        var file = $('#picUpload')[0].files[0];
        
        if (file.size > 1024 * 1024 * 2) {
            alert('您上傳的檔案大於2MB，請重新選擇！');
        } else {
        var reader = new FileReader;
        	reader.onload = function (e) {
            $('#Preview').attr('src', e.target.result);
        };
        	reader.readAsDataURL(file);
        	productEdit = true
        }
    });
    $("#Preview").on("click", function() {
        $("#picUpload").click();
    })
    
// 上傳圖片
$('form#uploadForm').submit(function(event) {
	event.preventDefault();

	$.ajax({
		url: '${pageContext.request.contextPath}/backend/productManage/uploadFile?id=0',
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
    
// 送出後回到查詢頁並更新
$('form#modelAttribute').submit(function(event) {
	event.preventDefault();

	$.ajax({
		url: '${formUrl}',
		type: 'POST',
		data: $('form#modelAttribute').serialize(),
		success: function(data, textStatus, xhr) {
			
			$(".btnUpload").trigger("click");
			alert("新增成功");
			window.location.replace('${productUrl}');
		},
		error: function(xhr, textStatus, exception){
			alert("新增錯誤");
			window.location.href ="";
		}
	});

});

</script>
