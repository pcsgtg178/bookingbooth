<?php 

namespace App\Controllers;

use App\Models\TestModel;

class UsersController
{
    public function __construct()
	{
		$this->test = new TestModel;
	}

	public function test($request, $response, $args)
	{
		return $response->withJson($this->test->test());
	}
}