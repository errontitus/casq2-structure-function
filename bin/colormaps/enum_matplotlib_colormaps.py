# See https://matplotlib.org/3.1.1/tutorials/colors/colormaps.html
# Also has info on creating your own color maps.

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib import cm
from colorspacious import cspace_converter
from collections import OrderedDict

from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure


cmaps = OrderedDict()

# We are largely interested in the diverging color maps, since most of the time we want to 
# show a value along a single dimension around a middle point. There are many other examples at https://matplotlib.org/3.1.1/tutorials/colors/colormaps.html.

cmaps['Diverging'] = [
            'PiYG', 'PRGn', 'BrBG', 'PuOr', 'RdGy', 'RdBu',
            'RdYlBu', 'RdYlGn', 'Spectral', 'coolwarm', 'bwr', 'seismic']

nrows = max(len(cmap_list) for cmap_category, cmap_list in cmaps.items())
gradient = np.linspace(0, 1, 256)
gradient = np.vstack((gradient, gradient))

def plot_color_gradients(cmap_category, cmap_list, nrows):
    fig, axes = plt.subplots(nrows=nrows)
    fig.subplots_adjust(top=0.95, bottom=0.01, left=0.2, right=0.99)
    axes[0].set_title(cmap_category + ' colormaps', fontsize=14)

    for ax, name in zip(axes, cmap_list):
        ax.imshow(gradient, aspect='auto', cmap=plt.get_cmap(name))
        pos = list(ax.get_position().bounds)
        x_text = pos[0] - 0.01
        y_text = pos[1] + pos[3]/2.
        fig.text(x_text, y_text, name, va='center', ha='right', fontsize=10)

    # Turn off *all* ticks & spines, not just the ones with colormaps.
    for ax in axes:
        ax.set_axis_off()

def plot_single_color_gradient(name):
    fig = Figure()
    # A canvas must be manually attached to the figure (pyplot would automatically
    # do it).  This is done by instantiating the canvas with the figure as
    # argument.
    FigureCanvas(fig)
    ax = fig.add_subplot(111)
    ax.plot([1, 2, 3])

    fig.subplots_adjust(top=0.95, bottom=0.01, left=0.2, right=0.99)
    
    ax.imshow(gradient, aspect='auto', cmap=plt.get_cmap(name))
    ax.set_axis_off()

    return fig

# Plot all
for cmap_category, cmap_list in cmaps.items():
    plot_color_gradients(cmap_category, cmap_list, nrows)

# plt.show()
plt.savefig("all_colormaps.pdf")

# Plot one.
fig = plot_single_color_gradient("bwr")
fig.savefig("matplotlib_blue_white_red.png")