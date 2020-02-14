<?php 

namespace App\Controllers;

use App\Models\BoothModel;

class BoothController
{

    public function __construct()
	{
		$this->booth = new BoothModel;
	}

	public function all($request, $response, $args)
	{
		return $response->withJson($this->booth->all());
	}
	public function price($request, $response, $args)
	{
		return $response->withJson($this->booth->price());
	} 

	public function dis_all($request, $response, $args)
	{
		return $response->withJson($this->booth->dis_all());
	}

	public function dis_balance($request, $response, $args)
	{
		return $response->withJson($this->booth->dis_balance());
	} 

	public function dis_booking($request, $response, $args)
	{
		return $response->withJson($this->booth->dis_booking());
	}  


}