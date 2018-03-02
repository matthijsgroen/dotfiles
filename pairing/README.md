Setup remote pair programming
=============================

1. setup a user account, eg. 'Pairing'. Give this user standard permissions.
2. setup remote login for this user: `System preferences -> Sharing -> Remote login`
3. setup public key login for this user on your own machine, so that you can use `ssh pairing@localhost` without using a password.
   1. sudo cp ~/Downloads/id_dsa.pub /Users/pairing/
   2. su pairing
   3. cd ~
   4. mkdir .ssh
   5. chmod 700 .ssh
   6. cat id_dsa.pub >> .ssh/authorized_keys
   7. rm id_dsa.pub
4. place all files of this folder into the home folder of the pairing user.
5. setup a `sudo` rule that the pair user may run tmux as your own user

    `sudo visudo`

    setup in this file the rule that the user pairing may run tmux as another user:
    (using zshell)

        pairing  ALL=(your-username) NOPASSWD: /bin/zsh -c tmux

    or when using fish-shell

        pairing  ALL=(your-username) NOPASSWD: /usr/local/bin/fish -c tmux


Using Tmux
==========

### Starting/joining session

    ssh pairing@localhost
    ./start-pairing.sh (session name)
    
To set a default folder for new panes:

    Ctrl+a : (tmux prompt)
    attach -c (new default path)

### Leaving session

    Ctrl+b d (detach-session) *

### Killing session

    Ctrl+a q (kill-session)

\* Ctr+a is the TMux binding of your user TMux. The Pairing TMux will also automatically close when the session of the user TMux ends

\* Ctr+b is the TMux binding of your pairing TMux.
