<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class BoothModel
{
	public function __construct()
	{
		$this->conn = new ConnectionController;
	}
    
    public function all()
	{	
		return Sqlsrv::array(
				$this->conn->connect(),
				"SELECT 
				BT.ID,
				BT.DETAIL,
				BK.STATUS_BOOKING,
				BK.STATUS_OVER
				FROM BOOTH BT
				LEFT JOIN (
					SELECT * FROM BOOKING BK
					WHERE CONVERT(DATE, GETDATE(), 5) < CONVERT(DATE, BK.BOOKEDDATE, 5) 
				) BK
				ON BK.BOOTHID = BT.ID
				WHERE BK.STATUS_BOOKING IS NULL" 
		);
	}

	public function price()
	{	
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT 
					ID,
					NAME,
					PRICE
			FROM MASTER_PRICE" 
		);
	}

	public function dis_all()
	{	
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT 
					COUNT(ID)[number]
			FROM BOOTH" 
		);
	}

	public function dis_balance()
	{	
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT COUNT(BL.ID)[number] FROM(
				SELECT 
						BT.ID,
						BT.DETAIL,
						BK.STATUS_BOOKING,
						BK.STATUS_OVER
						FROM BOOTH BT
						LEFT JOIN (
							SELECT * FROM BOOKING BK
							WHERE CONVERT(DATE, GETDATE(), 5) < CONVERT(DATE, BK.BOOKEDDATE, 5) 
						) BK
						ON BK.BOOTHID = BT.ID
						WHERE BK.STATUS_BOOKING IS NULL
			)BL" 
		);
	}

	public function dis_booking()
	{	
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT COUNT(BK.BOOTHID)[number] FROM(
				SELECT BOOTHID FROM BOOKING
				WHERE STATUS_OVER = 0
				GROUP BY BOOTHID
			)BK" 
		);
	}

}