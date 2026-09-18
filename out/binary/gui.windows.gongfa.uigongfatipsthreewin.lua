







def_class("UIGongFaTipsThreeWin",UIWindowBase)









function UIGongFaTipsThreeWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.buttonRoot=UIObject.get(self,1)
self.colorframe=UIImage.get(self,2)
self.displayBtn=UIButton.get(self,3)
self.displayTx=UIText.get(self,4)
self.fadeouttContent=UIObject.get(self,5)
self.gfDescText=UIText.get(self,6)
self.gfItem=UIObject.get(self,7)
self.guanlian=UIButton.get(self,8)
self.Icon=UIImage.get(self,9)
self.itembg=UIImage.get(self,10)
self.leftPanel=UIObject.get(self,11)
self.liandonBtn=UIButton.get(self,12)
self.maxLevelTxt=UIText.get(self,13)
self.menu_anim_1=UIObject.get(self,14)
self.pageCollect=UIObject.get(self,15)
self.rightPanel=UIObject.get(self,16)
self.skillCondition=UIObject.get(self,17)
self.skillItem1=UIObject.get(self,18)
self.skillItem2=UIObject.get(self,19)
self.studyDesc=UIObject.get(self,20)
self.Text=UIText.get(self,21)
self.title1=UIObject.get(self,22)
self.title2=UIObject.get(self,23)
self.title3=UIObject.get(self,24)
self.title5=UIObject.get(self,25)

self.displayBtn:setButtonClick(function()self:onDisplayBtn()end)

self.guanlian:setButtonClick(function()self:onGuanlian()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)
self.menu_anim={
self.menu_anim_1,
}



end


function UIGongFaTipsThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.buttonRoot);self.buttonRoot=nil;
_UIObject_release(self.colorframe);self.colorframe=nil;
_UIObject_release(self.displayBtn);self.displayBtn=nil;
_UIObject_release(self.displayTx);self.displayTx=nil;
_UIObject_release(self.fadeouttContent);self.fadeouttContent=nil;
_UIObject_release(self.gfDescText);self.gfDescText=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.guanlian);self.guanlian=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.itembg);self.itembg=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.maxLevelTxt);self.maxLevelTxt=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.pageCollect);self.pageCollect=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.skillCondition);self.skillCondition=nil;
_UIObject_release(self.skillItem1);self.skillItem1=nil;
_UIObject_release(self.skillItem2);self.skillItem2=nil;
_UIObject_release(self.studyDesc);self.studyDesc=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.title5);self.title5=nil;
self.menu_anim=nil;
end























local pageNumSignConfig={
[2]={'image_pzshang','image_pzxia',},
[3]={'image_pzshang','image_pzzhong','image_pzxia'},
}


function UIGongFaTipsThreeWin:onLoaded(...)
self:bindComponents()
end


function UIGongFaTipsThreeWin:__delete()
self:unbindComponents()
if self.openStudy then
self.openStudy=false
UIManager:closeWindow('UIGongFaStudyWin')
end
end


function UIGongFaTipsThreeWin:onHide()

end




function UIGongFaTipsThreeWin:onShow(argtable,afterOnloaded)
self.gfID=argtable.gfID
self.hideReport=argtable.hideReport or false

local isLDGF=liandonModel:getLianDonLinkageIdByGFId(self.gfID)>0
self.liandonBtn:setActive(isLDGF)

self.allActive=UIGongFaModel:isPageAllActive(self.gfID)
local isinit=afterOnloaded
self:refreshView()
self:refreshSkillView()

if isinit then
if self.showLeft then
self.leftPanel:setChildCanvasGroupAlpha(0)
self.leftPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
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

self:showAnim()
self:refreshDisplayButton()


self:SetGlBtn()
end

function UIGongFaTipsThreeWin:fadeOutView(init)
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

function UIGongFaTipsThreeWin:showAnim()
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

function UIGongFaTipsThreeWin:refreshView()
local defaultActive=UIGongFaModel:isGongFaDefaultActive(self.gfID)
self.hasReward=UIGongFaModel:hasActiveAnyPageReward(self.gfID)
self.showLeft=not defaultActive and(self.hasReward or not self.allActive)
self.leftPanel:setActive(self.showLeft)
if self.showLeft then
self:refreshRewardView()
end
local showStudy=false
if not self.showLeft then
showStudy=UIGongFaModel:checkStudyCanUp(self.gfID,false,false)
if showStudy then
UIManager:showWindow('UIGongFaStudyWin',{gfID=self.gfID})
end
end
self.openStudy=showStudy
if self.showLeft or showStudy then
self.rightPanel:setLocalPosX(220)
self.guanlian:setChildDOLocalMoveX(-563,0)
else
self.rightPanel:setLocalPosX(0)
self.guanlian:setChildDOLocalMoveX(-236,0)
end
self:setRightCanvas()
end

function UIGongFaTipsThreeWin:setRightCanvas()
if self.openStudy then
local pos=self:getChildCanvas(-1)
self.rightPanel:setChildCanvas(pos[1],pos[2]+1)
else
self.rightPanel:setChildRemoveCanvas()
end
end

function UIGongFaTipsThreeWin:refreshRewardView()
local leftPanelWidget=self.leftPanel:getChildWidgetBase()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local pageGrid=leftPanelWidget:GetChildCommonLayoutGroupWidgetList(0)
local pieces=cfg.piece
local pagenum=#pieces
local pagesigncfg=pageNumSignConfig[pagenum]
for i=1,3 do
local item=pageGrid[i-1]
local pieceData=pieces[i]
local s=pieceData~=nil
item:SetChildActive(6,s)
if s then
local itemID=pieceData[1]
local acitve=UIGongFaModel:isPageActive(self.gfID,itemID)
local has=UIGongFaModel:hasActivePageReward(self.gfID,i)

item:SetChildIcon(0,iconHelper.getIconName(itemID),true)

local signicon=pagesigncfg[i]
item:SetChildCSImageSprite(5,globalABLookup.cangjingge,signicon)

local name_str=itemsConfig.getItemName(itemID)
if acitve then
name_str=string.format('<color=#549327>%s</color>',name_str)
end
item:SetChildText(1,name_str)

item:SetChildActive(2,acitve)

item:SetChildActive(3,not acitve)
if not acitve then
item:SetChildButtonClick(3,function()
self:onJumpItem(itemID)
end)
end

local reward=pieceData[2][1]
local rItemID=reward[1]
local num=reward[2]
local grayNum=0
if not acitve then
grayNum=mathHelper.setbit(grayNum,eGrayType.eLock-1)
end
local conf={itemid=rItemID,itemcount=num,showname=false,showCountBG=false,showStage=true,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(7,prop)
item:SetBaseItemClickEvent(7,function(...)self:onGoodItemClick(...)end)

item:SetChildActive(4,acitve and not has)
end
end

local itemReward=leftPanelWidget:GetChildWidgetBase(3)
local hasAllReward=false
if self.allActive then
hasAllReward=UIGongFaModel:hasActiveAllPageReward(self.gfID)
end
local reward=cfg.reward[1]
local rItemID=reward[1]
local num=reward[2]
local grayNum=0
if not self.allActive then
grayNum=mathHelper.setbit(grayNum,eGrayType.eLock-1)
end
local conf={itemid=rItemID,itemcount=num,showname=false,showCountBG=false,showStage=true,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemReward:SetChildPropData(0,prop)
itemReward:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
itemReward:SetChildActive(1,self.allActive and not hasAllReward)


leftPanelWidget:SetChildGray(1,not self.hasReward)
leftPanelWidget:SetChildActive(2,self.hasReward)
end

function UIGongFaTipsThreeWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eLeft})
end
end

function UIGongFaTipsThreeWin:onJumpItem(itemid)
gainControl:showCommonGainWin_item(itemid)
end

function UIGongFaTipsThreeWin:refreshSkillView()
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


local max_lv=UIGongFaModel:getGFMaxLevel(self.gfID)
local maxlv_str
if max_lv>0 then
maxlv_str=FMT.fmt('功法层数上限 {0}',UIGongFaModel:getGFMaxLevel(self.gfID))
else
maxlv_str='尚未收集篇章'
end
self.maxLevelTxt:setText(maxlv_str)


self.gfDescText:setText(cfg.desc)


local maxGFLv=UIGongFaModel:getGFMaxLevel(self.gfID)
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

local skillLv=UIGongFaModel:getSkillLvInGongFa(self.gfID,maxGFLv,skillID)
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


local studylv=UIGongFaModel:getStudyLevel(self.gfID)
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

function UIGongFaTipsThreeWin:getSkillItem(idx)
if idx==1 then
return self.skillItem1
else
return self.skillItem2
end
end

function UIGongFaTipsThreeWin:onPageRewardClick()
local gfID=self.gfID
if UIGongFaModel:isGongFaActive(gfID)then
UIGongFaController:reqGongFaRewards(gfID)
end
end

function UIGongFaTipsThreeWin:onStudyBtn()
if self.clickLock then return end

if not self.allActive then
UIManager.error('需完成所有篇章收集')
return
end
if self.hasReward then
UIManager.error('请先领取篇章收集奖励')
return
end
self.openStudy=not self.openStudy
if self.openStudy then

self:setRightCanvas()
self.clickLock=true
local func1=function()
self.clickLock=false
end
local func2=function()
self.rightPanel:setChildDOLocalMoveX(220,0.21,func1)
self.guanlian:setChildDOLocalMoveX(-563,0.2)
end
self:delayDo(0.1,func2)
UIManager:showWindow('UIGongFaStudyWin',{gfID=self.gfID})
else
UIManager:closeWindow('UIGongFaStudyWin')
local func=function()
self.clickLock=false
self:setRightCanvas()
end
self.clickLock=true
self.rightPanel:setChildDOLocalMoveX(0,0.2,func)
self.guanlian:setChildDOLocalMoveX(-236,0.2)
end
end

function UIGongFaTipsThreeWin:rec_pageReward()
self:refreshView()
end

function UIGongFaTipsThreeWin:rec_study(gfID)
if self.gfID==gfID then
self:refreshSkillView()
end
end

function UIGongFaTipsThreeWin:refreshDisplayButton()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local show=api_Available_SetChildFightRenderToImage()and fightModel:haveBattleShow()==nil and cfg.display~=nil and not self.hideReport
self.displayBtn:setActive(show)
if show then
local eType=cfg.display[3]
local str=reportDisplayConfig:getHandleName(eType)
self.displayTx:setText(str)
end
end

function UIGongFaTipsThreeWin:onDisplayBtn()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local reportCfg=cfg.display
reportDisplayController:displayReport(reportCfg[3],reportCfg[1],reportCfg[2],nil,{gongfa=self.gfID})
end

function UIGongFaTipsThreeWin:onLiandonBtn()
local linkageId=liandonModel:getLianDonLinkageIdByGFId(self.gfID)
UIManager:showWindow('UITipLianDonWin',{linkageId=linkageId})
end

local abname="ui/windows/common/liandong_atlas_pak.ab"
local colorcmp=
{
[eQualityColor.eRed]='image_yishigongfadi_04',
[eQualityColor.eOrange]='image_yishigongfadi_03',
[eQualityColor.ePurple]='image_yishigongfadi_02',
[eQualityColor.eBlue]='image_yishigongfadi_05',
}

function UIGongFaTipsThreeWin:SetGlBtn()
local glID=liandonModel:CheckGongFa_Guanlian(self.gfID)

if not glID then
self.guanlian:setActive(false)
return
end
self.guanlian_id=glID
self.guanlian:setActive(true)

local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local itemidtable=gongfaLookup:checkpiecesgongfa(self.gfID)
local itemid=itemidtable[1]
local itemConfig_1=itemsConfig.getConfig(itemid)
self.Icon:setImageIcon(iconHelper.getItemIconName(itemConfig_1.icon),false)
self.itembg:setSprite(abname,colorcmp[cfg.color])
self.Text:setText("异世功法")
end

function UIGongFaTipsThreeWin:onGuanlian()
local arg={self.gfID,self.guanlian_id}
if self.gfID then
arg.GFid=self.gfID
end
UIManager:showWindow("UIGuanLianWin",arg)
end
