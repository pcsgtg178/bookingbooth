<?php $this->layout("layouts/main") ?>
<?php
require '../vendor/autoload.php';
?> 

<style type="text/css">
	body {
    	font-family: "Garuda";
	} 
 	table {
	        border-collapse: collapse;
		    width: 1000px;
		    font-family: "Garuda";
		    text-align: left;
	    }
	    td, tr, th {
	        padding: 10px;
	        height: 40px;
	        font-family: "Garuda";
			
	    }
	    .table, .tr, .td {
	     border: 1px solid black;
	     padding: 0px;
 		}
</style>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>

	<?php
		foreach ($data as $value) 
		{
	?>
	<?php 
	}
	?>

	<table style="font-size: 16px">
		<tr>
			<td width="25%" rowspan="2" align="center"></td>
			<td width="50%" align="center">
				<h2>
					รายการจองพื้นที่ตลาดนัดกระทุ่มแบน
				</h2>
			</td>
			<td width="25%" align="Right"></td>
		</tr>
		<tr>
			<td align="center"><h3>BOOKING BOOTH SYSTEM</h3></td>
			<td align="Right">วันที่&nbsp;<?=date('d/m/Y')?></label></td>
		</tr>
	</table>
	<br>
	<table style="font-size: 18px;" border="1">
		<tr>
			<td width="60%" rowspan="2">
				ชื่อ-นามสกุล&nbsp;:&nbsp;<?php echo $value->NAME;?> <br><br>
				เบอร์โทรศัพท์&nbsp;:&nbsp;<?php echo $value->TEL;?>
			</td>
			<td>วันที่จอง&nbsp;:&nbsp;<?php echo $value->BOOKINGDATE;?></td>
		</tr>
		<tr>
			<td>รหัสสมาชิกผู้ใช้&nbsp;:&nbsp;<?php echo $value->MEMBERID;?></td>
		</tr>
	</table>
	<table width="1000" border="1" style="font-size: 18px">
		<tr align="CENTER">
			<td width="10%" align="CENTER">ลำดับ</td>	
			<td width="20%" align="CENTER">ล๊อค</td>
			<td width="40%" align="CENTER">รายละเอียด</td>
			<td width="30%" align="CENTER">จำนวนเงิน</td>
		</tr>
		<?php 
			$TotalPrice = 0;
			// echo '<pre>'. print_r($sorted, true) . '</pre>';
			foreach ($sorted as $value_line) {
			$TotalPrice = $TotalPrice + $value_line->PRICE; 
		?>
		<tr>
			<td align="CENTER"><?php echo $value_line->RowNumber; ?></td>
			<td align="CENTER">&nbsp;<?php echo $value_line->BOOTHID; ?></td>
			<td align="CENTER">&nbsp;<?php echo $value_line->DETAIL; ?></td>
			<td align="Right"><?php
			  if($value_line->PRICE != 0){ 
				echo number_format($value_line->PRICE, 2, '.', ','); 
				}else{ echo "&nbsp;"; 
			  } 
			?></td>
		</tr>
		<?php }
		  ?>
		<tr>
			<td width="700" COLSPAN=3 align="center">ราคาสุทธิ&nbsp;<?PHP 
			function convert($number){ 
				$txtnum1 = array('ศูนย์','หนึ่ง','สอง','สาม','สี่','ห้า','หก','เจ็ด','แปด','เก้า','สิบ'); 
				$txtnum2 = array('','สิบ','ร้อย','พัน','หมื่น','แสน','ล้าน','สิบ','ร้อย','พัน','หมื่น','แสน','ล้าน'); 
				$number = str_replace(",","",$number); 
				$number = str_replace(" ","",$number); 
				$number = str_replace("บาท","",$number); 
				$number = explode(".",$number); 
				if(sizeof($number)>2){ 
					return ''; 
					exit; 
				} 
				$strlen = strlen($number[0]); 
				$convert = ''; 
				for($i=0;$i<$strlen;$i++){ 
					$n = substr($number[0], $i,1); 
					if($n!=0){ 
						if($i==($strlen-1) AND $n==1){ $convert .= 'เอ็ด'; } 
						elseif($i==($strlen-2) AND $n==2){  $convert .= 'ยี่'; } 
						elseif($i==($strlen-2) AND $n==1){ $convert .= ''; } 
						else{ $convert .= $txtnum1[$n]; } 
						$convert .= $txtnum2[$strlen-$i-1]; 
					} 
				} 

				$convert .= 'บาท'; 
				if($number[1]=='0' OR $number[1]=='00' OR 
				$number[1]==''){ 
				$convert .= 'ถ้วน'; 
				}else{ 
				$strlen = strlen($number[1]); 
				for($i=0;$i<$strlen;$i++){ 
				$n = substr($number[1], $i,1); 
					if($n!=0){ 
					if($i==($strlen-1) AND $n==1){$convert 
					.= 'เอ็ด';} 
					elseif($i==($strlen-2) AND 
					$n==2){$convert .= 'ยี่';} 
					elseif($i==($strlen-2) AND 
					$n==1){$convert .= '';} 
					else{ $convert .= $txtnum1[$n];} 
					$convert .= $txtnum2[$strlen-$i-1]; 
					} 
			} 
				$convert .= 'สตางค์'; 
			} 
				return $convert; 
			} 
				echo convert(number_format($TotalPrice, 2, '.', ',') ); 
			?></td>
				<td align="Right"><?php echo number_format($TotalPrice, 2, '.', ','); ?></td>
		</tr>
	  
	</table>
</body>
</html>

<?php
$html = ob_get_clean();
$mpdf = new mPDF();
$mpdf->WriteHTML($html);
ob_clean();
$mpdf->Output();
ob_end_flush(); 