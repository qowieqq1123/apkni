







def_class("UIMoJieZhenTaiWin",UIWindowBase)









function UIMoJieZhenTaiWin:bindComponents()

self.buffContent=UIObject.get(self,0)
self.buffPanel=UIButton.get(self,1)
self.currentBuffEmpty=UIText.get(self,2)
self.currentBuffList=UIObject.get(self,3)
self.currentBuffTitle=UIText.get(self,4)
self.fixAddProgress=UIText.get(self,5)
self.fixCommitBtn=UIButton.get(self,6)
self.fixCompleted=UIObject.get(self,7)
self.fixCostItemList=UIObject.get(self,8)
self.fixPanel=UIObject.get(self,9)
self.fixPanelBtn=UIButton.get(self,10)
self.fixPanelBtnSelect=UIObject.get(self,11)
self.fixProgress=UIObject.get(self,12)
self.fixProgressTx=UIText.get(self,13)
self.fixRewardItemList=UIObject.get(self,14)
self.leftArrowBtn=UIButton.get(self,15)
self.nameImg=UIImage.get(self,16)
self.rankBtn=UIButton.get(self,17)
self.rightArrowBtn=UIButton.get(self,18)
self.root=UIObject.get(self,19)
self.worshipBuffDuration=UIText.get(self,20)
self.worshipBuffList=UIObject.get(self,21)
self.worshipCommitBtn=UIButton.get(self,22)
self.worshipCostItemList=UIObject.get(self,23)
self.worshipPanel=UIObject.get(self,24)
self.worshipPanelBtn=UIButton.get(self,25)
self.worshipPanelBtnLockFlag=UIObject.get(self,26)
self.worshipPanelBtnSelect=UIObject.get(self,27)
self.zhentaiModel=UIObject.get(self,28)
self.zhenTaiStory=UIText.get(self,29)

self.buffPanel:setButtonClick(function()self:onBuffPanel()end)

self.fixCommitBtn:setButtonClick(function()self:onFixCommitBtn()end)

self.fixPanelBtn:setButtonClick(function()self:onFixPanelBtn()end)

self.leftArrowBtn:setButtonClick(function()self:onLeftArrowBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rightArrowBtn:setButtonClick(function()self:onRightArrowBtn()end)

self.worshipCommitBtn:setButtonClick(function()self:onWorshipCommitBtn()end)

self.worshipPanelBtn:setButtonClick(function()self:onWorshipPanelBtn()end)



end


function UIMoJieZhenTaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buffContent);self.buffContent=nil;
_UIObject_release(self.buffPanel);self.buffPanel=nil;
_UIObject_release(self.currentBuffEmpty);self.currentBuffEmpty=nil;
_UIObject_release(self.currentBuffList);self.currentBuffList=nil;
_UIObject_release(self.currentBuffTitle);self.currentBuffTitle=nil;
_UIObject_release(self.fixAddProgress);self.fixAddProgress=nil;
_UIObject_release(self.fixCommitBtn);self.fixCommitBtn=nil;
_UIObject_release(self.fixCompleted);self.fixCompleted=nil;
_UIObject_release(self.fixCostItemList);self.fixCostItemList=nil;
_UIObject_release(self.fixPanel);self.fixPanel=nil;
_UIObject_release(self.fixPanelBtn);self.fixPanelBtn=nil;
_UIObject_release(self.fixPanelBtnSelect);self.fixPanelBtnSelect=nil;
_UIObject_release(self.fixProgress);self.fixProgress=nil;
_UIObject_release(self.fixProgressTx);self.fixProgressTx=nil;
_UIObject_release(self.fixRewardItemList);self.fixRewardItemList=nil;
_UIObject_release(self.leftArrowBtn);self.leftArrowBtn=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rightArrowBtn);self.rightArrowBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.worshipBuffDuration);self.worshipBuffDuration=nil;
_UIObject_release(self.worshipBuffList);self.worshipBuffList=nil;
_UIObject_release(self.worshipCommitBtn);self.worshipCommitBtn=nil;
_UIObject_release(self.worshipCostItemList);self.worshipCostItemList=nil;
_UIObject_release(self.worshipPanel);self.worshipPanel=nil;
_UIObject_release(self.worshipPanelBtn);self.worshipPanelBtn=nil;
_UIObject_release(self.worshipPanelBtnLockFlag);self.worshipPanelBtnLockFlag=nil;
_UIObject_release(self.worshipPanelBtnSelect);self.worshipPanelBtnSelect=nil;
_UIObject_release(self.zhentaiModel);self.zhentaiModel=nil;
_UIObject_release(self.zhenTaiStory);self.zhenTaiStory=nil;
end


















local _this
local pageType={
eFix=1,
eWorship=2,
}
local _abName="ui/windows/mojiezhentai/mojiezhentai_atlas_pak.ab"

function UIMoJieZhenTaiWin:onLoaded(...)
self:bindComponents()
_this=self
self.pageType=pageType.eFix

self:addProNotify(39,2,self.on_39_2)

self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
end


function UIMoJieZhenTaiWin:__delete()
self:unbindComponents()
_this=nil
self:stopBuffCDTick()
end




function UIMoJieZhenTaiWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id
self.stageCfg=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex)
local client_build_list=self.stageCfg.client_build_list
self.max_build_id=#client_build_list
self.client_build_id=client_build_list[self.build_id]

self.nameImg:setSprite(_abName,self.stageCfg.name_icon_list[self.build_id])

self:refreshZhenTaiModel()
self:refreshShowView()
self:refreshPageBtnSelect()
self:refreshWorshipPanelBtn()
end

function UIMoJieZhenTaiWin:refreshZhenTaiModel()
local client_build_cfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.client_build_id)
local node=xianjieModel:getZhenTaiNode(self.seasonType,self.stageIndex,self.build_id)
local modelSet=client_build_cfg.clientParam[node]
local body=modelSet.model
self.zhentaiModel:setChildUIModelShowTarget(body,0.55,{},0,false,false,0,nil)
end

function UIMoJieZhenTaiWin:refreshPageBtnSelect()
self.fixPanelBtnSelect:setActive(self.pageType==pageType.eFix)
self.worshipPanelBtnSelect:setActive(self.pageType==pageType.eWorship)
end

function UIMoJieZhenTaiWin:refreshWorshipPanelBtn()
local buy_buff_conf=self.stageCfg.buy_buff_conf[self.build_id]
local stageIndex=buy_buff_conf.stage
local stage=seasonModel:getStage(self.seasonType,stageIndex)
if not stage then
logErr(string.format("赛季玩法id：%d 不存在第%d个章节",self.seasonType,stageIndex))
return
end
local isOpen=stage:checkOpen()and stage:isOverBegin()
self.winlua:SetChildImageExGray(self.worshipPanelBtn:getID(),not isOpen)
self.worshipPanelBtnLockFlag:setActive(not isOpen)
end

function UIMoJieZhenTaiWin:refreshShowView()
if self.pageType==pageType.eFix then
self.fixPanel:setActive(true)
self.worshipPanel:setActive(false)
self:refreshFixPanel()
elseif self.pageType==pageType.eWorship then
self.fixPanel:setActive(false)
self.worshipPanel:setActive(true)
self:refreshWorshipPanel()
end
end

function UIMoJieZhenTaiWin:refreshFixPanel()

local data=xianjieModel:getZhenTaiEntity(self.seasonType,self.stageIndex,self.build_id)or defaultT
local finish_cnt=data.finish_cnt or 0
local max_finish_cnt=self.stageCfg.fix_conf[self.build_id]
self.max_finish_cnt=max_finish_cnt
local isCompleted=finish_cnt>=max_finish_cnt
self.fixProgress:setChildIconFillAmount(finish_cnt/max_finish_cnt)
self.fixProgressTx:setText(string.format("%s/%s",finish_cnt,max_finish_cnt))
self.fixCommitBtn:setActive(not isCompleted)
self.fixCompleted:setActive(isCompleted)

local story=self.stageCfg.zhentaiStory[self.build_id]
self.zhenTaiStory:setText(story)

local fix_cost=self.stageCfg.fix_cost[self.build_id]
local finish_item_id=self.stageCfg.finish_item_id[self.build_id]
local finish_item_count=0
for i,v in ipairs(fix_cost)do
if finish_item_id==v[1]then
finish_item_count=v[2]
break
end
end
self.finish_item_count=finish_item_count
local fixAddStr=string.format("修复进度<color=#A7DD55>+%d/次</color>",finish_item_count)
self.fixAddProgress:setText(fixAddStr)
self.lerpFixCount=math.ceil((max_finish_cnt-finish_cnt)/finish_item_count)

local len=#fix_cost
self.fixCostItemList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.fixCostItemList:getChildLayoutGroupGridItem(index-1)
local itemid,itemnum=unpack(fix_cost[index])
local showCountBG=itemnum>1
local itemcount=showCountBG and mathHelper.formatNumber(itemnum)or""
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
end)

local fix_reward=self.stageCfg.fix_reward[self.build_id]
local rewards=cfgHelper.get2(cfg_awardconfig_get,fix_reward,"showItems")
local len=#rewards
self.fixRewardItemList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.fixRewardItemList:getChildLayoutGroupGridItem(index-1)
local itemid,itemnum=unpack(rewards[index])
local showCountBG=itemnum>1
local itemcount=showCountBG and mathHelper.formatNumber(itemnum)or""
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildActive(2,itemnum<0)
end)
end

function UIMoJieZhenTaiWin:refreshWorshipPanel()
local buy_buff_conf=self.stageCfg.buy_buff_conf[self.build_id]
local cost=buy_buff_conf.cost
local buff=buy_buff_conf.buff

local len=#buff
self.worshipBuffList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.worshipBuffList:getChildLayoutGroupGridItem(index-1)
local buffid=buff[index]
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
item:SetChildIcon(0,iconHelper.getzmStateIcon(buffCfg.icon),true)
item:SetChildText(1,buffCfg.name)
item:SetChildText(2,buffCfg.desc)
end)

local buffid=buff[1]
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local duration=buffCfg.duration
local hour=math.floor(duration/3600)
self.worshipBuffDuration:setText(string.format("增益效果持续时长：%d时/次（效果不可叠加）",hour))

local len=#cost
self.worshipCostItemList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.worshipCostItemList:getChildLayoutGroupGridItem(index-1)
local itemid,itemnum=unpack(cost[index])
local showCountBG=itemnum>1
local itemcount=showCountBG and mathHelper.formatNumber(itemnum)or""
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
end)

self.curr_buff_conf=nil
self.curr_buff_begin_times=nil
self.curr_buff_duration=nil
local nowTime=timeHelper.getServerShortTime()
local datas=xianjieModel:getZhenTaiDatas(self.seasonType,self.stageIndex)
if datas then
for build_id,data in ipairs(datas)do
local entity=data.entity
if entity and entity.buff_begin_times and entity.buff_begin_times>0 then
local buff_begin_times=entity.buff_begin_times
local buy_buff_conf=self.stageCfg.buy_buff_conf[build_id]
local buff=buy_buff_conf.buff
local buffid=buff[1]
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local duration=buffCfg.duration
if buff_begin_times+duration>=nowTime then
self.curr_buff_conf=buy_buff_conf
self.curr_buff_begin_times=buff_begin_times
self.curr_buff_duration=duration
break
end
end
end
end
local curr_buff_list=self.curr_buff_conf and self.curr_buff_conf.buff or defaultT
local len=#curr_buff_list
self.currentBuffTitle:setText(len>0 and"当前增益:"or"")
self.currentBuffEmpty:setActive(len<=0)
self.currentBuffList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.currentBuffList:getChildLayoutGroupGridItem(index-1)
local buffid=curr_buff_list[index]
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local curr_buff_pass_times=nowTime-self.curr_buff_begin_times
item:SetChildIcon(0,iconHelper.getzmStateIcon(buffCfg.icon),true)
item:SetChildButtonClick(0,function()
self.buffPanel:setActive(true)
end)
item:SetChildIcon(1,iconHelper.getzmStateIcon(buffCfg.icon),true)
item:SetChildImageExGray(1,true)
item:SetChildIconFillAmount(1,curr_buff_pass_times/self.curr_buff_duration)
end)

self.buffContent:setChildLayoutGroupCreateItems(len,function(index)
local item=self.buffContent:getChildLayoutGroupGridItem(index-1)
local buffid=curr_buff_list[index]
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
local curr_buff_lerp_times=self.curr_buff_duration+self.curr_buff_begin_times-nowTime
item:SetChildIcon(0,iconHelper.getzmStateIcon(buffCfg.icon),true)
item:SetChildText(1,buffCfg.name)
item:SetChildText(2,buffCfg.desc)
item:SetChildText(3,timeHelper.format_time_stamp(curr_buff_lerp_times))
item:SetChildActive(4,index<len)
end)
if len>0 then
self:startBuffCDTick()
end
end

function UIMoJieZhenTaiWin:startBuffCDTick()
self:stopBuffCDTick()
local func=function()
if not _this then return end
local nowTime=timeHelper.getServerShortTime()
local curr_buff_pass_times=nowTime-self.curr_buff_begin_times
if curr_buff_pass_times<self.curr_buff_duration then

local itemList=self.currentBuffList:getChildLayoutGroupGridList()
for i=1,itemList.Count do
local item=itemList[i-1]
item:SetChildIconFillAmount(1,curr_buff_pass_times/self.curr_buff_duration)
end

local itemList=self.buffContent:getChildLayoutGroupGridList()
local curr_buff_lerp_times=self.curr_buff_duration-curr_buff_pass_times
for i=1,itemList.Count do
local item=itemList[i-1]
item:SetChildText(3,timeHelper.format_time_stamp(curr_buff_lerp_times))
end
else
self.currentBuffList:setChildLayoutGroupClearAllItems()
self.buffContent:setChildLayoutGroupClearAllItems()
self.curr_buff_conf=nil
self.curr_buff_begin_times=nil
self.curr_buff_duration=nil
self.buffPanel:setActive(false)
self.currentBuffTitle:setText("")
self.currentBuffEmpty:setActive(true)
self:stopBuffCDTick()
end
end
self.buffCDTimer=self:setTimer(1,0,func)
end

function UIMoJieZhenTaiWin:stopBuffCDTick()
if self.buffCDTimer then
self:stopTimerByID(self.buffCDTimer)
self.buffCDTimer=nil
end
end

function UIMoJieZhenTaiWin.on_39_2(seasonType,stageIndex,dataType,build_id,ret)
if seasonType==_this.seasonType and stageIndex==_this.stageIndex and build_id==_this.build_id then
if dataType==3 then
_this:refreshFixPanel()
_this:refreshZhenTaiModel()
if ret=='-1'then
UIManager.info("当前镇台已修复，请祖师移步其他镇台进行修复")
elseif ret=='-2'then
local data=xianjieModel:getZhenTaiEntity(_this.seasonType,_this.stageIndex,_this.build_id)or defaultT
local finish_cnt=data.finish_cnt or 0
local max_finish_cnt=_this.max_finish_cnt
local lerpFixCount=math.ceil((max_finish_cnt-finish_cnt)/_this.finish_item_count)
xianjieController:reqFixZhenTai(_this.seasonType,_this.stageIndex,_this.build_id,lerpFixCount,true)


















else
local autoNum=xianjieModel:getZhenTaiAutoFixNum()
if autoNum>0 then
UIManager.info(string.format("本次提交次数已超出修复所需，自动调整为提交【%d次】",autoNum))
xianjieModel:setZhenTaiAutoFixNum(0)
end
end
elseif dataType==4 then
if ret=='-1'then
UIManager.info("集结过程中，队长持有【镇岳】效果时暂不可更换镇台增益")
else
local buy_buff_conf=_this.stageCfg.buy_buff_conf[build_id]
local buff=buy_buff_conf.buff
local nameStr=''
for i,buffid in ipairs(buff)do
local buffCfg=cfg_fairylandbuffconfig_get(buffid)
nameStr=string.format("%s【%s】",nameStr,buffCfg.name)
end
UIManager.info(string.format("成功获得%s效果",nameStr))
_this:refreshWorshipPanel()
end
end
end
end

function UIMoJieZhenTaiWin.onSeasonStageChange(seasonType,stageIndex)
_this:refreshWorshipPanelBtn()
_this:refreshFixPanel()
end

function UIMoJieZhenTaiWin:onLeftArrowBtn()
local build_id
if self.build_id>1 then
build_id=self.build_id-1
else
build_id=self.max_build_id
end
local argtable={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=build_id,
}
self:onShow(argtable)
xianjieController:jumpMoJieZhenTai(self.seasonType,self.stageIndex,build_id)
end

function UIMoJieZhenTaiWin:onRightArrowBtn()
local build_id
if self.build_id<self.max_build_id then
build_id=self.build_id+1
else
build_id=1
end
local argtable={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=build_id,
}
self:onShow(argtable)
xianjieController:jumpMoJieZhenTai(self.seasonType,self.stageIndex,build_id)
end

function UIMoJieZhenTaiWin:onFixCommitBtn()
if self.lerpFixCount<=0 then
return
end
local moneytypes={}
local fix_cost=self.stageCfg.fix_cost[self.build_id]
local itemMinCount=math.huge
for i,v in ipairs(fix_cost)do
local has=itemsModel.getCount(v[1])
if has<v[2]then
gainControl:showGainWin(v[1])
return
else
local itemCommitCount=math.floor(has/v[2])
itemMinCount=math.min(itemMinCount,itemCommitCount)
end
if moneyConfig.isMoney(v[1])then
table.insert(moneytypes,{v[1]})
end
end
local max=math.min(itemMinCount,self.lerpFixCount)

local iconname=nil
local iconStr=nil
local iconname2=nil
local iconStr2=nil
local itemid=nil
local itemid2=nil
local singlePrice=0
local singlePrice2=0
if fix_cost then
itemid=fix_cost[1][1]
iconname=iconHelper.getIconName(fix_cost[1][1])
iconStr=chatEmotHelper.getIconEmotMesg(iconname,35)
singlePrice=fix_cost[1][2]
if fix_cost[2]then
itemid2=fix_cost[2][1]
iconname2=iconHelper.getIconName(fix_cost[2][1])
iconStr2=chatEmotHelper.getIconEmotMesg(iconname2,35)
singlePrice2=fix_cost[2][2]
end
end

local show_data={
type='UIUseItemDialouge_2',
title='镇台修复',
content='本次提交将根据总次数消耗以下道具',
AlwaysShowSlider=true,
max=max,
itemid=itemid,
iconStr=iconStr,
singlePrice=singlePrice,
itemid2=itemid2,
iconStr2=iconStr2,
singlePrice2=singlePrice2,
moneytypes=moneytypes,
oktext='捐献',
canceltext='取消',
okcallback=function(num)
xianjieController:reqFixZhenTai(self.seasonType,self.stageIndex,self.build_id,num)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIMoJieZhenTaiWin:onWorshipCommitBtn()





local buy_buff_conf=self.stageCfg.buy_buff_conf[self.build_id]
local moneytypes={}
local cost=buy_buff_conf.cost
for i,v in ipairs(cost)do
local has=itemsModel.getCount(v[1])
if has<v[2]then
gainControl:showGainWin(v[1])
return
end
if moneyConfig.isMoney(v[1])then
table.insert(moneytypes,{v[1]})
end
end

local iconname=nil
local iconStr=nil
local iconname2=nil
local iconStr2=nil
local itemid=nil
local itemid2=nil
local singlePrice=0
local singlePrice2=0
if cost then
itemid=cost[1][1]
iconname=iconHelper.getIconName(cost[1][1])
iconStr=chatEmotHelper.getIconEmotMesg(iconname,35)
singlePrice=cost[1][2]
if cost[2]then
itemid2=cost[2][1]
iconname2=iconHelper.getIconName(cost[2][1])
iconStr2=chatEmotHelper.getIconEmotMesg(iconname2,35)
singlePrice2=cost[2][2]
end
end

local show_data={
type='UIDialouge',
title='镇台供奉',
moneytypes=moneytypes,
oktext='确认',
canceltext='取消',
okcallback=function()
xianjieController:reqWorshipZhenTai(self.seasonType,self.stageIndex,self.build_id)
end
}
if self.curr_buff_conf then
show_data.content="当前已有镇台增益，是否覆盖"
else
show_data.content="是否供奉当前镇台获取增益"
end
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIMoJieZhenTaiWin:onFixPanelBtn()
if self.pageType==pageType.eFix then
return
end
self.pageType=pageType.eFix
self:refreshShowView()
self:refreshPageBtnSelect()
end

function UIMoJieZhenTaiWin:onWorshipPanelBtn()
if self.pageType==pageType.eWorship then
return
end
local buy_buff_conf=self.stageCfg.buy_buff_conf[self.build_id]
local stageIndex=buy_buff_conf.stage
local stage=seasonModel:getStage(self.seasonType,stageIndex)
if not stage then
logErr(string.format("赛季玩法id：%d 不存在第%d个章节",self.seasonType,stageIndex))
return
end
if stage:checkOpen()and stage:isOverBegin()then
self.pageType=pageType.eWorship
self:refreshShowView()
self:refreshPageBtnSelect()
else
local seasonName=seasonModel:getHandleConfig(self.seasonType,"name")
local stageName=stage:getConfig("name")
UIManager.info(FMT.fmt("{0}第{1}章开启后可查看",seasonName,stageIndex))
end
end

function UIMoJieZhenTaiWin:onBuffPanel()
self.buffPanel:setActive(false)
end

function UIMoJieZhenTaiWin:onRankBtn()
local args={
handleType=self.seasonType,
stageIdx=self.stageIndex,
build_id=self.build_id,
parentWin=self,
}
if self.stageCfg.rankPanel then
self:showWindow(self.stageCfg.rankPanel,args)
end
end