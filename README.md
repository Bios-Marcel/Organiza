[![CircleCI](https://circleci.com/gh/Bios-Marcel/Organiza/tree/master.svg?style=svg)](https://circleci.com/gh/Bios-Marcel/Organiza/tree/master)

# Organiza
An attempt at writing a lightweight file manager for GTK3 using vala.

## Goals
* Focus on keyboard navigation
* Lightweight UI
  > The plan is to not overload the UI, therefore not every action will have a clickable item on the UI, but be bound to a keyboard shortcut instead
* Customizable keybindings
* Minimal configuration possibilities (finding the best possible defaults, whereas best means most useful to as many people as possible)
* Simple keybinding overview 
* The usual stuff
  * Delete file(s)/folder(s)
  * Copy file(s)/folder(s)
  * Move file(s)/folder(s)
  * Create file(s)/folder(s)
* Creation of links
* Triggering different actions per drag and drop
* Undo / Redo
* Controlling file permissions
* Listview for folders/files
  * Optionally display details (Date, size and so on)
* Multiple views
* Hide dotfiles
* Bookmarks
  * keybindings for bookmarks
* Overview of available drives


## Roadmap

### 0.0.1
#### Application
- [x] Displaying the file hierarchy
- [ ] Navigation by mouse and keyboard
  - [x] Up and down by keyboard
  - [ ] Up and down by mouse
#### Development
- [ ] Unit tests
  - [ ] Build Integration
- [ ] Run build on commit (Travis?)

### 0.0.2

*TODO*
