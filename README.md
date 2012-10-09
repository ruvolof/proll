PRoll - A Perl Dice Roller
==========================

PRoll, as you probably had already understood, stands for Perl Roll. It's a pure Perl Dice Roller.
I wrote it because I need it when gamemastering play by email session and because I'd love the idea
of having a terminal based dice roller.

### Installation ###

First of all, clone the git repository on your machine:

`git clone git://github.com/ruvolof/proll proll`  
`cd proll`

Now, you should run `install.sh` as follows:

`./install.sh`

You could do it as root, in which case PRoll will be installed in /usr/bin, or with your user account,
in which case PRoll will be installed in $HOME/bin and $HOME/bin will be added tou your PATH variable
if it's not yet there.

If you get tired of it, you can unistall it by running:

`./install.sh uninstall`

Which, of course, will require root privileges if you installed it under /usr/bin.

### Usage ###

`proll XdY`

Where X is the number of dices you want to roll and Y the number of faces for each dice.
