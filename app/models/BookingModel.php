<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class BookingModel
{
    public function __construct()
	{
		$this->conn = new ConnectionController;
    }

	public function updatestatus($conn)
	{
		$sql = "UPDATE BOOKING SET STATUS_OVER = 1 WHERE CONVERT(DATE, GETDATE(), 5) > CONVERT(DATE, BOOKEDDATE, 5) AND STATUS_OVER = 0";

		if(Sqlsrv::query($conn,$sql))
		{
			return true;
		}
		return false;
	}

	public function all(){
		$conn = $this->conn->connect();
		if(self::updatestatus($conn))
		{
			$sql = "SELECT BKK.MEMBERID, BKK.NAME, SUM(BKK.TOTAL)[TOTAL] FROM(
				SELECT 
					BK.MEMBERID
					,MB.NAME
					,CASE WHEN BK.STATUS_APPROVED IS NULL OR BK.STATUS_APPROVED = 0
						OR	BK.STATUS_OVER IS NULL OR BK.STATUS_OVER = 1  THEN 0
					ELSE SUM(MP.PRICE) END [TOTAL]
					,BK.STATUS_APPROVED
					,BK.STATUS_OVER
				FROM BOOKING BK
				LEFT JOIN MEMBER MB
				ON BK.MEMBERID = MB.ID
				LEFT JOIN MASTER_PRICE MP
				ON MP.ID = BK.TOTAL
				WHERE BK.STATUS_OVER = 0
				GROUP BY  BK.MEMBERID
						,MB.NAME
						,BK.STATUS_APPROVED
						,BK.STATUS_OVER
		)BKK
		GROUP BY 
				BKK.MEMBERID,
				BKK.NAME";
			return Sqlsrv::array($this->conn->connect(),$sql);
		}
		else
		{
			//
		}	
	}

	public function allline($memberid){
		$sql = "SELECT BK.BOOKINGID
				,BK.BOOKINGDATE
				,BK.BOOKEDDATE
				,BK.SALEDATE
				,BK.BOOTHID
				,BK.MEMBERID
				,MB.NAME
				,MP.PRICE
				,BK.STATUS_APPROVED
				,BK.STATUS_OVER
				FROM BOOKING BK
				LEFT JOIN MEMBER MB
				ON BK.MEMBERID = MB.ID
				LEFT JOIN MASTER_PRICE MP
				ON MP.ID = BK.TOTAL
				WHERE BK.MEMBERID = '$memberid'
				ORDER BY BK.BOOKINGDATE DESC";
		return Sqlsrv::array($this->conn->connect(),$sql);
	}

	public function list($memberid){
		$sql = "SELECT ROW_NUMBER() OVER (Order by BK.BOOKINGDATE DESC) AS RowNumber,
				BK.BOOKINGID,
				BK.BOOKINGDATE,
				BK.BOOKEDDATE,
				BK.BOOTHID,
				BT.DETAIL,
				MP.PRICE,
				BK.STATUS_APPROVED,
				BK.STATUS_OVER
				FROM BOOKING BK
				LEFT JOIN BOOTH BT
				ON BK.BOOTHID = BT.ID
				LEFT JOIN MASTER_PRICE MP
				ON MP.ID = BK.TOTAL
				WHERE MEMBERID = '$memberid'
				AND STATUS_OVER = 0
				ORDER BY BK.BOOKINGDATE DESC";
		return Sqlsrv::array($this->conn->connect(),$sql); 
	}

	public function gennumberseq($conn)
	{

		$sql = "SELECT TOP(1)
				STUFF(S.NUMBER_SEQ,LEN(S.NUMBER_SEQ) +1 -LEN(CONVERT(NVARCHAR(10),S.NEXTREC))
				,LEN(CONVERT(NVARCHAR(10),S.NEXTREC))
				,CONVERT(NVARCHAR(10),S.NEXTREC))[GENNUMBER]
				FROM MASTER_NUMBERSEQ S
				WHERE S.NUMBER_SEQ = '0000'
				AND LEN(CONVERT(NVARCHAR(10),S.NEXTREC)) <= LEN(SUBSTRING(S.NUMBER_SEQ,CHARINDEX('-', S.NUMBER_SEQ)+1,LEN(S.NUMBER_SEQ)))";

		$results = array();

		$query = sqlsrv_query(
			$conn,
			$sql
		);

		while ($f = sqlsrv_fetch_object($query))
		{
			$results[] = $f;
		}
		return  $results[0]->GENNUMBER;
	}

	public function updatenumberseq($conn)
	{
		$sql = "UPDATE MASTER_NUMBERSEQ
				SET NEXTREC = NEXTREC+1
				WHERE NUMBER_SEQ = '0000'";

		if(Sqlsrv::query($conn,$sql))
		{
			return true;
		}
		return false;
	}

	public function bookingbooth($memberid
							,$boothid
							,$bookingdate
							,$bookeddate
							,$saledate
							,$priceid)
	{	
		$conn 	= $this->conn->connect();
		if (sqlsrv_begin_transaction ($conn) === false){
         	die( print_r( sqlsrv_errors(), true ));
		}
		try{
			$bookingid = self::gennumberseq($conn);
			$bookingid = $boothid.'-'.date('Y').sprintf("%02d", date('m')).'-'.$bookingid;
			if(isset($bookingid)){
				$insertbookingbooth = sqlsrv_query(
													$this->conn->connect(),
													"INSERT INTO BOOKING(
													BOOKINGID
													,BOOTHID
													,MEMBERID
													,BOOKINGDATE
													,BOOKEDDATE
													,SALEDATE
													,TOTAL
													,STATUS_BOOKING
													,STATUS_OVER) VALUES(?,?,?,?,?,?,?,1,0)",
													array(
														$bookingid
														,$boothid
														,$memberid
														,$bookingdate
														,$bookeddate
														,$saledate
														,$priceid
													)					
										);
					if($priceid == '2'){
						$d =strtotime("tomorrow");
						$nextdate = date("Y-m-d", $d);
						try{
							$bookingid = self::gennumberseq($conn);
							$bookingid = $boothid.'-'.date('Y').sprintf("%02d", date('m')).'-'.$bookingid;
							if(isset($bookingid)){
								$insertbookingbooth = sqlsrv_query(
																	$this->conn->connect(),
																	"INSERT INTO BOOKING(
																	BOOKINGID
																	,BOOTHID
																	,MEMBERID
																	,BOOKINGDATE
																	,BOOKEDDATE
																	,SALEDATE
																	,TOTAL
																	,STATUS_BOOKING
																	,STATUS_OVER) VALUES(?,?,?,?,?,?,?,1,0)",
																	array(
																		$bookingid
																		,$boothid
																		,$memberid
																		,$bookingdate
																		,$bookeddate
																		,$nextdate
																		,$priceid
																	)					
														);						
							}
							
							if($insertbookingbooth)
							{
								if(self::updatenumberseq($conn))
								{
									$checkerror = true;
								}
								else
								{
									$checkerror = false;
								}
							}
				
							if($checkerror)
							{
								sqlsrv_commit ($conn);
								return 	[
										"result" => true,
										"message" => "Create successful."
									];
							}
							else
							{
								sqlsrv_rollback ($conn);
								return 	[
									"result" => false,
									"message" => sqlsrv_errors()
								];
							}
				
						}
						catch (Exception $e) {
							Sqlsrv::rollback($this->conn->connect());
							return 	[
								"result" => false,
								"message" => $e->getMessage()
							];
				
						}
					}						
			}
			
			if($insertbookingbooth)
			{
				if(self::updatenumberseq($conn))
				{
					$checkerror = true;
				}
				else
				{
					$checkerror = false;
				}
			}

			if($checkerror)
			{
				sqlsrv_commit ($conn);
				return 	[
						"result" => true,
						"message" => "Create successful."
					];
			}
			else
			{
				sqlsrv_rollback ($conn);
				return 	[
					"result" => false,
					"message" => sqlsrv_errors()
				];
			}

		}
		catch (Exception $e) {
			Sqlsrv::rollback($this->conn->connect());
			return 	[
				"result" => false,
				"message" => $e->getMessage()
			];

		}
		
	}

	public function delete($id) 
	{	
		if (Sqlsrv::begin($this->conn->connect()) === false) {
			return 	[
				"result" => false,
				"message" => "Error start transaction."
			];
		}
		try
		{		
				$deletebook = sqlsrv_query(
											$this->conn->connect(),
											"DELETE FROM BOOKING 
											WHERE BOOKINGID=?",
											array(
												$id,
											)
								);
				if($deletebook)
				{
					return 	[
						"result" => true,
						"message" => "Delete successful."
					];
				}
				else
				{
					return 	[
						"result" => false,
						"message" => "Delete Failed."
					];
				}

		}catch (Exception $e) {
			Sqlsrv::rollback($this->conn->connect());
			return 	[
				"result" => false,
				"message" => $e->getMessage()
			];
		}	    
	}

	public function BOOKINGCheck($id)
	{
		$bookingcheck =  Sqlsrv::array(
			$this->conn->connect(),
			"SELECT * FROM BOOKING
			WHERE STATUS_APPROVED = 1 
			AND BOOKINGID = ?",
			[
				$id
			]
		);

		return $bookingcheck;
	}

	public function submit($id, $status)
	{
		if (Sqlsrv::begin($this->conn->connect()) === false) {
			return 	[
				"result" => false,
				"message" => "Error start transaction."
			];
		}
		try
		{
				$status = !$status;
				$submitbooking = sqlsrv_query(
											$this->conn->connect(),
											"UPDATE BOOKING SET STATUS_APPROVED=?
											WHERE BOOKINGID=?",
											array(
												$status,
												$id
											)
								);

				if($submitbooking)
				{
					return 	[
						"result" => true,
						"message" => "Update successful."
					];
				}
				else
				{
					return 	[
						"result" => false,
						"message" => "Update Failed."
					];
				}

		}catch (Exception $e) {
			Sqlsrv::rollback($this->conn->connect());
			return 	[
				"result" => false,
				"message" => $e->getMessage()
			];
		} 
	}
}