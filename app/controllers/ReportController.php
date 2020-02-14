<?php 

namespace App\Controllers;

use App\Models\ReportModel;
use Wattanar\Sqlsrv;
use psr\Container\ContainerInterface;

class ReportController
{
	protected $container;
	public function __construct(ContainerInterface $container)
	{
		$this->report = new ReportModel;
		$this->container = $container;
		$this->template = $this->container->get('plate');
	}

	public function report_approved($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		$data = $this->report->report_approved($parsedBody["inp_app_report"]);
		$data_line = $this->report->report_approvedline($parsedBody["inp_app_report"]);

		$fake_data   = [
			[0] //1
		]; 
		$Num = 1;
		foreach ($data_line as $value_num) {
			$Num++;
		}
		$number_rows = 10-$Num;
		for ($i=0; $i < $number_rows; $i++) { 
			foreach ($fake_data[$i] as $value) {
				$sorted = [];
				$data_line[] = (object) [
				'RowNumber' => '',
				'BOOTHID' => '',
				'DETAIL' =>'',
				'PRICE' => '',
				];

				$sorted = $data_line;
			}
		}
		// echo "<pre>". print_r($data, true) . "</pre>";
		// echo "<pre>". print_r($sorted, true) . "</pre>";
		return $this->template->render("report/report_booking",[
			"data" => $data,
			"sorted" => $sorted
		]);

		exit();
		
	}
}