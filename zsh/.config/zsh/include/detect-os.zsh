() {
  if [[ -v CURRENT_OS ]]; then
    return 0
  fi

  local UNAME_S=$(uname -s 2>/dev/null || echo "unkown")
  if [[ "${UNAME_S:l}" == "darwin" ]]
  then
    export CURRENT_OS="macos"
    export OS_MACOS=true
  elif [[ "${UNAME_S:l}" == "linux" ]]
  then
    export CURRENT_OS="linux"
    export OS_LINUX=true
  else
    export CURRENT_OS="unknown"
  fi
}
