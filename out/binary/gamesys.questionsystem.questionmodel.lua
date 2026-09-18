questionModel={}

function questionModel:init()
self.data={}
self.Id=nil
end

function questionModel:setData(len,array)
self.data=array or{}
end

function questionModel:setPrize()
local id=questionModel:getId()
local idx=math.floor(id/32)+1
local flag=self.data[idx]or 0
self.data[idx]=mathHelper.setbit(flag,id-1)
end


function questionModel:isPrize()
local id=questionModel:getId()
local idx=math.floor(id/32)+1
local flag=self.data[idx]or 0
return mathHelper.getBitValue(flag,id-1)
end

function questionModel:hasPrize()
return not questionModel:isPrize()
end

function questionModel:freshId()
local oldId=self.Id
local newId=questionModel:getValidId()
if oldId~=newId then
self.Id=newId
questionControl:freshEntry()
notifySystem:postNotify(notifyConfig.questionChanged,oldId,newId)
end
end

function questionModel:getId()
return self.Id
end

function questionModel:getValidId()
local isOpenWenJuan=systemModel.isOpen(SYSTEM_DEFINE.eQuestionnaire)
if not isOpenWenJuan then return end
local cfgs=cfg_questionnaireconfig()
for i,v in ipairs(cfgs)do
if questionModel:isOpen(v)then
return v.id
end
end
end

function questionModel:isOpen(cfg)
local time=cfg.time
if time==nil then return false end
local pfid=loginModel:getPfid()
local serverid=playerModel:getActorServerID()
local pfparam=time[0]or time[pfid]or{}
local separam=pfparam[0]or pfparam[serverid]
return questionModel:checkParams(separam)
end

function questionModel:checkParams(args)
if args==nil then return false end
local typo=args[1]
local param=args[2]
if typo==1 then
local minday=param[1]
local maxday=param[2]
local openDay=timeHelper.getServerOpenDay()
return minday<=openDay and openDay<=maxday







end
return false
end

function questionModel:getUrl(id)
local cfg=cfg_questionnaireconfig_get(id)
return cfg.url
end