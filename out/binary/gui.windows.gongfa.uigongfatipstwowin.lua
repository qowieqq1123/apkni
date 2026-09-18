







def_class("UIGongFaTipsTwoWin",UIWindowBase)









function UIGongFaTipsTwoWin:bindComponents()

self.colorframe=UIImage.get(self,0)
self.gfItem=UIObject.get(self,1)
self.maxLevelTxt=UIText.get(self,2)
self.title1=UIObject.get(self,3)
self.skillItem1=UIObject.get(self,4)
self.skillItem2=UIObject.get(self,5)
self.title2=UIObject.get(self,6)
self.skillCondition=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.blackImg=UIObject.get(self,9)
self.title3=UIObject.get(self,10)
self.studyDesc=UIObject.get(self,11)
self.fadeouttContent=UIObject.get(self,12)
self.displayBtn=UIButton.get(self,13)
self.displayTx=UIText.get(self,14)
self.liandonBtn=UIButton.get(self,15)

self.displayBtn:setButtonClick(function()self:onDisplayBtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)



end


function UIGongFaTipsTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.maxLevelTxt);self.maxLevelTxt=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.skillItem1);self.skillItem1=nil;
_UIObject_release(self.skillItem2);self.skillItem2=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.skillCondition);self.skillCondition=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.studyDesc);self.studyDesc=nil;
_UIObject_release(self.fadeouttContent);self.fadeouttContent=nil;
_UIObject_release(self.displayBtn);self.displayBtn=nil;
_UIObject_release(self.displayTx);self.displayTx=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
end























function UIGongFaTipsTwoWin:onLoaded(...)
self:bindComponents()
end


function UIGongFaTipsTwoWin:__delete()
self:unbindComponents()
end


function UIGongFaTipsTwoWin:onHide()

end




function UIGongFaTipsTwoWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.gfID=argtable.gfID
self.gfLevel=argtable.gfLevel
self.hideReport=argtable.hideReport or false

local isLDGF=liandonModel:getLianDonLinkageIdByGFId(self.gfID)>0
self.liandonBtn:setActive(isLDGF)

local isinit=afterOnloaded
if isinit then
self.root:setChildCanvasGroupAlpha(0)


self.root:setChildCanvasGroupDOFade(1,0.3,nil)
self.blackImg:setChildCanvasGroupAlpha(0)
self.blackImg:setChildCanvasGroupDOFade(1,0.3,nil)

local func=function()
self:fadeOutView()
end
self:delayDo(0.1,func)
self:fadeOutView(true)
end
self:refreshSkillView()
self:refreshDisplayButton()
end

function UIGongFaTipsTwoWin:fadeOutView(init)
local fadeoutWidget=self.fadeouttContent:getChildWidgetBase()
local delay=0
local step=0.05
for i=0,6 do
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

function UIGongFaTipsTwoWin:refreshSkillView()
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

local gflv=self.gfLevel
local lv_str
if gflv==nil then
gflv=UIGongFaModel:getGFMaxLevel(self.gfID)
end
if gflv>0 then
lv_str=FMT.fmt('当前功法层数 {0}',gflv)
else
lv_str='尚未收集篇章'
end

self.maxLevelTxt:setText(lv_str)


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

local skillLv=UIGongFaModel:getSkillLvInGongFa(self.gfID,gflv,skillID)
if skillLv==nil then

skillLv=1
else
if skillLv>0 then
if self.disciple_guid~=nil then
skillLv=skillModel:getSkillLv(skillID,skillLv)
end
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
if self.disciple_guid~=nil then
studylv=UIGongFaModel:getStudyLevel(self.gfID)
end
local showStudy=studylv>0
self.title3:setActive(showStudy)
self.studyDesc:setActive(showStudy)
if showStudy then

local title3Weiget=self.title3:getChildWidgetBase()
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


local showCondition=self.disciple_guid~=nil
self.title2:setActive(showCondition)
self.skillCondition:setActive(showCondition)
if showCondition then
local fixLearn,conditionList=UIGongFaModel:checkGongFaFixDisciple(self.gfID,self.disciple_guid)
local tempStrList={}
local condStrList=UIGongFaModel:getConditionDesc(self.gfID)
if#condStrList>0 then
for i,data in ipairs(condStrList)do
local d={}
d[1]=FMT.fmt('{0}{1}',data[1],data[2])
d[2]=conditionList[i][1]
table.insert(tempStrList,d)
end
end

local needmoney=UIGongFaModel:getGFConsume(self.disciple_guid,self.gfID)
local moneyType=eMoneyType.mtChuanDao
local cur=moneyModel.getMoney(moneyType)
local dd={}
dd[1]=FMT.fmt('{0}：{1}',moneyModel.getMoneyName(moneyType),needmoney)
dd[2]=cur>=needmoney
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
end
end

function UIGongFaTipsTwoWin:getSkillItem(idx)
if idx==1 then
return self.skillItem1
else
return self.skillItem2
end
end

function UIGongFaTipsTwoWin:refreshDisplayButton()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local show=api_Available_SetChildFightRenderToImage()and fightModel:haveBattleShow()==nil and cfg.display~=nil and not self.hideReport
self.displayBtn:setActive(show)
if show then
local eType=cfg.display[3]
local str=reportDisplayConfig:getHandleName(eType)
self.displayTx:setText(str)
end
end

function UIGongFaTipsTwoWin:onDisplayBtn()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local reportCfg=cfg.display
reportDisplayController:displayReport(reportCfg[3],reportCfg[1],reportCfg[2],nil,{gongfa=self.gfID})
end

function UIGongFaTipsTwoWin:onLiandonBtn()
local linkageId=liandonModel:getLianDonLinkageIdByGFId(self.gfID)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end