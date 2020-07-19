#!/usr/bin/env python3

"""
Config i3

Usage:
  config.py [options]

Options:
  -h --help                 Show this screen.
  --version                 Show version.
  --4k                      use DPI=196
"""

from docopt import docopt
import os
import errno

def link_to_dir(file, dir, overwrite=False, newname=None):
    if not os.path.isabs(dir):
        raise Exception("dir is not abspath")

    src = os.path.abspath(file)
    if newname is not None:
        base = newname
    else:
        base = os.path.basename(src)

    if not os.path.exists(src):
        raise Exception("{} doesn't exist".format(src))
    try:
        target = os.path.join(dir, base)
        os.symlink(src, target)
        print('{} -> {}'.format(target, src))
    except OSError as e:
        if e.errno == errno.EEXIST:
            os.remove(target)
            os.symlink(src, target)
            print('{} overwritten'.format(target))

def link_to_home(file, **kwargs):
    home = os.getenv('HOME')
    if home is None:
        raise Exception("can't get HOME")
    link_to_dir(file, home, **kwargs)

args = docopt(__doc__)

if args['--4k']:
    # not used by GDM so
    # link_to_home('.xinitrc-4k', overwrite=True, newname='.xinitrc')
    link_to_home('.Xresources-4k', overwrite=True, newname='.Xresources')
else:
    # not used by GDM so
    # link_to_home('.xinitrc', overwrite=True)
    link_to_home('.Xresources', overwrite=True)
