# Custom Layout
Using a cusotm layout on Arch Linux.

## Customize the BR layout
Edit the br symbols file to include the custom symbols layout:

```bash
sudoedit /usr/share/X11/xkb/symbols/br
```

Insert:

```
// Jhon CUstom Keyboard
// by Jhon
//
partial alphanumeric_keys
xkb_symbols "jhon" {

    include "br(abnt2)"
    name[Group1]="Portuguese (Brazil, Jhon)";

    key <RCTL> { [        slash,       question,        degree,    questiondown ] };
    key <LSGT> { [ Control_L ] };
    key <LCTL> { [ backslash, bar ] };
    key <AB03> { [ c, C, ccedilla, Ccedilla ]};
    key <AC10> { [ Control_R, ccedilla ] };
    key <CAPS> { [ Escape ] };
    key <ESC>  { [ apostrophe, quotedbl, notsign, notsign ] };
};
```

## Update XKB Base.xml
Update the rules base.xml:

```
sudoedit /usr/share/X11/xkb/rules/base.xml
```
Insert under BR layout variantList:

```
        <variant>
          <configItem>
            <name>jhon</name>
            <description>Portuguese (Brazil, Jhon)</description>
          </configItem>
        </variant>
```

## Update XKB Base.lst
Update the rules base.lst:

```
sudoedit /usr/share/X11/xkb/rules/base.lst
```

Insert:

```
jhon            br: Portuguese (Brazil, Jhon)
```

## Set the layout:
Run the following command:
```sh
sudo localectl set-x11-keymap br pc105 jhon
```
## References
- [[https://stackoverflow.com/questions/45021978/create-a-custom-setxkbmap-option]]
