







def_class("UIGongFaTipsWin",UIWindowBase)









function UIGongFaTipsWin:bindComponents()

self.colorframe=UIImage.get(self,0)
self.gfItem=UIObject.get(self,1)
self.title0=UIObject.get(self,2)
self.skillProgress=UIObject.get(self,3)
self.title1=UIObject.get(self,4)
self.skillItem1=UIObject.get(self,5)
self.skillItem2=UIObject.get(self,6)
self.maxLevelTxt=UIText.get(self,7)
self.buttonRoot=UIObject.get(self,8)
self.menu_anim_1=UIObject.get(self,9)
self.menu_anim_2=UIObject.get(self,10)
self.menu_anim_3=UIObject.get(self,11)
self.scrollContent=UIObject.get(self,12)
self.root=UIObject.get(self,13)
self.blackImg=UIObject.get(self,14)
self.title2=UIObject.get(self,15)
self.studyDesc=UIObject.get(self,16)
self.lvUpReddot=UIObject.get(self,17)
self.displayBtn=UIButton.get(self,18)
self.displayTx=UIText.get(self,20)
self.liandonBtn=UIButton.get(self,21)

self.displayBtn:setButtonClick(function()self:onDisplayBtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
}



end


function UIGongFaTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.title0);self.title0=nil;
_UIObject_release(self.skillProgress);self.skillProgress=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.skillItem1);self.skillItem1=nil;
_UIObject_release(self.skillItem2);self.skillItem2=nil;
_UIObject_release(self.maxLevelTxt);self.maxLevelTxt=nil;
_UIObject_release(self.buttonRoot);self.buttonRoot=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.scrollContent);self.scrollContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.studyDesc);self.studyDesc=nil;
_UIObject_release(self.lvUpReddot);self.lvUpReddot=nil;
_UIObject_release(self.displayBtn);self.displayBtn=nil;
_UIObject_release(self.displayTx);self.displayTx=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
self.menu_anim=nil;
end























function UIGongFaTipsWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
end


function UIGongFaTipsWin:__delete()
self:unbindComponents()
end


function UIGongFaTipsWin:onHide()

end




function UIGongFaTipsWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.gfID=argtable.gfID
self.tipsType=argtable.tipsType
self.hideReport=argtable.hideReport or false

local isLDGF=liandonModel:getLianDonLinkageIdByGFId(self.gfID)>0
self.liandonBtn:setActive(isLDGF)

self.discipleGFNetData=UIDiscipleModel:getDiscipleGFData(self.disciple_guid,self.gfID)

if self.tipsType==2 then

self.menu_anim[2]:setActive(false)
local buttonWeiget=self.buttonRoot:getChildWidgetBase()
buttonWeiget:SetChildActive(1,false)
elseif self.tipsType==3 then

local buttonWeiget=self.buttonRoot:getChildWidgetBase()
for i,v in ipairs(self.menu_anim)do
v:setActive(false)
buttonWeiget:SetChildActive(i-1,false)
end
end

local isinit=afterOnloaded
if isinit then
self.root:setChildCanvasGroupAlpha(0)


self.root:setChildCanvasGroupDOFade(1,0.3,nil)
self.blackImg:setChildCanvasGroupAlpha(0)
self.blackImg:setChildCanvasGroupDOFade(1,0.3,nil)
end
self:refreshSkillView(isinit)

self:showAnim()

self:refreshDisplayButton()
end

function UIGongFaTipsWin:resetScroll()
self.scrollContent:setLocalPosY(0)
end

function UIGongFaTipsWin:showAnim()
self.buttonRoot:setActive(false)
for i=1,3 do
local anim=self.menu_anim[i]
anim:setChildUIModelShowTarget(2017,1,{},eAnimationID.common_window_enter,false,false,0,nil)
end
local func1=function()
self.buttonRoot:setActive(true)
self.buttonRoot:setChildCanvasGroupAlpha(0)
self.buttonRoot:setChildCanvasGroupDOFade(1,1,nil)
end
self:delayDo(0.3,func1)
end

function UIGongFaTipsWin:refreshSkillView(isinit)
self.fadeList={}

local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)

self.colorframe:setSprite(globalABLookup.tipssprite,FMT.fmt('frame_tygftips_{0}',cfg.color))


local gfItemWidget=self.gfItem:getChildWidgetBase()

local gflv=self.discipleGFNetData.param_2
gfItemWidget:SetChildText(0,FMT.fmt('{0}({1})',cfg.name,UIGongFaModel:getGFLeverlStr(gflv)))

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


local maxlv_str=FMT.fmt('功法层数上限 {0}',UIGongFaModel:getGFMaxLevel(self.gfID))
self.maxLevelTxt:setText(maxlv_str)


if isinit then
self.title0:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.title0)
end


if isinit then
self.skillProgress:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.skillProgress)
end
local gfMaxLv=UIGongFaModel:getGFMaxLevel(self.gfID)
self.isFull=false
if gflv>=gfMaxLv then
self.isFull=true
end
local curExp=self.discipleGFNetData.param_3
local maxExp=UIGongFaModel:getUpGFExp(self.gfID,gflv)
if maxExp==nil then
curExp=1
maxExp=1
else
if curExp>maxExp then curExp=maxExp end
end
local progressWeiget=self.skillProgress:getChildWidgetBase()
progressWeiget:SetChildProgressValue(0,curExp,maxExp)
local progress_str=''
if self.isFull then
progress_str=UIGongFaModel:getGFLeverlStr(-1)
else
progress_str=FMT.fmt('{0}/{1}',curExp,maxExp)
end
progressWeiget:SetChildProgressText(0,progress_str)


if isinit then
self.title1:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.title1)
end


local skils=cfg.skill
for i=1,2 do
local skillID=skils[i]
local hasSkill=skillID~=nil
local item=self:getSkillItem(i)
item:setActive(hasSkill)
if hasSkill then
if isinit then
item:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,item)
end
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
local hoardDescEx=skillModel:getSkillHoardDescEx(self.disciple_guid,self.gfID,skillID,skillLv)
descExList=table.concatTableX(descExList or{},hoardDescEx)

local lsDescList=skillModel:getLingShouTraitEffectAdd(self.disciple_guid,self.gfID,skillID)
descExList=table.concatTableX(descExList or{},lsDescList)
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


local studylv=UIGongFaModel:getStudyLevel(self.gfID)
local showStudy=studylv>0
self.title2:setActive(showStudy)
self.studyDesc:setActive(showStudy)
if showStudy then

if isinit then
self.title2:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.title2)
self.studyDesc:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.studyDesc)
end
local title2Weiget=self.title2:getChildWidgetBase()
title2Weiget:SetChildText(0,FMT.fmt('功法研习 +{0}',studylv))

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


self:refreshLvUpReddot()

if isinit then
local func=function()
self:doFadeList()
end
self:delayDo(0.01,func)
end
end

function UIGongFaTipsWin:refreshLvUpReddot()
local reddot=UIDiscipleModel:checkDiscipleGFCanUpById(self.disciple_guid,self.gfID)
self.lvUpReddot:setActive(reddot)
end

function UIGongFaTipsWin:doFadeList()
for i,v in ipairs(self.fadeList)do
v:setChildCanvasGroupDOFade(1,0.1,nil)
end
end

function UIGongFaTipsWin:getSkillItem(idx)
if idx==1 then
return self.skillItem1
else
return self.skillItem2
end
end

function UIGongFaTipsWin:onUpClick()
self:resetScroll()
local gfID=self.gfID
if UIGongFaModel:isDiscipleGFLevelFull(self.disciple_guid,gfID,true)then
return
end
UIManager:showWindow('UIGongFaUpWin',{guid=self.disciple_guid,gfID=gfID})
end

function UIGongFaTipsWin:onSetupClick()
local gfID=self.gfID
local dis_guid=self.disciple_guid
local tipsType=self.tipsType
UIFullDiscipleMainControl:showWindowSkill({dis_guid=dis_guid})
local func=function()
local flag=UIFullCangJingGeControl:showMyWindowEx(FULL_TAB_TYPE.eGongFaLearn,dis_guid,nil)
if flag then
if UIDiscipleModel:isDiscipleLearnGF(dis_guid,gfID)then
UIManager:showWindow('UIGongFaTipsWin',{guid=dis_guid,gfID=gfID,tipsType=tipsType})
end
end
end
fullScreenUI.setNextActiveUICallback(func)
self:closeSelf()
end

function UIGongFaTipsWin:onForgetClick()
UIManager:showWindow('UIGongFaForgetWin',{guid=self.disciple_guid,gfID=self.gfID})
end

function UIGongFaTipsWin:rec_upGF(gfID,oldlv,newlv)
if gfID==self.gfID then
self:refreshSkillView()
end
end

function UIGongFaTipsWin:onMoneyChanged(moneyType)
if moneyType==eMoneyType.mtChuanDao then
self:refreshLvUpReddot()
end
end

function UIGongFaTipsWin:refreshDisplayButton()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local show=api_Available_SetChildFightRenderToImage()and fightModel:haveBattleShow()==nil and cfg.display~=nil and not self.hideReport
self.displayBtn:setActive(show)
if show then
local eType=cfg.display[3]
local str=reportDisplayConfig:getHandleName(eType)
self.displayTx:setText(str)
end
end

function UIGongFaTipsWin:onDisplayBtn()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local reportCfg=cfg.display
reportDisplayController:displayReport(reportCfg[3],reportCfg[1],reportCfg[2],nil,{gongfa=self.gfID})
end

function UIGongFaTipsWin:onLiandonBtn()
local linkageId=liandonModel:getLianDonLinkageIdByGFId(self.gfID)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end