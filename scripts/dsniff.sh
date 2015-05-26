#!/bin/bash
# Cleartext password sniffing on all available interfaces
. px_interface_selector.sh

f_logging_setup(){
  clear
  echo
  echo "Would you like to log data?"
  echo
  echo "Captures saved to /opt/pwnix/captures/passwords/"
  echo
  echo "1. Yes"
  echo "2. No "
  echo
  f_get_logchoice
}

f_get_logchoice(){
  read -p "Choice: " logchoice
  case $logchoice in
    [1-2]*) ;;
    *)
      echo 'Please enter 1 for YES or 2 for NO.'
      f_get_logchoice
      ;;
  esac
}

f_run(){
  # If user chose to log, log to folder
  # else just run cmd
  if [ $logchoice -eq 1 ]; then
    filename=/opt/pwnix/captures/passwords/dsniff_$(date +%F-%H%M).log
    ettercap -i $interface -u -T -q | tee $filename
  elif [ $logchoice -eq 2 ]; then
    ettercap -i $interface -T -q -u
  fi
}

f_interface 1
f_logging_setup
f_run
