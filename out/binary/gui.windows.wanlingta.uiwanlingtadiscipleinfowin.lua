







def_class("UIWanLingTaDiscipleInfoWin",UIWindowBase)









function UIWanLingTaDiscipleInfoWin:bindComponents()

self.changeAnimBtn=UIButton.get(self,0)
self.discipleList=UILoopListView.new(self,1)
self.discipleModel=UIObject.get(self,2)
self.dynamicBtn=UIButton.get(self,3)
self.dynamicImageBtn=UIButton.get(self,4)
self.fightBtn=UIButton.get(self,5)
self.fightContent=UIObject.get(self,6)
self.fightPanel=UIObject.get(self,7)
self.jobIcon=UIImage.get(self,8)
self.name=UIText.get(self,9)
self.showBackBtn=UIButton.get(self,10)
self.showBackFlag=UIObject.get(self,11)
self.spSwitchBtn=UIButton.get(self,12)
self.storyBtn=UIButton.get(self,13)
self.storyContent=UIObject.get(self,14)
self.storyPanel=UIObject.get(self,15)
self.tmRewardBtn=UIButton.get(self,16)
self.tmRewardReddot=UIObject.get(self,17)

self.changeAnimBtn:setButtonClick(function()self:onChangeAnimBtn()end)

self.discipleList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.dynamicBtn:setButtonClick(function()self:onDynamicBtn()end)

self.dynamicImageBtn:setButtonClick(function()self:onDynamicImageBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.showBackBtn:setButtonClick(function()self:onShowBackBtn()end)

self.spSwitchBtn:setButtonClick(function()self:onSpSwitchBtn()end)

self.storyBtn:setButtonClick(function()self:onStoryBtn()end)

self.tmRewardBtn:setButtonClick(function()self:onTmRewardBtn()end)



end


function UIWanLingTaDiscipleInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changeAnimBtn);self.changeAnimBtn=nil;
self.discipleList:deleteSelf();self.discipleList=nil;
_UIObject_release(self.discipleModel);self.discipleModel=nil;
_UIObject_release(self.dynamicBtn);self.dynamicBtn=nil;
_UIObject_release(self.dynamicImageBtn);self.dynamicImageBtn=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.fightContent);self.fightContent=nil;
_UIObject_release(self.fightPanel);self.fightPanel=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.showBackBtn);self.showBackBtn=nil;
_UIObject_release(self.showBackFlag);self.showBackFlag=nil;
_UIObject_release(self.spSwitchBtn);self.spSwitchBtn=nil;
_UIObject_release(self.storyBtn);self.storyBtn=nil;
_UIObject_release(self.storyContent);self.storyContent=nil;
_UIObject_release(self.storyPanel);self.storyPanel=nil;
_UIObject_release(self.tmRewardBtn);self.tmRewardBtn=nil;
_UIObject_release(self.tmRewardReddot);self.tmRewardReddot=nil;
end


















local pageType={
story=1,
fight=2,
}
local _storyItemCmp={
tmIcon={3,4,5},
}
local animationList={0,21,10,11,20,1000,1001}
local this

function UIWanLingTaDiscipleInfoWin:onLoaded(...)
self:bindComponents()
this=self
self.type=eWanLingTaShowcaseType.eXYHL
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)

self.loopListView=self.winlua:GetChildUILoopListView(self.discipleList:getID())
self.loopListView:SetAction(function(...)
if not self or self.isClose then return end
self:freshLoopAction(...)
end,function()
if not self or self.isClose then return end
self:startLoopAction()
end)
end


function UIWanLingTaDiscipleInfoWin:__delete()
self:unbindComponents()
this=nil
end

function UIWanLingTaDiscipleInfoWin:startLoopAction()
end




function UIWanLingTaDiscipleInfoWin:onShow(argtable,afterOnloaded)
self.dzListData=argtable.data
self.tjId2IdxLookup={}
for idx,v in ipairs(self.dzListData)do
self.tjId2IdxLookup[v.id]=idx
end
self.selectIdx=argtable.index or 1
self.cur_anim=1
self.page=pageType.story
self.artIdx=1
self.modelArgs={1}
self.storyPanel:setActive(true)
self.fightPanel:setActive(false)
self.showBack=false
self.showBackFlag:setActive(self.showBack)
self:refreshDiscipleLeftList()
self:refreshDiscipleInfo()
self:refreshDiscipleModel()
self.loopListView:JumpIndex(self.selectIdx-1)
end

function UIWanLingTaDiscipleInfoWin.onWanLingTaTuJianChange(tjId,tjLevel)
if not this then return end
local dataIndex=this.tjId2IdxLookup[tjId]
if dataIndex then
this:refrshTianMingRewardReddot()
this:refreshItemReddot(nil,dataIndex)
end
end

function UIWanLingTaDiscipleInfoWin:refrshTianMingRewardReddot()
local tjId=self.dzListData[self.selectIdx].id
local reddot=wanLingTaModel:checkTuJianReddot(tjId)
self.tmRewardReddot:setActive(reddot)
end


function UIWanLingTaDiscipleInfoWin:refreshDiscipleLeftList()
local dataNum=#self.dzListData
local prefablist={}
local itemidlist={}
for i=1,dataNum do
prefablist[#prefablist+1]='disItem'
itemidlist[#itemidlist+1]=0
end
self.loopListView:InitDataList(dataNum,prefablist,itemidlist,nil,nil)
end

function UIWanLingTaDiscipleInfoWin:freshLoopAction(i,item)
local index=i+1
self:refreshDiscipeItem(index,item)
end

function UIWanLingTaDiscipleInfoWin:refreshDiscipeItem(index,item)
if not item then
item=self.loopListView:GetItemWidget(index-1)
end
local dzid=self.dzListData[index].dzId
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzid)
local imageInfo=dzData.imageInfo

local func=function()
self:on_select_dis(index)
end
item:SetChildButtonClick(-1,func,true)
comHelper.setChildModelHeadIconBGByColor(item,0,imageInfo.color)

comHelper.setChildModelRawImageByDiziId(item,dzid,1,0,eHeadCenterType.eHead)

local isSelect=index==self.selectIdx
item:SetChildActive(2,isSelect)

self:refreshItemReddot(item,index)
end

function UIWanLingTaDiscipleInfoWin:on_select_dis(idx)
if self.selectIdx==idx then return end
local item=self.loopListView:GetItemWidget(self.selectIdx-1)
if item then
item:SetChildActive(2,false)
end
self.selectIdx=idx
item=self.loopListView:GetItemWidget(self.selectIdx-1)
item:SetChildActive(2,true)
self.cur_anim=1
self.artIdx=1
self.modelArgs={1}
self:refreshDiscipleInfo()
self:refreshDiscipleModel()
end

function UIWanLingTaDiscipleInfoWin:refreshItemReddot(item,idx)
if item==nil then
item=self.loopListView:GetItemWidget(idx-1)
end

if item~=nil then
local tjId=self.dzListData[idx].id
local reddot=wanLingTaModel:checkTuJianReddot(tjId)
item:SetChildActive(3,reddot)
end
end

function UIWanLingTaDiscipleInfoWin:refreshDiscipleInfo()
local dzid=self.dzListData[self.selectIdx].dzId
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzid)
local imageInfo=dzData.imageInfo
self.jobIcon:setSprite(globalABLookup.global,UIDiscipleModel:getJobIconName(imageInfo.job))
self.name:setText(dzData.disciplename)
if self.page==pageType.story then
self:refreshStoryIdx()
self:refreshStory()
else
self:refreshFight()
end
self:refrshTianMingRewardReddot()
local showSpSwitchBtn=self.dzListData[self.selectIdx].spDzId~=nil
self.spSwitchBtn:setActive(showSpSwitchBtn)
end

function UIWanLingTaDiscipleInfoWin:refreshStoryIdx()
local dzid=self.dzListData[self.selectIdx].dzId
if self.dzListData[self.selectIdx].spDzId then
dzid=self.dzListData[self.selectIdx].spDzId
end
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
local dzNowTmLv=dzData and(dzData.tmlv or-1)or-1
local tj_id=self.dzListData[self.selectIdx].id
local tj_conf=wanLingTaModel:getTuJianConfig(tj_id)
local tj_data=wanLingTaModel:getTuJianData(tj_id)
local tj_lv=tj_data.level
local story=tj_conf.story
local unlockLv,storyId=unpack(story[1])
local needTmLv=tj_conf.activeUp[unlockLv]
local isActive=tj_lv>=unlockLv or dzNowTmLv>=needTmLv
if isActive then
self.storyIdx=1
else
self.storyIdx=nil
end
end


function UIWanLingTaDiscipleInfoWin:refreshStory()
local dzid=self.dzListData[self.selectIdx].dzId
if self.dzListData[self.selectIdx].spDzId then
dzid=self.dzListData[self.selectIdx].spDzId
end
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
local dzNowTmLv=dzData and(dzData.tmlv or-1)or-1
local tj_id=self.dzListData[self.selectIdx].id
local tj_conf=wanLingTaModel:getTuJianConfig(tj_id)
local tj_data=wanLingTaModel:getTuJianData(tj_id)
local tj_lv=tj_data.level
local story=tj_conf.story
self.storyContent:setChildLayoutGroupCreateItems(#story,function(index)
local storyItem=self.storyContent:getChildLayoutGroupGridItem(index-1)
local unlockLv,storyId=unpack(story[index])
local needTmLv=tj_conf.activeUp[unlockLv]
local isActive=tj_lv>=unlockLv or dzNowTmLv>=needTmLv
local storyCfg=cfg_xumitaxyhlstoryconfig_get(storyId)

storyItem:SetChildActive(0,isActive)

storyItem:SetChildActive(1,not isActive)

storyItem:SetChildText(2,storyCfg.name)

if not isActive then
local chong=UIDiscipleModel.getTianMingLevelChong(needTmLv)
local floor=UIDiscipleModel.getTianMingLevelFloor(needTmLv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
for i,cmp in ipairs(_storyItemCmp.tmIcon)do
if chong>=i then
storyItem:SetChildActive(cmp,true)
storyItem:SetChildCSImageSprite(cmp,abName,iconName)
else
storyItem:SetChildActive(cmp,false)
end
end
end

storyItem:SetChildActive(6,index~=self.storyIdx)

storyItem:SetChildActive(7,index==self.storyIdx)

storyItem:SetChildActive(8,index~=self.storyIdx)

storyItem:SetChildActive(9,index==self.storyIdx)

storyItem:SetChildButtonClick(10,function()
if isActive and self and not self.isClose then
self:onClickStory(index)
end
end)

storyItem:SetChildText(11,storyCfg.txt)
storyItem:SetChildActive(11,index==self.storyIdx)

local reddot=false
storyItem:SetChildActive(12,reddot)
end)
end

function UIWanLingTaDiscipleInfoWin:onClickStory(index)
local tj_id=self.dzListData[self.selectIdx].id
local tj_conf=wanLingTaModel:getTuJianConfig(tj_id)
local tj_data=wanLingTaModel:getTuJianData(tj_id)
local tj_lv=tj_data.level
local story=tj_conf.story
local unlockLv=story[index][1]
local isActive=true
if not isActive then














else
self:expandAndCollapseStoryDesc(false)
if self.storyIdx==index then
self.storyIdx=nil
else
self.storyIdx=index
end
self:expandAndCollapseStoryDesc(true)
end
end

function UIWanLingTaDiscipleInfoWin:expandAndCollapseStoryDesc(open)
if self.storyIdx then
local storyItem=self.storyContent:getChildLayoutGroupGridItem(self.storyIdx-1)

storyItem:SetChildActive(6,not open)

storyItem:SetChildActive(7,open)

storyItem:SetChildActive(8,not open)

storyItem:SetChildActive(9,open)

storyItem:SetChildActive(11,open)
end
end

function UIWanLingTaDiscipleInfoWin:refreshFight()
local tj_id=self.dzListData[self.selectIdx].id
local tj_conf=wanLingTaModel:getTuJianConfig(tj_id)
local isSwitching=self.dzListData[self.selectIdx].isSwitching
local artModel=isSwitching and tj_conf.artModel.switch or tj_conf.artModel
local artModelTemp={}
for idx,artId in ipairs(artModel)do
local artCfg=cfg_xumitaxyhlzdxxconfig_get(artId)
local isActive=self:checkUnlockFight(artCfg.conditions)
local sort=isActive and idx or(idx+10000000)
table.insert(artModelTemp,{id=artId,sortOrder=sort})
end
table.sort(artModelTemp,function(a,b)
return a.sortOrder<b.sortOrder
end)
if self.artIdx>#artModelTemp then
self.artIdx=1
else
local artId=artModelTemp[self.artIdx].id
local artCfg=cfg_xumitaxyhlzdxxconfig_get(artId)
local isActive=self:checkUnlockFight(artCfg.conditions)
if not isActive then
self.artIdx=1
end
end
local artId=artModelTemp[self.artIdx].id
local artCfg=cfg_xumitaxyhlzdxxconfig_get(artId)
self.modelArgs=artCfg.modelArgs
self.fightContent:setChildLayoutGroupCreateItems(#artModelTemp,function(index)
local fightItem=self.fightContent:getChildLayoutGroupGridItem(index-1)
local artId=artModelTemp[index].id
local artCfg=cfg_xumitaxyhlzdxxconfig_get(artId)
local isActive=self:checkUnlockFight(artCfg.conditions)

fightItem:SetChildActive(0,isActive)

fightItem:SetChildActive(1,not isActive)
if not isActive then
fightItem:SetChildButtonClick(1,function()
UIManager.error(artCfg.lockStr)
end)
end

fightItem:SetChildText(2,artCfg.name)

fightItem:SetChildActive(3,index~=self.artIdx)

fightItem:SetChildActive(4,index==self.artIdx)

fightItem:SetChildText(5,artCfg.lockStr)

fightItem:SetChildButtonClick(6,function()
if self and not self.isClose then
self:onClickFight(index,artCfg)
end
end)
end)
end

function UIWanLingTaDiscipleInfoWin:checkUnlockFight(cdn)
local type=cdn[1]
if type==1 then
return true
elseif type==2 then
local jjlv=cdn[2]
local dzid=self.dzListData[self.selectIdx].dzId
if self.dzListData[self.selectIdx].spDzId then
dzid=self.dzListData[self.selectIdx].spDzId
end
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
local nowLv=dzData and(dzData.jingjielv or 0)or 0
if nowLv<jjlv then
nowLv=wanLingTaModel:getDiscipleHighestLevel(dzid)
end
return jjlv<=nowLv
elseif type==3 then
local clothItemid=cdn[2]
return ClothingHelper.checkClothAcitveAndFullStar(clothItemid)
end
return true
end

function UIWanLingTaDiscipleInfoWin:onClickFight(index,artCfg)
if self.artIdx==index then
return
end
local fightItem=self.fightContent:getChildLayoutGroupGridItem(self.artIdx-1)
fightItem:SetChildActive(3,true)
fightItem:SetChildActive(4,false)
self.artIdx=index
fightItem=self.fightContent:getChildLayoutGroupGridItem(self.artIdx-1)
fightItem:SetChildActive(3,false)
fightItem:SetChildActive(4,true)
self.modelArgs=artCfg.modelArgs
self:refreshDiscipleModel()
end

function UIWanLingTaDiscipleInfoWin:refreshDiscipleModel()
local dzid=self.dzListData[self.selectIdx].dzId
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzid)
local imageInfo=dzData.imageInfo
if self.page==pageType.story then
local args={bgFisrt=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo,args)
self.discipleModel:setChildUIModelRemoveTarget()
comHelper.setChildInSideModelEx(self.discipleModel,modelParams,0.85,nil,0,0,false,false,0.5)
else
self.dynamicImageBtn:setActive(false)
local args={}
if self.showBack then
args.tmLv=15
end
if self.modelArgs[1]==2 then
args.xianmo_voc=self.modelArgs[2]
elseif self.modelArgs[1]==3 then
args.clothingId=self.modelArgs[2]
if self.showBack then
args.clothingStar=ClothingConfig.getStarMaxLv(self.modelArgs[2])
end
if self:isShowLiHuiBtn(args.clothingId)then
self.dynamicImageBtn:setActive(true)
end
end
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,nil,args)
self.discipleModel:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,animationList[self.cur_anim],false,false,0.5)
self.discipleModel:setChildUIModelShowTargetOffset(0,-85)
end
end

function UIWanLingTaDiscipleInfoWin:onChangeAnimBtn()
if self.page==pageType.fight then
self.cur_anim=self.cur_anim+1
if self.cur_anim>#animationList then
self.cur_anim=1
end
self.discipleModel:setChildModelAnimationState(animationList[self.cur_anim])
end
end

function UIWanLingTaDiscipleInfoWin:onStoryBtn()
if self.page==pageType.story then
return
end
self.page=pageType.story
self.storyPanel:setActive(true)
self.fightPanel:setActive(false)
self:refreshDiscipleModel()
self:refreshStory()
end

function UIWanLingTaDiscipleInfoWin:onFightBtn()
if self.page==pageType.fight then
return
end
self.page=pageType.fight
self.storyPanel:setActive(false)
self.fightPanel:setActive(true)
self.cur_anim=1
self:refreshDiscipleModel()
self:refreshFight()
end

function UIWanLingTaDiscipleInfoWin:onShowBackBtn()
self.showBack=not self.showBack
self.showBackFlag:setActive(self.showBack)
self:refreshDiscipleModel()
end

function UIWanLingTaDiscipleInfoWin:onDynamicBtn()
local dzId=self.dzListData[self.selectIdx].dzId
local tjId=self.dzListData[self.selectIdx].id
local isSwitching=self.dzListData[self.selectIdx].isSwitching
self:showWindow("UIDiscipleLiHuiShowWin",{dzId=dzId,tjId=tjId,isSwitching=isSwitching})
end

function UIWanLingTaDiscipleInfoWin:onTmRewardBtn()
local tjId=self.dzListData[self.selectIdx].id
self:showWindow("UIWanLingTa_TianMingRewardWin",{tjId=tjId})
end

function UIWanLingTaDiscipleInfoWin:isShowLiHuiBtn(itemid)
local dzId=self.dzListData[self.selectIdx].dzId
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzId)
local imageInfo=dzData.imageInfo
local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,imageInfo.body)
if bodyCfg.clothing_map and itemid then
local change=bodyCfg.clothing_map[itemid]
if change then
return true
end
end
return false
end

function UIWanLingTaDiscipleInfoWin:onDynamicImageBtn()
local clothingId=self.modelArgs[2]
local dzId=self.dzListData[self.selectIdx].dzId
local tjId=self.dzListData[self.selectIdx].id
self:showWindow("UIDiscipleLiHuiShowWin",{dzId=dzId,tjId=tjId,itemid=clothingId})
end

function UIWanLingTaDiscipleInfoWin:onSpSwitchBtn()
local isSwitching=self.dzListData[self.selectIdx].isSwitching
isSwitching=not isSwitching
self.dzListData[self.selectIdx].isSwitching=isSwitching
if isSwitching then
self.dzListData[self.selectIdx].dzId=self.dzListData[self.selectIdx].switchDzId
else
self.dzListData[self.selectIdx].dzId=self.dzListData[self.selectIdx].spDzId
end
self:refreshDiscipeItem(self.selectIdx)
self:refreshDiscipleInfo()
if self.page==pageType.fight then
self:refreshFight()
end
self:refreshDiscipleModel()
end