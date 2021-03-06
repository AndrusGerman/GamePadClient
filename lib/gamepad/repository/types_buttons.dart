class GetButtonsTypeRepository {
  final List<ButtonTypeInfo> dataMouse = [
    ButtonTypeInfo("L", name: "Izquierda"),
    ButtonTypeInfo("R", name: "Derecha"),
  ];

  final List<ButtonTypeInfo> dataKeyboard = [
    ButtonTypeInfo("Esc"),
    ButtonTypeInfo("1"),
    ButtonTypeInfo("2"),
    ButtonTypeInfo("3"),
    ButtonTypeInfo("4"),
    ButtonTypeInfo("5"),
    ButtonTypeInfo("6"),
    ButtonTypeInfo("7"),
    ButtonTypeInfo("8"),
    ButtonTypeInfo("9"),
    ButtonTypeInfo("0"),
    ButtonTypeInfo("Minus"),
    ButtonTypeInfo("Equal"),
    ButtonTypeInfo("Backspace"),
    ButtonTypeInfo("Tab"),
    ButtonTypeInfo("Q"),
    ButtonTypeInfo("W"),
    ButtonTypeInfo("E"),
    ButtonTypeInfo("R"),
    ButtonTypeInfo("T"),
    ButtonTypeInfo("Y"),
    ButtonTypeInfo("U"),
    ButtonTypeInfo("I"),
    ButtonTypeInfo("O"),
    ButtonTypeInfo("P"),
    ButtonTypeInfo("Leftbrace"),
    ButtonTypeInfo("Rightbrace"),
    ButtonTypeInfo("Enter"),
    ButtonTypeInfo("Leftctrl"),
    ButtonTypeInfo("A"),
    ButtonTypeInfo("S"),
    ButtonTypeInfo("D"),
    ButtonTypeInfo("F"),
    ButtonTypeInfo("G"),
    ButtonTypeInfo("H"),
    ButtonTypeInfo("J"),
    ButtonTypeInfo("K"),
    ButtonTypeInfo("L"),
    ButtonTypeInfo("Semicolon"),
    ButtonTypeInfo("Apostrophe"),
    ButtonTypeInfo("Grave"),
    ButtonTypeInfo("Leftshift"),
    ButtonTypeInfo("Backslash"),
    ButtonTypeInfo("Z"),
    ButtonTypeInfo("X"),
    ButtonTypeInfo("C"),
    ButtonTypeInfo("V"),
    ButtonTypeInfo("B"),
    ButtonTypeInfo("N"),
    ButtonTypeInfo("M"),
    ButtonTypeInfo("Comma"),
    ButtonTypeInfo("Dot"),
    ButtonTypeInfo("Slash"),
    ButtonTypeInfo("Rightshift"),
    ButtonTypeInfo("Kpasterisk"),
    ButtonTypeInfo("Leftalt"),
    ButtonTypeInfo("Space"),
    ButtonTypeInfo("Capslock"),
    ButtonTypeInfo("F1"),
    ButtonTypeInfo("F2"),
    ButtonTypeInfo("F3"),
    ButtonTypeInfo("F4"),
    ButtonTypeInfo("F5"),
    ButtonTypeInfo("F6"),
    ButtonTypeInfo("F7"),
    ButtonTypeInfo("F8"),
    ButtonTypeInfo("F9"),
    ButtonTypeInfo("F10"),
    ButtonTypeInfo("Numlock"),
    ButtonTypeInfo("Scrolllock"),
    ButtonTypeInfo("Kp7"),
    ButtonTypeInfo("Kp8"),
    ButtonTypeInfo("Kp9"),
    ButtonTypeInfo("Kpminus"),
    ButtonTypeInfo("Kp4"),
    ButtonTypeInfo("Kp5"),
    ButtonTypeInfo("Kp6"),
    ButtonTypeInfo("Kpplus"),
    ButtonTypeInfo("Kp1"),
    ButtonTypeInfo("Kp2"),
    ButtonTypeInfo("Kp3"),
    ButtonTypeInfo("Kp0"),
    ButtonTypeInfo("Kpdot"),
    ButtonTypeInfo("Zenkakuhankaku"),
    ButtonTypeInfo("102Nd"),
    ButtonTypeInfo("F11"),
    ButtonTypeInfo("F12"),
    ButtonTypeInfo("Ro"),
    ButtonTypeInfo("Katakana"),
    ButtonTypeInfo("Hiragana"),
    ButtonTypeInfo("Henkan"),
    ButtonTypeInfo("Katakanahiragana"),
    ButtonTypeInfo("Muhenkan"),
    ButtonTypeInfo("Kpjpcomma"),
    ButtonTypeInfo("Kpenter"),
    ButtonTypeInfo("Rightctrl"),
    ButtonTypeInfo("Kpslash"),
    ButtonTypeInfo("Sysrq"),
    ButtonTypeInfo("Rightalt"),
    ButtonTypeInfo("Linefeed"),
    ButtonTypeInfo("Home"),
    ButtonTypeInfo("Up"),
    ButtonTypeInfo("Pageup"),
    ButtonTypeInfo("Left"),
    ButtonTypeInfo("Right"),
    ButtonTypeInfo("End"),
    ButtonTypeInfo("Down"),
    ButtonTypeInfo("Pagedown"),
    ButtonTypeInfo("Insert"),
    ButtonTypeInfo("Delete"),
    ButtonTypeInfo("Macro"),
    ButtonTypeInfo("Mute"),
    ButtonTypeInfo("Volumedown"),
    ButtonTypeInfo("Volumeup"),
    ButtonTypeInfo("Power"),
    ButtonTypeInfo("Kpequal"),
    ButtonTypeInfo("Kpplusminus"),
    ButtonTypeInfo("Pause"),
    ButtonTypeInfo("Scale"),
    ButtonTypeInfo("Kpcomma"),
    ButtonTypeInfo("Hangeul"),
    ButtonTypeInfo("Hanja"),
    ButtonTypeInfo("Yen"),
    ButtonTypeInfo("Leftmeta"),
    ButtonTypeInfo("Rightmeta"),
    ButtonTypeInfo("Compose"),
    ButtonTypeInfo("Stop"),
    ButtonTypeInfo("Again"),
    ButtonTypeInfo("Props"),
    ButtonTypeInfo("Undo"),
    ButtonTypeInfo("Front"),
    ButtonTypeInfo("Copy"),
    ButtonTypeInfo("Open"),
    ButtonTypeInfo("Paste"),
    ButtonTypeInfo("Find"),
    ButtonTypeInfo("Cut"),
    ButtonTypeInfo("Help"),
    ButtonTypeInfo("Menu"),
    ButtonTypeInfo("Calc"),
    ButtonTypeInfo("Setup"),
    ButtonTypeInfo("Sleep"),
    ButtonTypeInfo("Wakeup"),
    ButtonTypeInfo("File"),
    ButtonTypeInfo("Sendfile"),
    ButtonTypeInfo("Deletefile"),
    ButtonTypeInfo("Xfer"),
    ButtonTypeInfo("Prog1"),
    ButtonTypeInfo("Prog2"),
    ButtonTypeInfo("Www"),
    ButtonTypeInfo("Msdos"),
    ButtonTypeInfo("Coffee"),
    ButtonTypeInfo("Direction"),
    ButtonTypeInfo("Cyclewindows"),
    ButtonTypeInfo("Mail"),
    ButtonTypeInfo("Bookmarks"),
    ButtonTypeInfo("Computer"),
    ButtonTypeInfo("Back"),
    ButtonTypeInfo("Forward"),
    ButtonTypeInfo("Closecd"),
    ButtonTypeInfo("Ejectcd"),
    ButtonTypeInfo("Ejectclosecd"),
    ButtonTypeInfo("Nextsong"),
    ButtonTypeInfo("Playpause"),
    ButtonTypeInfo("Previoussong"),
    ButtonTypeInfo("Stopcd"),
    ButtonTypeInfo("Record"),
    ButtonTypeInfo("Rewind"),
    ButtonTypeInfo("Phone"),
    ButtonTypeInfo("Iso"),
    ButtonTypeInfo("Config"),
    ButtonTypeInfo("Homepage"),
    ButtonTypeInfo("Refresh"),
    ButtonTypeInfo("Exit"),
    ButtonTypeInfo("Move"),
    ButtonTypeInfo("Edit"),
    ButtonTypeInfo("Scrollup"),
    ButtonTypeInfo("Scrolldown"),
    ButtonTypeInfo("Kpleftparen"),
    ButtonTypeInfo("Kprightparen"),
    ButtonTypeInfo("New"),
    ButtonTypeInfo("Redo"),
    ButtonTypeInfo("F13"),
    ButtonTypeInfo("F14"),
    ButtonTypeInfo("F15"),
    ButtonTypeInfo("F16"),
    ButtonTypeInfo("F17"),
    ButtonTypeInfo("F18"),
    ButtonTypeInfo("F19"),
    ButtonTypeInfo("F20"),
    ButtonTypeInfo("F21"),
    ButtonTypeInfo("F22"),
    ButtonTypeInfo("F23"),
    ButtonTypeInfo("F24"),
    ButtonTypeInfo("Playcd"),
    ButtonTypeInfo("Pausecd"),
    ButtonTypeInfo("Prog3"),
    ButtonTypeInfo("Prog4"),
    ButtonTypeInfo("Dashboard"),
    ButtonTypeInfo("Suspend"),
    ButtonTypeInfo("Close"),
    ButtonTypeInfo("Play"),
    ButtonTypeInfo("Fastforward"),
    ButtonTypeInfo("Bassboost"),
    ButtonTypeInfo("Print"),
    ButtonTypeInfo("Hp"),
    ButtonTypeInfo("Camera"),
    ButtonTypeInfo("Sound"),
    ButtonTypeInfo("Question"),
    ButtonTypeInfo("Email"),
    ButtonTypeInfo("Chat"),
    ButtonTypeInfo("Search"),
    ButtonTypeInfo("Connect"),
    ButtonTypeInfo("Finance"),
    ButtonTypeInfo("Sport"),
    ButtonTypeInfo("Shop"),
    ButtonTypeInfo("Alterase"),
    ButtonTypeInfo("Cancel"),
    ButtonTypeInfo("Brightnessdown"),
    ButtonTypeInfo("Brightnessup"),
    ButtonTypeInfo("Media"),
    ButtonTypeInfo("Switchvideomode"),
    ButtonTypeInfo("Kbdillumtoggle"),
    ButtonTypeInfo("Kbdillumdown"),
    ButtonTypeInfo("Kbdillumup"),
    ButtonTypeInfo("Send"),
    ButtonTypeInfo("Reply"),
    ButtonTypeInfo("Forwardmail"),
    ButtonTypeInfo("Save"),
    ButtonTypeInfo("Documents"),
    ButtonTypeInfo("Battery"),
    ButtonTypeInfo("Bluetooth"),
    ButtonTypeInfo("Wlan"),
    ButtonTypeInfo("Uwb"),
    ButtonTypeInfo("Unknown"),
    ButtonTypeInfo("VideoNext"),
    ButtonTypeInfo("VideoPrev"),
    ButtonTypeInfo("BrightnessCycle"),
    ButtonTypeInfo("BrightnessZero"),
    ButtonTypeInfo("DisplayOff"),
    ButtonTypeInfo("Wimax"),
    ButtonTypeInfo("Rfkill"),
    ButtonTypeInfo("Micmute"),
  ];
}

class ButtonTypeInfo {
  final String _code;
  final String name;
  ButtonTypeInfo(this._code, {this.name = ""});

  String getName() {
    if (name == "") {
      return _code;
    }
    return "($name) $_code";
  }

  String getCode() {
    return _code;
  }
}
