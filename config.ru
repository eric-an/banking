require './config/environment'

use Rack::MethodOverride
use UsersController
use AccountsController
run ApplicationController