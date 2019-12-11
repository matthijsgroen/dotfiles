function gcb
  echo (git branch ^/dev/null | sed -n '/\* /s///p')
end
