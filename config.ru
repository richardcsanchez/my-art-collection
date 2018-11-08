require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use CollectorsController
use ArtworkController
use ArtistController
use MediumController
run ApplicationController
