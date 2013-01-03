Capistrano::Configuration.instance.load do

  namespace :mongoid do

    desc <<-DESC
      Creates the mongoid.yml configuration file in shared path.
    DESC
    task :setup, :except => { :no_release => true } do
      location = 'config/mongoid.yml'
      config = File.read(location)

      run "mkdir -p #{shared_path}/config"
      put config, "#{shared_path}/config/mongoid.yml"
    end

    desc <<-DESC
      [internal] Updates the symlink for mongoid.yml file to the just deployed release.
    DESC
    task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
    end

  end

  after "deploy:setup",           "mongoid:setup"   unless fetch(:skip_mongoid_setup, false)
  after "deploy:finalize_update", "mongoid:symlink"

end