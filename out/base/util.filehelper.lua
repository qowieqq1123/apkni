




fileHelper={}

local writablePath=CS.GamePath.writablePath

function fileHelper.getFullPath(path)
return writablePath..'/'..path
end

if deviceHelper.isRunWebGL()then
fileHelper.getFullPath=function(path)
return _WXInterface.USER_DATA_PATH..'/'..path
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


function fileHelper.readFileEx(path,default)
local fpath=fileHelper.getFullPath(path)
if deviceHelper.isRunPC()then
fpath=replaceencodef(fpath)
end
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

function fileHelper.writeFileEx(path,content)
local fpath=fileHelper.getFullPath(path)
fileHelper.writeFile(fpath,content)
end

function fileHelper.writeFile(filename,content)
if deviceHelper.isRunPC()then
filename=replaceencodef(filename)
end
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
