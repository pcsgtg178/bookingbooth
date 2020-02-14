<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="x-ua-compatible" content="ie=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" type="image/png" href="/resources/logo.png"/>
		<title>BOOKING BOOTH SYSTEM</title>
		<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
		<link rel="stylesheet" href="/resources/css/app.css" />
		<link rel="stylesheet" href="/resources/css/carousel.css" />
		<link rel="stylesheet" href="/resources/font-awesome/css/fontawesome.css">
		<link rel="stylesheet" href="/resources/font-awesome/css/solid.css">
		<link rel="stylesheet" href="/resources/font-awesome/css/brands.css">
		<link rel="stylesheet" href="/resources/sweetalert-master/dist/sweetalert.css" />
	</head>
	<body>
		<div class="container">
			<div class="row" style="justify-content: center;">
				
				<div class="col-md-6 col-md-offset-3 border" style="border-radius: 15px;">
					<div class="panel panel-default">
						<br>
						<div class="panel-heading text-center">
							<h2> <strong>เข้าสู่ระบบ</strong> </h2> 
						</div>
						<div class="panel-body">
							<br><br>
							<form id="form_user_auth">
								<div class="form-group">
									<div class="row">
										<div class="col-md-12">
											<label for="username">Username</label>
											<div class="form-group">
												<input type="text" name="inp_username" id="inp_username" class="form-control" placeholder="Username" required>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-md-10">
											<label for="password">Password</label>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<input type="password" name="inp_password" id="inp_password" class="form-control" placeholder="Password" required>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 text-left">
											<button type="reset">Clear</button>
										</div>
									</div>
								</div>
								<button class="btn btn-primary btn-lg btn-block" type="submit">เข้าสู่ระบบ</button>
								
								<br><br>
								<!-- <p align="right"><a href="/forgetpassword"><i>forget password</i></a></p> -->
								<div style="
											padding: 20px 0 0 0; 
											display: -webkit-box;
											display: -webkit-flex;
											display: -moz-box;
											display: -ms-flexbox;
											display: flex;
											-webkit-flex-direction: column;
											-moz-flex-direction: column;
											-ms-flex-direction: column;
											-o-flex-direction: column;
											flex-direction: column;
											-ms-align-items: center;
											align-items: center;">
									<span style="font-size: 14px; line-height: 1.5; color: #666666; padding-bottom: 17px;">หากท่านยังไม่เป็นสมาชิก กรุณา</span>
									<a style="font-size: 14px; line-height: 1.5; color: #333333; text-transform: uppercase; text-decoration: none;" href="/signup">สมัครสมาชิก</a>
								</div>
							</form>
							<br>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="/resources/sweetalert-master/dist/sweetalert.min.js"></script> 
		<script src="/resources/js/jquery-1.12.0.min.js"></script>
		<script src="/resources/js/bootstrap.min.js"></script>
		<script src="/resources/js/gojax.min.js"></script>
		<script src="/resources/js/app.js"></script>
		<script src="/resources/js/gotify.min.js"></script>

		<script type="text/javascript">

		jQuery(document).ready(function($) {
			$('#inp_username').val('').focus();
			$('#form_user_auth').on('submit', function(event) {
				
				event.preventDefault();
				gojax_f('post', '/api/v1/user/auths', '#form_user_auth')
				.done(function(data) {
				if (data.result === false) {
					swal("ชื่อผู้ใช้ หรือ รหัสผ่านผิด", "กรุณาเช็คชื่อผู้ใช้ และรหัสผ่าน", "error");
					// gotify(data.message,"danger");
				} else {
					if (data.message==0) {
						//swal("User นี้ไม่มีสิทธิ์ใช้งาน", "กรุณาติดต่อ Admin", "info");
						// window.location = '/profile';
						window.location = '/';
					}else{
						console.log("change pages success!");
						window.location = '/';
					}
					
				}
			});
			});
		});

		</script>

	</body>
</html>

