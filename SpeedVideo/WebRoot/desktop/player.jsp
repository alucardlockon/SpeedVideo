<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>${video.title} - 速播视频 - Html5视频，电影，电视剧，动漫</title>

		<%@include file="../commons/header.jsp"%>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/userAgent.js">
</script>
		<c:if test="${!empty sessionScope.user}" var="rs">
			<script type="text/javascript">
$(function() {
	$('#commentContent').click(function() {
		var s = $('.comments').length;
		$('#row').val(s + 1);
	})
})
$(function() {
	$('#commentbtn').click(
			function() {
				htmlobj = $.ajax( {
					url : 'commentAction?comment.content='
							+ $('#commentContent').val() + '&comment.row='
							+ $('#row').val() + '&comment.vid='
							+ $('#commentvid').val(),
					async : true
				});
				$('#commentContent').val('')
			});
});
$(function() {
	$('.rateimg').click(function() {
		var s = this;
		imgnum = s.id.substring(s.id.indexOf('_') + 1);
		for (i = 1; i <= imgnum; i++) {
			document.getElementById('rateimg_' + i).src = 'images/star1.png';
		}
		for (i = 10; i > imgnum; i--) {
			document.getElementById('rateimg_' + i).src = 'images/star2.png';
		}
		//location='commentAction!rate?vid='+${video.id}+'&score='+imgnum;
			htmlobj = $.ajax( {
				url : 'commentAction!rate?vid='+${video.id}+'&score='+imgnum,
				async : true
			});
		})
})
$(function() {
	$('.rateimg').mouseover(function() {
		var s = this;
		imgnum = s.id.substring(s.id.indexOf('_') + 1);
		for (i = 1; i <= imgnum; i++) {
			document.getElementById('rateimg_' + i).src = 'images/star1.png';
		}
		for (i = 10; i > imgnum; i--) {
			document.getElementById('rateimg_' + i).src = 'images/star2.png';
		}
		})
})
$(function() {
	$('.rateimg').ready(function() {
		var s = this;
		var sco=${score}*1;
		for (i = 1; i <= sco; i++) {
			document.getElementById('rateimg_' + i).src = 'images/star1.png';
		}
		for (i = 10; i > sco; i--) {
			document.getElementById('rateimg_' + i).src = 'images/star2.png';
		}
		})
})
</script>
		</c:if>
	</head>

	<body>
		<div id="body-container">
			<div id="logo-bar">
				<jsp:include page="../commons/logo_bar.jsp"></jsp:include>
			</div>
			<div id="main-body">
				<div id="left-list">
					<s:action name="categoryAction!getCategory" executeResult="true"
						namespace="/">
					</s:action>
				</div>
				<div id="content" style="width: 40%;height:100%">
					<span id="title">${video.title}</span>
					<div class="video_content">
						<video
							src="${pageContext.request.contextPath}/videos/${video.url}"
							controls="controls" preload="preload" height="240px"
							width="432px">
						<source type="video/mp4" />
						您的浏览器不支持 video标签，使用
						<a href="https://www.google.com/intl/zh-CN/chrome/browser/">Chorme</a>,
						<a href="http://www.apple.com.cn/safari/">Safari</a>,
						<a href="http://firefox.com.cn/download/">FireFox</a>浏览器获得更好的体验。
						</video>
					</div>
					<c:if test="${!empty sessionScope.user}" var="rs">
						<a href='videoAction!addtoFav?video.id=${video.id}'><img
								src='images/like.png' style="height: 38; width: 90" /> </a>
					</c:if>
					<br />
					<span id="videoscore">${totalscore}</span>&nbsp;分
					<br />
					<c:if test="${rs}">
						<div id='rate_div'>
							<img src="images/star2.png" class="rateimg" id="rateimg_1" />
							<img src="images/star2.png" class="rateimg" id="rateimg_2" />
							<img src="images/star2.png" class="rateimg" id="rateimg_3" />
							<img src="images/star2.png" class="rateimg" id="rateimg_4" />
							<img src="images/star2.png" class="rateimg" id="rateimg_5" />
							<img src="images/star2.png" class="rateimg" id="rateimg_6" />
							<img src="images/star2.png" class="rateimg" id="rateimg_7" />
							<img src="images/star2.png" class="rateimg" id="rateimg_8" />
							<img src="images/star2.png" class="rateimg" id="rateimg_9" />
							<img src="images/star2.png" class="rateimg" id="rateimg_10" />
						</div>
					</c:if>
					<br />
					影片简介:
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;${video.intro}
					<br />
					<span id="views">观看数:${video.views}</span>
					<br />
					<div id="comment_form">
						<c:if test="${rs}">
							<form action="commentAction" id="commentForm">
								<textarea rows="5" id="commentContent" name="comment.content"
									style="height: 20%"></textarea>
								<br />
								<input type="button" id="commentbtn" value="我要评论" />
								<input type="hidden" id="row" name="comment.row" value="1">
								<input type="hidden" id="commentvid" name="comment.vid"
									value="${video.id}">
							</form>
						</c:if>
					</div>
				</div>
				<div id="right-list">
					评论:
					<blockquote style="">
						<s:iterator value="comments">
							<table class="comments">
								<thead>
									<tr>
										<td>
											<a href="userAction!userinfo?user.id=${uid}"><img
													src="images/${user.photo}" alt="" width="120"/>
											</a>
										</td>
									</tr>
									<tr>
										<td>
											${row}楼&nbsp;用户:
											<a href="userAction!userinfo?user.id=${uid}">${user.username}</a>
										</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											${content}
										</td>
									</tr>
									<tr>
										<td>
											<small><i> 发表于: <s:date name="postdate"
														format="yyyy-MM-dd hh:mm:ss" /> </i> </small>
										</td>
									</tr>
								</tbody>
								<tfoot>
								</tfoot>
							</table>
						</s:iterator>
						<c:if test="${page>1}">
							<a
								href="${pageContext.request.contextPath}/videoAction!play?video.id=${video.id}&page=${page-1}">&lt;&lt;上一页
							</a> &nbsp;
							</c:if>
						<c:if test="${page<maxPage}">
						<a
								href="${pageContext.request.contextPath}/videoAction!play?video.id=${video.id}&page=${page+1}">下一页&gt;&gt;</a>
						</c:if>
					</blockquote>
				</div>
			</div>
			<div id="footer">
				<jsp:include page="../commons/footer.jsp"></jsp:include>
			</div>

		</div>
	</body>
</html>

