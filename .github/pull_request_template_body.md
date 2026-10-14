# Миграция конфига Hyprland на новый Lua-стандарт + реконструкция dotfiles

**Branch:** `feat/hyprland-lua-migration` → `main`

## Что делает этот PR

Переписывает основной конфиг Hyprland под **новый стандарт конфигурации — язык Lua** и попутно чинит найденные ошибки в остальных конфигах риса.

### 1. Hyprland: `.conf` → `.lua` (основное изменение)

- Создан **`.config/hypr/hyprland.lua`** — полный перенос содержимого старого конфига в идиоматичном Lua-стиле (Hyprland использует Lua 5.4):
  - директивы → вызовы функций: `monitor(...)`, `exec_once(...)`, `env(...)`, `gesture(...)`;
  - блоки переменных → функции, возвращающие таблицы: `general(function() return {...} end)`, `decoration(...)` (с вложенными `shadow`/`blur`), `input(...)`, `dwindle(...)`, `master(...)`, `misc(...)`, `animations(...)`;
  - `bezier` / `animation` → поля таблиц: `bezier_easeOutQuint = {0.23, 1, 0.32, 1}`, `animation_windowsIn = {1, 4.1, "easeOutQuint", "popin 87%"}`;
  - привязки → таблицы по модификаторам: `bind.SUPER["q"] = {"exec", ...}`, `bind.SUPER_SHIFT[...]`, `bindel[""]["XF86AudioMute"]`, `bindm.SUPER["mouse:272"] = "movewindow"`;
  - shell-переменные `$terminal/$fileManager/$browser` → настоящие Lua-переменные (`local terminal = "kitty"`);
  - per-device конфиг → `device("epic-mouse-v1", function() return { sensitivity = -0.5 } end)`;
  - windowrulev2-блоки → `windowrule({ name = ..., ["match:class"] = ... })`;
  - бонус Lua: workspace-привязки 1–9 и `movetoworkspace` сгенерированы циклом `for i = 1, 9 do ... end`.
- Удалён старый **`.config/hypr/hyprland.conf`**.

### 2. Реконструкция остальных конфигов

| Файл | Исправление |
|---|---|
| `hyprland.conf` (до удаления) | убрана лишняя `&` у `swww-daemon`; `sleep && waypaper --restore` обёрнут в `sh -c`; `export`-строка заменена на `env =`; устранён конфликт `QT_QPA_PLATFORMTHEME qt5ct/qt6ct` |
| `.config/rofi/config.rasi` | активная тема назначена явно: `@ ~/.config/rofi/themes/spotlight-dark.rasi` (в main не было ни одной активной темы — только закомментированные эксперименты с чужими путями `/home/neuroman/...`) → конфиг переносим; удалён мусор из ~20 закомментированных строк |
| `.config/waybar/style.css` | починен сломанный CSS: незакрытый `@keyframes flicker`, лишняя скобка, дубль `color` |
| `.config/rofi/powermenu.rasi` | файл был пустым (0 байт), хотя на него ссылается `powermenu.sh` — создана тема в стиле риса (Catppuccin Mocha) |
| `.config/rofi/powermenu.sh` | выставлен флаг исполнения `+x` |
| `.config/waypaper/config.ini` | несуществующая папка `~/Hidamari` и чужие пути `/home/neuroman/...` → `~/Видео/live_wallpaper` (как инструктирует README) |

## Верификация

- ✅ `luac5.4 -p hyprland.lua` — синтаксис OK;
- ✅ автоматическая сверка: все 181 активная директива старого `.conf` присутствуют в `.lua`;
- ✅ баланс `{}` во всех rasi/css/conf — 0; `waybar/config` — валидный JSON; `bash -n powermenu.sh` — OK;
- ✅ в конфигах не осталось следов `neuroman` / `Hidamari`.

## Статистика

```
9 files changed, 462 insertions(+), 431 deletions(-)
delete mode .config/hypr/hyprland.conf
create mode .config/hypr/hyprland.lua
```

## Примечание по запуску

Требует сборку Hyprland с поддержкой Lua-конфигов; при необходимости указать явно: `hyprland --config ~/.config/hypr/hyprland.lua`.
