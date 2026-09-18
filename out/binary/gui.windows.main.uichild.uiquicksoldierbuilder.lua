




UIQuickSoldierBuilder=simple_class(UIChildObject)

local iconname='button_zjmbinying'
local _this
function UIQuickSoldierBuilder:onLoaded()

_this=self
end

function UIQuickSoldierBuilder:onShow()
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if bdData then
UIFullYunJiaYingControl:showYunJiaYingWindow({entityId=-1,unBuildID=bdData.un_build_id})
end
end,true)



end

function UIQuickSoldierBuilder:release()

self:setChildActive(2,false)
self:doPunchRotation(false)
_this=nil
end


function UIQuickSoldierBuilder.refreshReddot(class,sub_typo,last_flag,flag)
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
end

function UIQuickSoldierBuilder:doPunchRotation(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
if self.reddotTweener==nil then
self:setChildRotation(2,0,0,0)
local tweener=self:setChildDOPunchRotation(2,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(2,0,0,0)
end
end
end