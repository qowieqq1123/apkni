







def_class("UIDiscipleMainWin",UIWindowBase)









function UIDiscipleMainWin:bindComponents()

self.copyBtn=UIButton.get(self,0)
self.discipleList=UILoopListView.new(self,1)
self.gongLueBtn=UIButton.get(self,2)
self.gongLueReddot=UIObject.get(self,3)
self.presetBtn=UIButton.get(self,4)
self.presetNum=UIText.get(self,5)
self.presetNumBg=UIObject.get(self,6)
self.presetReddot=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.shareBtn=UIButton.get(self,9)
self.shareReward=UIObject.get(self,10)
self.shareRewardCount=UIText.get(self,11)
self.shareRewardIcon=UIObject.get(self,12)

self.copyBtn:setButtonClick(function()self:onCopyBtn()end)

self.discipleList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.gongLueBtn:setButtonClick(function()self:onGongLueBtn()end)

self.presetBtn:setButtonClick(function()self:onPresetBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIDiscipleMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.copyBtn);self.copyBtn=nil;
self.discipleList:deleteSelf();self.discipleList=nil;
_UIObject_release(self.gongLueBtn);self.gongLueBtn=nil;
_UIObject_release(self.gongLueReddot);self.gongLueReddot=nil;
_UIObject_release(self.presetBtn);self.presetBtn=nil;
_UIObject_release(self.presetNum);self.presetNum=nil;
_UIObject_release(self.presetNumBg);self.presetNumBg=nil;
_UIObject_release(self.presetReddot);self.presetReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.shareReward);self.shareReward=nil;
_UIObject_release(self.shareRewardCount);self.shareRewardCount=nil;
_UIObject_release(self.shareRewardIcon);self.shareRewardIcon=nil;
end
















local WriteInCopyBuffer=CS.UIHelper.WriteInCopyBuffer

local PageSlotConfig=
{
[1]={

wins={'UIDiscipleRoleInfo2Win','UIDiscipleRoleInfoThreeWin','UIDiscipleRoleInfoTwoWin','UIDiscipleRoleInfoChuiWeiWin'},
},
[2]={

wins={'UIDiscipleRoleAttrWin'},
},
[3]={

wins={'UIDiscipleRoleInfo2Win','UIEquipWin','UIDiscipleRoleInfoThreeWin'},
},
[4]={

wins={'UIDiscipleRoleInfoWin','UIDiscipleSkillInfoWin'},
},
[5]={

wins={'UIDiscipleRoleInfoWin','UIDiscipleTianMingWin'},
},
[6]={

wins={'UIDiscipleRoleInfoWin','UIDiscipleLinggenlInfoWin'},
},
}
local maxScrollNum=5
local _this=nil

local HandleSubWin=
{
[item_funtion_type.jj_xiuweidan]={
win='UIDiscipleJingJieWin',
func=function(...)
return{selectPage=1}
end,
check=function(guid)
local checkChuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
return not checkChuiwei
end,
},
[item_funtion_type.jj_tupodan]={
win='UIDiscipleJingJieWin',
func=function(...)
return{selectPage=2}
end,
check=function(guid)
local checkChuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
return not checkChuiwei
end,
},
[item_funtion_type.lt_jingyandan]={
win='UIDiscipleLianTiWin',
check=function(guid)
if not UIDiscipleModel:checkLTOpen(guid,false)then
return false
end
return true
end,
},
}
local _useLoop=api_Available_GetChildLoopTreeView()or false

function UIDiscipleMainWin:onLoaded(...)
_this=self
self:bindComponents()

self.isInitDiscipleList=false
self:addNotify(notifyConfig.onTestModelChange,self.onTestModelChange)
self:addNotify(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)

self:addNotify(notifyConfig.onReddotCatchTypeChange,self.onReddotCatchTypeChange)
self.loopListView=self.winlua:GetChildUILoopListView(self.discipleList:getID())

self.loopListView:SetAction(function(...)
if not self or self.isClose then return end
self:freshLoopAction(...)
end,function()
if not self or self.isClose then return end
self:startLoopAction()
end)
self:refreshGongLueBtn()
self:refreshPresetBtn()

self:showCopyBtn()
end


function UIDiscipleMainWin:__delete()
_this=nil
if self.disciplelist~=nil and#self.disciplelist>0 and self.curDisIndex~=nil then
local data=self.disciplelist[self.curDisIndex]
if data then
data.netData.isnew=nil
end
end
self:unbindComponents()
self.isInitDiscipleList=false
self:closeAllWin()
end

function UIDiscipleMainWin:startLoopAction()

end

function UIDiscipleMainWin:freshLoopAction(i,item)
local index=i+1
self:refreshDiscipeItem(index,item)
end

function UIDiscipleMainWin.onTestModelChange(flag)
if _this==nil or not _this.isVisible then return end

_this:showCopyBtn()
end

function UIDiscipleMainWin:showCopyBtn()
local show=false



show=show and playerController.testModel
self.copyBtn:setActive(show)
end

function UIDiscipleMainWin.onDiscipleRemove(reason,guid)
if _this==nil or not _this.isVisible then return end

if reason==discipleRemoveReason.eKickout then
_this:removeDisciple(guid)
end
end

function UIDiscipleMainWin.onReddotCatchTypeChange(catchType,...)
if _this==nil or _this.isClose==nil then return end
local params={...}
if catchType==CATCH_TYPE.eMoney or catchType==CATCH_TYPE.eItem or catchType==CATCH_TYPE.eZongMenLevel or
catchType==CATCH_TYPE.eDiscipleFightChanged then
_this:refreshAllItemReddot()
elseif catchType==CATCH_TYPE.eDiscipleJJ or catchType==CATCH_TYPE.eDiscipleLT or catchType==CATCH_TYPE.eDiscipleDaoYan or
catchType==CATCH_TYPE.eDiscipleTianMing or catchType==CATCH_TYPE.eDiziChuiWei or catchType==CATCH_TYPE.eDiscipleSpriteRoot then
local guid=params[1]
_this:refreshItemReddotEx(guid)
end
end




function UIDiscipleMainWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
local defaultPage=argtable.showPage or 1
self.selectPage=defaultPage
local showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
self.disciplelist=argtable.disciplelist
self.itemid=argtable.itemid
self.subArgs=argtable.subArgs
if showType==dicipleType.eSystem then
if self.disciplelist==nil then
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local sortParams={true}
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder,sortParams)
self.disciplelist=list
end
end
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
self:refreshWin()
if not self.isInitDiscipleList then
self.isInitDiscipleList=true
self:initLoopRoleListPanel()
self:jumpIndex()
end

self:openExtraSubWin()
roleAudioController:playRoleSpeak(self.disciple_guid,roleAudioNodeType.ZhaoMuChengGong)
self:handOpenCallBack(argtable)
self:refreshPresetNum()
end

function UIDiscipleMainWin:handOpenCallBack(argtable)
if argtable and argtable.opedCallBack then
argtable.opedCallBack()
end
end

function UIDiscipleMainWin:openExtraSubWin()
local itemid=self.itemid
if itemid then
local itemConfig=itemsConfig.getConfig(itemid)
local funcparam=itemConfig.funcparam
if funcparam~=nil then
local funcType=funcparam.type
local openWin=HandleSubWin[funcType]
if openWin then
local check=true
if openWin.check then
check=openWin.check(self.disciple_guid)
end
if check then
local win=openWin.win
local args=self:getOpenExtraSubWinArgs(funcType)
UIManager:showWindow(win,args)
end
end
end
end
end

function UIDiscipleMainWin:getOpenExtraSubWinArgs(funcType)
local openWin=HandleSubWin[funcType]
local func=openWin.func
local args={}
if func then
args=func()
end
args.guid=self.disciple_guid
return args
end

function UIDiscipleMainWin:getShowPage()
return self.selectPage
end

function UIDiscipleMainWin:onShowArgRecv(argtable)
self.selectPage=argtable.showPage
local isJump=false
if argtable.dis_guid~=nil then
self:onSelect({dis_guid=argtable.dis_guid})
isJump=true

if argtable.subArgs~=nil then
self.subArgs=argtable.subArgs
end
end
self:refreshWin()
if isJump then
self:jumpIndex()
end

self:handOpenCallBack(argtable)
end

function UIDiscipleMainWin:onSelect(argtable)
local dis_guid=argtable.dis_guid
if dis_guid~=nil and not mathHelper.compareInt64(self.disciple_guid,dis_guid)then
local found=nil
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,dis_guid)then
found=i
break
end
end
if not found then
return
end

self:on_select_dis(nil,found,nil,nil)
end
end

function UIDiscipleMainWin:refreshWin()
local show_wins={}
local close_wins={}
local cur=PageSlotConfig[self.selectPage]
local cur_wins=cur.wins
if cur_wins and#cur_wins>0 then
for i,v in ipairs(cur_wins)do
show_wins[v]=true
end
end
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
if v==true and show_wins[k]==nil then
close_wins[k]=true
end
end

for k,v in pairs(close_wins)do
UIManager:hideWindow(k)
self.activeWin[k]=false
end
end

if self.activeWin==nil then
self.activeWin={}
end
if cur_wins and#cur_wins>0 then
for i,v in ipairs(cur_wins)do
local args={guid=self.disciple_guid,page=self.selectPage,subArgs=self.subArgs}
if self.activeWin[v]then
local win=UIManager:findActiveWindow(v)
if win then
win:onShow(args)
else
UIManager:showWindowImp(v,args)
end
else
UIManager:showWindowImp(v,args)
self.activeWin[v]=true
end
end
end


self:refreshShareBtn()
end

function UIDiscipleMainWin:closeAllWin()
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
UIManager:closeWindow(k)
end
self.activeWin=nil
roleAudioController:stopRoleSpeak()
end
end

function UIDiscipleMainWin:getDiZiIndex(guid)
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,guid)then
return i
end
end
return nil
end


function UIDiscipleMainWin:initLoopRoleListPanel()
local dataNum=#self.disciplelist
local prefablist={}
local itemidlist={}
for i=0,dataNum do
prefablist[#prefablist+1]='disItem'
itemidlist[#itemidlist+1]=0
end
self.loopListView:InitDataList(dataNum,prefablist,itemidlist,nil,nil)
end

function UIDiscipleMainWin:jumpIndex()
if self.curDisIndex>0 then
self.loopListView:JumpIndex(self.curDisIndex-1)
end
end

function UIDiscipleMainWin:refreshDiscipeItem(i,item)
local netdata=self.disciplelist[i].netData.net
local discipleguid=netdata.discipleguid
local func=function()
self:on_select_dis(1,i)
end
item:SetChildButtonClick(-1,func,true)
comHelper.setChildModelHeadIconBG(item,0,discipleguid)

UIDiscipleModel:setDiscipleXianMoHeadImage(item,8,netdata)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead)

local isSelect=mathHelper.compareInt64(self.disciple_guid,discipleguid)
local isnew=self.disciplelist[i].netData.isnew==true

self:changItemSelect(item,isSelect,isnew)

self:refreshItemReddot(item,i)

self:refreshKetupo(item,i)
end

function UIDiscipleMainWin:changItemSelect(item,isSelect,isnew)
if item~=nil then
item:SetChildActive(3,isSelect)
item:SetChildActive(2,isnew)
end
end

function UIDiscipleMainWin:refreshKetupo(item,idx)
if item==nil then
item=self.loopListView:GetItemWidget(idx-1)
end
if item~=nil then
local netdata=self.disciplelist[idx].netData.net
local discipleguid=netdata.discipleguid
local state=UIDiscipleModel:getDiscipleState(discipleguid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local istopo=(not chuiwei)and UIDiscipleModel:checkJJReddot(discipleguid)
item:SetChildActive(7,istopo)
end
end

function UIDiscipleMainWin:refreshItemReddot(item,idx)
if item==nil then
item=self.loopListView:GetItemWidget(idx-1)
end

if item~=nil then
local netdata=self.disciplelist[idx].netData.net
local discipleguid=netdata.discipleguid

local flag=UIDiscipleModel:checkDiscipleSelectReddot(discipleguid)
item:SetChildActive(6,flag)
end
end

function UIDiscipleMainWin:refreshItemReddotEx(guid)
local idx=self:getDiZiIndex(guid)
if idx then
self:refreshItemReddot(nil,idx)
self:refreshKetupo(nil,idx)
end
end

function UIDiscipleMainWin:refreshAllItemReddot()
for i,v in ipairs(self.disciplelist)do
self:refreshItemReddot(nil,i)
self:refreshKetupo(nil,i)
end
end

function UIDiscipleMainWin:refreshDiscipleList()
self.loopListView:RefreshAllItems()
end

function UIDiscipleMainWin:on_select_dis(id,index)
if self.curDisIndex==index then return end

local old=self.curDisIndex
self.curDisIndex=index
if old then
self.disciplelist[old].netData.isnew=nil
local olditem=self.loopListView:GetItemWidget(old-1)
self:changItemSelect(olditem,false,false)
end
local item=self.loopListView:GetItemWidget(self.curDisIndex-1)

local isNew=self.disciplelist[self.curDisIndex].netData.isnew==true
self:changItemSelect(item,true,isNew)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid

self:onChangeDisciple(dis_guid)
roleAudioController:playRoleSpeak(dis_guid,roleAudioNodeType.ZhaoMuChengGong)
end

function UIDiscipleMainWin:onChangeDisciple(dis_guid)
UIFullDiscipleMainControl:changeAttachValue('dis_guid',dis_guid)
local changeMenu,changeSelect=UIFullDiscipleMainControl:refreshMenu()

if not changeSelect then
local activeWin=self.activeWin
if activeWin~=nil then
for k,v in pairs(activeWin)do
if v==true then
local win=UIManager:findActiveWindow(k)
if win and win.onChangeDisciple then
win:onChangeDisciple(dis_guid)
end
end
end
end

self:refreshShareBtn()

self:refreshPresetNum()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleChangeTab)
end

function UIDiscipleMainWin:removeDisciple(guid)
local found=nil
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,guid)then
found=i
break
end
end
if found then
table.remove(self.disciplelist,found)
if#self.disciplelist>0 then
self.curDisIndex=found-1
if self.curDisIndex<1 then
self.curDisIndex=1
end
local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid
self:initLoopRoleListPanel()
self:onChangeDisciple(dis_guid)
self:jumpIndex()
else
fullScreenUI.closeActiveUI()
end
end
end

function UIDiscipleMainWin:refreshGongLueBtn()
local isshow=systemModel.isOpen(SYSTEM_DEFINE.eDiZiGongLue)
self.gongLueBtn:setActive(isshow)
if isshow then
local firstOpen=userActorSetting.get('fistOpenDZGongLue',false)
local isReddot=not firstOpen
self.gongLueReddot:setActive(isReddot)
end
end

function UIDiscipleMainWin:onGongLueBtn()
userActorSetting.flushVal('fistOpenDZGongLue',true)
self:refreshGongLueBtn()
local list=table.weakCopy(self.disciplelist)
UIManager:showWindow('UIDiZIGongLueWin',{dis_guid=self.disciple_guid,disciplelist=list})
end

function UIDiscipleMainWin:onCopyBtn()
local netdata=self.disciplelist[self.curDisIndex].netData.net
WriteInCopyBuffer(tostring(netdata.discipleguid))
end

function UIDiscipleMainWin:getDiscipleList()
return self.disciplelist
end

function UIDiscipleMainWin:onShareBtn()
local shareShowType=shareImageModel:getShareShowTypeByWinName(self.window_name)
local param={
disciple_guid=self.disciple_guid,
}
shareImageController:showShareImageWin(shareShowType,param)
end


function UIDiscipleMainWin:refreshShareRewardShow()

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



function UIDiscipleMainWin:refreshShareBtn()
local color=UIDiscipleModel:getDiscipleColor(self.disciple_guid)
local showShareBtn=shareImageModel:IsShareDzBtnCanShow(color)

if showShareBtn and UIDiscipleModel:isShuWuDiscipleEx(self.disciple_guid)then
showShareBtn=false
end
self.shareBtn:setActive(showShareBtn)
if not showShareBtn then
return
end

self:refreshShareRewardShow()
end

function UIDiscipleMainWin:onPresetBtn()

UIManager:showWindow('UIDiscipleEquipPresetWin',{dis_guid=self.disciple_guid,disciplelist=self.disciplelist})
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'equipPreset',0)==0
if reddot then
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'equipPreset',1,0)
self.presetReddot:setActive(false)
end
end


function UIDiscipleMainWin:refreshPresetBtn()
local showPresetBtn=systemModel.isOpen(SYSTEM_DEFINE.eEquipPreset)
self.presetBtn:setActive(showPresetBtn)
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'equipPreset',0)==0
self.presetReddot:setActive(reddot)
end


function UIDiscipleMainWin:refreshPresetNum()
local num=discipleEquipPresetController:getDiscipleEquipPresetNum(self.disciple_guid)
local showPresetBtn=systemModel.isOpen(SYSTEM_DEFINE.eEquipPreset)and num>0
self.presetNumBg:setActive(showPresetBtn)
if not showPresetBtn then
return
end
self.presetNum:setText(num)
end
