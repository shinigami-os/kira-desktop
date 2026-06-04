/* ===============================================
    Kira Linux - GTK3 theme
    Applied via ~/.config/gtk-3.0/gtk.css
    Changes require re-login to take full effect.
   ===============================================*/

/* -- Base colors -- */

@define-color base          %base%;
@define-color surface0      %surface0%;
@define-color surface1      %surface1%;
@define-color surface2      %surface2%;
@define-color overlay       %overlay%;
@define-color muted         %muted%;
@define-color text          %text%;
@define-color subtext       %subtext%;
@define-color primary       %primary%;
@define-color primary_dim   %primary_dim%;
@define-color secondary     %secondary%;
@define-color green         %green%;
@define-color yellow        %yellow%;

/* -- Window --*/

window,
.background {
    background-color: @base;
    color: @text;
}

/* -- Header bar -- */

headerbar,
.titlebar {
    background-color: @surface0;
    color: @text;
    border-bottom: 1px solid @surface2;
    box-shadow: none;
}

headerbar button,
.titlebar button {
    background: transparent;
    color: @subtext;
    border: none;
    border-radius: 6px;
    padding: 4px 8px;
}

headerbar button:hover,
.titlebar button:hover {
    background-color: @surface1;
    color: @text;
}

headerbar button:active,
.titlebar button:active {
    background-color: @overlay;
    color: @primary;
}

/* Close button */
headerbar button.titlebutton.close,
.titlebar button.titlebutton.close {
    color: @secondary;
}

headerbar button.titlebutton.close:hover,
.titlebar button.titlebutton.close:hover {
    background-color: @secondary;
    color: @base;
}

/* -- Sidebar --*/

.sidebar,
placessidebar {
    background-color: @surface0;
    color: @text;
    border-right: 1px solid @surface2;
}

.sidebar row,
placessidebar row {
    border-radius: 6px;
    padding: 2px 4px;
}

.sidebar row:hover,
placessidebar row:hover {
    background-color: @surface1;
}

.sidebar row:selected,
placessidebar row:selected {
    background-color: @overlay;
    color: @primary;
}

/* -- Buttons --*/

button {
    background-color: @surface1;
    color: @text;
    border: 1px solid @surface2;
    border-radius: 6px;
    padding: 6px 12px;
    box-shadow: none;
}

button:hover {
    background-color: @overlay;
    color: @text;
    border-color: @primary_dim;
}

button:active,
button:checked {
    background-color: @primary;
    color: @base;
    border-color: @primary;
}

button.suggested-action {
    background-color: @primary;
    color: @base;
    border-color: @primary;
}

button.suggested-action:hover {
    background-color: @primary_dim;
}

button.destructive-action {
    background-color: @secondary;
    color: @base;
    border-color: @secondary;
}

/* -- Entries (text inputs) -- */

entry {
    background-color: @surface1;
    color: @text;
    border: 1px solid @surface2;
    border-radius: 6px;
    padding: 6px 10px;
    box-shadow: none;
    caret-color: @primary;
}

entry:focus {
    border-color: @primary;
    box-shadow: 0 0 0 2px alpha(@primary, 0.25);
}

entry selection {
    background-color: @primary;
    color: @base;
}

/* -- Lists and rows -- */

list,
listbox {
    background-color: @base;
    color: @text;
}

row {
    padding: 6px 8px;
}

row:hover {
    background-color: @surface1;
}

row:selected {
    background-color: @overlay;
    color: @primary;
}

/* -- Menus -- */

menu,
.menu,
.context-menu {
    background-color: @surface1;
    color: @text;
    border: 1px solid @surface2;
    border-radius: 8px;
    padding: 4px;
    box-shadow: 0 4px 16px alpha(@base, 0.8);
}

menuitem {
    border-radius: 6px;
    padding: 6px 12px;
}

menuitem:hover {
    background-color: @overlay;
    color: @primary;
}

menuitem:disabled {
    color: @muted;
}

separator.horizontal {
    background-color: @surface2;
    min-height: 1px;
    margin: 4px 8px;
}

/* -- Popovers -- */

popover {
    background-color: @surface1;
    border: 1px solid @surface2;
    border-radius: 8px;
    box-shadow: 0 4px 16px alpha(@base, 0.8);
}

popover > arrow {
    background-color: @surface1;
    border-color: @surface2;
}

/* -- Notebook (tabs) -- */

notebook > header {
    background-color: @surface0;
    border-bottom: 1px solid @surface2;
}

notebook > header tab {
    background-color: transparent;
    color: @muted;
    border-radius: 6px 6px 0 0;
    padding: 6px 16px;
}

notebook > header tab:hover {
    color: @text;
    background-color: @surface1;
}

notebook > header tab:checked {
    background-color: @surface1;
    color: @primary;
    border-bottom: 2px solid @primary;
}

/* -- Scrollbars -- */

scrollbar {
    background-color: transparent;
}

scrollbar slider {
    background-color: @surface2;
    border-radius: 4px;
    min-width: 4px;
    min-height: 4px;
}

scrollbar slider:hover {
    background-color: @muted;
}

scrollbar slider:active {
    background-color: @primary_dim;
}

/* -- Progress bars -- */

progressbar trough {
    background-color: @surface2;
    border-radius: 4px;
    min-height: 6px;
}

progressbar progress {
    background-color: @primary;
    border-radius: 4px;
}

/* -- Check and radio buttons -- */

checkbutton check,
radiobutton radio {
    background-color: @surface1;
    border: 1px solid @surface2;
    border-radius: 4px;
}

checkbutton check:checked,
radiobutton radio:checked {
    background-color: @primary;
    border-color: @primary;
    color: @base;
}

checkbutton check:hover,
radiobutton radio:hover {
    border-color: @primary_dim;
}

/* -- Tooltips -- */

tooltip {
    background-color: @surface1;
    color: @text;
    border: 1px solid @surface2;
    border-radius: 6px;
    padding: 4px 8px;
}

/* -- Switches -- */

switch {
    background-color: @surface2;
    border-radius: 14px;
    min-width: 40px;
    min-height: 20px;
}

switch:checked {
    background-color: @primary;
}

switch slider {
    background-color: @text;
    border-radius: 50%;
    min-width: 16px;
    min-height: 16px;
}

/* -- File chooser -- */

.path-bar button {
    background-color: @surface1;
    border-radius: 6px;
    color: @subtext;
}

.path-bar button:hover {
    color: @text;
    background-color: @overlay;
}

.path-bar button.highlighted {
    color: @primary;
}
