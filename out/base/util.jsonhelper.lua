







jsonHelper={}


local cjson=require'cjson'

function jsonHelper.decode_josn(content,default)
local r1,r2=pcall(cjson.decode,content)
if r1 then
return r2
else
return default
end
end

function jsonHelper.writeFile(filename,input)


local r=cjson.encode(input)


fileHelper.writeFileEx(filename,r)
end

function jsonHelper.readFile(filename,default)









local content=fileHelper.readFileEx(filename)
if not content or content==default then
return default
end

return jsonHelper.decode_josn(content,default)
end

function jsonHelper.readPath(path,default)











local content=fileHelper.readFile(path,default)
if not content or content==default then
return default
end

return jsonHelper.decode_josn(content,default)
end

function jsonHelper.readStreamingFile(filename,default)













local path=CS.GamePath.streamingAssetsPath..filename
return jsonHelper.readPath(path,default)
end

function jsonHelper.read_json_file(filename,default)
return jsonHelper.readFile(filename,default)
end

function jsonHelper.decode(content)
return cjson.decode(content)
end

function jsonHelper.encode(input)
return cjson.encode(input)
end
