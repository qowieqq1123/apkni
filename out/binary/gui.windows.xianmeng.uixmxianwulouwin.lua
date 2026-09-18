







def_class("UIXMXianWuLouWin",UIWindowBase)









function UIXMXianWuLouWin:bindComponents()

self.root=UIObject.get(self,0)
self.speakObj=UIObject.get(self,1)
self.noTaskSign=UIObject.get(self,2)
self.npcModel=UIObject.get(self,3)
self.taskRoot=UIObject.get(self,4)
self.timeTxt=UIText.get(self,5)
self.numTxt=UIText.get(self,6)
self.commitBtn=UIButton.get(self,7)
self.rewardObj=UIButton.get(self,8)
self.selectPanel=UIObject.get(self,9)
self.taskTitleTxt=UIText.get(self,10)
self.rewardDesc=UIText.get(self,11)
self.rewardIcon=UIImage.get(self,12)
self.rewardBoxDescTxt=UIText.get(self,13)
self.rewardBoxModel=UIObject.get(self,14)
self.rewardBoxDescObj=UIObject.get(self,15)
self.speakText=UIText.get(self,16)
self.expProgressText=UIText.get(self,17)
self.expProgress=UIObject.get(self,18)
self.expProgressGreen=UIObject.get(self,19)
self.noteBtn=UIButton.get(self,20)
self.batchToggle=UIToggleButton.get(self,21)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.rewardObj:setButtonClick(function()self:onRewardObj()end)

self.noteBtn:setButtonClick(function()self:onNoteBtn()end)



end


function UIXMXianWuLouWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.noTaskSign);self.noTaskSign=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.taskRoot);self.taskRoot=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.numTxt);self.numTxt=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.rewardObj);self.rewardObj=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.taskTitleTxt);self.taskTitleTxt=nil;
_UIObject_release(self.rewardDesc);self.rewardDesc=nil;
_UIObject_release(self.rewardIcon);self.rewardIcon=nil;
_UIObject_release(self.rewardBoxDescTxt);self.rewardBoxDescTxt=nil;
_UIObject_release(self.rewardBoxModel);self.rewardBoxModel=nil;
_UIObject_release(self.rewardBoxDescObj);self.rewardBoxDescObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.expProgressText);self.expProgressText=nil;
_UIObject_release(self.expProgress);self.expProgress=nil;
_UIObject_release(self.expProgressGreen);self.expProgressGreen=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
_UIObject_release(self.batchToggle);self.batchToggle=nil;
end
















local _this=nil


function UIXMXianWuLouWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)

self:setTimer(1,0,function()
self:refreshTime()
end)

self.tjnum=1
self.isBatchToggle=userActorSetting.get('xmxwl_bat',false)
self.batchToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle()
end


function UIXMXianWuLouWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXMXianWuLouWin:onHide()

end

function UIXMXianWuLouWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local good_idx=_this.goodslookup[moneyType]
if good_idx then
_this:refreshView()
_this:refreshCommitNum()
end
end

function UIXMXianWuLouWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
local good_idx=_this.goodslookup[itemid]
if good_idx then
_this:refreshView()
_this:refreshCommitNum()
end
end




function UIXMXianWuLouWin:onShow(argtable,afterOnloaded)
self.seletIndex=self:getSelectIndex()








self:refreshView(true)

if afterOnloaded then
self:doMyAnim()
end
end

function UIXMXianWuLouWin:refreshTime()
local cur=gameUtilityModel.getServerLongTime()
local y,m,d=timeHelper.getDateNumber(cur)
local t=timeHelper.timeServer(y,m,d,5,0,0)
if cur==t then
self:rec_submit()
end
local flag,refreshTime=xianmengModel:checkXWLInitOutTime()
if flag and refreshTime~=nil then
if cur==refreshTime then
xianmengController:reqXWLInfo()
end
end
end

function UIXMXianWuLouWin:getSelectIndex()
local tjGoods=xianmengModel:getTJGoods()
for i,goodid in ipairs(tjGoods)do
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)
if goodcfg==nil then
logErr(FMT.fmt('物品:{0}不在《仙务楼--提交物品 》表中，请检查配置',goodid))
end
local itemid=goodcfg.item[1]
local itemnum=goodcfg.item[2]
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagModel.getItemCountById(itemid)
end
if hasnum>=itemnum then
return i
end
end
return 1
end

function UIXMXianWuLouWin:doMyAnim()
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.15,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end

function UIXMXianWuLouWin:refreshView(isInit)
local hasTask=xianmengModel:checkXWLHasTask()
local goodslookup={}
self.goodsList={}
local tjGoods=xianmengModel:getTJGoods()
for idx,goodid in ipairs(tjGoods)do
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)
local itemid=goodcfg.item[1]
goodslookup[itemid]=idx
self.goodsList[idx]=goodid
end

self:refreshLunNum()

self:refreshBatchCnt()

local num=#self.goodsList
local grids=self.selectPanel:getChildCommonLayoutGroupWidgetList()
for i=1,num do
local d=self.goodsList[i]
local isshow=d~=nil
local item=grids[i-1]
item:SetChildActive(-1,isshow)
if isshow then
self:refreshSelectItem(item,i)

item:SetBaseItemClickEvent(0,function()
self:onItemSelect(i)
end)
item:SetBaseItemLongTouchEvent(0,function()
self:onItemLongClick(i)
end)
item:SetChildButtonClick(-1,function()
self:onItemSelect(i)
end)
end
end

self:refreshMoneyReward()

self:refreshCommitNum()
if hasTask then

self:refreshAddExp()
end
self.goodslookup=goodslookup
self:refreshProgress()
self:refreshBoxReward(isInit)
end

function UIXMXianWuLouWin:refreshBatchCnt()
self.tjnum=1
if self.isBatchToggle then
local seletIndex=self.seletIndex
local leftnum=xianmengModel:getXWL_tjNum()
local maxnum=leftnum
local goodid=self.goodsList[seletIndex]
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)
local itemid=goodcfg.item[1]
local need=goodcfg.item[2]
local hasnum=itemsModel.getCount(itemid)
local cnt=math.floor(hasnum/need)
maxnum=math.min(maxnum,cnt)
self.tjnum=math.max(1,maxnum)
end
end

function UIXMXianWuLouWin:refreshLunNum()
local data=xianmengModel:getXWLData()
local maxlun=xianmengModel:getMaxLun()
self.timeTxt:setText(FMT.fmt('<color=#7d3b17>任务轮数：</color>{0}/{1}',data.lunshuId,maxlun))
local hasTask=xianmengModel:checkXWLHasTask()
local titile_str
if hasTask then
local taskId=data.taskId
local cfg=cfgHelper.get1(cfg_xianwuloutaskconfig_get,taskId)
titile_str=cfg.name
else
titile_str='今日仙盟事务'
end
self.taskTitleTxt:setText(titile_str)
end

function UIXMXianWuLouWin:refreshSelectItem(item,idx)
if item==nil then
item=self.selectPanel:getChildCommonLayoutGroupWidgetItem(idx-1)
end
local goodid=self.goodsList[idx]
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)
local isSelect=self.seletIndex==idx
local itemid=goodcfg.item[1]
local itemnum=goodcfg.item[2]*(isSelect and self.tjnum or 1)

local itemcount
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
itemcount=FMT.fmt('{0}/{1}',mathHelper.formatBIGNumbereEx(hasnum),mathHelper.formatBIGNumbereEx(itemnum))
else
hasnum=bagModel.getItemCountById(itemid)
itemcount=FMT.fmt('{0}/{1}',hasnum,itemnum)
end
if hasnum<itemnum then
itemcount=FMT.fmt('<color=#c82c2c>{0}</color>',itemcount)
end

local conf={itemid=itemid,showCountBG=false,showStage=true,itemcount='',showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)

local name_str=itemsConfig.getItemName(itemid)
name_str=FMT.fmt('{0}\n{1}',itemcount,name_str)
item:SetChildText(1,name_str)

self:refreshSelectItemSelect(item,idx,isSelect)
end

function UIXMXianWuLouWin:refreshSelectItemSelect(item,idx,isSelect)
if item==nil then
item=self.selectPanel:getChildCommonLayoutGroupWidgetItem(idx-1)
end
item:SetChildActive(2,isSelect)
end

function UIXMXianWuLouWin:onItemSelect(idx)
if self.seletIndex==idx then return end
local old=self.seletIndex
self.seletIndex=idx
self:refreshBatchCnt()
if old~=nil then
self:refreshSelectItemSelect(nil,old,false)
end
self:refreshSelectItemSelect(nil,idx,true)





self:refreshView()
end

function UIXMXianWuLouWin:onItemLongClick(idx)
local goodid=self.goodsList[idx]
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)

local itemid=goodcfg.item[1]
itemsComponentHelper.onItemClickEx(itemid)
end

function UIXMXianWuLouWin:refreshAddExp()
local goodid=self.goodsList[self.seletIndex]
local addJinDuVal=cfgHelper.get2(cfg_xianwuloutijiaowupinconfig_get,goodid,'addJinDuVal')
self.addexp=addJinDuVal*self.tjnum
end

function UIXMXianWuLouWin:refreshMoneyReward()
local goodid=self.goodsList[self.seletIndex]
local moneyReward=cfgHelper.get2(cfg_xianwuloutijiaowupinconfig_get,goodid,'addItems')
local moneyType=moneyReward[1]
local moneyNum=moneyReward[2]*self.tjnum
self.rewardDesc:setText(FMT.fmt('{0} x{1}',itemsConfig.getItemName(moneyType),moneyNum))
self.rewardIcon:setImageIcon(iconHelper.getIconName(moneyType),false)
end

function UIXMXianWuLouWin:refreshProgress(anim,callback)
if self.progressTween~=nil then
if not self.progressTween:IsComplete()then
self.progressTween:OnComplete(nil)
self.progressTween:Complete()
end
self.progressTween=nil
end
if self.progressGreenTween~=nil then
if not self.progressGreenTween:IsComplete()then
self.progressGreenTween:OnComplete(nil)
self.progressGreenTween:Complete()
end
self.progressGreenTween=nil
end

local hasTask=xianmengModel:checkXWLHasTask()
if hasTask then
local data=xianmengModel:getXWLData()
local curlun=data.lunshuId
local maxexp=cfgHelper.get2(cfg_xianwuloutasklunshuconfig_get,curlun,'progressBarMax')
local curexp=data.jinduVal
local addexp=self.addexp or 0
local progress_str=FMT.fmt('收集进度：{0}/{1}',curexp,maxexp)
if addexp>0 then
progress_str=FMT.fmt('{0}<color=#97fe7f>(+{1})</color>',progress_str,addexp)
end
local rate1=curexp/maxexp
local rate2=(curexp+addexp)/maxexp
if rate1>1 then
rate1=1
end
if rate2>1 then
rate2=1
end
self.expProgressText:setText(progress_str)

self.expProgressGreen:setActive(true)

if anim==true then
local old=self.expProgress:getChildIconFillAmount()
local lerp=math.abs(rate1-old)
local lerp2=math.abs(rate2-old)
self.expProgressGreen:setChildIconFillAmount(old)
if lerp>0 then
local time=3*lerp
self.progressTween=self.expProgress:setChildImageDOFillAmount(rate1,time,function()
if _this==nil then return end
_this.progressTween=nil
if lerp2>0 then
local time2=3*lerp2
self.progressGreenTween=self.expProgressGreen:setChildImageDOFillAmount(rate2,time2,function()
if _this==nil then return end
_this.progressGreenTween=nil
end)
end
if callback~=nil then
callback()
end
end)
else
if lerp2>0 then
local time2=3*lerp2
self.progressGreenTween=self.expProgressGreen:setChildImageDOFillAmount(rate2,time2,function()
if _this==nil then return end
_this.progressGreenTween=nil
end)
end
if callback~=nil then
callback()
end
end
else
self.expProgress:setChildIconFillAmount(rate1)
self.expProgressGreen:setChildIconFillAmount(rate2)
end
else
self.expProgressText:setText('本周任务已完成')
self.expProgress:setChildIconFillAmount(1)
self.expProgressGreen:setActive(false)
end
end

function UIXMXianWuLouWin:refreshCommitNum()
local num=xianmengModel:getXWL_tjNum()
local num_str
if num>0 then
num_str=FMT.fmt('<color=#549327>{0}</color>',num)
else
num_str=FMT.fmt('<color=#c82c2c>{0}</color>',num)
end
num_str=FMT.fmt('今日剩余提交次数：{0}',num_str)
self.numTxt:setText(num_str)

local tjGoods=xianmengModel:getTJGoods()
local goodid=tjGoods[self.seletIndex]
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)

local itemid=goodcfg.item[1]
local itemnum=goodcfg.item[2]
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagModel.getItemCountById(itemid)
end
local isGray=num<=0 or hasnum<itemnum
self.commitBtn:setChildImageExGray(isGray)

end

function UIXMXianWuLouWin:refreshBoxReward(isInit)
local data=xianmengModel:getXWLData()
local lunshu=data.lunshuId2
local hasReward=lunshu>0
local hasTask=xianmengModel:checkXWLHasTask()
if lunshu==0 then
if hasTask then
lunshu=data.lunshuId
end
end
local showReward=lunshu>0
self.rewardBoxDescObj:setActive(showReward)
if showReward then
self.rewardBoxDescTxt:setText(FMT.fmt('{0}阶',lunshu))
end

local animId
if hasReward then
animId=2018
else
if hasTask then
animId=2016
else
animId=2019
end
end

if isInit then
self.rewardBoxModel:setChildUIModelShowTarget(4031,1,{},animId,false,false,0,nil)
else
self.rewardBoxModel:setChildModelAnimationState(animId)
end


















end


function UIXMXianWuLouWin:freshToggle(isToggle)
self.batchToggle:setToggle(self.isBatchToggle)
end

function UIXMXianWuLouWin:onToggleChanged(name,isToggle,data)
if self.isBatchToggle==isToggle then return end
self.isBatchToggle=isToggle
userActorSetting.flushVal('xmxwl_bat',isToggle)
self:freshToggle()
self:refreshView()
end

function UIXMXianWuLouWin:onRewardObj()
local tjGoods=xianmengModel:getTJGoods()
local goodid=tjGoods[self.seletIndex]
local moneyReward=cfgHelper.get2(cfg_xianwuloutijiaowupinconfig_get,goodid,'addItems')
local moneyType=moneyReward[1]
itemsComponentHelper.onItemClickEx(moneyType)
end

function UIXMXianWuLouWin:onRewardBoxObj()
local data=xianmengModel:getXWLData()
local lunshu=data.lunshuId2
local hasReward=lunshu>0
if hasReward then
if self.rewardCooldown~=nil and Time.realtimeSinceStartup<self.rewardCooldown then
return
end
self.rewardCooldown=Time.realtimeSinceStartup+10
xianmengController:reqXWLReward(lunshu)
else
local hasTask=xianmengModel:checkXWLHasTask()
if hasTask then
UIManager:showWindow('UIXMXianWuLouBoxRewardWin',{boxID=data.boxId})
end
end
end

function UIXMXianWuLouWin:onNoteBtn()
xianmengController:openXWLNotes()
end

function UIXMXianWuLouWin:onCommitBtn()
local hasTask=xianmengModel:checkXWLHasTask()






local data=xianmengModel:getXWLData()
local num=xianmengModel:getXWL_tjNum()
if num<=0 then
UIManager.error('今日提交次数已满')
return
end

local tjGoods=xianmengModel:getTJGoods()
local goodid=tjGoods[self.seletIndex]
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)
local itemid=goodcfg.item[1]
local itemnum=goodcfg.item[2]
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagModel.getItemCountById(itemid)
end
if hasnum<itemnum then
if moneyConfig.isMoney(itemid)then
moneySystem:useMoney(itemid,itemnum,nil,WARNING_TYPE.eWarning)
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemid)))
gainControl:showCommonGainWin_item(itemid)
end
return
end

if hasTask then
local curlun=data.lunshuId
local maxexp=cfgHelper.get2(cfg_xianwuloutasklunshuconfig_get,curlun,'progressBarMax')
local curexp=data.jinduVal
if curexp>=maxexp then
UIManager.error('进度已满')
return
end

xianmengController:reqXWLSubmit(goodid,self.tjnum)
else
xianmengController:reqXWLSubmit2(goodid,self.tjnum)
end
end
















































































function UIXMXianWuLouWin:rec_submit()
self:refreshView()
self:refreshCommitNum()
end

function UIXMXianWuLouWin:rec_progress()
local addexp=self.addexp
local func=nil
if addexp>0 then
self.addexp=0
func=function()
if _this==nil then return end
_this:refreshProgress(false)
end
end
self:refreshProgress(true,func)
self.addexp=addexp
end

function UIXMXianWuLouWin:rec_lun()
self.seletIndex=self:getSelectIndex()
self:refreshView()
end

function UIXMXianWuLouWin:rec_boxReward()
self.rewardCooldown=nil
self:refreshBoxReward()
end