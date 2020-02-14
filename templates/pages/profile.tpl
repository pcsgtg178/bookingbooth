<?php $this->layout("layouts/main") ?>
<style>
    input {
        width: 100%;
        padding: 15px;
        margin: 5px 0 22px 0;
        display: inline-block;
        border: none;
        background: #f1f1f1;
    }
    * {
        box-sizing: border-box;
    }
    .btn_delete:link {
        cursor: pointer;
        color: rgb(255, 0, 0);
    }
    .btn_delete:hover{
        cursor: pointer;
        color: rgb(255, 122, 122);
    }
</style>
<div class="container">
    <div class="container rounded" style="background-color: #f2f2f2; margin: 10px 0 10px 0 ; border-radius: 30px; justify-content: center;">
            <form id="form_update_user" class="form-group" onsubmit="return submit_update_user()">
                <nav class="navbar navbar-expand-lg">
                    <h2 style="text-decoration: underline; color: rgb(48, 113, 252);">แก้ไขข้อมูลส่วนตัว</h2>
                  
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                      <ul class="navbar-nav mr-auto">
                      </ul>
                      <a class="nav-link disabled btn_delete" onclick="return delete_user()" tabindex="-1"  >ลบบัญชี?</a>
                    </div>
                </nav>
                <div style="padding: .5rem 1rem;">
                    <p>หากต้องการแก้ไขให้กรอกข้อมูลแล้วกดบันทึก.</p>
                    <hr>
                    <label for="id"><b>รหัสสมาชิก</b></label>
                    <input class="form-control" type="text" name="id" id="id" value="<?php echo $_SESSION["userid"]; ?>" readonly>

                    <label for="username"><b>ชื่อสมาชิก</b></label>
                    <input class="form-control" type="text" name="username" id="username"> 
                    
                    <label for="password"><b>รหัสผ่าน</b></label>
                    <div class="input-group mb-3">
                        <input class="form-control" type="password" style="margin: 0;" name="password" value="<?php echo $_SESSION["password"]; ?>" readonly> 
                        <div class="input-group-append">
                          <button class="btn btn-warning" onclick="return modal_change_password()" type="button">เปลี่ยนรหัสผ่าน</button>
                        </div>
                    </div>
                    <label for="name"><b>ชื่อ-สกุล</b></label>
                    <input class="form-control" type="text" name="name" id="name"> 

                    <label for="tel"><b>เบอร์โทร</b></label>
                    <input class="form-control" type="text" name="tel" id="tel">

                    <label for="status"><b>สถานะ</b></label>
                    <input class="form-control" type="text" name="status" value="<?php echo ($_SESSION["status"])? "Admin":"User"; ?>" readonly>
                    <button class="btn btn-success" id="Save"><i class="glyphicon glyphicon-floppy-save"></i>&nbsp;บันทึก</button>
                    <a class="btn btn-primary" href="/home"><i class="glyphicon glyphicon-floppy-save"></i>&nbsp;ยกเลิก</a>  
                </div> 
            </form>
            <div class="modal" id="modal_change" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h4 class="modal-title">this title</h4>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="disiblebutton()">
                        <span aria-hidden="true" class="fas fa-window-close"></span>
                      </button>
                      
                    </div>
                  <div class="modal-body">
                      <form id="form_change" onsubmit="return submit_change_password()">
                            <input type="hidden" name="id" id="id" value="<?php echo $_SESSION["userid"]; ?>">
                          <div class="form-group">
                                <label for="new_pass" id="lab_new_pass">รหัสผ่านใหม่</label>
                                <input type="password" name="new_pass" id="new_pass" class="form-control" autocomplete="off">
                                <span id="8char" class="glyphicon fas fa-times" style="color:#FF0004;"></span> 8 ตัวอักษรขึ้นไป<br>
                                <span id="ucase" class="glyphicon fas fa-times" style="color:#FF0004;"></span> ตัวพิมพ์ใหญ่อย่างน้อยหนึ่งตัว
                                <span id="lcase" class="glyphicon fas fa-times" style="color:#FF0004;"></span> ตัวพิมพ์เล็กอย่างน้อยหนึ่งตัว<br>
                                <span id="num" class="glyphicon fas fa-times" style="color:#FF0004;"></span> ตัวเลขหนึ่งตัว
                          </div>
                          <div class="form-group">    
                              <label for="sub_new_pass" id="lab_sub_new_pass">ยืนยันรหัสผ่านใหม่อีกครั้ง</label>
                              <input type="password" name="sub_new_pass" id="sub_new_pass" class="form-control" autocomplete="off">
                              <span id="pwmatch" class="glyphicon fas fa-times" style="color:#FF0004;"></span> รหัสตรงกัน
                          </div>
                            
                          <button class="btn btn-primary" id="submit"><i class="glyphicon glyphicon-floppy-save"></i>&nbsp;ยืนยันการเปลี่ยนแปลง</button>
                      </form>
                    </div>
                  </div>
                </div>
            </div>
            <div id="dialog" title="Delete"><label for="Delete">คุณต้องการลบที่จะมัน?</label></div>
    </div>
</div>
<script>

    var userid = '<?php echo $_SESSION["userid"]; ?>';
    $('#dialog').hide();
    jQuery(document).ready(function($){
        show_name();
        show_username();
        show_tel();
        document.getElementById("submit").disabled = true;
        
    });

    $("input[type=password]").keyup(function(){
        var ucase = new RegExp("[A-Z]+");
        var lcase = new RegExp("[a-z]+");
        var num = new RegExp("[0-9]+");
        
        if($("#new_pass").val().length >= 8){
            $("#8char").removeClass("fas fa-times");
            $("#8char").addClass("fas fa-check");
            $("#8char").css("color","#00A41E");
        }else{
            $("#8char").removeClass("fas fa-check");
            $("#8char").addClass("fas fa-times");
            $("#8char").css("color","#FF0004");
        }
        
        if(ucase.test($("#new_pass").val())){
            $("#ucase").removeClass("fas fa-times");
            $("#ucase").addClass("fas fa-check");
            $("#ucase").css("color","#00A41E");
        }else{
            $("#ucase").removeClass("fas fa-check");
            $("#ucase").addClass("fas fa-times");
            $("#ucase").css("color","#FF0004");
        }
        
        if(lcase.test($("#new_pass").val())){
            $("#lcase").removeClass("fas fa-times");
            $("#lcase").addClass("fas fa-check");
            $("#lcase").css("color","#00A41E");
        }else{
            $("#lcase").removeClass("fas fa-check");
            $("#lcase").addClass("fas fa-times");
            $("#lcase").css("color","#FF0004");
        }
        
        if(num.test($("#new_pass").val())){
            $("#num").removeClass("fas fa-times");
            $("#num").addClass("fas fa-check");
            $("#num").css("color","#00A41E");
        }else{
            $("#num").removeClass("fas fa-check");
            $("#num").addClass("fas fa-times");
            $("#num").css("color","#FF0004");
        }
        
        if($("#new_pass").val() == $("#sub_new_pass").val()){
            $("#pwmatch").removeClass("fas fa-times");
            $("#pwmatch").addClass("fas fa-check");
            $("#pwmatch").css("color","#00A41E");
            document.getElementById("submit").disabled = false;
        }else{
            $("#pwmatch").removeClass("fas fa-check");
            $("#pwmatch").addClass("fas fa-times");
            $("#pwmatch").css("color","#FF0004");
        }
    });

    function modal_change_password() {
        $('#form_change').trigger('reset');
        $('#modal_change').modal({backdrop: 'static'});
        $('.modal-title').text('เปลี่ยนรหัสผ่าน');
        $('input[name=bookingid]').val(userid);
        $('input[name=boothid]').val(rowdata.ID);
    }

    function delete_user(){
        $("#dialog").dialog({
      		buttons : {
        		"ยืนยัน" : function() {

        		gojax('get', '/api/v1/user/delete_user', {id:userid})

			    	.done(function(data) {
			    		if (data.status == 200)
						{
							gotify(data.message,"success");
			    			//$('#dialog').dialog("close");
			          		//$('#gridbooking').jqxGrid('updatebounddata');
						} else {
						    gotify(data.message,"danger");
						}
                    });
                    $('#dialog').dialog("close");
    	 		    return false;

        	},
        		"ยกเลิก" : function() {
          			$(this).dialog("close");
        	}
              
        }
    })}
    
    function submit_update_user(){
        $.ajax({
            url : '/api/v1/user/update',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_update_user').serialize()
            })
            .done(function(data) {
                if (data.status != 200) {
                    gotify(data.message,"danger");
                }else{
                    gotify(data.message,"success");
                }
                window.location.reload();
            });
        return false;
    }

    function submit_change_password(){
        $.ajax({
            url : '/api/v1/user/change_pass',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_change').serialize()
            })
            .done(function(data) {
                if (data.status != 200) {
                    gotify(data.message,"danger");
                }else{
                    gotify(data.message,"success");
                }
                $('#modal_change').modal('hide');
            });
        return false;
    }
    function show_username(){

        $.ajax({
                url: "/api/v1/user/username?userid="+userid,
                type : 'get', 
                cache : false, 
                dataType : 'json',
                success: function(result){
                x = JSON.stringify(result[0].USERNAME);
                x = JSON.parse(x);
                $('input[name=username]').val(x);
            
        }});

    }
    function show_name(){

        $.ajax({
                url: "/api/v1/user/name?userid="+userid,
                type : 'get',
                dataType : 'json',
                cache : false, 
                success: function(result){
                x = JSON.stringify(result[0].NAME);
                x = JSON.parse(x);
                $('input[name=name]').val(x);
        }});

    }
    function show_tel(){

        $.ajax({
                url: "/api/v1/user/tel?userid="+userid,
                type : 'get',
                dataType : 'json',
                cache : false, 
                success: function(result){
                x = JSON.stringify(result[0].TEL);
                x = JSON.parse(x);
                $('input[name=tel]').val(x);
        }});

    }

</script>