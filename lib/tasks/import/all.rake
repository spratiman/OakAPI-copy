namespace :import do
  desc "Import all data"
  task :all => ["import:courses", "import:terms", "import:lectures"]
end