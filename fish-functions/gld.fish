function gld
  git log --since $argv[1]T0:00 --until $argv[2]T23:59 --pretty=format:'%ad %Cgreen%cn%Creset - %s' --date=iso | sort | grep 'Matthijs'
end
