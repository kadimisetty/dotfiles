import sys
sys.path.insert(0, '/Applications/Zephyros.app/Contents/Resources/libs/')
import zephyros

@zephyros.zephyros
def myscript():
    def nudge_window():
        win = zephyros.api.focused_window()
        f = win.frame()
        f.x += 3
        win.set_frame(f)

    def show_window_title():
        zephyros.api.alert(zephyros.api.focused_window().title())

    zephyros.api.bind('D', ['Cmd', 'Shift'], show_window_title)
    zephyros.api.bind('F', ['Cmd', 'Shift'], nudge_window)
