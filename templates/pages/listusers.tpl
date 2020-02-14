<?php $this->layout("layouts/main") ?>
    <!-- style -->
    <div class="container">
        <h3>ผู้เข้าใช้งานระบบ</h3>
        <div id="griduser"></div>
    </div>
<script type="text/javascript">
    //var checkre = '<?php echo urlencode($_GET["check"]); ?>';
    // document ready
    jQuery(document).ready(function($){
        griduser();

        /*if(checkre == 0)
        {
           alert('Username ซ้ำ กรุณาทำรายการใหม่');
        }*/
    });

    function griduser(){
        var dataAdapter = new $.jqx.dataAdapter({
            datatype: "json",
            datafields: [
                { 
                    name: "ID",
                    type: "string" 
                },
                { 
                    name: "USERNAME", 
                    type: "string" 
                },
                { 
                    name: "PASSWORD", 
                    type: "string" 
                },
                { 
                    name: "STATUS", 
                    type: "string" 
                },
                { 
                    name: "NAME", 
                    type: "string" 
                },
                { 
                    name: "TEL", 
                    type: "string" 
                }
            ],
                url : '/api/v1/user/load'
        });

        return $("#griduser").jqxGrid({
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
                    text:"รหัสผู้เข้าใช้งาน", 
                    datafield: "ID",
                    width:"5%"
                },
                { 
                    text:"Username", 
                    datafield: "USERNAME"
                },
                { 
                    text:"Password", 
                    datafield: "PASSWORD"
                },
                { 
                    text:"สถานะ", 
                    datafield: "STATUS", 
                    width:"20%"
                },
                { 
                    text:"ชื่อ-นามสกุล", 
                    datafield: "NAME", 
                    width:"20%"
                },
                { 
                    text:"เบอรโทรศัพท์", 
                    datafield: "TEL", 
                    width:"10%"
                }
            ]
        });
    }
</script>