FW = require'nw'
FW.app_id = "AddonForge"
winapi = require("winapi")
require("winapi.filedialogs")
require('winapi.monitor')
require('winapi.cursor')
require('winapi.windowclass')
require('winapi.menuclass')
require('winapi.buttonclass')
require('winapi.toolbarclass')
require('winapi.groupboxclass')
require('winapi.checkboxclass')
require('winapi.radiobuttonclass')
require('winapi.editclass')
require('winapi.tabcontrolclass')
require('winapi.listboxclass')
require('winapi.comboboxclass')
require('winapi.labelclass')
require('winapi.listviewclass')
require('winapi.bitmappanel')
local bitmap = require('bitmap')
APP = FW:app()
APP:autoscaling(false)

WIN = APP:window({
	x = 400,
	y = 400,
	w = 300,
	h = 200,
	title = "AddonForge"
})

WinObject = WIN.backend.win
WIN:client_size(800, 600)

function FileSelect(info, ft)
	local ret = {
		APP:opendialog({
			title = "AddonForge | " .. info,
			filetypes = {ft},
			initial_dir = "C:\\"
		})
	}

	if #ret == 0 then return end

	return ret
end

function timer(time, func)
	APP:runevery(time, func)
end

function ActivateApp()
	APP:run()
end

local text = winapi.Label({
	text = "TEST",
	parent = WinObject,
	w = 100,
	h = 100
})

bmppanel = winapi.BitmapPanel({
	w = 256,
	h = 256,
	x = 100,
	y = 200,
	parent = WinObject
})

function WIN:click(button, count)
	openimg(ret[1])
end