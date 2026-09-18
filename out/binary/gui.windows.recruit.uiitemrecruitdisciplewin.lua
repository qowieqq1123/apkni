







def_class("UIItemRecruitDiscipleWin",UIWindowBase)









function UIItemRecruitDiscipleWin:bindComponents()

self.Root=UIButton.get(self,0)
self.modelImage=UIObject.get(self,1)
self.NameTx=UIText.get(self,2)
self.JobTx=UIText.get(self,3)
self.pinzhi=UIImage.get(self,4)
self.modelObj=UIObject.get(self,5)
self.skills=UIObject.get(self,6)
self.specialityList=UIObject.get(self,7)
self.discipleDesc=UIText.get(self,8)
self.discipleSpeciality=UIObject.get(self,9)
self.newFlag=UIObject.get(self,10)
self.TxEnter=UIObject.get(self,11)
self.shareBtn=UIButton.get(self,12)
self.shareReward=UIObject.get(self,13)
self.shareRewardIcon=UIObject.get(self,14)
self.shareRewardCount=UIText.get(self,15)

self.Root:setButtonClick(function()self:onRoot()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIItemRecruitDiscipleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.NameTx);self.NameTx=nil;
_UIObject_release(self.JobTx);self.JobTx=nil;
_UIObject_release(self.pinzhi);self.pinzhi=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.skills);self.skills=nil;
_UIObject_release(self.specialityList);self.specialityList=nil;
_UIObject_release(self.discipleDesc);self.discipleDesc=nil;
_UIObject_release(self.discipleSpeciality);self.discipleSpeciality=nil;
_UIObject_release(self.newFlag);self.newFlag=nil;
_UIObject_release(self.TxEnter);self.TxEnter=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.shareReward);self.shareReward=nil;
_UIObject_release(self.shareRewardIcon);self.shareRewardIcon=nil;
_UIObject_release(self.shareRewardCount);self.shareRewardCount=nil;
end



















function UIItemRecruitDiscipleWin:onLoaded(...)
self:bindComponents()
end


function UIItemRecruitDiscipleWin:__delete()
UIRecruitModel:setItemRecruitDiscipleWindowState(false)
roleAudioController:stopRoleSpeak()
self:unbindComponents()




end




function UIItemRecruitDiscipleWin:onShow(argtable,afterOnloaded)
self:showWindow("UITopMaskWin")
self.disciple=argtable.disciple
self.callback=argtable.callback
self.isFullOpen=argtable.isFullOpen
self:refresh()
end


function UIItemRecruitDiscipleWin:onHide()

end

function UIItemRecruitDiscipleWin:refresh()
self.Root:setActive(true)

local abName='ui/windows/world/sharedtextures/dashijie_showdisciple_altas.ab'

local diziId=UIDiscipleModel:getDiscipleID(self.disciple)

local sameIdDiscipleCount=UIDiscipleModel:getSameIdDiscipleCount(diziId)
local isNew=true
if sameIdDiscipleCount>1 then
isNew=false
end

self.newFlag:setActive(isNew)


self.NameTx:setText(UIDiscipleModel:getDiscipleName(self.disciple))
self.JobTx:setText(UIDiscipleModel:getJobName(UIDiscipleModel:getDiscipleJob(self.disciple)))



local specialDesc=""
local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,diziId)
if diziCfg and diziCfg.specialDesc then
specialDesc=diziCfg.specialDesc
end
self.discipleDesc:setText(specialDesc)

local info=UIDiscipleModel:getDiscipleImageInfo(self.disciple)
if info then
local insideModel=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
self.modelImage:setChildUIModelShowTarget(insideModel.body,insideModel.scale,insideModel.componets,0)



local otherParam=diziCfg.insideShow and diziCfg.insideShow[2]or nil
if otherParam then
if otherParam.offset then
self.winlua:SetChildUIModelShowTargetOffset(self.modelImage:getID(),otherParam.offset[1]or 0,otherParam.offset[2]or 0)
end
if otherParam.scale then
self.winlua:SetChildUIModelShowScale(self.modelImage:getID(),otherParam.scale)
end
end


if info.color<=3 then

self.pinzhi:setActive(false)
else
self.pinzhi:setActive(true)
if info.color==4 then
self.pinzhi:setCSImageSprite(abName,FMT.fmt('image_huodedzui_2',info.color))
elseif info.color==5 then
self.pinzhi:setCSImageSprite(abName,FMT.fmt('image_huodedzui_1',info.color))
end
end


local skillList=UIDiscipleModel:getDiscipleJobSkillList(self.disciple)
self.skills:setChildLayoutGroupCreateItems(#skillList)
local items=self.skills:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local sdata=skillList[i+1]
local skillID=sdata[1]
local skillLv=sdata[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)
item:SetChildButtonClick(3,function()
UIManager:showWindow('UIDiscipleJobSkillTipsWin',{skillID=skillID,skillLv=skillLv,attend=1})
end)
end


local tmLv=UIDiscipleModel:getTianMingLevel(self.disciple)
if tmLv>=0 then

self.discipleSpeciality:setActive(true)

local allDesclist=UIDiscipleModel:getDiscipleSpecialityConfig(self.disciple,true)



self.desclist={}
for i,v in ipairs(allDesclist)do
if v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eSpiritClient then

table.insert(self.desclist,v)
end
end

local dataNum=#self.desclist
self.specialityList:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.specialityList:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=self.desclist[i]
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItemExx(item,cfg)
item:SetChildButtonClick(1,function()
self:onDescSlotClick(i)
end)

local showEffect=cfg.effectID~=nil
item:SetChildActive(2,showEffect)
if showEffect then
item:SetChildAnimationStringID(2,cfg.effectID,true)
end
end
end
else

self.discipleSpeciality:setActive(false)
end


self:refreshShareBtn(info.color)
else
loggerUtil.logErrFMT("没有弟子GUID:{0}",tostring(self.disciple))
end
roleAudioController:playRoleSpeak(self.disciple,roleAudioNodeType.ZhaoMuChengGong)
end

function UIItemRecruitDiscipleWin:showNext(guid)
self.disciple=guid
self.Root:setActive(false)
self.TxEnter:setChildShowEffect(10072,true)
self:refresh()
end


function UIItemRecruitDiscipleWin:refreshShareRewardShow()
local shareType=shareImageModel:getShareTypeByWinName(self.window_name)
local isShow=false
if shareType then
local canGetNum=shareImageModel:getShareRewardCanGetNumByType(shareType)
isShow=canGetNum>0
end
self.shareReward:setActive(isShow)
if isShow then

local rewards=cfgHelper.get(cfg_yaoqingmadailyconfig_get,shareType,"rewards")
if rewards then

local reward=rewards[1]
local itemId=reward[1]
local itemCount=reward[2]
local countStr=mathHelper.formatNumber(itemCount)
self.shareRewardIcon:setChildIcon(iconHelper.getIconName(itemId),false)
self.shareRewardCount:setText(countStr)
end
end
end


function UIItemRecruitDiscipleWin:refreshShareBtn(color)
local showShareBtn=shareImageModel:IsShareDzBtnCanShow(color)
self.shareBtn:setActive(showShareBtn)
if not showShareBtn then
return
end

self:refreshShareRewardShow()
end




function UIItemRecruitDiscipleWin:onRoot()
local cb=self.callback
local hasNext=false
local nextGuid=nil

if UIRecruitModel:getShowRecruitDiscipleQueueSize()>0 then

hasNext=true
local data=UIRecruitModel:pushShowRecruitDiscipleQueue()
nextGuid=data.guid
end

if not hasNext then
local diziId=UIDiscipleModel:getDiscipleID(self.disciple)

if self.isFullOpen==false then
self:closeSelf()
else
UIRecruitControl:closeUI()
end

local dzCfg=cfgHelper.get1(cfg_discipleconfig_get,diziId)
if dzCfg and dzCfg.specialAppear and isometricMapSystem:IsInHome()then
storyAIManager:startStoryBehavior(dzCfg.specialAppear)
end
end

if cb then
cb()
end

if hasNext then
self.callback=nil
return self:showNext(nextGuid)
end
end

function UIItemRecruitDiscipleWin:onDescSlotClick(idx)
local cfg=self.desclist[idx]
local item=self.specialityList:getChildLayoutGroupGridItem(idx-1)
local netData=UIDiscipleModel:getDiscipleData(self.disciple)

if UIDiscipleModel.onClickClientSpeciality(item,netData,cfg,eDirectionType.eLeft)then
return
end

UIManager:showWindow('UISpecialityWin',{item=item,node='left',guid=self.disciple,config=cfg,pivot=Vector2.New(0.5,0)})
end

function UIItemRecruitDiscipleWin:addCallback(callback)
self.callback=callback
end

function UIItemRecruitDiscipleWin:onShareBtn()
local shareShowType=shareImageModel:getShareShowTypeByWinName(self.window_name)
local param={
disciple_guid=self.disciple,
}
shareImageController:showShareImageWin(shareShowType,param)
end
