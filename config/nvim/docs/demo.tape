Output docs/demo.gif

Set Width 1200
Set Height 600
Set FontSize 16
Set FontFamily "JetBrainsMono Nerd Font"
Set Padding 4
Set Theme "tokyonight"
Set Framerate 30
Set PlaybackSpeed 1
Set TypingSpeed 40ms

Sleep 500ms
Type "nvim lua/plugins/snacks.lua"
Enter
Sleep 1s

Space
Sleep 1s
Escape
Sleep 500ms

Space
Type "cd"
Sleep 1s
Alt+h
Sleep 500ms
Alt+h
Sleep 500ms
Escape
Sleep 1s

Type ":e /tmp/vhs-demo.lua"
Enter
Sleep 500ms
Type "o"
Type "  print('format on save')"
Sleep 500ms
Escape
Sleep 500ms
Space
Type "s"
Type "s"
Sleep 1s

Type ":e lua/plugins/snacks.lua"
Enter
Sleep 500ms
Type "o"
Type "vim."
Sleep 1s
Escape
Type "u"
Sleep 500ms

Space
Type "f"
Sleep 800ms
Type "f"
Sleep 1s
Type "snacks"
Sleep 1s
Enter
Sleep 1s

Space
Type "q"
Enter
