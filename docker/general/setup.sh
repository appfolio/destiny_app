crontab -l > mycron
command="rm -rf /usr/src/destiny/log/*"
job="0 0 * * 0 $command"
cat mycron | fgrep -i -v "$command" | { cat; echo "$job"; } | crontab -
rm mycron
