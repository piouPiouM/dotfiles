require 'rake'

desc "Install the dot files into user’s home directory"
task :dotfiles do
  puts "> link miscellaneous files."
  link_files("misc")

  puts "> link vim files."
  link_file("vim/vimrc")
  link_file("vim/gvimrc")
  link_file("vim")

  puts "> link bash files."
  link_files("bash")

  puts "> reload bash environment."
  system %Q{source $HOME/.bash_profile} 
end

desc "Install and initialize the Homebrew environment"
task :homebrew do
  install_homebrew
  if command?('brew')
    initialize_homebrew
  end
end

desc "Install web dev environment"
task :webdev do
  if command?('brew')
    system %Q{brew tap josegonzalez/homebrew-php}
    system %Q{brew install php53 php53-intl php53-xdebug php53-apc}
  end
end

desc "Intall applications"
task :apps do
  system %Q{brew tap phinze/homebrew-cask}
  system %Q{brew install brew-cask}
end

def install_homebrew
  if command?('brew')
    puts "Note: Homebrew is already installed."
  else
    print "> Install Homebrew? [ynq]"
    case $stdin.gets.chomp
    when "y"
      puts "> Installing Homebrew"
      system %Q{ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"}
      system %Q{brew doctor}
    when "q"
      exit
    else
      puts "x Skip installing Homebrew"
    end
  end
end

def initialize_homebrew
  puts
  puts "> Updating Homebrew"
  system %Q{brew update && brew tap homebrew/dupes}
  puts "> Installing environment"
  system %Q{brew install bash-completion wget tree ack ctags}
end

def command?(command)
  system "type -a #{command} > /dev/null 2>&1"
end

def link_file(file, dest = Dir.home)
  system %Q{ln -siv "#{Dir.pwd}/#{file}" "#{dest}/.#{File.basename(file)}"}
end

def link_files(fromdir, dest = Dir.home)
  Dir.foreach(File.join(Dir.pwd, "/", fromdir)) do |filename|
    next if filename == '.' or filename == '..'
    link_file("#{fromdir}/#{filename}", dest)
  end
end
