<?php $this->layout("layouts/main") ?>
<style>
    .ui-front {
        z-index: 318;
    }
</style>
<div class="container">
    <br>
    <table>
        <td>
            <form onsubmit="return printsub()" method="post" action="/api/v1/report/approved" target="_blank"  style="margin-bottom: 10px;">
                <input type="hidden" name="inp_app_report" value="" />
                <button class="btn btn-success btn-sm" type="submit" id="btn_report_app">ใบเสร็จอนุมัติเบิกบัญชี</button>
            </form>
        </td>
    </table>
    <div id="gridlistbooking"></div><br>
    <table>
        <td>
            <button class="btn btn-primary btn-sm" id="btn_submit" name="btn_submit" style="margin-bottom: 10px;">อนุมัติ/ยกเลิกการจอง</button>
       </td>
    </table>
    <div id="gridlistline_booking"></div><br>
    <div id="dialog" title="Submitbooking"><label for="Submitbooking">Are you sure to submit?</label></div>
</div>

<script  type="text/javascript">
    $('#dialog').hide();
    jQuery(document).ready(function($){
        
        gridlistbooking();
        $('#btn_report_app').hide();
        $('#btn_submit').hide();

    });

    $('#gridlistline_booking').on('rowclick', function (event){
        var args = event.args;
        var boundIndex = args.rowindex;
        var datarow = $("#gridlistline_booking").jqxGrid('getrowdata', boundIndex);

        if(datarow.STATUS_OVER == 1){
            document.getElementById("btn_submit").disabled = true;
        }
        else{
            document.getElementById("btn_submit").disabled = false;
        }
    });

    $('#btn_submit').on('click', function(e) {
      var rowdata = row_selected("#gridlistline_booking");
    	if (typeof rowdata !== 'undefined') {
    		$("#dialog").dialog({
      		buttons : {
        		"OK" : function() {

        		gojax('post', '/api/v1/booking/submit', {id:rowdata.BOOKINGID, status:rowdata.STATUS_APPROVED})

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
                $('#gridlistbooking').jqxGrid('updatebounddata');
                $('#gridlistline_booking').jqxGrid('updatebounddata');   
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

    $('#gridlistbooking').on('rowclick', function (event){
        var args = event.args;
        var boundIndex = args.rowindex;
        var datarow = $("#gridlistbooking").jqxGrid('getrowdata', boundIndex);

        $('#btn_report_app').show();
        $('#btn_submit').show();

        if(datarow.TOTAL == 0){
            document.getElementById("btn_report_app").disabled = true;
        }
        else{
            document.getElementById("btn_report_app").disabled = false;
        }
        
        gridlistline_booking(datarow.MEMBERID);
    });

    function printsub(){
      var rowdata = row_selected('#gridlistbooking');
      if(!!rowdata){
          $('input[name=inp_app_report]').val(rowdata.MEMBERID);
          return true;
      }else{
          alert('กรุณาเลือกข้อมูล');
          return false;
      }
  }

    function gridlistbooking(){
        var dataAdapter = new $.jqx.dataAdapter({
            datatype: "json",
            datafields: [
                {
                    name: "MEMBERID",
                    type: "string"
                },
                { 
                    name: "NAME",
                    type: "string" 
                },
                { 
                    name: "TOTAL",
                    type: "float" 
                }
            ],
                url : '/api/v1/booking/load'
        });

        return $("#gridlistbooking").jqxGrid({
            width: '100%',
            source: dataAdapter,
            autoheight: true,
            columnsresize: true,
            pageable: true,
            filterable: true,
            showfilterrow: true,
            theme : 'Office',
            columns: [
                { 
                    text:"รหัสสมาชิกผู้จอง", 
                    datafield: "MEMBERID"
                },
                { 
                    text:"ชื่อผู้จอง", 
                    datafield: "NAME"
                },
                { 
                    text:"ยอดจ่าย", 
                    datafield: "TOTAL"
                }
            ]
        });
    }

    function gridlistline_booking(MEMBERID){
        var dataAdapter = new $.jqx.dataAdapter({
            datatype: "json",
            datafields: [
                { 
                    name: "BOOKINGID",
                    type: "string" 
                },
                { 
                    name: "BOOKINGDATE",
                    type: "date"
                },
                { 
                    name: "BOOKEDDATE",
                    type: "date"
                },
                { 
                    name: "BOOTHID",
                    type: "string" 
                },
                {
                    name: "MEMBERID",
                    type: "string"
                },
                { 
                    name: "NAME",
                    type: "string" 
                },
                { 
                    name: "PRICE",
                    type: "float" 
                },
                { 
                    name: "STATUS_APPROVED",
                    type: "int" 
                }
                ,
                { 
                    name: "STATUS_OVER",
                    type: "int" 
                }
            ],
                url : '/api/v1/booking/loadline?memberid='+MEMBERID
        });

        return $("#gridlistline_booking").jqxGrid({
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
                    text:"รหัสจอง", 
                    datafield: "BOOKINGID",
                    width:"20%"
                },
                { 
                    text:"วันที่จอง", 
                    datafield: "BOOKINGDATE",
                    cellsformat: 'dd/MM/yyyy'
                },
                { 
                    text:"วันที่สิ้นสุด", 
                    datafield: "BOOKEDDATE",
                    cellsformat: 'dd/MM/yyyy'
                },
                { 
                    text:"รหัสล๊อค", 
                    datafield: "BOOTHID",
                    width:"10%"
                },
                { 
                    text:"ราคาล๊อค", 
                    datafield: "PRICE",
                    cellsformat: 'd2',
                    aggregates:['sum'],
                    width:"13%"
                },
                { 
                    text:"สถานะการอนุมัติ", 
                    datafield: "STATUS_APPROVED", 
                    width:"10%", 
                    filterable: false,
                    cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                        var status;
                        if (value == 0) {
                            status =  "<div style='padding: 5px; background:#FF0000 ; color:#ffffff;'>ยังไม่ได้อนุมัติ</div>";
                        }else if(value == 1){
                            status =  "<div style='padding: 5px; background:#00BB00 ; color:#ffffff;'>อนุมัติแล้ว</div>";
                        }
                        /*}else if(value == 1){
                            status =  "<div style='padding: 5px; background:#EE0000 ; color:#ffffff;'>อนุมัติแล้วล๊อคนี้ไปแล้ว</div>";
                        }   */                 
                        return status;
                    }
                },
                { 
                    text:"สถานะการจอง", 
                    datafield: "STATUS_OVER", 
                    width:"15%", 
                    filterable: false,
                    cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                        var status;
                        if (value == 1) {
                            status =  "<div style='padding: 5px; background:#FF0000 ; color:#ffffff;'>เลยวันที่จองแล้ว</div>";
                        }else if(value == 0){
                            status =  "<div style='padding: 5px; background:#00BB00 ; color:#ffffff;'>ยังอยู่ในสถานะการจอง</div>";
                        }
                        /*}else if(value == 1){
                            status =  "<div style='padding: 5px; background:#EE0000 ; color:#ffffff;'>อนุมัติแล้วล๊อคนี้ไปแล้ว</div>";
                        }   */                 
                        return status;
                    }
                }
            ]
        });
    }

</script>