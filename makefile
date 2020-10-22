
all: br ca cc gc ir rm re rp tc ts vi zs

ba:
	cp ~/.bash_aliases .

br:
	cp ~/.bashrc .

ca:
	cp ~/.config/autostart/conkyleft.desktop .config/autostart/. ; \
		cp ~/.config/autostart/conkyright.desktop ./.config/autostart/.

cc:
	cp ~/.conky/.conkyrc_left .conky/. ; \
		cp ~/.conky/.conkyrc_right .conky/.

gc:
	cp ~/.gitconfig .

ir:
	cp ~/.inputrc .

rm:
	cp ~/.R/Makevars .R/.

re:
	cp ~/.Renviron .

rp:
	cp ~/.Rprofile .

tc:
	cp ~/.tmux.conf .

ts:
	cp ~/tmux_split.vim .

vi:
	cp ~/.vimrc .

zs:
	cp ~/.zshrc .
