ffi = require("ffi")
glue = require'glue'

ffi.cdef("int printf(const char *fmt, ...);")
printf = ffi.C.printf

function printt( t, indent, done )

	done = done or {}
	indent = indent or 0
	local keys = glue.keys( t )

	table.sort( keys, function( a, b )
		if ( type(a) == "number" and type(b) == "number" ) then return a < b end
		return tostring( a ) < tostring( b )
	end )

	done[ t ] = true

	for i = 1, #keys do
		local key = keys[ i ]
		local value = t[ key ]
		printf( string.rep( "\t", indent ) )

		if  ( type(value) == "table" and not done[ value ] ) then

			done[ value ] = true
			printf( tostring( key ) .. ":" .. "\n" )
			printt( value, indent + 2, done )
			done[ value ] = nil

		else

			printf( tostring( key ) .. "\t=\t" )
			printf( tostring( value ) .. "\n" )

		end

	end

end

function decary(bin)
	bin = string.reverse(bin)
	local sum = 0

	for i = 1, string.len(bin) do
	  num = string.sub(bin, i,i) == "1" and 1 or 0
	sum = sum + num * math.pow(2, i-1)

	end
	return sum
end

function GetChroma(path)
	local ChromaHeader = " 0 17 8 %d+ %d+ %d+ %d+ 3 1 %d+ "
	local found = ""
	for k in string.gmatch(IntToChar(glue.readfile(path)), ChromaHeader) do
		found = k
	end
	if not found then return end
	found = string.gsub(found," 0 17 8 %d+ %d+ %d+ %d+ 3 1 ","")
	found = found:sub(0,-2)

	if found == "17" then -- 1 1
		return "4:4:4"
	elseif found == "33" then -- 2 1
		return "4:2:2"
	elseif found == "34" then -- 2 2
		return "4:2:0"
	end
	return found
end


function IntToChar(text)
	local exit = ""
	local tbl = {}
	local array = ffi.cast("const char*",text)
	for I=1,#text do table.insert(tbl,tonumber(array[I-1])) end
	exit = table.concat(tbl, " ")
	return exit
end


function string.Explode(s)
	local t = {}
	for k in string.gmatch(s,"%d+") do table.insert(t,k) end

	return t
end

function CharToInt(text)
	local exit = ""
	local exp = string.Explode(text)
	for k,v in pairs(exp) do exit = exit..string.char(v) end
	return exit
end

print(ASCIIDecode(ASCIIEncode("HELLO")))