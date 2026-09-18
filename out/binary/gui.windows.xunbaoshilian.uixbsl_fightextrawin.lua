







def_class("UIXBSL_fightExtraWin",UIWindowBase)









function UIXBSL_fightExtraWin:bindComponents()

self.icon=UIImage.get(self,0)
self.desc=UIText.get(self,1)
self.btnClick=UIButton.get(self,2)
self.teamBuffPanel=UIObject.get(self,3)
self.vocBanPanel=UIObject.get(self,4)
self.vocBanGroup=UIObject.get(self,5)

self.btnClick:setButtonClick(function()self:onBtnClick()end)



end


function UIXBSL_fightExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.btnClick);self.btnClick=nil;
_UIObject_release(self.teamBuffPanel);self.teamBuffPanel=nil;
_UIObject_release(self.vocBanPanel);self.vocBanPanel=nil;
_UIObject_release(self.vocBanGroup);self.vocBanGroup=nil;
end
















local _this




function UIXBSL_fightExtraWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXBSL_fightExtraWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXBSL_fightExtraWin:onShow(argtable,afterOnloaded)
self.chapterId=argtable and argtable.chapterId
self.levelIdx=argtable and argtable.levelIdx
self.guanqiaId=argtable and argtable.guanqiaId

local modeId=XBSL_DIFFICULTY_MODE.Hard
local cfg=xunBaoShiLianModel:checkModelChapter(modeId,self.chapterId)
local buffInfoCfg=cfg.buffInfo
if buffInfoCfg then

local desc=buffInfoCfg.desc or""
self.desc:setText(desc)


local iconParam=buffInfoCfg.icon
if iconParam then
local iconType=iconParam[1]
local param=iconParam[2]

if iconType==1 then

local jobId=param[1]
local jobicon=UIDiscipleModel:getJobIconName(jobId)
self.icon:setSprite(globalABLookup.global,jobicon)
elseif iconType==2 then
local abName=param[1]
local iconName=param[2]
self.icon:setSprite(abName,iconName)
end
end


self.clickTips=buffInfoCfg.tips
end

local banList_lookup=cfg.voc_bans
local hasVocBan=banList_lookup~=nil and next(banList_lookup)~=nil
self.vocBanPanel:setActive(hasVocBan)
if hasVocBan then
local banList={}
for vocId,v in pairs(banList_lookup)do
if v and v==1 then
banList[#banList+1]=vocId
end
end

table.sort(banList,function(a,b)
return a<b
end)

local count=#banList
self.vocBanGroup:setChildLayoutGroupCreateItems(count,function(index)
local widget=self.vocBanGroup:getChildLayoutGroupGridItem(index-1)
local vocId=banList[index]
local jobicon=UIDiscipleModel:getJobIconName(vocId)
widget:SetChildCSImageSprite(0,globalABLookup.global,jobicon)
end)
end
end


function UIXBSL_fightExtraWin:onHide()

end




function UIXBSL_fightExtraWin:onBtnClick()
if not self.clickTips then
return
end


local tips=self.clickTips
local pos=Vector2.New(-45,35)
self:showWindow('UIConditionTipsOne',{showType=1,str=tips,posWidget=self.widget,posWidgetIndex=self.teamBuffPanel:getID(),pos=pos})
end