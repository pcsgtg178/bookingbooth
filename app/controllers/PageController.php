<?php

namespace App\Controllers;

use psr\Container\ContainerInterface;

class PageController
{
    protected $container;
    
    public function __construct(ContainerInterface $container)
    {
        $this->container = $container;
        $this->template = $this->container->get('plate');
    }

	public function index($request, $response, $args)
	{
		if($_SESSION['status']==0){
			return $response->withRedirect("/home");
		}
		else{
			return $response->withRedirect("/manager");
		}
		
	}

	public function profile($request, $response, $args)
	{
		return $this->template->render("pages/profile");
	}

	public function test($request, $response, $args)
	{
		return $this->template->render("pages/test");
	}

	public function auth($request, $response, $args)
	{
		return $this->template->render("pages/login");
	}

	public function signup($request, $response, $args)
	{
		return $this->template->render("pages/register");
	}
	
	public function home_user()
	{
		return $this->template->render("pages/home");
	}

	public function home_admin()
	{
		return $this->template->render("pages/home_admin");
	}

	public function about()
	{
		return $this->template->render("pages/about");
	}

	public function contact()
	{
		return $this->template->render("pages/contact");
	}

	public function list_users()
	{
		return $this->template->render("pages/listusers");
	}

	public function booking()
	{
		return $this->template->render("pages/booking");
	}

	public function list_booking()
	{
		return $this->template->render("pages/listbooking");
	}

	//Report
	public function Alert_report()
	{
		return $this->template->render("report/report_booking");
	}

}