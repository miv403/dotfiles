# dotfiles

> miv403's configuration files

```bash
systemctl --user add-wants niri.service mako.service
```

## current usage

![screenshot](.img/screenshot-00.png)

### desktop

- niri
- waybar
  - calendar at-a-glance
  - clipboard
  - detailed temperature and fan info
  - weather with wttr.in
- mako
  - volume/brightness indicator (volumeosd/brightnessosd)
- fuzzel
  - org capture (fuzzel-capture)
  - clipboard (cliphist)
- niri-ocr: uses tesseract for turkish&english image-to-text extraction
- [selectra](https://github.com/miv403/selectra): tureng dictionary lookup with notification
- [rofi-tdk.sh](https://github.com/metwse/rofi-tdk.sh): tdk sözlük for rofi
- [project manager](https://github.com/miv403/project-manager): project switcher/manager with fuzzel.
- quick launchers
  - agenda: launches org-mode agenda view
  - calendar: launches `ikhal`
  - finder: search `$HOME` with fd, uses fuzzel to enumerate results
  - library: *finder* but looks in `$LIBRARY_DIR`
  - seeker: enumerates opened niri windows via fuzzel and seeks to selected one.

### terminal

- alacritty
- tmux
  - scratchpad
- nvim

### calendar/agenda

- doom: org agenda
- khal: calendar
- vdirsyncer: google calendar sync
