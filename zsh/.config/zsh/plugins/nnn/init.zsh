if ! command_exist nnn; then
  return 0
fi

typeset -A _plug_keymap=(
  [p]="preview-tui"
)

for keymap plugin in ${(kv)_plug_keymap}
do
  NNN_PLUG+=";${keymap}:${plugin}"
done

export NNN_PLUG=${NNN_PLUG:1}

export NNN_FIFO=${TMPDIR}/nnn.fifo
export NNN_OPTS="adeH"
export SPLIT='v'
