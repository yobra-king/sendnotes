<?php

namespace App\Providers;

use Illuminate\Routing\UrlGenerator;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\URL;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
   }

    /**
     * Bootstrap any application services.
     */
    public function boot(UrlGenerator $url)
    {

        if (env('APP_ENV') !== 'local') {
               URL::forceScheme('https');
           }

} }
