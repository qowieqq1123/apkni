




fileHelper={}

local writablePath=CS.GamePath.writablePath
local replaceencode
if CS.AppDataModel.API_LEVEL_NUM>=74 then
replaceencode=CS.GameInterface.replaceencode
end
local replaceencodef=function(path)
if CS.AppDataModel.API_LEVEL_NUM>=74 then
local bytes=replaceencode(path)
return string.char(unpack(bytes))
end
return path
end

function fileHelper.replaceencodefun(path)
return replaceencodef(path)
end

function fileHelper.getFullPath(path)
local fullPath=writablePath..'/'..path
return fullPath
end

if deviceHelper.isRunWebGL()then
fileHelper.getFullPath=function(path)
return _WXInterface.USER_DATA_PATH..'/'..path
end
elseif deviceHelper.isRunPC~=nil and deviceHelper.isRunPC()then
fileHelper.getFullPath=function(path)
local fullPath=writablePath..'/'..path
fullPath=replaceencodef(fullPath)
return fullPath
end
end



function fileHelper.isFileExists(filePath)
local file=io.open(filePath,"r");
if file then
io.close(file);
return true;
end
return false;
end

if deviceHelper.isRunWebGL()then
fileHelper.isFileExists=function(filePath)
return _WXInterface.IsFileExists(filePath)
end
end


function fileHelper.isDirectoryExists(path)
local file=io.open(path,"rb");
if file then
io.close(file);
return true;
end
return false;
end

if deviceHelper.isRunWebGL()then
fileHelper.isDirectoryExists=function(path)
return _WXInterface.IsDirectoryExists(path)
end
end


function fileHelper.copyFile(sourcePath,savePath)
local rf=io.open(sourcePath,"rb");
local len=rf:seek("end");
rf:seek("set",0);
local data=rf:read(len);
local wf=io.open(savePath,"wb");
wf:write(data,len);
rf:close();
wf:close();
end

if deviceHelper.isRunWebGL()then
fileHelper.copyFile=function(sourcePath,savePath)
_WXInterface.CopyFileSync(sourcePath,savePath)
end
end


function fileHelper.createDirectory(path,platform)
local cmd='';
if platform and platform=='WindowsEditor'then
cmd="mkdir "..path;
else
cmd="mkdir -p "..path;
end
os.execute(cmd);
end

if deviceHelper.isRunWebGL()then
fileHelper.createDirectory=function(path,platform)
_WXInterface.MkdirSync(path,true)
end
end


function fileHelper.readFileEx(path,default)
local fpath=fileHelper.getFullPath(path)
return fileHelper.readFile(fpath,default)
end


function fileHelper.readFile(filename,default)
local f=io.open(filename,'r')
if f==nil then

return default
end
local content=f:read('*all')
f:close()
return content
end

if deviceHelper.isRunWebGL()then
fileHelper.readFile=function(filename,default)
if not fileHelper.isFileExists(filename)then
return default
end
local content=_WXInterface.ReadFileSync(filename)
if not content or content==''then
return default
end
return content
end
end


function fileHelper.writeFileEx(filename,content)
local fullPath=fileHelper.getFullPath(filename)
fileHelper.writeFile(fullPath,content)
end


function fileHelper.writeFile(filename,content)
local f=io.open(filename,'w+')
if f~=nil then
f:write(content)
f:close()
return
end
logErr(FMT.fmt('open file{0} failed',filename))
end

if deviceHelper.isRunWebGL()then
fileHelper.writeFile=function(filename,content)
_WXInterface.WriteFileSync(filename,content)
end

end

function fileHelper.deleteDirectory(directoryName)
if fileHelper.isFileExists(directoryName)then
os.execute('rmdir /s /q "'..directoryName..'"')
end
end

if deviceHelper.isRunWebGL()then
fileHelper.deleteDirectory=function(directoryName)
if _WXInterface.IsDirectoryExists(directoryName)then
_WXInterface.RmdirSync(directoryName,true)
end
end
end

function fileHelper.decodeURI(s)
s=string.gsub(s,'%%(%x%x)',function(h)return string.char(tonumber(h,16))end)
return s
end

function fileHelper.encodeURI(s)
s=string.gsub(s,"([^%w%.%- ])",function(c)return string.format("%%%02X",string.byte(c))end)
return string.gsub(s," ","+")
end
