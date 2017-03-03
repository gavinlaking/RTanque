# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }

  host { 'hostmachine':
    ip => '192.168.0.1';
  }

  package { ['htop', 'tree', 'unzip']:
    ensure => present;
  }

  # package {
  #   [
  #     'build-essential',
  #     'git',
  #     'libsdl2-dev',
  #     'libsdl2-ttf-dev',
  #     'libpango1.0-dev',
  #     'libgl1-mesa-dev',
  #     'libopenal-dev',
  #     'libsndfile-dev',
  #     'ruby-dev',
  #     'freeglut3-dev'
  #   ]:
  #   ensure => present;
  # }

  file {
    '/home/vagrant/.bashrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      source => 'puppet:///modules/baseconfig/bashrc';
  }
}
