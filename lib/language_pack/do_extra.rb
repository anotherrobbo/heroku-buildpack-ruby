require "language_pack"
require "language_pack/rails5"

class LanguagePack::DoExtra < LanguagePack::Rails5
  def self.use?
    pwd = Dir.pwd
    bps = "#{pwd}/buildpack_scripts"
    puts "Checking for #{bps}/doextra.sh"
    # If #{bps}/doextra.sh exists, then run this.
    File.exists?("#{bps}/doextra.sh") && super
  end

  def name
    "Ruby/DoExtra"
  end

  def compile
    # Initial setup from ruby.rb
    setup_language_pack_environment
    setup_export
    setup_profiled
    
    # Here we do the actual extra script running
    pwd = Dir.pwd
    bps = "#{pwd}/buildpack_scripts"
    puts "Calling #{bps}/doextra.sh"
    cmd1 = "export GEM_PATH=#{ENV["GEM_PATH"]};"
    cmd2 = "export GEM_HOME=#{ENV["GEM_HOME"]};"
    cmd3 = "/bin/bash #{bps}/doextra.sh"
    cmds = "#{cmd1} #{cmd2} #{cmd3} "
    extra_output = ""
    extra_output << pipe("#{cmds}")
    puts "Extra Output: #{extra_output}"
    super
  end
end
