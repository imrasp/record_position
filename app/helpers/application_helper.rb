module ApplicationHelper

  def odroid_update_software_no_compile
    require 'net/ssh'
    @result = ''
    system("cd ~/CLionProjects/LearnVI_Drone && git add -A && git commit -m 'update' && git push board 2cameras")
    @result = "The code is updated! without complie"
  end

  def odroid_update_software_crosscompile
    require 'net/ssh'
    @result = ''
    system("cd ~/CLionProjects/LearnVI_Drone/script && ./xodroid_build.sh")
    system("cd ~/CLionProjects/LearnVI_Drone && git add -A && git commit -m 'update' && git push board 2cameras")
    @result = "The software is updated! from crosscompile"
  end

  def odroid_update_software_crosscompile_fast
    require 'net/ssh'
    @result = ''
    system("cd ~/CLionProjects/LearnVI_Drone/script && ./fast_xodroid_build.sh")
    system("cd ~/CLionProjects/LearnVI_Drone && git add -A && git commit -m 'update' && git push board 2cameras")
    @result = "The software is updated! from crosscompile"
  end

  def download_logs
    require 'net/ssh'
    @result = ''
    system("rm -rf /home/rasp/CLionProjects/LearnVI_Drone/download_result/Recorded_Datasets")
    system("mkdir /home/rasp/CLionProjects/LearnVI_Drone/download_result/Recorded_Datasets")
    system("rsync -av --progress odroid@10.42.0.1:/home/odroid/workspace/VIDrone/Recorded_Datasets /home/rasp/CLionProjects/LearnVI_Drone/download_result/")
    @result = "Download logs complete"
  end

  def odroid_update_software
    require 'net/ssh'
    @result = ''
    system("cd ~/CLionProjects/LearnVI_Drone && git add -A && git commit -m 'update' && git push board 2cameras")
    Net::SSH.start('10.42.0.1', 'odroid', :password => "odroid") do |ssh|

      @result = "updating..."

      # capture only stdout matching a particular pattern
      stdout = ""
      ssh.exec!("ls -l ") do |channel, stream, data|
        stdout << data if stream == :stdout
        @result = stdout
      end
      puts stdout

      # # run multiple processes in parallel to completion
      # ssh.exec "pwd"
      # ssh.exec "/home/odroid/workspace/VIDrone/script/rebuild_odroid.sh"
      # ssh.loop
      # @result = "update completed!"

      # open a new channel and configure a minimal set of callbacks, then run
      # the event loop until the channel finishes (closes)
      channel = ssh.open_channel do |ch|

        ch.exec "/home/odroid/workspace/VIDrone/script/rebuild_odroid.sh" do |ch, success|
          raise "could not execute command" unless success

          # "on_data" is called when the process writes something to stdout
          ch.on_data do |c, data|
            if data =~ /^\[sudo\] password for /
              # Send the password
              channel.send_data "#{@password}\n"
            else
              $stdout.print data
              @result += data.to_s + "\n"
            end
          end

          # "on_extended_data" is called when the process writes something to stderr
          ch.on_extended_data do |c, type, data|
            $stderr.print data
            @result += data.to_s + "\n"
          end

          ch.on_close {puts "done!"}
        end
      end

      channel.wait
    end
  end

  def odroid_acommand acommand
    require 'net/ssh'

    @result = ''
    Net::SSH.start('10.42.0.1', 'odroid', :password => "odroid") do |ssh|

      # open a new channel and configure a minimal set of callbacks, then run
      # the event loop until the channel finishes (closes)
      channel = ssh.open_channel do |ch|

        ch.exec acommand do |ch, success|
          raise "could not execute command" unless success

          # "on_data" is called when the process writes something to stdout
          ch.on_data do |c, data|
            if data =~ /^\[sudo\] password for /
              # Send the password
              channel.send_data "#{@password}\n"
            else
              $stdout.print data
              @result += data.to_s + "\n"
            end
          end

          # "on_extended_data" is called when the process writes something to stderr
          ch.on_extended_data do |c, type, data|
            $stderr.print data
            @result += data.to_s + "\n"
          end

          ch.on_close {puts "done!"}
        end
      end
      channel.wait
    end
  end
end
