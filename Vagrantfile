Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.network :private_network, ip: "192.168.0.10"

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--cpuexecutioncap", "75",
      "--memory", "1024",
    ]
    vb.gui = true
  end
  config.vm.provision "shell", inline: <<-EOL
    sudo apt-get update
    sudo apt-get install -y gnome
    sudo apt-get install -y build-essential git libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libopenal-dev libsndfile-dev ruby-dev freeglut3-dev gnome-panel

    if [ ! -f /home/vagrant/.vagrant-chruby-provisioned ]; then
      wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
      tar -xzvf chruby-0.3.9.tar.gz && cd chruby-0.3.9/ && sudo make install

      echo 'if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then' | sudo tee -a /etc/profile.d/chruby.sh
      echo '  source /usr/local/share/chruby/chruby.sh' | sudo tee -a /etc/profile.d/chruby.sh
      echo '  source /usr/local/share/chruby/auto.sh' | sudo tee -a /etc/profile.d/chruby.sh
      echo 'fi' | sudo tee -a /etc/profile.d/chruby.sh

      echo 'source /etc/profile.d/chruby.sh' >> /home/vagrant/.bashrc

      echo 'ruby-2.4.2' >> /home/vagrant/.ruby-version
      chown vagrant:vagrant /home/vagrant/.ruby-version
      echo "---\n:benchmark: false\n:bulk_threshold: 1000\n:backtrace: false\n:verbose: true\ngem: --no-ri --no-rdoc" >> /home/vagrant/.gemrc
      chown vagrant:vagrant /home/vagrant/.gemrc

      touch /home/vagrant/.vagrant-chruby-provisioned
    fi

    if [ ! -f /home/vagrant/.vagrant-ruby-install-provisioned ]; then
      wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz
      tar -xzvf ruby-install-0.6.1.tar.gz && cd ruby-install-0.6.1/ && sudo make install

      touch /home/vagrant/.vagrant-ruby-install-provisioned
    fi

    if [ ! -f /home/vagrant/.vagrant-ruby-provisioned ]; then
      ruby-install ruby 2.4.2
      gem install bundler

      touch /home/vagrant/.vagrant-ruby-provisioned
    fi

    if [ ! -f /home/vagrant/.vagrant-desktop-setup ]; then
      # show icons on desktop
      gsettings set org.gnome.desktop.background show-desktop-icons true
      echo 'source /home/vagrant/.bashrc' >> /home/vagrant/.bash_profile
      chown vagrant:vagrant /home/vagrant/.bash_profile

      mkdir -p /home/vagrant/Desktop
      chown vagrant:vagrant /home/vagrant/Desktop

      gnome-desktop-item-edit --create-new /home/vagrant/Desktop/runner.desktop

      cp -f /vagrant/scripts/runner /home/vagrant/Desktop/runner
      chown vagrant:vagrant /home/vagrant/Desktop/runner
      chmod 0755 /home/vagrant/Desktop/runner

      cp -f /vagrant/scripts/runner.desktop /home/vagrant/Desktop/runner.desktop
      cp -f /vagrant/scripts/runner.desktop /home/vagrant/.local/share/applications/
      chown vagrant:vagrant /home/vagrant/Desktop/runner.desktop
      chown vagrant:vagrant /home/vagrant/.local/share/applications/runner.desktop
      chmod 0755 /home/vagrant/Desktop/runner.desktop

      touch /home/vagrant/.vagrant-desktop-setup
    fi

    echo "Username: vagrant | Password: vagrant"
    echo "To enable auto-login; go to Settings -> Users -> Automatic Login"
    echo "To disable screen blanking; go to Settings -> Power -> Blank Screen -> Never"
  EOL
end
