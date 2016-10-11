Vagrant.configure("2") do |config|
	
    config.vm.define "redwork" do |redwork|
        # Specify the base box
        redwork.vm.box = "ubuntu/trusty64"
        redwork.vm.network "private_network", ip: "192.168.100.2"
        redwork.vm.network "public_network"

        # Setup port forwarding
        redwork.vm.network :forwarded_port, guest: 80, host: 80, auto_correct: true
        redwork.vm.network :forwarded_port, guest: 15672, host: 15672, auto_correct: true

        # Setup synced folder
        redwork.vm.synced_folder "./", "/var/www", create: true, group: "www-data", owner: "www-data"
        #redwork.vm.synced_folder "./", "/var/www", type: "rsync" , rsync__auto: true, rsync__exclude: [".git/", "*.bat", "node_modules/"], rsync__args: ["--verbose", "--rsync-path='sudo rsync'", "--archive", "-z"]

        # VM specific configs
        redwork.vm.provider "virtualbox" do |v|
            v.memory = 1024
            v.cpus = 1
        end

        # Shell provisioning
        redwork.vm.provision "shell" do |s|
            s.path = "provision/setup.sh"
        end

        redwork.trigger.after [:up, :reload] do
           run_remote "/vagrant/provision/nginx.sh"
        end
    end
end