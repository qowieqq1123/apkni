
userActorSetting={}
local config=nil
local userpath=CS.GamePath.writablePath..'userDefault.json'
local delayFlushTimer

function userActorSetting.init(username)
local appKey=string.gsub(username,'[\\/:*?\"<>|]','_')
userpath='actor_'..appKey..'.json'
local e,s=pcall(function()config=jsonHelper.readFile(userpath,{})end)
if not e then
config={}
end
UISettingModel:initActorSettingData()
notifySystem:postNotify(notifyConfig.loadActorSetting)
end

function userActorSetting.get(key,defaultValue)
local v=config[key]
if v==nil then
return defaultValue
end
return v
end

function userActorSetting.set(key,value)
config[key]=value
end


function userActorSetting.flushVal(key,value,defaultValue)
local lastVal=config[key]
if lastVal==nil then
lastVal=defaultValue
end
if lastVal~=value then
config[key]=value
userActorSetting.flush()
end
end

function userActorSetting.remove(key)
if config then
config[key]=nil
end
end

function userActorSetting.flush(delay)
if delay then
if delayFlushTimer==nil then
delayFlushTimer=FrameTimer.New(userActorSetting.save,1,0)
delayFlushTimer:Start()
end
else
userActorSetting.save()
end
end

function userActorSetting.save()
if delayFlushTimer then
delayFlushTimer:Stop()
delayFlushTimer=nil
else

end
jsonHelper.writeFile(userpath,config)
end
