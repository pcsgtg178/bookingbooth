<?php 

namespace App\Controllers;

use App\Models\UsersModel;
use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

require_once './resources/Mobile-Detect-2.8.33/Mobile_Detect.php';

class UsersController
{	
	public function __construct()
	{
		$this->user = new UsersModel;
		$this->conn = new ConnectionController;
	}

	public function all($request, $response, $args)
	{
		return $response->withJson($this->user->all());
	}

	public function username($request, $response, $args)
	{
		$parsedBody = $request->getQueryParams();
		return $response->withJson($this->user->username($parsedBody["userid"]));
	}

	public function name($request, $response, $args)
	{
		$parsedBody = $request->getQueryParams();
		return $response->withJson($this->user->name($parsedBody["userid"]));
	}

	public function tel($request, $response, $args)
	{
		$parsedBody = $request->getQueryParams();
		return $response->withJson($this->user->tel($parsedBody["userid"]));
	}

	public function create($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		if ($parsedBody["form_type"]=="create") {
			if($response->withJson($this->user->createuser($parsedBody["mb_user"],
															$parsedBody["mb_pass"],
															$parsedBody["mb_name"],
															$parsedBody["mb_tel"])
										) === false)
			{
				echo json_encode(["status" => 404, "message" => "Create Failed"]);
				header("Location: /signup");
				exit;
			}
			else{
				echo json_encode(["status" => 200, "message" => "Create Success"]);
				header("Location: /user/auth");
				exit;
			}
		}
		else{

			if($response->withJson($this->user->updateuser($parsedBody["mb_user"]
			 											   // ,$parsedBody["inp_password"]
			 											   ,$parsedBody["mb_pass"]
			 											   ,$parsedBody["mb_name"]
															,$parsedBody["mb_tel"]
															,$parsedBody["userid"])) === false)
			{
				header("Location: /profile");
				exit;
			}
		}
	}
    
	public function auth($request, $response, $args)
	{
		$conn = $this->conn->connect();
		$sql = "UPDATE BOOKING SET STATUS_OVER = 1 WHERE CONVERT(DATE, GETDATE(), 5) > CONVERT(DATE, BOOKEDDATE, 5) AND STATUS_OVER = 0";
		sqlsrv_query($conn,$sql);

		$parsedBody = $request->getParsedBody();
		try {
			//console.log("auth work!");
			$isRealUser = $this->user->isRealUser($parsedBody["inp_username"]
												 ,$parsedBody["inp_password"]);
		} catch (Exception $e) {
			return $response->withJson([
				"result" => false,
				//"message" => $e->getMessage()
			]);
		}

		if ($isRealUser === false) {
			return $response->withJson([
				"result" => false,
				//"message" => "กรุณาเช็คชื่อผู้ใช้ และรหัสผ่าน"
			]);
		}else{
			//$updatelogin = $this->user->updatelogin($parsedBody["inp_username"]);
		}

		try {
			$getUserInfo = $this->user->userInfo($parsedBody["inp_username"]
												,$parsedBody["inp_password"]);
		} catch (Exception $e) {
			return $response->withJson([
				"result" => false,
				"message" => $e->getMessage()
			]);
		}

		$_SESSION["logged"] 	= true;
		$_SESSION["userid"] 	= $getUserInfo[0]->ID;
		$_SESSION["username"]	= $getUserInfo[0]->USERNAME;
		$_SESSION["password"]	= $getUserInfo[0]->PASSWORD;
		$_SESSION["status"] 	= $getUserInfo[0]->STATUS;
		$_SESSION["name"] 	= $getUserInfo[0]->NAME;
		$_SESSION["tel"] 	= $getUserInfo[0]->TEL;

		return $response->withJson([
			"result" => true,
			"message" => $_SESSION["status"]
		]);


	}

	public function update_user($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		if ($parsedBody){
			if($response->withJson($this->user->update_user($parsedBody["id"],$parsedBody["username"],$parsedBody["name"],$parsedBody["tel"])) === false) {
				echo json_encode(["status" => 404, "message" => "Submit Failed"]);
				exit;
			}
			echo json_encode(["status" => 200, "message" => "ยืนยันการบันทึกเสร็จสิ้น"]);
			
		}
	}

	public function change_pass($request, $response, $args)
	{
		
		$parsedBody = $request->getParsedBody();
		if ($parsedBody){
			if($response->withJson($this->user->change_pass($parsedBody["id"],$parsedBody["sub_new_pass"])) === false) {
					echo json_encode(["status" => 404, "message" => "Submit Failed"]);
					exit;
			}
			echo json_encode(["status" => 200, "message" => "ยืนยันการเปลี่ยนแปลงเสร็จสิ้น"]);
		}
	}

	public function delete_user($request, $response, $args)
	{

		$parsedBody = $request->getParsedBody();
		
		if ($parsedBody) {

			if($response->withJson($this->user->delete_user($parsedBody["id"])) === false) {
					echo json_encode(["status" => 404, "message" => "ไม่สามารถลบได้"]);
					exit;
			}
			echo json_encode(["status" => 200, "message" => "ลบแล้วเรียบร้อย"]);
		}

	}

	public function logout($request, $response, $args)
	{
		session_destroy();
		return $response->withRedirect("/home");
	}
}