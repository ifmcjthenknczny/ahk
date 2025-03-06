#Persistent
#NoEnv
SetBatchLines, -1
SetTitleMatchMode, 2

; Function to adjust brightness
AdjustBrightness(Amount) {
    objWMI := ComObjGet("winmgmts:\\.\root\WMI").ExecQuery("SELECT * FROM WmiMonitorBrightnessMethods WHERE Active=TRUE")._NewEnum()
    while objWMI[mon] {
        mon.WmiSetBrightness(1, Min(Max(GetBrightness() + Amount, 0), 100))
    }
}

; Function to get current brightness
GetBrightness() {
    objWMI := ComObjGet("winmgmts:\\.\root\WMI").ExecQuery("SELECT * FROM WmiMonitorBrightness WHERE Active=TRUE")._NewEnum()
    while objWMI[mon]
        return mon.CurrentBrightness
    return 50 ; Default if unable to retrieve brightness
}

; Bind Scroll Lock to decrease brightness by 10
ScrollLock::
    AdjustBrightness(-10)
    return

; Bind Pause/Break to increase brightness by 10
Pause::
    AdjustBrightness(10)
    return
