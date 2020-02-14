<?php

namespace App\Models;

use Wattanar\Sqlsrv;
use App\Controllers\ConnectionController;

class UsersModel
{

	protected $mailer;
	public function __construct()
	{
		$this->conn = new ConnectionController;
	}

	public function all()
	{	
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT U.ID
			  	,U.USERNAME
			  	,S.STATUS
			  	,U.NAME
			  	,U.TEL
			  	,CASE WHEN U.PASSWORD != '' THEN '*****' END [PASSWORD]
			FROM MEMBER U
			LEFT JOIN MEMBER_STATUS S
			ON U.STATUS = S.ID"
		);
	}

	public function username($id)
	{	
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT USERNAME
			FROM MEMBER 
			WHERE ID=?",
			array($id)
		);
	}

	public function name($id)
	{	
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT NAME
			FROM MEMBER 
			WHERE ID=?",
			array($id)
		);
	}

	public function tel($id)
	{	
		return Sqlsrv::array(
			$this->conn->connect(),
			"SELECT TEL
			FROM MEMBER 
			WHERE ID=?",
			array($id)
		);
	}

	public function gennumberseq($conn)
	{
		
		$sql = "SELECT TOP(1)
				STUFF(S.NUMBER_SEQ,LEN(S.NUMBER_SEQ) +1 -LEN(CONVERT(NVARCHAR(10),S.NEXTREC))
				,LEN(CONVERT(NVARCHAR(10),S.NEXTREC))
				,CONVERT(NVARCHAR(10),S.NEXTREC))[GENNUMBER]
				FROM MASTER_NUMBERSEQ S
				WHERE S.NUMBER_SEQ like 'MB-%'
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
				WHERE NUMBER_SEQ like 'MB-%'";

		if(Sqlsrv::query($conn,$sql))
		{
			return true;
		}
			return false; 
	}

	public function update_user($id,
								$username,
								$name,
								$tel)
	{
		$conn 	= $this->conn->connect();
		if (sqlsrv_begin_transaction ($conn) === false){
         	die( print_r( sqlsrv_errors(), true ));
		}
		try
		{
				$submitupdate = sqlsrv_query(
											$this->conn->connect(),
											"UPDATE MEMBER SET USERNAME=?, NAME=?, TEL=?
											WHERE ID=?",
											array(
												$username,
												$name,
												$tel,
												$id
											)
								);

				if($submitupdate)
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

	public function change_pass($id, $sub_new_pass){
		if (Sqlsrv::begin($this->conn->connect()) === false) {
			return 	[
				"result" => false,
				"message" => "Error start transaction."
			];
		}
		try
		{
				$submitupdate = sqlsrv_query(
											$this->conn->connect(),
											"UPDATE MEMBER SET PASSWORD=?
											WHERE ID=?",
											array(
												$sub_new_pass,
												$id
											)
								);

				if($submitupdate)
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

	public function createuser($mb_user,
							$mb_pass,
							$mb_name,
							$mb_tel)
	{
		
		$conn 	= $this->conn->connect();
		if (sqlsrv_begin_transaction($conn) === false){
				die( print_r( sqlsrv_errors(), true ));
		}

		try{
			
			$mb_id = self::gennumberseq($conn);
			$sql = "INSERT INTO MEMBER(
										ID,
										USERNAME,
										PASSWORD,
										STATUS,
										NAME,
										TEL) 
					VALUES(?,?,?,0,?,?)";

			if(isset($mb_id)){
				$insertuser = sqlsrv_query($conn, $sql,array($mb_id
															,$mb_user
															,$mb_pass
															,$mb_name
															,$mb_tel
														)
							);
			}
			//var_dump(isset($mb_id),$insertuser,$mb_id,$mb_user,$mb_pass,$mb_name,$mb_tel);
			if($insertuser){
				if(self::updatenumberseq($conn)){
					$checkerror = true;
				}
				else
				{
					$checkerror = false;
				}
			}

			if($checkerror)
			{
				sqlsrv_commit($conn);
				return 	[
						"result" => true,
						"message" => "Create successful."
					];
			}
			else
			{
				sqlsrv_rollback($conn);
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

    public function isRealUser($username,$password)
	{	
		return Sqlsrv::hasRows(
			$this->conn->connect(),
			"SELECT * 
			FROM MEMBER
			WHERE USERNAME = ?
			AND PASSWORD = ?",
			[
				$username, 
				$password
			]
		);
	}

	public function userInfo($username,$password)
	{
		$user =  Sqlsrv::array(
			$this->conn->connect(),
			"SELECT * 
			FROM MEMBER
			WHERE USERNAME = ?
			AND PASSWORD = ?",
			[
				$username, 
				$password
			]
		);
		return $user;
	}

	public function delete_user($id) 
	{	
		if (Sqlsrv::begin($this->conn->connect()) === false) {
			return 	[
				"result" => false,
				"message" => "Error start transaction."
			];
		}
		try
		{		
				$deleteuser = sqlsrv_query(
											$this->conn->connect(),
											"DELETE FROM MEMBER 
											WHERE ID=?",
											array(
												$id,
											)
								);
				if($deleteuser)
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
}