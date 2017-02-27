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

desc "Install node applications"
task :node do
  if command?('npm')
    # JavaScript development
    system %Q{npm install -g typescript}
    # JavaScript linters
    system %Q{npm install -g jshint eslint eslint_d npm-run}
  end
end

desc "Install web dev environment"
task :webdev do
  if command?('brew')
    system %Q{brew tap homebrew/apache homebrew/completions homebrew/core homebrew/dupes homebrew/php homebrew/services homebrew/versions}
    system %Q{brew install php56 php56-intl php56-xdebug php56-apc homebrew/php/composer}
    system %Q{brew install node yarn}
    system %Q{pip2 install ansible-lint}
  end
end

desc "Install neovim environment"
task :neovim do
  if command?('brew')
    system %Q{brew install ruby}
    system %Q{brew tap caskroom/fonts}
    system %Q{brew cask install font-bitstreamverasansmono-nerd-font}
    system %Q{brew cask install font-codenewroman-nerd-font}
    system %Q{brew cask install font-fantasquesansmono-nerd-font}
    system %Q{brew cask install font-firacode-nerd-font}
    system %Q{brew cask install font-hack-nerd-font}
    system %Q{brew cask install font-inconsolata}
    system %Q{brew cask install font-sourcecodepro-nerd-font}
    system %Q{brew install python3}
    system %Q{brew tap neovim/neovim}
    system %Q{brew install --HEAD neovim}
    system %Q{pip2 install neovim}
    system %Q{pip3 install neovim}
    system %Q{gem install neovim}
    system %Q{ln -siv "#{Dir.pwd}/vim" "#{Dir.home}/.config/nvim"}
  end
end

desc "Install applications"
task :apps do
  system %Q{brew tap caskroom/cask}
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
      system %Q{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
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
  system %Q{brew update && brew upgrade && brew tap homebrew/dupes}
  puts "> Installing environment"
  system %Q{brew install bash-completion wget tree cloc ack node par macvim trash tidy-html5 editorconfig}
  system %Q{brew tap universal-ctags/universal-ctags}
  system %Q{brew install --HEAD universal-ctags}
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
