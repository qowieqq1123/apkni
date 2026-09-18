







def_class("UIGongFaTipsFiveWin",UIWindowBase)








function UIGongFaTipsFiveWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.rightPanel=UIObject.get(self,1)
self.gfItem=UIObject.get(self,2)
self.colorframe=UIImage.get(self,3)
self.buttonRoot=UIObject.get(self,4)
self.menuAnimGrid=UIObject.get(self,5)
self.menu_anim_1=UIObject.get(self,6)
self.title1=UIObject.get(self,7)
self.skillItem2=UIObject.get(self,8)
self.title5=UIObject.get(self,9)
self.studyDesc=UIObject.get(self,10)
self.title2=UIObject.get(self,11)
self.skillCondition=UIObject.get(self,12)
self.title3=UIObject.get(self,13)
self.pageCollect=UIObject.get(self,14)
self.skillItem1=UIObject.get(self,15)
self.gfDescText=UIText.get(self,16)
self.maxLevelTxt=UIText.get(self,17)
self.fadeouttContent=UIObject.get(self,18)
self.menu_anim={
self.menu_anim_1,
}



end


function UIGongFaTipsFiveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.buttonRoot);self.buttonRoot=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.skillItem2);self.skillItem2=nil;
_UIObject_release(self.title5);self.title5=nil;
_UIObject_release(self.studyDesc);self.studyDesc=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.skillCondition);self.skillCondition=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.pageCollect);self.pageCollect=nil;
_UIObject_release(self.skillItem1);self.skillItem1=nil;
_UIObject_release(self.gfDescText);self.gfDescText=nil;
_UIObject_release(self.maxLevelTxt);self.maxLevelTxt=nil;
_UIObject_release(self.fadeouttContent);self.fadeouttContent=nil;
self.menu_anim=nil;
end






















local pageNumSignConfig={
[2]={'image_pzshang','image_pzxia',},
[3]={'image_pzshang','image_pzzhong','image_pzxia'},
}




function UIGongFaTipsFiveWin:onLoaded(...)
self:bindComponents()
end


function UIGongFaTipsFiveWin:__delete()
self:unbindComponents()
end




function UIGongFaTipsFiveWin:onShow(argtable,afterOnloaded)
self.gfID=argtable.gfID
self.gfLevel=argtable.gfLevel
local showGain=argtable.showGain

self:refreshSkillView()

if afterOnloaded then
self.rightPanel:setChildCanvasGroupAlpha(0)
self.rightPanel:setChildCanvasGroupDOFade(1,0.3,nil)
self.blackImg:setChildCanvasGroupAlpha(0)
self.blackImg:setChildCanvasGroupDOFade(1,0.3,nil)

local func=function()
self:fadeOutView()
end
self:delayDo(0.1,func)
self:fadeOutView(true)
end

if showGain==nil then
showGain=false
else
if showGain then
if UIGongFaModel:isGongFaActive(self.gfID)then
showGain=false
end
end
end
self.menuAnimGrid:setActive(showGain)
self.buttonRoot:setActive(showGain)
if showGain then
self:showAnim()
end
end


function UIGongFaTipsFiveWin:onHide()

end

function UIGongFaTipsFiveWin:showAnim()
self.buttonRoot:setActive(false)
local anim=self.menu_anim[1]
anim:setChildUIModelShowTarget(2017,1,{},eAnimationID.common_window_enter,false,false,0,nil)
local func1=function()
self.buttonRoot:setActive(true)
self.buttonRoot:setChildCanvasGroupAlpha(0)
self.buttonRoot:setChildCanvasGroupDOFade(1,1,nil)
end
self:delayDo(0.3,func1)
end



function UIGongFaTipsFiveWin:refreshSkillView()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)

self.colorframe:setSprite(globalABLookup.tipssprite,FMT.fmt('frame_tygftips_{0}',cfg.color))


local gfItemWidget=self.gfItem:getChildWidgetBase()
gfItemWidget:SetChildText(0,cfg.name)

local elements=UIGongFaModel:getGFElements(self.gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
gfItemWidget:SetChildCSImageSprite(1,globalABLookup.global,elementIcon)
gfItemWidget:SetChildText(2,ELEMENT_TYPE.getNameGF(elementid))

local faction=cfg.faction or FACTION_TYPE.eNone
local showfaction=faction~=FACTION_TYPE.eNone
gfItemWidget:SetChildActive(3,showfaction)
if showfaction then
local faction_icon=UIGongFaModel:getGFFactionIcon(faction)
gfItemWidget:SetChildCSImageSprite(3,globalABLookup.global,faction_icon)
end


local max_lv=self.gfLevel
if not max_lv then
max_lv=UIGongFaModel:getGFMaxLevel(self.gfID)
end
local maxlv_str
if max_lv>0 then
maxlv_str=FMT.fmt('功法层数上限 {0}',max_lv)
else
maxlv_str='尚未收集篇章'
end
self.maxLevelTxt:setText(maxlv_str)


self.gfDescText:setText(cfg.desc)


local skils=cfg.skill
for i=1,2 do
local skillID=skils[i]
local hasSkill=skillID~=nil
local item=self:getSkillItem(i)
item:setActive(hasSkill)
if hasSkill then
local itemWidget=item:getChildWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
itemWidget:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
itemWidget:SetChildActive(1,is_bd)
itemWidget:SetChildText(2,skillCfg.name)

local skillLv=UIGongFaModel:getSkillLvInGongFa(self.gfID,max_lv,skillID)
if skillLv==nil then

skillLv=1
else
if skillLv>0 then
skillLv=skillModel:getSkillLv(skillID,skillLv)
end
end
local lv_str=''
local lock_str=nil
if skillLv>0 then
lv_str=FMT.fmt('{0}级',skillLv)
else
local skillActiveGfLv=UIGongFaModel:getGongFaLvBySkillLv(skillID,1,self.gfID)
lock_str=FMT.fmt('功法{0}级解锁',skillActiveGfLv)
end
itemWidget:SetChildText(3,lv_str)

local isLock=lock_str~=nil
itemWidget:SetChildActive(8,isLock)
if isLock then
itemWidget:SetChildText(8,lock_str)
end

itemWidget:SetChildActive(7,isLock)

local desc_str=skillModel:getSkillDesc(skillID,skillLv)
itemWidget:SetChildText(4,desc_str)

local descExList=skillModel:getSkillDescEx(skillID,skillLv)
local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
local showDescEx=descExNum>0
itemWidget:SetChildActive(9,showDescEx)
if showDescEx then
itemWidget:SetChildLayoutGroupCreateItems(9,descExNum)
local descExGrid=itemWidget:GetChildLayoutGroupGridList(9)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
end
end

local coolDown=skillModel:getSkillCooldownTime(skillID,skillLv)
local isCoolDown=coolDown>0
itemWidget:SetChildActive(5,isCoolDown)
if isCoolDown then
local cooldown_str=FMT.fmt('冷却：{0}回合',coolDown)
itemWidget:SetChildText(6,cooldown_str)
end
end
end


local studylv=0
local showStudy=studylv>0
self.title5:setActive(showStudy)
self.studyDesc:setActive(showStudy)
if showStudy then
local title3Weiget=self.title5:getChildWidgetBase()
title3Weiget:SetChildText(0,FMT.fmt('功法研习 +{0}',studylv))

local studyWeiget=self.studyDesc:getChildWidgetBase()
local studyDescList=UIGongFaModel:getStudyDescList(self.gfID,studylv)
local descnum=#studyDescList
studyWeiget:SetChildLayoutGroupCreateItems(0,descnum)
if descnum>0 then
local gridlist=studyWeiget:GetChildLayoutGroupGridList(0)
for i=1,descnum do
local item=gridlist[i-1]
local desc=studyDescList[i]
item:SetChildText(0,desc)
end
end
end


local tempStrList={}
local condStrList=UIGongFaModel:getConditionDesc(self.gfID)
if#condStrList>0 then
for i,data in ipairs(condStrList)do
local d={}
d[1]=FMT.fmt('{0}{1}',data[1],data[2])
d[2]=false
table.insert(tempStrList,d)
end
end

local needmoney=cfg.consume
local moneyType=eMoneyType.mtChuanDao

local dd={}
dd[1]=FMT.fmt('{0}：{1}',moneyModel.getMoneyName(moneyType),needmoney)
dd[2]=false
table.insert(tempStrList,dd)

local condNum=#tempStrList
self.skillCondition:setChildLayoutGroupCreateItems(condNum)
local condGrid=self.skillCondition:getChildLayoutGroupGridList()
for i=1,condNum do
local condItem=condGrid[i-1]
local data=tempStrList[i]
condItem:SetChildText(0,data[1])
local flag=data[2]
condItem:SetChildActive(1,flag)
end


local pageCollectWidget=self.pageCollect:getChildWidgetBase()
local defaultActive=UIGongFaModel:isGongFaDefaultActive(self.gfID)
local showPageCollect=not defaultActive
pageCollectWidget:SetChildActive(0,showPageCollect)
self.title3:setActive(showPageCollect)
if showPageCollect then
local pieces=cfgHelper.get2(cfg_disciplegongfaconfig_get,self.gfID,'piece')
local num=#pieces
local pageGrid=pageCollectWidget:GetChildCommonLayoutGroupWidgetList(0)

for i=1,3 do
local item=pageGrid[i-1]
local s=i<=num
item:SetChildActive(0,s)
if s then
local active=UIGongFaModel:isPageActiveEx(self.gfID,i)
local pagename=itemsConfig.getItemName(pieces[i][1])
if active then
pagename=string.format('<color=#76d81e>%s</color>',pagename)
end
item:SetChildText(0,pagename)
item:SetChildActive(1,active)
end
end
end
end

function UIGongFaTipsFiveWin:fadeOutView(init)
local fadeoutWidget=self.fadeouttContent:getChildWidgetBase()
local delay=0
local step=0.05
for i=0,9 do
local idx=i
local is_active=fadeoutWidget:GetChildActiveSelf(idx)
if is_active then
if init then
fadeoutWidget:SetChildCanvasGroupAlpha(idx,0)
else
if delay>0 then
local func=function(...)
fadeoutWidget:SetChildCanvasGroupDOFade(idx,1,0.2,nil)
end
self:delayDo(delay,func)
else
fadeoutWidget:SetChildCanvasGroupDOFade(idx,1,0.2,nil)
end
delay=delay+step
end
end
end
end

function UIGongFaTipsFiveWin:getSkillItem(idx)
if idx==1 then
return self.skillItem1
else
return self.skillItem2
end
end

function UIGongFaTipsFiveWin:onGainBtn()
local pieces=cfgHelper.get2(cfg_disciplegongfaconfig_get,self.gfID,'piece')
if pieces then

self:closeSelf()
local d=pieces[1]
local itemid=d[1]
gainControl:showCommonGainWin_item(itemid)
end
end