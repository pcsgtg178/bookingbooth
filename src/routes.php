<?php

$app->get("/", "App\Controllers\PageController:index");
$app->get("/user/auth", "App\Controllers\PageController:auth");
$app->get("/user/logout", "App\Controllers\UsersController:logout");
$app->get("/home", "App\Controllers\PageController:home_user");
$app->get("/manager", "App\Controllers\PageController:home_admin")->add($admin_auth);
$app->get("/signup", "App\Controllers\PageController:signup");
$app->get("/about", "App\Controllers\PageController:about");
$app->get("/contact", "App\Controllers\PageController:contact");
$app->get("/booking", "App\Controllers\PageController:booking")->add($user_auth);
$app->get("/user/profile", "App\Controllers\PageController:profile")->add($user_auth);
$app->get("/admin/profile", "App\Controllers\PageController:profile")->add($admin_auth);
$app->get("/list/users", "App\Controllers\PageController:list_users")->add($admin_auth);
$app->get("/list/booking", "App\Controllers\PageController:list_booking")->add($admin_auth);

//display
$app->get("/booth/dis_all", "App\Controllers\BoothController:dis_all");
$app->get("/booth/dis_balance", "App\Controllers\BoothController:dis_balance");
$app->get("/booth/dis_booking", "App\Controllers\BoothController:dis_booking");

$app->group("/api/v1", function() use ($app, $user_auth, $admin_auth) {
    
    $app->get("/test/load", "App\Controllers\BoothController:test");
    //user
    $app->post("/user/auths", "App\Controllers\UsersController:auth");
    $app->post("/user/create", "App\Controllers\UsersController:create");
    $app->post("/user/update", "App\Controllers\UsersController:update_user");
    $app->get("/user/delete_user", "App\Controllers\UsersController:delete_user");
    $app->post("/user/change_pass", "App\Controllers\UsersController:change_pass");
    $app->get("/user/load", "App\Controllers\UsersController:all");
    $app->get("/user/username", "App\Controllers\UsersController:username");
    $app->get("/user/name", "App\Controllers\UsersController:name");
    $app->get("/user/tel", "App\Controllers\UsersController:tel");

    //booth
    $app->get("/booth/load", "App\Controllers\BoothController:all");
    $app->get("/booth/price", "App\Controllers\BoothController:price");
    
    //booking 
    $app->get("/booking/load", "App\Controllers\BookingController:all");
    $app->get("/booking/loadline", "App\Controllers\BookingController:allline");
    $app->get("/booking/list", "App\Controllers\BookingController:list");
    $app->post("/booking/create", "App\Controllers\BookingController:create");
    $app->post("/booking/delete", "App\Controllers\BookingController:delete");
    $app->post("/booking/submit", "App\Controllers\BookingController:submit");

    //report 
    $app->post("/report/approved", "App\Controllers\ReportController:report_approved");

});

$app->get("/test", "App\Controllers\PageController:test");
$app->get("/api/v2/test/load", "App\Controllers\TestController:test");