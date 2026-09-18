









worldHUDResPoint_Mystery=simple_class(worldHUDBase)
worldHUDResPoint_Mystery.name="worldHUDResPoint_Mystery"

function worldHUDResPoint_Mystery:onCreate()

local typeCfg=cfgHelper.get1(cfg_worldresmysteryconfig_get,self.data[5])
self.mystery=typeCfg.mystery
self.mysteryCfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,self.mystery)
local fb_color=self.mysteryCfg.color

local name
if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
name=self.mysteryCfg.name
else
name=string.gsub(self.mysteryCfg.name,' ','\n')
end

local difficulty_text_color=cfg_secretscenebaseconfig_get(1).fb_quality
local color_cfg=difficulty_text_color[fb_color]
local colorStr=color_cfg[3]

self.cmp:SetChildText(4,colorStr and FMT.fmt("<color=#{0}>{1}</color>",colorStr,name)or FMT.cfmt(fb_color,name))
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)
worldHUDBase.onCreate(self)
end

function worldHUDResPoint_Mystery:onUpdate()
self:taskView()
end

function worldHUDResPoint_Mystery:taskView()

local targetKey=worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,self.mystery})
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
self.cmp:SetChildActive(2,task.progress_state==eWorldTripProgress.Work)
else
self.cmp:SetChildActive(2,false)
end
end