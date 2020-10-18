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
.uploadForm{
	width:30%;
	position:relative;
	left:0;
	right:0;
	margin:auto;
	bottom:0;
}
</style>

<div class="uploadForm">
<form name="uploadForm" id="uploadForm" method="post" 
            enctype="multipart/form-data">
        <img id="Preview" src="https://i.imgur.com/aQRV2SP.png" 
        style="width: 200px; height: 200px">    
        <input type="file" name="file" id="picUpload" accept=".png, .jpg, .jpeg"/><br/>
        <input type="submit" value="上傳" class="btnUpload" />
</form>
</div>

<script type="text/javascript">

// 上傳商品圖片立刻顯示
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
	
	console.log("here");
	
	$.ajax({
		url: '${pageContext.request.contextPath}/backend/productManage/uploadFile',
		type: 'POST',
		data: new FormData($('#uploadForm')[0]),
		contentType: false,
		processData: false,
		success: function(data) {
			if (data == 'success'){
				alert("圖片已上傳");
			} else {
				alert("上傳失敗");
			}
		}
	});
})  
   
</script>
