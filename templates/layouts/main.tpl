<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" type="image/png" href="/resources/logo.png"/>
	<title>BOOKING BOOTH SYSTEM</title>
	<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
  	<link rel="stylesheet" href="/resources/jqwidgets/styles/jqx.base.css">
  	<!--<link rel="stylesheet" href="/resources/css/multiple-select.css" />-->
  	<link rel="stylesheet" href="/resources/css/app.css" />
  	<!--<link rel="stylesheet" href="/resources/css/sandstone.min.css" />-->
  	<link rel="stylesheet" href="/resources/jqwidgets/styles/themeorange2.css"/>
  	<link rel="stylesheet" href="/resources/css/jquery-ui.min.css" />
    <link rel="stylesheet" href="/resources/sweetalert-master/dist/sweetalert.css" />
    <!--<link rel="stylesheet" href="/resources/chosen/chosen.css" />-->
  	<link rel="stylesheet" href="/resources/css/msgBoxLight.css" type="text/css" />
	<link rel="stylesheet" href="/resources/css/carousel.css" />
	<link rel="stylesheet" href="/resources/font-awesome/css/fontawesome.css">
	<link rel="stylesheet" href="/resources/font-awesome/css/solid.css">
	<link rel="stylesheet" href="/resources/font-awesome/css/brands.css">

	<script src="/resources/js/jquery-1.12.0.min.js"></script>
	<script src="/resources/js/jquery-ui.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script src="/resources/jqwidgets/jqxcore.js"></script>
	<script src="/resources/jqwidgets/jqxdata.js"></script> 
	<script src="/resources/jqwidgets/jqxbuttons.js"></script>
	<script src="/resources/jqwidgets/jqxscrollbar.js"></script>
	<script src="/resources/jqwidgets/jqxmenu.js"></script>
	<script src="/resources/jqwidgets/jqxcheckbox.js"></script>
	<script src="/resources/jqwidgets/jqxlistbox.js"></script>
	<script src="/resources/jqwidgets/jqxdropdownlist.js"></script>
	<script src="/resources/jqwidgets/jqxdropdownbutton.js"></script> 
	<script src="/resources/jqwidgets/jqxgrid.js"></script>
	<script src="/resources/jqwidgets/jqxgrid.sort.js"></script> 
	<script src="/resources/jqwidgets/jqxgrid.pager.js"></script> 
	<script src="/resources/jqwidgets/jqxgrid.selection.js"></script> 
	<script src="/resources/jqwidgets/jqxgrid.edit.js"></script> 
	<script src="/resources/jqwidgets/jqxgrid.filter.js"></script> 
	<script src="/resources/jqwidgets/jqxgrid.columnsresize.js"></script>
	<script src="/resources/jqwidgets/jqxcore.js"></script>
	<script src="/resources/jqwidgets/jqxbuttongroup.js"></script>
	<script src="/resources/jqwidgets/jqxbuttons.js"></script>
	<script src="/resources/jqwidgets/jqxradiobutton.js"></script>
	<script src="/resources/jqwidgets/jqxdatetimeinput.js"></script>
	<script src="/resources/jqwidgets/jqxcalendar.js"></script>
	<script src="/resources/jqwidgets/jqxgrid.aggregates.js"></script>
	<script src="/resources/jqwidgets/jqxwindow.js"></script>
	<script src="/resources/js/gojax.min.js"></script>
	<script src="/resources/js/functions.js"></script>
	<script src="/resources/js/app.js"></script>
	<script src="/resources/js/gotify.min.js"></script>
	<script src="/resources/js/multiple-select.js"></script>
	<script src="/resources/js/jquery.msgBox.js"></script>
	<script src="/resources/js/jqueryui_datepicker_thai_min.js"></script>
	<script src="/resources/sweetalert-master/dist/sweetalert.min.js"></script>
	<script src="/resources/chosen/chosen.jquery.min.js"></script>

	
	<!--<link rel="stylesheet" href="/resources/ztreev3/css/zTreeStyle/zTreeStyle.css">-->
	<style>
		.containers {
			padding-top: 8px;
		}
		.drop,.drop:link, .drop:hover, .drop:visited, .drop:active{
			text-decoration: none;
			color: white;
			display: block;
    		padding: .5rem 1rem;
		}
		.changepass, .changepass:link,.changepass:hover, .changepass:visited, .changepass:active{
			text-decoration: none;
			color: black;
			margin-top: 0;
			border-top-right-radius: 0;
			border-top-left-radius: 0;
		}
		.dropdown-menu {
			left: auto;
			right: 0;
			position: absolute;
			top: 100%;
			z-index: 1000;
			display: none;
			float: left;
			min-width: 160px;
			padding: 5px 0;
			margin: 2px 0 0;
			list-style: none;
			font-size: 14px;
			text-align: left;
			background-color: #ffffff;
			border: 1px solid #dfd7ca;
			border-radius: 4px;
			-webkit-box-shadow: 0 6px 12px rgba(0,0,0,0.175);
			box-shadow: 0 6px 12px rgba(0,0,0,0.175);
			-webkit-background-clip: padding-box;
			background-clip: padding-box;
		}
		.open>.dropdown-menu {
			display: block;
		}

		#loader {
			color: #40b9ff;
			font-size: 20px;
			margin: 100px auto;
			width: 1em;
			height: 1em;
			border-radius: 50%;
			position: absolute;
			left: 50%;
			top: 30%;
			text-indent: -9999em;
			-webkit-animation: load4 1.3s infinite linear;
			animation: load4 1.3s infinite linear;
			-webkit-transform: translateZ(0);
			-ms-transform: translateZ(0);
			transform: translateZ(0);
			}
		@-webkit-keyframes load4 {
			0%,
			100% {	box-shadow: 0 -3em 0 0.2em, 2em -2em 0 0em, 3em 0 0 -1em, 2em 2em 0 -1em, 0 3em 0 -1em, -2em 2em 0 -1em, -3em 0 0 -1em, -2em -2em 0 0;}
			12.5% {	box-shadow: 0 -3em 0 0, 2em -2em 0 0.2em, 3em 0 0 0, 2em 2em 0 -1em, 0 3em 0 -1em, -2em 2em 0 -1em, -3em 0 0 -1em, -2em -2em 0 -1em;}
			25% {	box-shadow: 0 -3em 0 -0.5em, 2em -2em 0 0, 3em 0 0 0.2em, 2em 2em 0 0, 0 3em 0 -1em, -2em 2em 0 -1em, -3em 0 0 -1em, -2em -2em 0 -1em;}
			37.5% {	box-shadow: 0 -3em 0 -1em, 2em -2em 0 -1em, 3em 0em 0 0, 2em 2em 0 0.2em, 0 3em 0 0em, -2em 2em 0 -1em, -3em 0em 0 -1em, -2em -2em 0 -1em;}
			50% {	box-shadow: 0 -3em 0 -1em, 2em -2em 0 -1em, 3em 0 0 -1em, 2em 2em 0 0em, 0 3em 0 0.2em, -2em 2em 0 0, -3em 0em 0 -1em, -2em -2em 0 -1em;}
			62.5% {	box-shadow: 0 -3em 0 -1em, 2em -2em 0 -1em, 3em 0 0 -1em, 2em 2em 0 -1em, 0 3em 0 0, -2em 2em 0 0.2em, -3em 0 0 0, -2em -2em 0 -1em;}
			75% {	box-shadow: 0em -3em 0 -1em, 2em -2em 0 -1em, 3em 0em 0 -1em, 2em 2em 0 -1em, 0 3em 0 -1em, -2em 2em 0 0, -3em 0em 0 0.2em, -2em -2em 0 0;}
			87.5% {	box-shadow: 0em -3em 0 0, 2em -2em 0 -1em, 3em 0 0 -1em, 2em 2em 0 -1em, 0 3em 0 -1em, -2em 2em 0 0, -3em 0em 0 0, -2em -2em 0 0.2em;}
		}
		@keyframes load4 {
			0%,
			100% {	box-shadow: 0 -3em 0 0.2em, 2em -2em 0 0em, 3em 0 0 -1em, 2em 2em 0 -1em, 0 3em 0 -1em, -2em 2em 0 -1em, -3em 0 0 -1em, -2em -2em 0 0;}
			12.5% {	box-shadow: 0 -3em 0 0, 2em -2em 0 0.2em, 3em 0 0 0, 2em 2em 0 -1em, 0 3em 0 -1em, -2em 2em 0 -1em, -3em 0 0 -1em, -2em -2em 0 -1em;}
			25% {	box-shadow: 0 -3em 0 -0.5em, 2em -2em 0 0, 3em 0 0 0.2em, 2em 2em 0 0, 0 3em 0 -1em, -2em 2em 0 -1em, -3em 0 0 -1em, -2em -2em 0 -1em;}
			37.5% {	box-shadow: 0 -3em 0 -1em, 2em -2em 0 -1em, 3em 0em 0 0, 2em 2em 0 0.2em, 0 3em 0 0em, -2em 2em 0 -1em, -3em 0em 0 -1em, -2em -2em 0 -1em;}
			50% {	box-shadow: 0 -3em 0 -1em, 2em -2em 0 -1em, 3em 0 0 -1em, 2em 2em 0 0em, 0 3em 0 0.2em, -2em 2em 0 0, -3em 0em 0 -1em, -2em -2em 0 -1em;}
			62.5% {	box-shadow: 0 -3em 0 -1em, 2em -2em 0 -1em, 3em 0 0 -1em, 2em 2em 0 -1em, 0 3em 0 0, -2em 2em 0 0.2em, -3em 0 0 0, -2em -2em 0 -1em;}
			75% {	box-shadow: 0em -3em 0 -1em, 2em -2em 0 -1em, 3em 0em 0 -1em, 2em 2em 0 -1em, 0 3em 0 -1em, -2em 2em 0 0, -3em 0em 0 0.2em, -2em -2em 0 0;}
			87.5% {	box-shadow: 0em -3em 0 0, 2em -2em 0 -1em, 3em 0 0 -1em, 2em 2em 0 -1em, 0 3em 0 -1em, -2em 2em 0 0, -3em 0em 0 0, -2em -2em 0 0.2em;}
		}

		/* Add animation to "page content" */
		.animate-bottom {
			position: relative;
			-webkit-animation-name: animatebottom;
			-webkit-animation-duration: 1s;
			animation-name: animatebottom;
			animation-duration: 1s
		}

		@-webkit-keyframes animatebottom {
			from { bottom:-100px; opacity:0 } 
			to { bottom:0px; opacity:1 }
		}

		@keyframes animatebottom { 
			from{ bottom:-100px; opacity:0 } 
			to{ bottom:0; opacity:1 }
		}

		#myDiv {
			display: none;
		}

	</style>
</head>
<body onload="myFunction()" style="margin:0;">
		<div class="gotify-overlay"></div>

		<div class="gotify">
		<div class="gotify-wrap">
			<div class="close-gotify" onclick="return close_gotify()"></div>
			<div class="gotify-content"></div>
		</div>
		</div>
		<div id="loader">Loading...</div>
	<!-- NOTE -->
	<div style="display:none;" id="myDiv" class="animate-bottom">
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
		<?php if (isset($_SESSION["logged"]) && $_SESSION["status"]==0){ ?>
			<a class="navbar-brand" href="/">BOOKING BOOTH</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="/">หน้าแรก</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/about">เกี่ยวกับเรา</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/contact">ติดต่อ</a>
				</li>
			</ul>
		<?php }else{ ?>
			<a class="navbar-brand" href="/">BOOKING BOOTH</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="/">หน้าแรก</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/about">เกี่ยวกับเรา</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/contact">ติดต่อ</a>
				</li>
			</ul>
		<?php }?>
		<?php if ((isset($_SESSION["logged"]) && $_SESSION["status"]==0)||(isset($_SESSION["logged"]) && $_SESSION["status"]==1)){ ?> 
			<div class="my-2 my-md-0">
				<ul class="navbar-nav mr-auto">
					<?php if (isset($_SESSION["logged"])&& $_SESSION["status"]==1): ?>
					<a href="#" class="dropdown-toggle drop active" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="fas fa-user"></span><?php echo " ".$_SESSION["username"]; ?></a>
						<ul class="dropdown-menu">
							<li><a class="changepass" href="/list/booking"><span class="fas fa-list"></span> รายการจอง</a></li>
							<li><a class="changepass" href="/list/users?check=$check"><span class="fas fa-users"></span> ข้อมูลสมาชิก</a></li>
							<li><a class="changepass" href="/admin/profile"><span class="fas fa-users"></span> ข้อมูลส่วนตัว</a></li>
						</ul>
					<li class="nav-item"><a class="nav-link" href="/user/logout"><span class="fas fa-sign-out-alt"></span> ออกจากระบบ</a></li>
					<?php endif ?>
					<?php if (isset($_SESSION["logged"])&& $_SESSION["status"]==0): ?>
					<a href="#" class="dropdown-toggle drop active" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="fas fa-user"></span><?php echo " ".$_SESSION["username"]; ?></a>
						<ul class="dropdown-menu">
							<li><a class="changepass" href="/user/profile"><span class="fas fa-users"></span> ข้อมูลส่วนตัว</a></li>
						</ul>
					<li class="nav-item"><a class="nav-link" href="/user/logout"><span class="fas fa-sign-out-alt"></span> ออกจากระบบ</a></li>
					<?php endif ?>
				</ul>
			</div>
		<?php }else{ ?>
			<div class="my-2 my-md-0">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active"><a class="nav-link" href="/user/auth"><span class="fas fas fa-sign-in-alt"></span> เข้าสู่ระบบ</a></li>
				</ul>
			</div>
			<?php }?>
			</div>
		</nav>
	<div class="containers">
		<?= $this->section('content'); ?>
		<br>
	</div>
	<!--<div class="container" style="font-size: larger;">
		<span class="float-right"><a href="#">Back to top</a></span>
		<p>&copy; 2019-2020 Company Deestone, Ltd. &middot;</p>
	</div>-->
	</div>
</body>
</html>
<script type="text/javascript">

	var myVar;

	function myFunction() {
		myVar = setTimeout(showPage, 750);
	}

	function showPage() {
		document.getElementById("loader").style.display = "none";
		document.getElementById("myDiv").style.display = "block";
	}

	function CloseSession(){
		session_destroy();
	}
	window.onbeforeunload = CloseSession;
</script> 
