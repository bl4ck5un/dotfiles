import os

HOME = os.getenv('HOME')
oh_my_zsh = 'curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh'

# error code
EUSER = 1


class Task(object):
    def __init__(self, taskname, *funcs, **kwargs):
        self.taskname = taskname
        self.funcs = funcs
        self.kwargs = kwargs

    def run(self):
        for f in self.funcs:
            r = f()
            if r == EUSER:
                print('> abandon %s' % f.func_name)
            elif r != 0:
                print('> error')

    def undo(self):
        for f in self.funcs:
            assert f(undo=True)

def linker(destdir, filename):
    def link(): 
        if os.path.isfile(filename):
            fullsrc = os.path.join(os.getcwd(), filename)
            fulldest = os.path.join(destdir, filename)
            y = raw_input('ln -sf %s %s [y]/n?' % (fullsrc, fulldest))
            if y == 'n':
                return EUSER
            else:
                return os.system('ln -sf %s %s' % (fullsrc, fulldest))
        else:
            return -1
    return link

def cmd(cmdstr):
    def run():
        y = raw_input('run %s [y/n]?' % cmdstr)
        if y == 'n':
            return EUSER
        else:
            return os.system(cmdstr)
    return run

def alert(msg):
    def say():
        print(msg)
        return 0
    return say

syntax_hlt_plugin = 'cd ~/.oh-my-zsh/custom/plugins && \
        git clone git://github.com/zsh-users/zsh-syntax-highlighting.git'

tasks = [
    Task('vim', linker(HOME, '.vimrc'), cmd('vim vim +PluginInstall +qall')),
    Task('ycm', alert('You need to compile YCM manually')),
    Task('zsh', cmd(oh_my_zsh), cmd(syntax_hlt_plugin), linker(HOME, '.zshrc')),
    ]

[ t.run() for t in tasks]

