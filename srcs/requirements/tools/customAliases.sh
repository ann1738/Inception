
BASHRC_PATH="/home/$USER/.bashrc"
BASHRC_PATH="/home/$USER/.zshrc"

ALIASES="#Docker Aliases
alias dls=\"docker container ls\" 
alias dlsa=\"docker container ls -a\"
alias dup=\"docker compose up\"
alias ddown=\"docker compose down\"
alias dbuild=\"docker compose build\"
alias dres=\"docker compose down && docker compose up\"
"

echo $ALIASES >> $BASHRC_PATH
echo $ALIASES >> $ZSHRC_PATH