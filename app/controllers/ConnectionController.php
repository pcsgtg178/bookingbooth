<?php 

namespace App\Controllers;

use Wattanar\Sqlsrv;

class ConnectionController
{
	public static function connect()
	{
		//$server = "192.168.90.30\develop";
		//$user = "sa";
		//$password = "c,]'4^j";
		//$database = "CarRepair";

		 $server = "DSL-PC-ICT-013";
		 $user = "";
		 $password = "";
		 $database = "BookingBooth";

		return Sqlsrv::connect(
			$server, 
			$user,
			$password,
			$database
		);
	}
}