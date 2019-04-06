require("util")
local nw = require'nw'
local fs = require'fs'
nw.app_id = "AddonForge"
winapi = require("winapi")
require("winapi.filedialogs")
require'winapi.monitor'
require'winapi.cursor'
require'winapi.windowclass'
require'winapi.menuclass'
require'winapi.buttonclass'
require'winapi.toolbarclass'
require'winapi.groupboxclass'
require'winapi.checkboxclass'
require'winapi.radiobuttonclass'
require'winapi.editclass'
require'winapi.tabcontrolclass'
require'winapi.listboxclass'
require'winapi.comboboxclass'
require'winapi.labelclass'
require'winapi.listviewclass'
require'winapi.bitmappanel'
local ex = require('libexif')
local bitmap = require'bitmap'
local libjpeg = require'libjpeg'
local app = nw:app()

app:autoscaling(false)

local win = app:window{
		x = 400, --center the window on its parent
		y = 400,
		w = 300,
		h = 200,
		title = "LuaWorkshopper 2.0",
}

win:client_size(800,600)



	local text = winapi.Label({text="TEST",parent = win.backend.win,w=100,h=100})
	local bmppanel = winapi.BitmapPanel{w = 256, h = 256, x = 100, y = 200, parent = win.backend.win}
function win:click(button, count)
	local ret = {app:opendialog({
		title = 'AddonForge | Select icon for your addon',
		filetypes = {'jpg'},
		-- path = path,
	})}
	if #ret == 0 then return end
	openimg(ret[1])

--openimg(path)
end
--0x3156140




function openimg(path)
	local f = assert(fs.open(path))
	local left = 1024 * 1024
	local function read(buf, sz)
		if left == 0 then return 0 end
		local sz = math.min(left, sz)
		local readsz
		if buf then
			readsz = assert(f:read(buf, sz))
		else
			local pos0 = assert(f:seek())
			local pos1 = assert(f:seek(sz))
			readsz = pos1 - pos0
		end
		left = left - readsz
		return readsz
	end
	local img, err = libjpeg.open{
		read = read,
		partial_loading = true,
		suspended_io = false
	}
	if not img then err = 'open '..err end
	local bmp = img:load()
	img:free()
	
	if bmppanel then bmppanel:free() end
	bmppanel = winapi.BitmapPanel{w = 256, h = 256, x = 100, y = 200, parent = win.backend.win}
	function bmppanel:on_bitmap_paint(a)
		bmp = bitmap.copy(bmp,"bgra8")
		bitmap.resize.nearest(bmp,a)
		-- bitmap.paint(a,bmp)
	end
	f:close()
	win.chroma = GetChroma(path)

end
-- openimg("C:\\Users\\Spar\\Desktop\\windows10.jpg")



-- win:show()

app:runevery(0,function() if not win.chroma or text.text == win.chroma then return end text.text = win.chroma or "no chroma" end)
app:run()

-- local ExifData = ex.exif_data_new_from_file('media/jpeg/autumn-wallpaper.jpg')

-- local ExifData = ex.read(glue.readfile("C:\\Users\\Spar\\Desktop\\test5.jpg"))
-- print(ExifData)
-- if ExifData then
-- 	local tags = ExifData:get_tags()

-- 	printt(tags)
-- 	ExifData:free()
-- else
-- 	print("Not Valid")
-- end


-- local ed = ex.read(glue.readfile("C:\\Users\\Spar\\Desktop\\test10_400.jpg"))