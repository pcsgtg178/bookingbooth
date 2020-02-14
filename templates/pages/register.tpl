<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="x-ua-compatible" content="ie=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" type="image/png" href="/resources/logo.png"/>
		<title>BOOKING BOOTH SYSTEM</title>
        <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
        <link rel="stylesheet" href="/resources/css/msgBoxLight.css" type="text/css" />
        <link rel="stylesheet" href="/resources/css/jquery-ui.min.css" />
        <link rel="stylesheet" href="/resources/sweetalert-master/dist/sweetalert.css" />
		<link rel="stylesheet" href="/resources/css/app.css" />
		<link rel="stylesheet" href="/resources/css/carousel.css" />
		<link rel="stylesheet" href="/resources/font-awesome/css/fontawesome.css">
		<link rel="stylesheet" href="/resources/font-awesome/css/solid.css">
        <link rel="stylesheet" href="/resources/font-awesome/css/brands.css">
        

        <script src="/resources/js/jquery-1.12.0.min.js"></script>
	    <script src="/resources/js/jquery-ui.min.js"></script>
		<script src="/resources/js/bootstrap.min.js"></script>
		<script src="/resources/js/gojax.min.js"></script>
		<script src="/resources/js/app.js"></script>
        <script src="/resources/js/gotify.min.js"></script>
        <script src="/resources/js/jquery.msgBox.js"></script>
        <script src="/resources/js/jqueryui_datepicker_thai_min.js"></script>
        <script src="/resources/sweetalert-master/dist/sweetalert.min.js"></script>
        <script src="/resources/chosen/chosen.jquery.min.js"></script>
	</head>
	<body>

        <div class="gotify-overlay"></div>

		<div class="gotify">
		<div class="gotify-wrap">
			<div class="close-gotify" onclick="close_message()"></div>
			<div class="gotify-content"></div>
		</div>
		</div>

        <div class="container">
            <form id="form_create" onsubmit="return submit_create_user()">
                <div class="container border" style="border-radius: 15px;">
                        <h2 class="mb-3">สมัครสมาชิก</h2>
                        <div class="form-group mb-3">
                            <label for="mb_user">ชื่อสมาชิก</label>
                            <input type="text" class="form-control" name="mb_user" id="mb_user" placeholder="ตัวอย่าง : chai123" aria-describedby="inputGroupPrepend" required>
                            <div class="invalid-feedback">
                                *โปรดกรอก username ของท่านให้เรียบร้อย.
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label for="mb_pass">รหัสผ่าน</label>
                            <input type="password" class="form-control" name="mb_pass" id="mb_pass" placeholder="ตัวอย่าง : 123456789" minlength="6" required>
                            <span id="8char" class="glyphicon fas fa-times" style="color:#FF0004;"></span> 8 ตัวอักษรขึ้นไป<br>
                            <span id="ucase" class="glyphicon fas fa-times" style="color:#FF0004;"></span> ตัวพิมพ์ใหญ่อย่างน้อยหนึ่งตัว
                            <span id="lcase" class="glyphicon fas fa-times" style="color:#FF0004;"></span> ตัวพิมพ์เล็กอย่างน้อยหนึ่งตัว<br>
                            <span id="num" class="glyphicon fas fa-times" style="color:#FF0004;"></span> ตัวเลขหนึ่งตัว
                            <div class="invalid-feedback">
                                *โปรดกรอก password ของท่านให้เรียบร้อย.
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label for="sub_pass">ยืนยัน รหัสผ่าน</label>
                            <input type="password" class="form-control" name="sub_pass" id="sub_pass" placeholder="ตัวอย่าง : 123456789" minlength="6" required>
                            <span id="pwmatch" class="glyphicon fas fa-times" style="color:#FF0004;"></span> รหัสตรงกัน
                            <div class="invalid-feedback">
                                *โปรดกรอก password ของท่านให้เรียบร้อย.
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label for="mb_name">ชื่อ-นามสกุล</label>
                            <input type="text" class="form-control" name="mb_name" id="mb_name" placeholder="ตัวอย่าง : ชาย หรือ ชาย สกุล" maxlength="30" required>
                            <div class="invalid-feedback">
                                *โปรดกรอกชื่อของท่านให้เรียบร้อย.
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <label for="mb_tel">เบอร์โทร</label>
                            <input type="tel" class="form-control" name="mb_tel" id="mb_tel" placeholder="ตัวอย่าง : 0999999999" minlength="10" maxlength="10" required>
                            <div class="invalid-feedback">
                                *โปรดกรอกเบอร์โทรติดต่อของท่านให้เรียบร้อย.
                            </div>
                        </div>
                    <button class="btn btn-primary btn-lg btn-block" id="Submit" type="submit">สมัครสมาชิก</button>
                    <span><a style="text-decoration: none;" href="/user/auth">ยกเลิก</a></span>
                </div>
            </form>
        </div>  
         
        <script type="text/javascript">

            jQuery(document).ready(function($){
                document.getElementById("Submit").disabled = true;
            });

            $("input[type=password]").keyup(function(){
            var ucase = new RegExp("[A-Z]+");
            var lcase = new RegExp("[a-z]+");
            var num = new RegExp("[0-9]+");
            
            if($("#mb_pass").val().length >= 8){
                $("#8char").removeClass("fas fa-times");
                $("#8char").addClass("fas fa-check");
                $("#8char").css("color","#00A41E");
            }else{
                $("#8char").removeClass("fas fa-check");
                $("#8char").addClass("fas fa-times");
                $("#8char").css("color","#FF0004");
            }
            
            if(ucase.test($("#mb_pass").val())){
                $("#ucase").removeClass("fas fa-times");
                $("#ucase").addClass("fas fa-check");
                $("#ucase").css("color","#00A41E");
            }else{
                $("#ucase").removeClass("fas fa-check");
                $("#ucase").addClass("fas fa-times");
                $("#ucase").css("color","#FF0004");
            }
            
            if(lcase.test($("#mb_pass").val())){
                $("#lcase").removeClass("fas fa-times");
                $("#lcase").addClass("fas fa-check");
                $("#lcase").css("color","#00A41E");
            }else{
                $("#lcase").removeClass("fas fa-check");
                $("#lcase").addClass("fas fa-times");
                $("#lcase").css("color","#FF0004");
            }
            
            if(num.test($("#mb_pass").val())){
                $("#num").removeClass("fas fa-times");
                $("#num").addClass("fas fa-check");
                $("#num").css("color","#00A41E");
            }else{
                $("#num").removeClass("fas fa-check");
                $("#num").addClass("fas fa-times");
                $("#num").css("color","#FF0004");
            }
            
            if($("#mb_pass").val() == $("#sub_pass").val()){
                $("#pwmatch").removeClass("fas fa-times");
                $("#pwmatch").addClass("fas fa-check");
                $("#pwmatch").css("color","#00A41E");
                document.getElementById("Submit").disabled = false;
            }else{
                $("#pwmatch").removeClass("fas fa-check");
                $("#pwmatch").addClass("fas fa-times");
                $("#pwmatch").css("color","#FF0004");
            }
        });

        function close_message(){
            close_gotify();
            window.location.replace("/user/auth");
        }

        function submit_create_user() {
        $.ajax({
            url : '/api/v1/user/create',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_create').serialize()
            })
            .done(function(data) {
                if (data.status != 201) {
                    gotify(data.message,"danger");
                }else{
                    gotify(data.message,"success");
                }
            });
        return false;
    }
        </script>
    </body>
</html>

