void main() {
  var dialog = ArticlesDialogBox();
  dialog.simulateUserInteraction();
}

// playing the role of a 'mediator'
abstract class DialogBox {
  void changed(UIControl control);
}

class ArticlesDialogBox extends DialogBox {
  late ListBox _articlesListBox;
  late TextBox _titleTextBox;
  late Button _saveButton;
  ArticlesDialogBox() {
    _articlesListBox = ListBox(this);
    _titleTextBox = TextBox(this);
    _saveButton = Button(this);
  }

  void simulateUserInteraction() {
    _articlesListBox.setSelection('Article 1');
    _titleTextBox.setContent('');
    print('TextBox: ${_titleTextBox.getContent()}');
    print('Button: ${_saveButton.isEnabled()}');
  }

  @override
  void changed(UIControl control) {
    if (control == _articlesListBox) {
      articleSelected();
    } else if (control == _titleTextBox) {
      titleChanged();
    } else if (control == _saveButton) {}
  }

  void articleSelected() {
    _titleTextBox.setContent(_articlesListBox.getSelection());
    _saveButton.setEnabled(true);
  }

  void titleChanged() {
    var content = _titleTextBox.getContent();
    var isEmpty = (content.isEmpty || content == '')
        ? _saveButton.setEnabled(false)
        : _saveButton.setEnabled(true);
  }
}

class UIControl {
  DialogBox owner;
  UIControl(this.owner);
}

class ListBox extends UIControl {
  ListBox(DialogBox owner) : super(owner);
  String _selection = '';

  String getSelection() {
    return _selection;
  }

  void setSelection(String selection) {
    _selection = selection;
    owner.changed(this);
  }
}

class TextBox extends UIControl {
  TextBox(DialogBox owner) : super(owner);
  String _content = '';

  String getContent() {
    return _content;
  }

  void setContent(String content) {
    _content = content;
    owner.changed(this);
  }
}

class Button extends UIControl {
  Button(DialogBox owner) : super(owner);
  bool _isEnabled = true;

  bool isEnabled() {
    return _isEnabled;
  }

  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    owner.changed(this);
  }
}
