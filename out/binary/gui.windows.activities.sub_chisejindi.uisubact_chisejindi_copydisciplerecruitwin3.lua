







def_class("UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:bindComponents()

self.discipleBtn=UIButton.get(self,0)
self.employeeList=UIObject.get(self,1)
self.fazeBtn=UIButton.get(self,2)
self.fireBtn=UIButton.get(self,3)
self.goBtn=UIButton.get(self,4)
self.leftBottom=UIObject.get(self,5)
self.moneyBg=UIButton.get(self,6)
self.moneyIcon=UIImage.get(self,7)
self.moneyNum=UIText.get(self,8)
self.refreshBtn=UIButton.get(self,9)
self.refreshCost=UIObject.get(self,10)
self.refreshMoney=UIImage.get(self,11)
self.refreshNum=UIText.get(self,12)
self.tips=UIText.get(self,13)
self.weaponBtn=UIButton.get(self,14)

self.discipleBtn:setButtonClick(function()self:onDiscipleBtn()end)

self.fazeBtn:setButtonClick(function()self:onFazeBtn()end)

self.fireBtn:setButtonClick(function()self:onFireBtn()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.weaponBtn:setButtonClick(function()self:onWeaponBtn()end)



end


function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.discipleBtn);self.discipleBtn=nil;
_UIObject_release(self.employeeList);self.employeeList=nil;
_UIObject_release(self.fazeBtn);self.fazeBtn=nil;
_UIObject_release(self.fireBtn);self.fireBtn=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.leftBottom);self.leftBottom=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.refreshCost);self.refreshCost=nil;
_UIObject_release(self.refreshMoney);self.refreshMoney=nil;
_UIObject_release(self.refreshNum);self.refreshNum=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.weaponBtn);self.weaponBtn=nil;
end
















local _this=nil
local _itemCmp={
recruitBtn=0,
costIcon=1,
costNum=2,
recruited=3,
tips=4,
tmBack=5,
gfSkill={6,7},
model=8,
color=9,
name=10,
jingjie=11,
attr={12,13,14},
job=15,
costRoot=16,
starList=17,
root=18,
background=19,
bgColor=20,
}
local _itemGFCmp={
back=-1,
icon=0,
sign=1,
}
local _animationID={
enter=2411,
exit=2412,
}
local _bgColorSpine={
[eQualityColor.ePurple]=5461,
[eQualityColor.eOrange]=5462,
[eQualityColor.eRed]=5463,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"



function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onLoaded(...)
self:bindComponents()
_this=self

socketManager:addNotify(249,238,self.on_249_238)
socketManager:addNotify(249,239,self.on_249_239)
socketManager:addNotify(249,241,self.on_249_241)
end


function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:__delete()
self:unbindComponents()
_this=nil

if self.tweener and self.tweener:IsActive()then
self.tweener:Kill()
end

socketManager:removeNotify(249,238,self.on_249_238)
socketManager:removeNotify(249,239,self.on_249_239)
socketManager:removeNotify(249,241,self.on_249_241)
end




function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onShow(argtable,afterOnloaded)

self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin
self.callback=argtable.callback


self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.copyData=self.info:getCopy()
self.teamData=self.info:getTeam()

self:initView()
self:refreshMoneyNum(true)
self:refreshList()
self:refreshRound()
end


function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onHide()

end




function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onFireBtn()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleSellWin3",args)
end


function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onRefreshBtn()
if self.tweener or not self.showList then return end

if self.copyData.money<self.config.refresh[2]then
UIManager.error("货币不足")
tipsManager.showTips({itemid=self.config.chanceMoney})
return
end






call_activitiesHandle_func("activitiesHandle_chisejindi","reqRefreshCopyItem",self.actId,self.subId)


AudioManager.playAudio(668)
self:closeList()
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onMoneyBg()
tipsManager.showTips({itemid=self.config.chanceMoney})
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onGoBtn()
if self.callback then
self.callback()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onFazeBtn()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
side=0,
}
self:showWindow("UISubAct_ChiSeJinDi_FaZeBagWin",args)
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onDiscipleBtn()
local discipleList=self.copyData.discipleList
self.copyData:sortDiscipleList()
local lookup=self.info:getTeamLookup_Disciple()
local roleList={}
for index,disciple in ipairs(discipleList)do
local pos=lookup[disciple]
local posData=pos and self.teamData[pos]or nil
local weapon=posData and posData.weapon or nil
local data={
disciple=disciple,
weapon=weapon,
}
table.insert(roleList,data)
end
if#roleList>0 then
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
roleList=roleList,
parentWin=self,
showList=true,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",args)
else
UIManager.error("无弟子信息可查看")
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onWeaponBtn()
local weaponList=self.copyData.weaponList
self.copyData:sortWeaponList()
local lookup=self.info:getTeamLookup_Weapon()
local dataList={}
for index,weapon in ipairs(weaponList)do
local pos=lookup[weapon]
local posData=pos and self.teamData[pos]or nil
local disciple=posData and posData.disciple or nil
local data={
disciple=disciple,
weapon=weapon,
}
table.insert(dataList,data)
end
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
dataList=dataList,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyWeaponDetailWin",args)
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:initView()
self.moneyIcon:setImageIcon(iconHelper.getIconName(self.config.chanceMoney),false)
self.refreshMoney:setImageIcon(iconHelper.getIconName(self.config.chanceMoney),false)

self.winlua:ForceLayoutRect(self.refreshCost:getID())
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:refreshMoneyNum(onlyTab)
local moneyStr=mathHelper.formatNumber(self.copyData.money)
self.moneyNum:setText(moneyStr)

local num=self.config.refresh[2]
local str=num<=self.copyData.money and num or FMT.cfmt2("#ee0000",num)
self.refreshNum:setText(str)

if not onlyTab then
local roundData=self.copyData.roundData
local items=self.employeeList:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
local data=roundData.list[i]
local recruitFlag=data.param_2
if recruitFlag~=1 then
local discipleID=data.param_1
local discipleServer=self.config.disciple[discipleID]
local price=discipleServer[3]
local priceStr=price<=self.copyData.money and price or FMT.cfmt2("#ee0000",price)
item:SetChildText(_itemCmp.costNum,priceStr)
end
end
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:checkCloseWin(warning)
local discipleLookup=self.info:getTeamLookup_Disciple()
if next(discipleLookup)==nil and#self.copyData.discipleList<=0 then
if warning then
UIManager.info("请先招募弟子")
end
return false
end
return true
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:refreshRound()
local firstRound=self.copyData.round==1
local roundData=self.copyData.roundData
if self.showBack==nil then
self.showBack=not firstRound
if not self.showBack then
for i=1,roundData.len do
local data=roundData.list[i]
if data.param_2==1 then
self.showBack=true
break
end
end
end
end
self.tips:setActive(firstRound)
self.refreshBtn:setActive(not firstRound)
self.leftBottom:setActive(not firstRound)
self.goBtn:setActive(self.showBack)
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:showBackBtn()
self.showBack=true
self.goBtn:setActive(self.showBack)
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:refreshList(onlyAnim)
local roundData=self.copyData.roundData
self.employeeList:setChildLayoutGroupCreateItems(roundData.len)
local items=self.employeeList:getChildLayoutGroupGridList()
local enterSeq=Lua.SequenceProxy.New()
enterSeq:AppendInterval(0.5)
for index=1,items.Count do
local item=items[index-1]
local data=roundData.list[index]
local discipleID=data.param_1
local levelUpID=nil
for _,id in ipairs(self.copyData.discipleList)do
local newId=self.info:doItemStarUp(id,discipleID)
if newId then
levelUpID=newId
break
end
end
local recruitFlag=data.param_2==1
local discipleServer=self.config.disciple[discipleID]
local levelUpServer=discipleServer
if levelUpID then
levelUpID=recruitFlag and(levelUpID-1)or levelUpID
levelUpServer=self.config.disciple[levelUpID]
end
local discipleAttr=self.config.discipleAttr
local contains=levelUpID~=nil
local momsterId=discipleServer[1]
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,momsterId)
local modelParams=monsterCfg.modelid
local attrCfg=levelUpID and discipleAttr[levelUpID]or discipleAttr[discipleID]
local gfList=self.config.discipleGFSkill[discipleID]
local tmList=self.config.discipleTM[discipleID]
local price=discipleServer[3]
local jingjielv=self.config.discipleJJ[discipleID]
local color=levelUpServer[5]
local job=discipleServer[6]
local star=self.info:getCopyItemStar(discipleID)
local attrLookup=attrListHelper.tramsformToLookup(attrCfg)
local priceStr=price<=self.copyData.money and price or FMT.cfmt2("#ee0000",price)
item:SetChildCSImageIcon(_itemCmp.costIcon,iconHelper.getIconName(self.config.chanceMoney),false)
item:SetChildText(_itemCmp.costNum,priceStr)
item:ForceLayoutRect(_itemCmp.costRoot)
item:SetChildButtonClick(_itemCmp.recruitBtn,function()
self:onClickRecruit(index)
end)
item:SetChildActive(_itemCmp.recruited,recruitFlag)
item:SetChildLayoutGroupCreateItems(_itemCmp.starList,star)
item:SetChildButtonClick(_itemCmp.tmBack,function()
if self.tweener or not self.showList then return end
local last=index>2
local tempVec1=Vector2.New(not last and 1 or 0,0.5)
local tempVec2=Vector2.New(last and 1 or 0,0.5)
local args={
tmList=tmList,
job=job,
}
self:showWindow("UIDiscipleTianMingTipsCommonWin",args)
end)
item:SetChildActive(_itemCmp.tips,contains)
item:SetChildActive(_itemCmp.recruitBtn,not recruitFlag)
item:SetChildUIModelShowTarget(_itemCmp.model,modelParams[1],1,modelParams[2],eAnimationID.stand,false,false,0)
item:SetChildButtonClick(_itemCmp.model,function()
if self.tweener or not self.showList then return end
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
roleList={
{
disciple=discipleID,
weapon=nil,
}
},
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",args)
end)
item:SetChildCSImageSprite(_itemCmp.color,_abName,FMT.fmt("image_chiseshilian_pz{0}",color))
if _bgColorSpine[color]then
item:SetChildUIModelShowTarget(_itemCmp.bgColor,_bgColorSpine[color],1,{},eAnimationID.stand,false,false,0)
else
item:SetChildUIModelRemoveTarget(_itemCmp.bgColor)
end
item:SetChildCSImageSprite(_itemCmp.job,globalABLookup.global,UIDiscipleModel:getJobIconName(job))
item:SetChildText(_itemCmp.name,monsterCfg.name)
item:SetChildText(_itemCmp.jingjie,UIDiscipleModel:getJJName3(jingjielv))
for i,v in ipairs(_itemCmp.attr)do
local attrValue=attrLookup[i]or 0
local attrStr=helper.getAttributeStr(i,attrValue,2,"{0}：{1}")
item:SetChildText(v,attrStr)
end
for i,v in ipairs(_itemCmp.gfSkill)do
local gfData=gfList[i]
local have=gfData~=nil
item:SetChildActive(v,have)
if have then
local skillId=gfData[1]
local skillLv=gfData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
local widget=item:GetChildWidgetBase(v)
widget:SetChildActive(_itemGFCmp.sign,is_bd)
widget:SetChildCSImageIcon(_itemGFCmp.icon,iconHelper.getSkillIcon(skillCfg.icon),false)
widget:SetChildButtonClick(_itemGFCmp.back,function()
if self.tweener or not self.showList then return end
local args={
skillID=skillId,
skillLv=skillLv,
fromCfg=skillCfg,
}
self:showWindow("UIDiscipleJobSkillTipsWin",args)
end)
end
end
if onlyAnim then
item:SetChildModelAnimationState(_itemCmp.background,_animationID.enter,1)
else
item:SetChildUIModelShowTarget(_itemCmp.background,6495,1,{},_animationID.enter,false,false,0)
end
local seq=Lua.SequenceProxy.New()
local tweener1=item:SetChildCanvasGroupDOFade(_itemCmp.root,1,0.20)
local tweener2=item:SetChildCanvasGroupDOFade(_itemCmp.bgColor,1,0.20)
seq:AppendInterval(0.233)
seq:Append(tweener1)
seq:Join(tweener2)
enterSeq:Join(seq)
end
enterSeq:AppendCallback(function()
self.tweener=nil
self.showList=true
end)
self.tweener=enterSeq
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:onClickRecruit(index)
if self.tweener or not self.showList then return end

local roundData=self.copyData.roundData
local data=roundData.list[index]
local recruitFlag=data.param_2==1
if recruitFlag then
UIManager.info("已招募弟子")
return
end


local discipleID=data.param_1
local discipleCfg=self.config.disciple[discipleID]
if self.copyData.money<discipleCfg[3]then
UIManager.error("货币不足")
tipsManager.showTips({itemid=self.config.chanceMoney})
return
end






AudioManager.playAudio(533)
call_activitiesHandle_func("activitiesHandle_chisejindi","reqSelectCopyItem",self.actId,self.subId,index)

end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:closeList()
local items=self.employeeList:getChildLayoutGroupGridList()
local exitSeq=Lua.SequenceProxy.New()
exitSeq:AppendInterval(0.5)
for i=1,items.Count do
local item=items[i-1]
item:SetChildModelAnimationState(_itemCmp.background,_animationID.exit,1)
local tweener1=item:SetChildCanvasGroupDOFade(_itemCmp.root,0,0.2)
local tweener2=item:SetChildCanvasGroupDOFade(_itemCmp.bgColor,0,0.2)
exitSeq:Join(tweener1)
exitSeq:Join(tweener2)
end
exitSeq:AppendCallback(function()
self.tweener=nil
self.showList=false

if self.waitRefresh then
self:refreshMoneyNum(true)
self:refreshList(true)
self.waitRefresh=nil
end
end)
self.tweener=exitSeq
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3:setItemRecruit(index)
local item=self.employeeList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_itemCmp.recruited,true)
item:SetChildActive(_itemCmp.recruitBtn,false)
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3.on_249_238(actId,subId,index)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoneyNum()
_this:setItemRecruit(index)
_this:showBackBtn()
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3.on_249_239(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
if _this.tweener then
_this.waitRefresh=true
else
_this:refreshMoneyNum(true)
_this:refreshList(true)
end
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin3.on_249_241(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoneyNum()
end
end
