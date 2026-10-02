_CHROME_MARK = "/* chrome-borders */"

try:
    from qutebrowser.browser import downloadview
    from qutebrowser.completion import completionwidget
    from qutebrowser.mainwindow import prompt
    from qutebrowser.mainwindow.statusbar import bar
    from qutebrowser.misc import keyhintwidget

    for _cls, _qss in [
        (bar.StatusBar, "QWidget#StatusBar { border-top: 1px solid @border@; }"),
        (completionwidget.CompletionView, "QTreeView { border: 1px solid @accent@; }"),
        (keyhintwidget.KeyHintView, "QLabel { border: 1px solid @border@; }"),
        (downloadview.DownloadView, "QListView { border-top: 1px solid @border@; }"),
        (
            prompt.PromptContainer,
            "QWidget#PromptContainer { border: 1px solid @accent@; }",
        ),
    ]:
        if _CHROME_MARK not in _cls.STYLESHEET:
            _cls.STYLESHEET += _CHROME_MARK + _qss
except Exception as _exc:  # never break config loading
    from qutebrowser.utils import log

    log.config.warning("chrome borders disabled: %r" % (_exc,))
