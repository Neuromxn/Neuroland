-- #######################################################################################
-- HYPRLAND CONFIG — LUA (новый стандарт конфигурации Hyprland)
-- Переносится один-в-один из старого hyprland.conf.
-- Справочник: https://wiki.hypr.land/Configuring/Lua/
--
-- Каждая директива конфига = вызов одноимённой функции:
--   key = value              ->  key(value)
--   блок { ... }             ->  f(function() ... return { ... } end)
--   привязка к переменной    ->  f.name("...")
--   $var в значениях         ->  var .. "..."
--
-- Запуск: hyprland --config ~/.config/hypr/hyprland.lua
-- #######################################################################################

----------------
--- ПЕРЕМЕННЫЕ ---
----------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "hyprlauncher"
local browser     = "vivaldi"

-- =================
--     MONITORS
-- =================

-- https://wiki.hypr.land/Configuring/Monitors/
monitor("DVI-D-1, 1366x768@60, 0x0, 1")
monitor("HDMI-A-1, 1920x1080@120, 1366x0, 1")
-- monitor("", "preferred", "auto", "auto") -- автонастройка

-- Главный монитор
workspace(1, { monitor = "HDMI-A-1", default = true })

-- ====================
--     AUTOSTART
-- ====================

exec_once("waybar")
exec_once("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
exec_once("swww-daemon")
exec_once("sh -c 'sleep 1 && waypaper --restore'")
exec_once("/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")
exec_once("/usr/libexec/hyprpolkitagent")

-- =============================
--     ENVIRONMENT VARIABLES
-- =============================

-- https://wiki.hypr.land/Configuring/Environment-variables/
env("XCURSOR_SIZE", "24")
env("HYPRCURSOR_SIZE", "24")

-- Тема оформления для Qt-приложений (qt5ct/qt6ct)
env("QT_QPA_PLATFORMTHEME", "qt5ct")
env("QT_STYLE_OVERRIDE", "kvantum")

-- ====================
--     PERMISSIONS
-- ====================

-- https://wiki.hypr.land/Configuring/Permissions/
-- Изменения требуют перезапуска Hyprland.
-- ecosystem(function() return { enforce_permissions = 1 } end)
-- permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-- =====================
--     LOOK AND FEEL
-- =====================

-- https://wiki.hypr.land/Configuring/Variables/

general(function() return {
    gaps_in = 5,
    gaps_out = 20,

    border_size = 3,

    -- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
    col_active_border = "rgba(a855f7ee) rgba(d8b4feee) 45deg",
    col_inactive_border = "rgba(595959aa)",

    -- Включить изменение размера окон перетаскиванием границ и гэпов
    resize_on_border = false,

    -- https://wiki.hypr.land/Configuring/Tearing/ перед включением
    allow_tearing = false,

    layout = "dwindle",
} end)

decoration(function() return {
    rounding = 10,
    rounding_power = 2,

    -- Прозрачность сфокусированных и несфокусированных окон
    active_opacity = 0.97,
    inactive_opacity = 0.95,

    shadow = {
        enabled = true,
        range = 5,
        render_power = 3,
        color = "rgba(1a1a1aee)",
    },

    -- https://wiki.hypr.land/Configuring/Variables/#blur
    blur = {
        enabled = true,
        size = 3,
        passes = 0,

        vibrancy = 0.1696,
    },
} end)

animations(function() return {
    enabled = true,

    -- Кривые анимаций: bezier.имя = { x0, y0, x1, y1 }
    bezier_easeOutQuint = { 0.23, 1, 0.32, 1 },
    bezier_easeInOutCubic = { 0.65, 0.05, 0.36, 1 },
    bezier_linear = { 0, 0, 1, 1 },
    bezier_almostLinear = { 0.5, 0.5, 0.75, 1 },
    bezier_quick = { 0.15, 0, 0.1, 1 },

    -- Анимации: animation.имя = { onoff, speed, curve [, style] }
    animation_global = { 1, 10, "default" },
    animation_border = { 1, 5.39, "easeOutQuint" },
    animation_windows = { 1, 4.79, "easeOutQuint" },
    animation_windowsIn = { 1, 4.1, "easeOutQuint", "popin 87%" },
    animation_windowsOut = { 1, 1.49, "linear", "popin 87%" },
    animation_fadeIn = { 1, 1.73, "almostLinear" },
    animation_fadeOut = { 1, 1.46, "almostLinear" },
    animation_fade = { 1, 3.03, "quick" },
    animation_layers = { 1, 3.81, "easeOutQuint" },
    animation_layersIn = { 1, 4, "easeOutQuint", "fade" },
    animation_layersOut = { 1, 1.5, "linear", "fade" },
    animation_fadeLayersIn = { 1, 1.79, "almostLinear" },
    animation_fadeLayersOut = { 1, 1.39, "almostLinear" },
    animation_workspaces = { 1, 1.94, "almostLinear", "fade" },
    animation_workspacesIn = { 1, 1.21, "almostLinear", "fade" },
    animation_workspacesOut = { 1, 1.94, "almostLinear", "fade" },
    animation_zoomFactor = { 1, 7, "quick" },
} end)

-- https://wiki.hypr.land/Configuring/Workspace-Rules/
-- "Умные гэпы" / без гэпов, когда окно одно (были закомментированы и в .conf):
-- workspace("w[tv1]", { gapsout = 0, gapsin = 0 })
-- workspace("f[1]", { gapsout = 0, gapsin = 0 })
-- windowrule({
--     name = "no-gaps-wtv1",
--     ["match:class"] = "",
--     ["match:float"] = false,
--     ["match:workspace"] = "w[tv1]",
--     border_size = 0,
--     rounding = 0,
-- })
-- windowrule({
--     name = "no-gaps-f1",
--     ["match:class"] = "",
--     ["match:float"] = false,
--     ["match:workspace"] = "f[1]",
--     border_size = 0,
--     rounding = 0,
-- })

-- https://wiki.hypr.land/Configuring/Dwindle-Layout/
dwindle(function() return {
    pseudotile = true,      -- главный переключатель псевдотайлинга (mainMod + P)
    preserve_split = true,  -- вам наверняка это нужно
} end)

-- https://wiki.hypr.land/Configuring/Master-Layout/
master(function() return {
    new_status = "master",
} end)

-- https://wiki.hypr.land/Configuring/Variables/#misc
misc(function() return {
    force_default_wallpaper = -1, -- 0 или 1, чтобы отключить обои с аниме-маскотами
    disable_hyprland_logo = false,
} end)

-- ====================
--     INPUT
-- ====================

input(function() return {
    kb_layout = "us,ru",
    kb_variant = "",
    kb_model = "",
    kb_options = "grp:alt_shift_toggle,grp_led:scroll",
    kb_rules = "",

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 .. 1.0, 0 — без изменений

    touchpad = {
        natural_scroll = false,
    },
} end)

-- https://wiki.hypr.land/Configuring/Gestures
gesture(3, "horizontal", "workspace")

-- Пример конфига для конкретного устройства
-- https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs
device("epic-mouse-v1", function() return {
    sensitivity = -0.5,
} end)

-- ====================
--     KEYBINDINGS
-- ====================

-- https://wiki.hypr.land/Configuring/Binds/

-- Привязки: bind.<модификаторы>[<клавиша>] = { <dispatcher>, <аргумент> }
-- (без модификаторов — bind[""])
bind.SUPER["q"] = { "exec", terminal .. " --override background_opacity=0.1" }
bind.SUPER["c"] = { "killactive" }
bind.SUPER["m"] = { "exec", "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit" }
bind.SUPER["e"] = { "exec", fileManager }
bind.SUPER["v"] = { "togglefloating" }
bind.SUPER["p"] = { "pseudo" }                                  -- dwindle
bind.SUPER["j"] = { "togglesplit" }                             -- dwindle
bind.SUPER["f"] = { "exec", browser }
bind[""]["F11"] = { "fullscreen" }
bind.SUPER_SHIFT["w"] = { "exec", "[float; center] waypaper" }
bind.SUPER["k"] = { "exec", "killall waybar && waybar &" }
bind.SUPER_ALT["s"] = { "exec", "steam" }
bind.SUPER_ALT["r"] = { "exec", "reaper" }
bind.SUPER_ALT["o"] = { "exec", "obsidian" }
bind.SUPER_ALT["c"] = { "exec", "code" }
bind.SUPER_SHIFT["m"] = { "exec", "kitty --override background_opacity=0 cmatrix -b -s -C magenta" }
bind.SUPER_SHIFT["a"] = { "exec", "kitty --class cava-desktop --override background_opacity=0 -e cava -p ~/.config/cava/desktop.conf" }
bind.SUPER_SHIFT["n"] = { "exec", "[float; center; size 820 450] kitty --hold --override background_opacity=0 neofetch --class kitty-fetch" }

-- Фокус стрелками (mainMod + arrows)
bind.SUPER["left"]  = { "movefocus", "l" }
bind.SUPER["right"] = { "movefocus", "r" }
bind.SUPER["up"]    = { "movefocus", "u" }
bind.SUPER["down"]  = { "movefocus", "d" }

-- Переключение рабочих столов mainMod + [1-9, 0->10]
for i = 1, 9 do
    bind.SUPER[tostring(i)] = { "workspace", tostring(i) }
end
bind.SUPER["0"] = { "workspace", "10" }

-- Перенос активного окна на рабочий стол mainMod + SHIFT + [1-9, 0->10]
for i = 1, 9 do
    bind.SUPER_SHIFT[tostring(i)] = { "movetoworkspace", tostring(i) }
end
bind.SUPER_SHIFT["0"] = { "movetoworkspace", "10" }

-- Специальный рабочий стол (scratchpad)
bind.SUPER["d"] = { "togglespecialworkspace", "magic" }
bind.SUPER_SHIFT["d"] = { "movetoworkspace", "special:magic" }

-- Скролл по рабочим столам mainMod + колесо мыши
bind.SUPER["mouse_down"] = { "workspace", "e+1" }
bind.SUPER["mouse_up"]   = { "workspace", "e-1" }

-- Движение/ресайз окон mainMod + ЛКМ/ПКМ
bindm.SUPER["mouse:272"] = "movewindow"
bindm.SUPER["mouse:273"] = "resizewindow"

-- Мультимедийные клавиши: громкость и яркость (bindel — срабатывает даже при заблокированном экране)
bindel[""]["XF86AudioRaiseVolume"] = { "exec", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" }
bindel[""]["XF86AudioLowerVolume"] = { "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" }
bindel[""]["XF86AudioMute"]        = { "exec", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" }
bindel[""]["XF86AudioMicMute"]     = { "exec", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" }
bindel[""]["XF86MonBrightnessUp"]  = { "exec", "brightnessctl -e4 -n2 set 5%+" }
bindel[""]["XF86MonBrightnessDown"] = { "exec", "brightnessctl -e4 -n2 set 5%-" }

-- Управление плеером (требуется playerctl)
bindl[""]["XF86AudioNext"]  = { "exec", "playerctl next" }
bindl[""]["XF86AudioPause"] = { "exec", "playerctl play-pause" }
bindl[""]["XF86AudioPlay"]  = { "exec", "playerctl play-pause" }
bindl[""]["XF86AudioPrev"]  = { "exec", "playerctl previous" }

-- Запуск приложений (аналог Win+R или лаунчер)
bind.SUPER["r"] = { "exec", "rofi -show drun" }

-- Переключение между открытыми окнами
bind.SUPER["Tab"] = { "exec", "rofi -show window" }

-- Выход из системы / перезагрузка
bind.SUPER["x"] = { "exec", "~/.config/rofi/powermenu.sh" }

-- ==============================
--     WINDOWS AND WORKSPACES
-- ==============================

-- https://wiki.hypr.land/Configuring/Window-Rules/

-- Игнорируем запросы maximize от всех приложений (обычно это удобнее)
windowrule({
    name = "suppress-maximize-events",
    ["match:class"] = ".*",
    suppress_event = "maximize",
})

-- Фикс проблем с перетаскиванием в XWayland
windowrule({
    name = "fix-xwayland-drags",
    ["match:class"] = "^$",
    ["match:title"] = "^$",
    ["match:xwayland"] = true,
    ["match:float"] = true,
    ["match:fullscreen"] = false,
    ["match:pin"] = false,
    no_focus = true,
})

-- Hyprland-run windowrule
windowrule({
    name = "move-hyprland-run",
    ["match:class"] = "hyprland-run",
    move = "20 monitor_h-120",
    float = true,
})
