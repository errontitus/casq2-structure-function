# Based on https://matplotlib.org/3.1.1/tutorials/colors/colorbar_only.html#sphx-glr-tutorials-colors-colorbar-only-py

import matplotlib.pyplot as plt
import matplotlib as mpl

fig, ax = plt.subplots(figsize=(6, 1))
fig.subplots_adjust(bottom=0.5)

cmap = mpl.cm.bwr
norm = mpl.colors.Normalize(vmin=5, vmax=10)

cb1 = mpl.colorbar.ColorbarBase(ax, cmap=cmap,
                                norm=norm,
                                orientation='horizontal')

ax.set_axis_off()
# cb1.set_label('Some Units')

fig.tight_layout(pad=0)
fig.savefig("./resource/matplotlib_bwr.png")