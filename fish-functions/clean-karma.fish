function clean-karma
  kill -9 (ps -ef | awk '/[k]arma/{print $2}')
end

