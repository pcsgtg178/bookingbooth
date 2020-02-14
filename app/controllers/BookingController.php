<?php 

namespace App\Controllers;

use App\Models\BookingModel;
use App\Controllers\ConnectionController;

class BookingController
{
    public function __construct()
	{
		$this->booking = new BookingModel;
		$this->conn = new ConnectionController;
	}
	
	public function all($request, $response, $args)
	{
		return $response->withJson($this->booking->all()); 
	}

	public function allline($request, $response, $args)
	{
		$parsedBody = $request->getQueryParams();
		return $response->withJson($this->booking->allline($parsedBody["memberid"]));
	}

	public function list($request, $response, $args)
	{
		$memberid = $_SESSION["userid"];
		return $response->withJson($this->booking->list($memberid));
	}

    public function create($request, $response, $args)
	{
		$conn = $this->conn->connect();
		$parsedBody = $request->getParsedBody();
		$boothid = $parsedBody["boothid"];
		$bookingdate = $parsedBody["bookingdate"];
		$bookeddate = $parsedBody["bookeddate"];
		$booking_check = "SELECT * FROM BOOKING WHERE BOOTHID='$boothid' AND BOOKINGDATE='$bookingdate' AND BOOKEDDATE BETWEEN '$bookingdate' AND '$bookeddate'";
		$result = sqlsrv_query($conn, $booking_check);
		$booking = sqlsrv_fetch_array( $result, SQLSRV_FETCH_ASSOC);

		if($booking){
			if(($booking['BOOTHID'] ===  $boothid)&&($booking['BOOKINGDATE'] === $bookingdate)&&($booking['STATUS_OVER'] === 0)){

				echo json_encode(["status" => 204, "message" => "รายการล๊อคนี้มีผู้จองแล้ว"]);
				exit();
			}
		}

		if($response->withJson($this->booking->bookingbooth($parsedBody["memberid"]
													,$parsedBody["boothid"]
													,$parsedBody["bookingdate"]
													,$parsedBody["bookeddate"]
													,$parsedBody["saledate"]
													,$parsedBody["priceid"])) === false)
		{	
			echo json_encode(["status" => 404, "message" => "การจองมีความผิดพลาด กรุณาติดต่อผู้พัฒนา"]);
			header("Location: /booking");
			exit();
		}
		else
		{
			echo json_encode(["status" => 201, "message" => "การจองเสร็จสิ้น"]);
			exit();
		}
	}

	public function delete($request, $response, $args)
	{

		$parsedBody = $request->getParsedBody();
		
		if ($parsedBody) {

			if($getbookingcheck = $this->booking->BOOKINGCheck($parsedBody["id"]))
			{
				echo json_encode(["status" => 404, "message" => "รายการจองนี้ถูกอนุมัติแล้ว"]);
				exit;
			}
		
			if($response->withJson($this->booking->delete($parsedBody["id"])) === false) {
					echo json_encode(["status" => 404, "message" => "ไม่สามารถลบได้"]);
					exit;
			}
			echo json_encode(["status" => 200, "message" => "ลบแล้วเรียบร้อย"]);

		}

	}

	public function submit($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		if ($parsedBody){
			if($response->withJson($this->booking->submit($parsedBody["id"],$parsedBody["status"])) === false) {
					echo json_encode(["status" => 404, "message" => "Submit Failed"]);
					exit;
			}
			echo json_encode(["status" => 200, "message" => "ยืนยันการทำการเสร็จสิ้น"]);
		}
	}
}