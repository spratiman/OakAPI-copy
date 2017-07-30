namespace :update do
  desc "Update all data"
  task :all => ["update:courses", "update:terms", "update:lectures"]
end