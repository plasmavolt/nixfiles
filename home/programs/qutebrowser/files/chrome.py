# 1px borders on qutebrowser's Qt chrome

_TF_BORDER = "@border@"
_TF_ACCENT = "@accent@"
_TF_MARK = "/* textfox */"


def _tf_append(obj, qss):
    """Append qss to obj.STYLESHEET once, idempotently."""
    if _TF_MARK in obj.STYLESHEET:
        return
    obj.STYLESHEET += _TF_MARK + qss


try:
    from qutebrowser.browser import downloadview as _tf_downloadview
    from qutebrowser.completion import completionwidget as _tf_completion
    from qutebrowser.mainwindow import prompt as _tf_prompt
    from qutebrowser.mainwindow.statusbar import bar as _tf_bar
    from qutebrowser.misc import keyhintwidget as _tf_keyhint

    # statusline
    _tf_append(
        _tf_bar.StatusBar,
        """
        QWidget#StatusBar {
            {%% if conf.statusbar.position == 'top' %%}
                border-bottom: 1px solid %(border)s;
            {%% else %%}
                border-top: 1px solid %(border)s;
            {%% endif %%}
        }
        """
        % {"border": _TF_BORDER},
    )

    # completion: boxed popup
    _tf_append(
        _tf_completion.CompletionView,
        """
        QTreeView {
            border: 1px solid %(accent)s;
        }
        """
        % {"accent": _TF_ACCENT},
    )

    # keyhint / downloads / prompts
    _tf_append(
        _tf_keyhint.KeyHintView,
        """
        QLabel {
            border: 1px solid %(border)s;
        }
        """
        % {"border": _TF_BORDER},
    )

    _tf_append(
        _tf_downloadview.DownloadView,
        """
        QListView {
            border-top: 1px solid %(border)s;
        }
        """
        % {"border": _TF_BORDER},
    )

    _tf_append(
        _tf_prompt.PromptContainer,
        """
        QWidget#PromptContainer {
            border: 1px solid %(accent)s;
        }
        """
        % {"accent": _TF_ACCENT},
    )
except Exception as _tf_exc:  # never break config loading
    from qutebrowser.utils import log as _tf_log

    _tf_log.config.warning("chrome borders disabled: %r" % (_tf_exc,))
