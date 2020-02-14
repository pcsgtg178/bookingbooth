<?php $this->layout("layouts/main") ?>
<style>
    .ui-front {
        z-index: 318;
    }
</style>
<div class="container">
    <br>
    <h4>ล๊อคร้านค้า</h4>
    <hr>
    <button id="btn_booking" onclick="return modal_create_open()" class="btn btn-primary btn-md" style="width: 100px; margin-bottom: 15px;">จอง</button>
    <div id="gridbooth"></div><br>
    <h4>รายการจองของคุณ</h4>
    <div id="gridbooking" style="margin-bottom: 12px;"></div>

    <button id="btn_delete" class="btn btn-danger btn-md">ยกเลิก</button>

    <div class="modal" id="modal_create" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
            <h4 class="modal-title">this title</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="disiblebutton()">
              <span aria-hidden="true" class="fas fa-window-close"></span>
	        </button>
	        
	      </div>
	    <div class="modal-body">
            <form id="form_create" onsubmit="return submit_create_repair()">
                <div class="form-group">
                    <label for="lab_bookingid" id="lab_bookingid">รหัสการจอง</label>
                    <input type="text" name="bookingid" id="bookingid" class="form-control" autocomplete="off">
                </div>
		        <div class="form-group">    
		        	<label for="lab_memberid" id="lab_memberid">รหัสการสมาชิก</label>
		            <input type="text" name="memberid" id="memberid" class="form-control" autocomplete="off">
		        </div>
		        <div class="form-group">
		            <label for="lab_boothid" id="lab_boothid">รหัสล๊อค</label>
		            <input type="text" name="boothid" id="boothid" class="form-control" autocomplete="off" >
		        </div>
                <div class="form-group">
                    <label for="lab_pice" id="lab_price">ยอดจ่ายทั้งหมด</label>
                    <div id="priceid" type="checked" name="priceid"></div>
                </div>
		        <div class="form-group">
		            <label for="lab_bookingdate" id="lab_bookingdate">วันที่จอง</label>
		            <input type="date" name="bookingdate" id="bookingdate" class="form-control" autocomplete="off" >
                </div>
                <div class="form-group">
		            <label for="lab_bookeddate" id="lab_bookeddate">วันที่สิ้นสุด</label>
		            <input type="date" name="bookeddate" id="bookeddate" class="form-control" autocomplete="off" >
                </div>

		        <input type="hidden" name="saledate">
                <input type="hidden" name="createBy">
                <input type="hidden" name="updateBy">

                <button class="btn btn-primary" id="Save"><i class="glyphicon glyphicon-floppy-save"></i>&nbsp;ยืนยันการจอง</button>
	        </form>
	      </div>
	    </div>
	  </div>
    </div>
    <div id="dialog" title="Delete"><label for="Delete">คุณต้องการลบที่จะมัน?</label></div>
</div>

<script type="text/javascript">
    $('#dialog').hide();
    var date = new Date();
    var dd = date.getDate();
    var mm = date.getMonth() + 1;
    var yyyy = date.getFullYear();
    if(dd < 10){
        dd = '0'+dd; 
    }
    if(mm < 10){
        mm = '0'+mm;
    }
    var nowDate = yyyy+'-'+mm+'-'+dd;
    var now2Date = mm+'/'+dd+'/'+yyyy;
    jQuery(document).ready(function($){
        gridbooth();
        gridbooking();
        disiblebutton();
        document.getElementById("Save").disabled = true;
    });
    var session_userid = '<?php echo $_SESSION["userid"]; ?>';

    function bookingDate(inputDate, addDay){
        var d = new Date(inputDate);
        d.setDate(d.getDate()+addDay);
        mkMonth=d.getMonth()+1;
        mkMonth=new String(mkMonth);
        if(mkMonth.length==1){
            mkMonth="0"+mkMonth;
        }
        mkDay=d.getDate();
        mkDay=new String(mkDay);
        if(mkDay.length==1){
            mkDay="0"+mkDay;
        }   
        mkYear=d.getFullYear();
        return mkYear+"-"+mkMonth+"-"+mkDay;
    }

    function disiblebutton(){
        document.getElementById("Save").disabled = true;
    }

    $('#gridbooth').on('rowclick', function (event){
        var args = event.args;
        var boundIndex = args.rowindex;
        var datarow = $("#gridbooth").jqxGrid('getrowdata', boundIndex);

        if(datarow.STATUS_BOOKING == 1){
            document.getElementById("btn_booking").disabled = true;
        }
        else{
            document.getElementById("btn_booking").disabled = false;
        }
    });

    $('#gridbooking').on('rowclick', function (event){
        var args = event.args;
        var boundIndex = args.rowindex;
        var datarow = $("#gridbooking").jqxGrid('getrowdata', boundIndex);

        if(datarow.STATUS_APPROVED == 1){
            document.getElementById("btn_delete").disabled = true;
        }
        else{
            document.getElementById("btn_delete").disabled = false;
        }
    });

  	$('#btn_delete').on('click', function(e) {
      var rowdata = row_selected("#gridbooking");
    	if (typeof rowdata !== 'undefined') {
    		$("#dialog").dialog({
      		buttons : {
        		"OK" : function() {

        		gojax('post', '/api/v1/booking/delete', {id:rowdata.BOOKINGID})

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
                    $('#gridbooking').jqxGrid('updatebounddata');
                    $('#gridbooth').jqxGrid('updatebounddata');
                    document.getElementById("btn_booking").disabled = false;
    	 		return false;

        	},
        		"Cancel" : function() {
          			$(this).dialog("close");
        	}
      	}
    	});

      	}else{//tan_edit_180625
					alert("กรุณาเลือกรายการ");
				}
  	});

    function modal_create_open() {
        var rowdata = row_selected("#gridbooth");
        if (typeof rowdata !== 'undefined') {
            $('#form_create').trigger('reset');
            $('#modal_create').modal({backdrop: 'static'});
            $('.modal-title').text('รายการจอง');
            $('#lab_bookingid').hide();
            $('input[name=bookingid]').hide();
            $('input[name=memberid]').val(session_userid);
            $('input[name=memberid]').prop('readonly', true);
            $('input[name=boothid]').val(rowdata.ID);
            $('input[name=boothid]').prop('readonly', true);
            $('#lab_bookingdate').hide();
            $('input[name=bookingdate]').hide();
            $('#lab_bookeddate').hide();
            $('input[name=bookeddate]').hide();
        }

        $("#priceid").jqxListBox({width: 466, height: 52});   
        getPrice()
        .done(function(data) {
            $('#priceid').jqxListBox('refresh');
            $.each(data, function(index, val) {
                var NAME;
                if(val.NAME == "Regular"){
                    NAME = "ขาประจำ";
                }else{
                    NAME = "ขาจร";
                }

                $("#priceid").jqxListBox('addItem',{
                    label: NAME +"  "+ val.PRICE,
                    value: val.ID,
                });           
            }); 
         });

        $("#priceid").on('select', function (event) {
            document.getElementById("Save").disabled = false;
            if (event.args) {
                var item = event.args.item;
                if (item) {
                    if(item.value == 1){
                        $('#lab_bookingdate').show();
                        $('input[name=bookingdate]').show();
                        $('#lab_bookeddate').show();
                        $('input[name=bookeddate]').show();
                        $('input[name=saledate]').val(nowDate);
                        $('input[name=bookingdate]').val(nowDate);
                        $('input[name=bookingdate]').prop('readonly', true);
                        $('input[name=bookeddate]').val(bookingDate(now2Date, 7));
                        $('input[name=bookeddate]').prop('readonly', true);
                    }
                    if(item.value == 2){
                        $('#lab_bookingdate').show();
                        $('input[name=bookingdate]').show();
                        $('#lab_bookeddate').show();
                        $('input[name=bookeddate]').show();
                        $('input[name=saledate]').val(nowDate);
                        $('input[name=bookingdate]').val(nowDate);
                        $('input[name=bookingdate]').prop('readonly', true);
                        $('input[name=bookeddate]').val(bookingDate(now2Date, 1));
                        $('input[name=bookeddate]').prop('readonly', true);
                    }
                }
            }
        });
  	}

    function submit_create_repair() {
        $.ajax({
            url : '/api/v1/booking/create',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_create').serialize()
            })
            .done(function(data) {
            if (data.status != 201) {
                gotify(data.message,"danger");
                $('#gridbooth').jqxGrid('updatebounddata');
                $('#gridbooking').jqxGrid('updatebounddata');
                document.getElementById("Save").disabled = true;
            }else{
                gotify(data.message,"success");
                $('#gridbooth').jqxGrid('updatebounddata');
                $('#gridbooking').jqxGrid('updatebounddata');
                document.getElementById("btn_booking").disabled = true;
                document.getElementById("Save").disabled = true;
                $('#modal_create').modal('hide');
            }
            });
        return false;
    }

    function gridbooth(){
        var dataAdapter = new $.jqx.dataAdapter({
            datatype: "json",
            datafields: [
                { 
                    name: "ID",
                    type: "string" 
                },
                { 
                    name: "DETAIL",
                    type: "string" 
                },
                { 
                    name: "STATUS_BOOKING",
                    type: "int" 
                }
            ],
                url : '/api/v1/booth/load'
        });

        return $("#gridbooth").jqxGrid({
            width: '100%',
            source: dataAdapter,
            autoheight: true,
            columnsresize: true,
            pageable: true,
            filterable: true,
            showfilterrow: true,
            theme : 'themeorange2',
            columns: [
                { 
                    text:"รหัสล๊อค", 
                    datafield: "ID",
                    width:"10%"
                },
                { 
                    text:"รายละเอียด", 
                    datafield: "DETAIL"
                },
	          	{ 
	          		text: 'สถานะการจอง',
	          		datafield: 'STATUS_BOOKING', 
	          		width:"10%", 
	          		filterable: false,
	                cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
	                    var status;
	                       if (value == 0) {
	                           status =  "<div style='padding: 5px; background:#00BB00 ; color:#ffffff;'>ยังไม่มีการจอง</div>";
	                       }else if(value == 1){
	                           status =  "<div style='padding: 5px; background:#EE0000 ; color:#ffffff;'>มีการจอง</div>";
	                       }                    
	                       return status;
	                }
	            }
            ]
        });
    }

    function gridbooking() {

        var dataAdapter = new $.jqx.dataAdapter({
        dataType: "json",
        dataFields: [
            { name: "RowNumber", type: "int"},
            { name: "BOOKINGID", type: "string"},
            { name: "BOOKINGDATE", type: "date", cellsformat: "dd-MM-yyyy"},
            { name: "BOOKEDDATE", type: "date", cellsformat: "dd-MM-yyyy"},
            { name: "BOOTHID", type: "string"},
            { name: "DETAIL", type: "string"},
            { name: "PRICE", type: "float"},
            { name: "STATUS_APPROVED", type: "int"},
            { name: "STATUS_OVER", type: "int"}
        ],
            url : '/api/v1/booking/list',
            sortcolumn: 'RowNumber',
            sortdirection: 'asc',
        });
        return $("#gridbooking").jqxGrid({
            width: '100%',
            source: dataAdapter,
            showstatusbar: true,
            statusbarheight: 25,
            autoheight: true,
            pageable: true,
            altrows: true,
            showaggregates: true,
            width: '100%',
            // filterable: true,
            // showfilterrow: true,
            theme : 'Office',
            columns: [
            { text:"อันดับ", datafield: "RowNumber", width:60},
            { text:"รหัสการจอง", datafield: "BOOKINGID", width:"13%"},
            { text:"วันที่จอง", datafield: "BOOKINGDATE", cellsformat: "dd-MM-yyyy", width:"13%"},
            { text:"วันที่สิ้นสุด", datafield: "BOOKEDDATE", cellsformat: "dd-MM-yyyy", width:"13%"},
            { text:"รหัสล๊อค", datafield: "BOOTHID"},
            { text:"รายละเอียด", datafield: "DETAIL"},
            { text:"ราคา", datafield: "PRICE", cellsformat: "d2", aggregates: ['sum'], width:"13%" },
            { 
                text: 'สถานะการอนุมัติ',
                datafield: 'STATUS_APPROVED', 
                width:"15%", 
                filterable: false,
                cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                    var status;
                        if (value ==1) {
                            status =  "<div style='padding: 5px; background:#00BB00 ; color:#ffffff;'>อนุมัติ</div>";
                        }else{
                            status =  "<div style='padding: 5px; background:#EE0000 ; color:#ffffff;'>ไม่อนุมัติ</div>";
                        }                    
                        return status;
                }
            },
            { 
                text: 'สถานะการจอง',
                datafield: 'STATUS_OVER', 
                width:"15%", 
                filterable: false,
                cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                    var status;
                        if (value ==0) {
                            status =  "<div style='padding: 5px; background:#00BB00 ; color:#ffffff;'>ยังอยู่ในช่วงของการจอง</div>";
                        }else{
                            status =  "<div style='padding: 5px; background:#EE0000 ; color:#ffffff;'>เลยเวลาที่ทำการจองไว้</div>";
                        }                    
                        return status;
                }
            }
        ]
        });
    }

    function getPrice(){
          	return $.ajax({
	        url : '/api/v1/booth/price',
	        type : 'get',
	        dataType : 'json',
            datafields: [
                        { name: 'ID' },
                        { name: 'NAME' }
            ],
	        cache : false
      	});
   	} 

</script>