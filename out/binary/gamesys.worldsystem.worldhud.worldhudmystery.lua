









worldHUDMystery=simple_class(worldHUDBase)
worldHUDMystery.name="worldHUDMystery"

function worldHUDMystery:onCreate()
self.cfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,self.data[2])
if not self.cfg then
loggerUtil.logErrFMT("秘境配置不存在{0}",self.data[2])
return
end
local fb_color=self.cfg.color

local name
if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
name=self.cfg.name
else
name=string.gsub(self.cfg.name,' ','\n')
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

function worldHUDMystery:onUpdate()
self:taskView()
end

function worldHUDMystery:taskView()

local taskKey=worldTaskModel:findTaskKey_ByTarget(self.key)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
self.cmp:SetChildActive(2,task.progress_state==eWorldTripProgress.Work)
else
self.cmp:SetChildActive(2,false)
end
end



