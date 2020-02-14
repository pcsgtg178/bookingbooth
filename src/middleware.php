<?php

//use Slim\App;
$user_auth = function ($request, $response, $next) {
if (isset($_SESSION["logged"]) && $_SESSION["logged"] === true && $_SESSION["status"]===0) {
    $response = $next($request, $response);
} else {
    return $response->withRedirect("/user/auth");
}
return $response;
};

$admin_auth = function ($request, $response, $next) {
    if (isset($_SESSION["logged"]) && $_SESSION["logged"] === true && $_SESSION["status"]===1) {
        $response = $next($request, $response);
    } else {
        return $response->withRedirect("/user/auth");
    }
    return $response;
    };
//return function (App $app) {
    // e.g: $app->add(new \Slim\Csrf\Guard);
//};
