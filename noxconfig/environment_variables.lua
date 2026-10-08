-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("HYPRCURSOR_THEME","Catppuccin Macchiato Green")
-- for QT themed stuff like dolphin
hl.env("QT_QPA_PLATFORMTHEME","qt6ct")

-- nvidia environment variables
hl.env("LIBVA_DRIVER_NAME","nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME","nvidia")
hl.env("SDL_VIDEODRIVER","wayland")
hl.env("GBM_BACKEND","nvidia-drm")

hl.env("ELECTRON_OZONE_PLATFORM_HINT","auto")

-- maybe fix shader cache issues?
hl.env("__GL_SHADER_DISK_CACHE_SIZE","12000000000")

-- Pin the compositor to the monitor GPU, independent of card enumeration order.
-- This alias follows the persistent PCI by-path link and contains no colons
-- (AQ_DRM_DEVICES uses colons to separate devices). Requires a new login session.
hl.env("AQ_DRM_DEVICES", os.getenv("HOME") .. "/.config/hypr/display-gpu")
-- hl.env("AQ_FORCE_LINEAR_BLIT", "0")
