









worldHUDResMystery=simple_class(worldHUDBase)
worldHUDResMystery.name="worldHUDResMystery"

function worldHUDResMystery:onCreate()
local guid=self.data[2]
local groupTable=string.split(guid,'-')
local allconfig=cfg_secretsceneziyuanfubenconfig()
self.cfg=allconfig[tonumber(groupTable[1])][tonumber(groupTable[2])]
if not self.cfg then
loggerUtil.logErrFMT("秘境配置不存在{0}",self.data[2])
return
end

local name
if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
name=self.cfg.name
else
name=string.gsub(self.cfg.name,' ','\n')
end

local cnt=string.utf8len(name)
self.cmp:SetChildText(4,cnt>4 and FMT.fmt("<size=20>{0}</size>",name)or name)
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)

worldHUDBase.onCreate(self)
end

function worldHUDResMystery:onUpdate()
self:taskView()
end

function worldHUDResMystery:taskView()

local guid=self.data[2]
local groupTable=string.split(guid,'-')
local groupId=tonumber(groupTable[1])

local curLayer=mysteryZiYuanFuBenModel:getCurLayer(groupId)
self.cmp:SetChildActive(2,curLayer>0)














end
