default["halt"]["home_directories"] = [
  "/home/driti/bin", 
  "/home/driti/dev", 
  "/home/driti/opt", 
  "/home/driti/tmp", 
  "/home/driti/work",
  "/home/driti/.i3",
]

default["halt"]["dot_files"] = [
  [".bashrc",    "/home/driti/dev/configs/.bashrc"],
  [".gitconfig", "/home/driti/dev/configs/.gitconfig"],
  [".i3/config", "/home/driti/dev/configs/.i3/config"],
  [".jshintrc",  "/home/driti/dev/configs/.jshintrc"],
  [".pylintrc",  "/home/driti/dev/configs/.pylintrc"],
  [".tmux.conf", "/home/driti/dev/configs/.tmux.conf"],
  [".Xdefaults", "/home/driti/dev/configs/.Xdefaults"],
]

default["halt"]["pathogen_directories"] = [
  "/home/driti/.vim",
  "/home/driti/.vim/autoload",
  "/home/driti/.vim/bundle",
]

default["halt"]["vim_plugins"] = [
  ["supertab",          "https://github.com/ervandew/supertab.git"],
  ["syntastic",         "https://github.com/scrooloose/syntastic.git"],
  ["vim-coffee-script", "https://github.com/kchmck/vim-coffee-script.git"],
  ["vim-fugitive",      "https://github.com/tpope/vim-fugitive.git"],
  ["vim-go",            "https://github.com/fatih/vim-go.git"],
  ["vim-javascript",    "https://github.com/pangloss/vim-javascript.git"],
  ["vim-less",          "https://github.com/groenewege/vim-less.git"],
  ["vim-markdown",      "https://github.com/plasticboy/vim-markdown.git"],
  ["vim-ruby",          "https://github.com/vim-ruby/vim-ruby.git"],
  ["xoria256",          "https://github.com/vim-scripts/xoria256.vim"],
]
