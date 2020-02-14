<?php $this->layout("layouts/main") ?>
<div id="gridtest"></div>

<script type="text/javascript">

    jQuery(document).ready(function($){
        gridtest();
    });
    function gridtest(){
        var dataAdapter = new $.jqx.dataAdapter({
            datatype: "json",
            datafields: [
                { 
                    name: "b_id",
                    type: "string" 
                },
                { 
                    name: "b_detail",
                    type: "string" 
                },
                { 
                    name: "b_price",
                    type: "string" 
                }
            ],
                url : '/api/v2/test/load'
        });

        return $("#gridtest").jqxGrid({
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
                    datafield: "b_id",
                    width:"10%"
                },
                { 
                    text:"รายละเอียด", 
                    datafield: "b_detail"
                },
                { 
                    text:"ราคา", 
                    datafield: "b_price"
                }
            ]
        });
    }    
</script>