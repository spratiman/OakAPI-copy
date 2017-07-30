namespace :app do
  desc "Ensure task is not run in production environment"
  task :ensure_dev_env => :environment do
    if Rails.env.production?
      raise "I\'m sorry, but you can't run this task in production! :("
    end
  end

  desc "Install development environment"
  task :install => [:ensure_dev_env, "db:setup", "import:all", "spec"]

  desc "Reset development environment"
  task :reset => [:ensure_dev_env, "db:drop", :install]
end
