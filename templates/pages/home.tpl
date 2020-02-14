<?php $this->layout("layouts/main") ?>
<style>
  .Booking:link,.Booking:hover,.Booking:visited,.Booking:active{
    color:black;
    text-decoration: none;
  }

  .modal {
    z-index:1;
    display:none;
    padding-top:100px;
    position:fixed;
    left:0;
    top:0;
    width:100%;
    height:100%;
    overflow:auto;
    background-color:rgb(0,0,0);
    background-color:rgba(0,0,0,0.8)
  }

  .modal-content{
    margin: auto;
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }


  .modal-hover-opacity {
    opacity:1;
    filter:alpha(opacity=100);
    -webkit-backface-visibility:hidden
  }

  .modal-hover-opacity:hover {
    opacity:0.60;
    filter:alpha(opacity=60);
    -webkit-backface-visibility:hidden
  }


  .close {
    text-decoration:none;
    float:right;
    top: 15px;
    font-size:40px;
    font-weight:bold;
    color:white;
    transition: 0.3s;
  }

  .close:hover,.close:focus {
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
  } 

  .container1 {
    width:200px;
    display:inline-block;
  }
  .modal-content, #caption {   
    -webkit-animation-name: zoom;
    -webkit-animation-duration: 0.6s;
    animation-name: zoom;
    animation-duration: 0.6s;
  }


  @-webkit-keyframes zoom {
    from {-webkit-transform:scale(0)} 
    to {-webkit-transform:scale(1)}
  }

  @keyframes zoom {
    from {transform:scale(0)} 
    to {transform:scale(1)}
  }
</style>
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img class="first-slide" src="upload/BookingBooth (10).jpg" alt="First slide">
        <div class="container">
          <div class="carousel-caption text-left">
            <h1>BOOKING BOOTH SYSTEM</h1>
            <p>สามารถเพิ่มโอกาสทางธุรกิจให้ผู้ประกอบการที่เป็นเจ้าของตลาดสามแยกกระทุ่มแบนบริหารจัดการจำนวนพื้นที่ผู้เช่าร้านค้าภายในตลาดได้.</p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <img class="second-slide" src="upload/BookingBooth (8).jpg" alt="Second slide">
        <div class="container">
          <div class="carousel-caption">
            <h1>และยัง..</h1>
            <p>เพื่อเพิ่มช่องทางการจองพื้นที่ให้ผู้เช่าร้านค้าที่ตลาดสามแยกกระทุ่มแบน.</p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <img class="third-slide" src="upload/BookingBooth (3).jpg" alt="Third slide">
        <div class="container">
          <div class="carousel-caption text-right">
            <h1>อีกทั้ง..</h1>
            <p>เพื่อให้ผู้ประกอบการที่เป็นเจ้าของตลาดสามแยกกระทุ่มแบนตรวจสอบจำนวนผู้เช่าและจำนวนพื้นที่ว่างได้อย่างชัดเจน.</p>
          </div>
        </div>
      </div>
	</div>
    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
</div>
<div class="container marketing">
  <div class="row featurette" style="background:rgb(243, 243, 243); padding: 20px;">
    <div class="col-md-4 text-center">
      <div class="row">
        <div class="col-sm-4" style="background:rgb(86, 179, 255); padding: 10px;">
            <i class="fas fa-store" style="font-size:70px;color:rgb(255, 255, 255)"></i>
        </div>
        <div class="col">
            <p style="font-size:20px; color:rgb(0, 0, 0)">จำนวนล๊อคทั้งหมด</p>
            <p style="font-size:20px; color:rgb(119, 119, 119)"><span id="booth_all"></span></p>
        </div>
      </div>
    </div>
    <div class="col-md-4 text-center">
      <div class="row">
        <div class="col-sm-4" style="background:rgb(255, 86, 86); padding: 10px;">
            <i class="fas fa-store" style="font-size:70px;color:rgb(255, 255, 255)"></i>
        </div>
        <div class="col">
            <p style="font-size:20px; color:rgb(0, 0, 0)">จำนวนล๊อคที่จองไปแล้ว</p>
            <p style="font-size:20px; color:rgb(119, 119, 119)"><span id="booth_booking"></span></p>
        </div>
      </div>
    </div>
    <div class="col-md-4 text-center">
      <div class="row">
        <div class="col-sm-4" style="background:#00CC00; padding: 10px;">
            <i class="fas fa-store" style="font-size:70px;color:rgb(255, 255, 255)"></i>
        </div>
        <div class="col">
            <p style="font-size:20px; color:rgb(0, 0, 0)">จำนวนล๊อคที่ยังเหลืออยู่</p>
            <p style="font-size:20px; color:rgb(119, 119, 119)"><span id="booth_balance"></span></p>
        </div>
      </div>
    </div>
  </div>

  <!-- Three columns of text below the carousel -->
  <?php if (isset($_SESSION["logged"])&& $_SESSION["status"]==0): ?>
  <br>
  <br>
  <br>
  <div class="row text-center">
    <div class="col-md-5"></div>
    <div class="col-md-2 p-3 mb-2 bg-dark text-white rounded-circle" style="cursor: pointer;" onclick="window.location.href='/booking'">
      <i class='fas fa-store' style='font-size:48px;'></i><br>
      จอง
    </div>  
    <div class="col-md-5"></div>
  </div>
  <?php endif ?>
  <hr class="featurette-divider">
  <div class="row featurette" >
    <div class="col-md-5">
        <h3 class="featurette-heading">
          มุมของกิน
        </h3>
        <p class="lead">
            สวัสดีวันจันทร์ วันนี้อากาศดี จะมีหมอกเล็กน้อยในตอนเช้า พระอาทิตย์เจิดจ้าสดใส ไม่มีอะไรต้องกังวล 
        </p>
    </div>
    <div class="col-md-7">
        <img class src="upload/BookingBooth (4).jpg"  width="650" height="450 ">
    </div>
  </div>

  <hr class="featurette-divider">

  <div class="row featurette" >
    <div class="col-md-7">
      <img class src="upload/BookingBooth (7).jpg"  width="650" height="450">
    </div>
    <div class="col-md-5">
        <h3 class="featurette-heading">
          มุมเสื้อผ้า
        </h3>
        <p class="lead">
            สวัสดีวันอังคาร วันนี้อากาศดีมาก จะมีหมอกและละอองน้ำเล็กน้อยในตอนเช้า อันเนื่องมาจากเมื่อคืนฝนตกและหยุดในตอนเช้า ท้องฟ้าเปิดกว้าง พระอาทิตย์เจิดจ้าสดใส ไม่มีอะไรต้องกังวล 
        </p>
    </div>
  </div>

  <hr class="featurette-divider">

  <div class="row featurette" >
    <div class="col-md-5">
        <h3 class="featurette-heading">
          ที่ตั้งของตลาด
        </h3>
        <p class="lead">
            สวัสดีวันพุธ วันนี้ก็ยังอากาศดีเช่นเคย แต่อาจจะมีฝนตกเล็กน้อยบางพื้นที่ แต่ส่วนใหญ่แล้วท้องฟ้าแจ่มใส 
        </p>
    </div>
    <div class="col-md-7">
      <iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d969.2683969440194!2d100.27400582918324!3d13.653287507825691!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1z4LiV4Lil4Liy4LiU4LiZ4Lix4LiU4Liq4Liy4Lih4LmB4Lii4LiB4LiB4Lij4Liw4LiX4Li44LmI4Lih4LmB4Lia4LiZ!5e0!3m2!1sth!2sth!4v1581322118384!5m2!1sth!2sth" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>  
    </div>
  </div>
  
  <hr class="featurette-divider">
  
  <h4>VIEW THE PHOTOS</h4>
  <div class="row featurette" >
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (13).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (12).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (11).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (10).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (9).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (8).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (7).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (6).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (5).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (4).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (3).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin:15px 0 15px 0"> 
        <img src="upload/BookingBooth (2).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
      <div class="col-sm-3" style="margin: 2px;"> 
        <img src="upload/BookingBooth (1).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>
  </div>
  <div id="modal01" class="modal" onclick="this.style.display='none'">
    <span class="close">&times;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    <div class="modal-content">
      <img id="img01" style="max-width:100%">
    </div>
  </div>
  <br>
  <br>
</div>

<script>

jQuery(document).ready(function($){
    showbalance();
    showall();
    showbooking();
});

function showall(){

  $.ajax({
          url: "/booth/dis_all",
          type : 'get',
          cache : false, 
          dataType : 'json',
          success: function(result){
            x = JSON.stringify(result[0].number);
            $("#booth_all").html(x);
  }});

}

function showbalance(){

  $.ajax({
          url: "/booth/dis_balance",
          type : 'get',
          cache : false, 
          dataType : 'json',
          success: function(result){
            x = JSON.stringify(result[0].number);
            $("#booth_balance").html(x);
        
  }});

}
function showbooking(){

  $.ajax({
          url: "/booth/dis_booking",
          type : 'get',
          dataType : 'json',
          cache : false, 
          success: function(result){
            x = JSON.stringify(result[0].number);
            $("#booth_booking").html(x);
  }});

}

function onClick(element) {
  document.getElementById("img01").src = element.src;
  document.getElementById("modal01").style.display = "block";
}

</script>
