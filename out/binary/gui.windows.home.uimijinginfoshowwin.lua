







def_class("UIMiJingInfoShowWin",UIWindowBase)









function UIMiJingInfoShowWin:bindComponents()

self.gotoBtnText=UIText.get(self,0)
self.level=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.scrollview=UIObject.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.icon=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.name=UIText.get(self,7)
self.mask=UIButton.get(self,8)
self.btnClose=UIButton.get(self,9)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIMiJingInfoShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gotoBtnText);self.gotoBtnText=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
end



















function UIMiJingInfoShowWin:onLoaded(...)
self:bindComponents()
end


function UIMiJingInfoShowWin:__delete()
self:unbindComponents()
end




function UIMiJingInfoShowWin:onShow(argtable,afterOnloaded)
self.miJingId=argtable and argtable.miJingId
self:refresh()
end


function UIMiJingInfoShowWin:onHide()

end

function UIMiJingInfoShowWin:refresh()
local mjcfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,self.miJingId)
local modelResId=mjcfg.modelRes
local modelCfg=cfgHelper.get1(cfg_worldmodelconfig_get,modelResId)
if modelCfg then
local modelData=modelCfg.data
local modelId=modelData[4]and modelData[4][1]
local scale=isometricMapSystem:getModelScale(modelId,true)
local modelParam={0,0,4}
scale=scale*modelParam[3]
self.icon:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(modelParam[1],modelParam[2])
end
self.desc:setText(mjcfg.story)

self.name:setText(mjcfg.name)
local n,p,pN=UIDiscipleModel:getJJNameX(mjcfg.fixedJingJie or 0)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
self.level:setText(jj_str)

local rwId=mjcfg.showReward
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems
local len=math.min(#rewards,5)
self.scrollview:setChildScrollViewCreateGrids(len,5)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local data=rewards[i+1]
local item=grids[i]
local stage
if not moneyConfig.isMoney(data[1])then
local rcfg=itemsConfig.getConfig(data[1])
stage=rcfg.stage
end
widgetHelper.setNormalRewardItem(item,0,{data[1],data[2],stage=stage,range=data.range})
end
end




function UIMiJingInfoShowWin:onGotoBtn()
local miJingId=self.miJingId
local posData=MysteryModel:get_mysteryFB_unit(miJingId)
local wdId=posData[1]

local finishCallback=function(flag_)
if flag_ then
if UIManager:isActive("UIMysteryEnterWin")then
UIManager:invokeUIMethod("UIMysteryEnterWin","onShow",{id=miJingId})
else

MysteryController:openEnterWin(miJingId)
end
if posData then
if worldModel:isSameWorld(posData[1])then
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,miJingId})
if key then
worldController:lookAtUnit(key)
end
else
local position=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})
local args={lookAt=position,}
worldController:enterWorld(posData[1],args)
end
end
end
end

cameraMoveController:Begin({eSceneType.eWorld,wdId},nil,finishCallback)
end

function UIMiJingInfoShowWin:onMask()
self:closeSelf()
end

function UIMiJingInfoShowWin:onBtnClose()
self:closeSelf()
end

