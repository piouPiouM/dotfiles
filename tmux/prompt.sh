#!/usr/bin/env bash

export TMUX_POWERLINE_DIR_HOME="$(dirname $0)"
source "${TMUX_POWERLINE_DIR_HOME}/config.sh"
get_pane_width

print_powerline() {
  # The format of the segments is:
  # segment "segment_file_name" foreground background outer_most_segment? min_pane_width
  # If the required PANE_WIDTH isn't met then the segment will be hidden
  if [[ $1 == "left" ]]; then
    segment "session_info" colour000 colour004 100
    segment "tmux_window_count" colour007 colour006 50
    #segment "arc_accepted" colour000 colour010 120
    #segment "arc_needs_revision" colour000 colour009 120
    #segment "arc_needs_review" colour000 colour013 120
    #segment "arc_changes_planned" colour000 colour011 120
  else
     #segment "online" colour000 colour011 110
     segment "now_playing" colour003 colour000 200
     segment "uptime" colour000 colour004 143
    #segment "tw_inbox" colour000 colour09
    segment "datetime" colour000 colour004 100
    segment "hostname" colour000 colour004 140
  fi

  exit 0
}

print_powerline "$1"
