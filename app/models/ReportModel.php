<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class ReportModel
{
	public function __construct()
	{
		$this->conn = new ConnectionController;
	}

	public function report_approved($inp_app_report)
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT	
					BK.BOOKINGID,
					BK.BOOKINGDATE,
					BK.BOOKEDDATE,
					BK.TOTAL,
					BK.MEMBERID,
					MB.USERNAME,
					MB.NAME,
					MB.TEL
			 FROM BOOKING BK
			 LEFT JOIN MEMBER MB
			 ON BK.MEMBERID = MB.ID
			 WHERE BK.MEMBERID = '$inp_app_report'"

		);
	}

	public function report_approvedline($inp_app_report)
	{
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT	ROW_NUMBER() OVER (Order by BK.BOOKINGID) AS RowNumber,
			BK.BOOKINGID,
			BK.BOOKINGDATE,
			BK.BOOKEDDATE,
			BK.BOOTHID,
			BT.DETAIL,
			MP.PRICE
			FROM BOOKING BK
			LEFT JOIN BOOTH BT 
			ON BK.BOOTHID = BT.ID

			LEFT JOIN BOOKINGDETAIL BKT
			ON BKT.BOOKINGID = BK.BOOKINGID

			LEFT JOIN MASTER_PRICE MP 
			ON MP.ID = BKT.PRICE

			WHERE BK.MEMBERID ='$inp_app_report'
			AND BK.STATUS_APPROVED = 1
			AND BK.STATUS_BOOKING = 1"
		);
	}
}