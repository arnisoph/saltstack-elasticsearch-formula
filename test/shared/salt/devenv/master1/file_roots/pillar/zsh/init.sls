users:
  manage:
    root:
      shell: /bin/zsh

zsh:
  lookup:
    #sls_include:
    #  - users
    ohmyzsh:
      setup: True
      src: https://github.com/bechtoldt/oh-my-zsh.git
  config:
    manage:
      users:
        root:
          foobaro: True
