





local io_lines=io.lines
local io_open=io.open
local pairs=pairs
local print=print
local debug=debug
local tonumber=tonumber
local setmetatable=setmetatable
local table_sort=table.sort
local table_insert=table.insert
local string_find=string.find
local string_sub=string.sub
local string_gsub=string.gsub
local string_format=string.format
local ffi=require("ffi")
local debug_getinfo=debug.getinfo
local os_clock=os.clock
ffi.cdef[[
  typedef long time_t;

  typedef struct timeval {
    time_t tv_sec;
    time_t tv_usec;
  } timeval;
 
  int gettimeofday(struct timeval* t, void* tzp);
]]
local os=require('os')
module(...)

local gettimeofday_struct=ffi.new("timeval")

local function gettimeofday()

return os_clock()
end

local mt={__index=_M}


function new(self)
return setmetatable({



start_time=0,
stop_time=0,



lines={},



current_line=nil,
current_start=0,



ignore={},



short={},



rows=20,
},mt)
end


function event(self,event,line)
local now=gettimeofday()
local src=debug_getinfo(3).source
local f=string_sub(src,2)
for i=1,#self.ignore do
if string_find(f,self.ignore[i],1,true)then
return
end
end

local short=self.short[f]
if not short then
local start=string_find(f,"[^/]+$")
self.short[f]=string_sub(f,start)
short=self.short[f]
end

if self.current_line~=nil then
self.lines[self.current_line][1]=
self.lines[self.current_line][1]+1
self.lines[self.current_line][2]=
self.lines[self.current_line][2]+(now-self.current_start)
end

self.current_line=src..':'..line

if self.lines[self.current_line]==nil then
self.lines[self.current_line]={0,0.0,f}
end

self.current_start=gettimeofday()
end


function dont(self,file)
table_insert(self.ignore,file)
end


function maxrows(self,max)
self.rows=max
end


function start(self)
self:dont('lulip.lua')
self.start_time=gettimeofday()
self.current_line=nil
self.current_start=0
debug.sethook(function(e,l)self:event(e,l)end,"l")
end


function stop(self)
self.stop_time=gettimeofday()
debug.sethook()
end


local function readfile(file)
local lines={}
local ln=1




return lines
end


function dump(self,file)
local t={}
for l,d in pairs(self.lines)do
table_insert(t,{line=l,data=d})
end
table_sort(t,function(a,b)return a["data"][2]>b["data"][2]end)

local files={}

local f=io_open(file,"w")
if not f then

return
end
f:write([[
<html>
<head>
<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js">
</script>
<style>.code { padding-left: 20px; }</style>
</head>
<body>
<table width="100%">
<thead><tr><th align="left">file:line</th><th align="right">count</th>
<th align="right">elapsed (s)</th><th align="left" class="code">self time</th>
</tr></thead>
<tbody>
]])

for j=1,self.rows do
if not t[j]then break end
local l=t[j]["line"]
local d=t[j]["data"]
if not files[d[3]]then
files[d[3]]=readfile(d[3])
end
local ln=tonumber(string_sub(l,string_find(l,":",1,true)+1))
f:write(string_format([[
<tr><td>%s</td><td align="right">%i</td><td align="right">%.3f</td>
<td class="code"><code class="prettyprint">%f</code></td></tr>]],
l,d[1],d[2],d[2]/d[1]))
end
f:write('</tbody></table></body></html')
f:close()
end
