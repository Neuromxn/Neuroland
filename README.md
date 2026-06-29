# Neuroland
Hyprland Ubuntu 26.04 rice dots
# Instalation
### 1.Install Hyprland
```bash
sudo apt install hyprland
```
### 2.Install dependencies
```bash
sudo apt install waybar rofi dunst swaylock swayidle kitty pavucontrol
```
##### Fonts
```bash
sudo apt install fonts-jetbrains-mono fonts-font-awesome
```
##### VS Code Install (snap)
```bash
sudo snap install code --classic
```
##### or
##### VS Code Install (official repository)
```bash
sudo apt update
sudo apt install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
```
```bash
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
```
```bash
sudo apt update
sudo apt install code
```
##### Fix screen capture for OBS, Discord
```bash
sudo apt install xdg-desktop-portal-hyprland xpg-desktop-portal-gtk
```
##### For QT5-6, GTK3-4 customization
```bash
sudo apt install nwg-look qt5ct qt6ct
```
##### swww for static wallpapers (optional)
```bash
sudo apt install git cargo libwayland-dev wayland-protocols libxkbcommon-dev
```
```bash
git clone https://github.com/LGFae/swww.git
~/swww
cd ~/swww
```
```bash
cargo build --release
sudo cp target/release/swww/ usr/local/bin/
sudo cp target/release/swww-daemon /usr/local/bin/
```
##### Install waypaper (guiutil for change wallpapers)
```bash
sudo apt install libcairo2-dev libgirepository1.0-dev libgirepository-2.0-dev pkg-config python3-dev python3-gi python3-gi-cairo gir1.2-gtk-3.0
```
```bash
sudo apt install pipx
pipx ensurepath
```
```bash
pipx install waypaper
source ~/.bashrc
```
```bash
pipx ensurepath
ource ~/.bashrc
```
##### Install mpvpaper for live wallpapers
```bash
sudo apt install libmpv-dev ninja-build meson git
```
```bash
git clone --single-branch https://github.com/GhostNaN/mpvpaper
cd mpvpaper
meson setup build --prefix=/usr/local
ninja -C build
sudo ninja -C build install
```



