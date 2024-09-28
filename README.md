<h2 align="center">
	Hyprland dotfiles
</h2>
<br>
<div align="center">
  <a href="#installation"><kbd> <br> Installation <br> </kbd></a>&ensp;&ensp;
  <a href="#gallery"><kbd> <br> Gallery <br> </kbd></a>&ensp;&ensp;
  <a href="#themes"><kbd> <br> Themes <br> </kbd></a>&ensp;&ensp;
  <a href="#keybinds"><kbd> <br> Keybinds <br> </kbd></a>&ensp;&ensp;
  <a href="https://github.com/NotMugil/dotfiles/wiki"><kbd> <br> Wiki <br> </kbd></a>&ensp;&ensp;
</div><br>

![showcase](.github/assets/showcase.png)
<br>
<div align="center">
<p>
<a href="https://github.com/NotMugil/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/NotMugil/dotfiles?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=C9CBFF&labelColor=302D41" alt="stars"><a>&nbsp;&nbsp;
<a href="https://github.com/NotMugil/dotfiles/issues"><img alt="GitHub Issues or Pull Requests" src="https://img.shields.io/github/issues/NotMugil/dotfiles?style=for-the-badge&logo=gitbook&color=A6E3A1&logoColor=A6E3A1&labelColor=302D41"></a>&nbsp;&nbsp;
<a href="https://github.com/NotMugil/dotfiles/"><img src="https://img.shields.io/github/repo-size/NotMugil/dotfiles?style=for-the-badge&logo=hyprland&logoColor=f9e2af&label=Size&labelColor=302D41&color=f9e2af" alt="REPO SIZE"></a>&nbsp;&nbsp;
<a href="https://github.com/NotMugil/dotfiles/commits/main/"><img src="https://img.shields.io/github/last-commit/NotMugil/dotfiles?style=for-the-badge&logo=github&logoColor=eba0ac&label=Last%20Commit&labelColor=302D41&color=eba0ac" alt="Last Commit"></a>&nbsp;&nbsp;
<a href="https://github.com/NotMugil/dotfiles?tab=GPL-3.0-1-ov-file"><img src="https://img.shields.io/github/license/NotMugil/dotfiles?style=for-the-badge&logo=&color=CBA6F7&logoColor=CBA6F7&labelColor=302D41" alt="LICENSE"></a>&nbsp;&nbsp;
</p>
</div>

## Installation

To install, execute the following commands:
```shell
curl -O install.sh https://raw.githubusercontent.com/NotMugil/dotfiles/main/install.sh
chmod +x install.sh
./install.sh
```

> [!TIP]
> You can use the installation script in different ways depending on your needs:

```
./install.sh -f, --full     : Installs Hyprland along with my custom configurations.
./install.sh -b, --base     : Installs only Hyprland without any custom configurations.
./install.sh -c, --config    : Copies my dotfiles to your home directory without installing anything else.
./install.sh -s, --services : Activates essential system services.
```

## Gallery
>[!NOTE] 
> Images included in the gallery may contain some softwares which may not be included in the packages list or the configurations.

|  **Lockscreen**                                          |
| -------------------------------------------------------- |
| ![gallery-1](.github/assets/gallery-01.png)              |

| **Neofetch & Thunar**                                    |
| -------------------------------------------------------- |
| ![gallery-7](.github/assets/gallery-07.png)              |

| **Wlogout logout menu**   			           |
| -------------------------------------------------------- |
| ![gallery-4](.github/assets/gallery-014png)              |

| **Rofi Application Launcher**                            |
| -------------------------------------------------------- |
| ![gallery-5](.github/assets/gallery-05.png)              |

| **Wallpaper Selector**                                   |
| -------------------------------------------------------- |
| ![gallery-2](.github/assets/gallery-02.png)              |

| **Notification Center (SwayNC)**                         |
| -------------------------------------------------------- |
| ![gallery-6](.github/assets/gallery-06.png)              |

## Keybinds
>[!NOTE] 
> Please note that some of these keybinds may be outdated or have been updated. I will do my best to keep this list current. For the most recent and working keybinds, please check the config file.

| Keys           		              	| Functionality                                                                   |
|-----------------------------------------------|---------------------------------------------------------------------------------|
| <kbd>SUPER</kbd> + <kbd>RETURN</kbd>          | Launch Kitty				                                          |
| <kbd>SUPER</kbd> + <kbd>D</kbd>		| Launch Rofi 				    	                                  |
| <kbd>SUPER</kbd> + <kbd>E</kbd>      		| Launch Thunar File Manager	 	                                          |
| <kbd>SUPER</kbd> + <kbd>B</kbd>     	        | Launch Browser                                                                  |
| <kbd>SUPER</kbd> + <kbd>C</kbd>          	| Launch text editor   		                                                  |
| <kbd>SUPER</kbd> + <kbd>Q</kbd>         	| Kill active window                                                              |
| <kbd>SUPER</kbd> + <kbd>/</kbd>          	| Opens keybinds hint		                                                  |
| <kbd>SUPER</kbd> + <kbd>W</kbd>          	| Opens wallpaper selector                                                        |
| <kbd>SUPER</kbd> + <kbd>U</kbd>          	| Opens waybar selector                                                           |
| <kbd>SUPER</kbd> + <kbd>R</kbd>          	| Chooses random wallpaper from dir                                               |
| <kbd>SUPER</kbd> + <kbd>V</kbd>          	| Toggle floating window  	                                                  |
| <kbd>SUPER</kbd> + <kbd>L</kbd>          	| Launch Lockscreen                                                     	  |
| <kbd>SUPER</kbd> + <kbd>M</kbd>          	| Launch wlogout                                        		          |
| <kbd>SUPER</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>| Opens sway notification center 	                                          |
| <kbd>SUPER</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>| Launch theme selector	 	                                          |
| <kbd>Alt</kbd> + <kbd>RETURN</kbd>            | Toggle between focused window to fullscreen                                     |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>| Toggle waybar 		                                                  |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Delete</kbd>| Kill hyprland 		                                                  |
| <kbd>Print</kbd>				| Take screenshot of entire area		                                  |
| <kbd>Ctrl</kbd> + <kbd>Print</kbd>		| Take screenshot of screen			    	                          |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Print</kbd>		| Take screenshot of selected area			          |

For a complete list, checkout [wiki](https://github.com/NotMugil/dotfiles/wiki/Keybindings) or refer to `~/.config/hypr/configs/binds.conf`.

## Star History

<a href="https://github.com/NotMugil/dotfiles/stargazers">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=NotMugil/dotfiles&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=NotMugil/dotfiles&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=NotMugil/dotfiles&type=Date" />
 </picture>
</a>

## Credits

- [Catppuccin](https://github.com/catppuccin/catppuccin) 
- [JaaKoolit's dotfiles](https://github.com/Jakoolit/hyprland-dots) 
- [Matt-ftw's dotfiles](https://github.com/Matt-ftw/dotfiles) 
- [gh0stzk's dotfiles](https://github.com/gh0stzk/dotfiles)
- [Hyprdots](https://github.com/prasanthrangan/hyprdots)
- [HyprNova](https://github.com/zDyanTB/HyprNova) 

_Thanks a lot for [r/unixporn](https://www.reddit.com/r/unixporn/) community for inspiring me to do this._

## To-do

- [ ] Better wallpaper selector theme
- [ ] Ease the task of changing username/home dir name
- [x] ~~Update Readme~~
- [x] ~~Update gallery images~~
- [ ] Configure themes for ~~wlogout~~, nvim, spicetify, firefox
