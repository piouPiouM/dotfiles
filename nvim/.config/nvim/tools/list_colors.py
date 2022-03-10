import re
print '<html>'
with open('list_colors.vim') as fin:
	for line in fin.xreadlines():
		m = re.search(r'_(\w+).+(#\w+)', line)
		if not m: continue
		print '<div style="float: left; width:100px; height:100px; background-color:{1}; font-size:8pt; color: #111; font-family:ubuntu;">{0}</div>'.format(*m.groups())
print '</html>'
