------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- We need 6 monitor settings because of 2 graphics cards
-- Depending on which card gets detected first, output names
-- may change

hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@75",
    position = "-1920x0",
    scale    = 1,
})

hl.monitor({
    output   = "DP-3",
    mode     = "1920x1080@143.98",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@75",
    position = "1920x0",
    scale    = 1,
})

------

hl.monitor({
    output   = "DP-5",
    mode     = "1920x1080@75",
    position = "-1920x0",
    scale    = 1,
})

hl.monitor({
    output   = "DP-6",
    mode     = "1920x1080@143.98",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output   = "DP-4",
    mode     = "1920x1080@75",
    position = "1920x0",
    scale    = 1,
})
