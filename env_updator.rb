#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class EnvUpdator
  def initialize()
    use_system_ruby = 'rbenv global system'
    puts use_system_ruby
    result = system(use_system_ruby)
    unless result
      raise use_system_ruby + ' was failed.'
      return
    end
  end

  def update(command, targets)
    versions = ''
    begin
      versions = `#{command} install -l`
    rescue => e
      puts "#{command} versions was failed."
    end

    install_l = ''
    begin
      install_l = `#{command} install -l`
    rescue => e
      puts "#{command} install -l was failed."
    end

    current_list = []
    latest_list= []

    prefix = ''
    if command == 'ndenv'
      prefix = 'v'
    end

    targets.each do |v|
      major = v[:major]
      minor = v[:minor]

      if minor.nil?
        re = /^\s*\**\s*#{prefix}#{major}\.\d+\.\d+.*$/
      else
        re = /^\s*\**\s*#{prefix}#{major}\.#{minor}\.\d+.*$/
      end

      current_list << versions.scan(re).last.strip
      latest_list << install_l.scan(re).last.strip
    end

    current_list.compact!
    latest_list.compact!

    p current_list
    p latest_list

    current_list.each do |o|
      uninstall = "#{command} uninstall -f #{o}"
      puts uninstall
      result = system(uninstall)
      unless result
        raise uninstall + ' was failed.'
      end
    end

    latest_list.each do |l|
      install = "#{command} install #{l}"
      puts install
      result = system(install)
      unless result
        raise install + ' was failed.'
      end
    end
  end
end
