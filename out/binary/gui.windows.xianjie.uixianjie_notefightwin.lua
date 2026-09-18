







def_class("UIXianJie_noteFightWin",UIWindowBase)









function UIXianJie_noteFightWin:bindComponents()

self.checkTxt=UIText.get(self,0)
self.filter=UIButton.get(self,1)
self.filterPanel=UIObject.get(self,2)
self.img_all=UIObject.get(self,3)
self.img_atk=UIObject.get(self,4)
self.img_def=UIObject.get(self,5)
self.logScrollView=UIObject.get(self,6)
self.LogScrollView=UILoopListView.new(self,7)
self.notLog=UIObject.get(self,8)
self.prepareBtn=UIButton.get(self,9)
self.prepareBtnSelect=UIObject.get(self,10)
self.prepareLogGridPanel=UIObject.get(self,11)
self.preparePanel=UIObject.get(self,12)
self.root=UIObject.get(self,13)
self.searchBtn=UIButton.get(self,14)
self.searchCancelBtn=UIButton.get(self,15)
self.searchInput=UIInputField.get(self,16)
self.warBtn=UIButton.get(self,17)
self.warBtnSelect=UIObject.get(self,18)
self.warLogGridPanel=UIObject.get(self,19)
self.warPanel=UIObject.get(self,20)

self.filter:setButtonClick(function()self:onFilter()end)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.prepareBtn:setButtonClick(function()self:onPrepareBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.warBtn:setButtonClick(function()self:onWarBtn()end)
self.img={
["all"]=self.img_all,
["atk"]=self.img_atk,
["def"]=self.img_def,
}



end


function UIXianJie_noteFightWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.checkTxt);self.checkTxt=nil;
_UIObject_release(self.filter);self.filter=nil;
_UIObject_release(self.filterPanel);self.filterPanel=nil;
_UIObject_release(self.img_all);self.img_all=nil;
_UIObject_release(self.img_atk);self.img_atk=nil;
_UIObject_release(self.img_def);self.img_def=nil;
_UIObject_release(self.logScrollView);self.logScrollView=nil;
self.LogScrollView:deleteSelf();self.LogScrollView=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.prepareBtn);self.prepareBtn=nil;
_UIObject_release(self.prepareBtnSelect);self.prepareBtnSelect=nil;
_UIObject_release(self.prepareLogGridPanel);self.prepareLogGridPanel=nil;
_UIObject_release(self.preparePanel);self.preparePanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.warBtn);self.warBtn=nil;
_UIObject_release(self.warBtnSelect);self.warBtnSelect=nil;
_UIObject_release(self.warLogGridPanel);self.warLogGridPanel=nil;
_UIObject_release(self.warPanel);self.warPanel=nil;
self.img=nil;
end

















local this
local pageType={
prepare=1,
fight=2,
}
local curPage=1
local filterType=0
local filterPanelVisible=false


function UIXianJie_noteFightWin:onLoaded(...)
self:bindComponents()
this=self

local id=self.LogScrollView:getID()
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIXianJie_noteFightWin:__delete()
if xianjieModel:jude_zhengzhanshanhailog_reddot()~=xianjieModel:Get_reddotchangeflag()then
notifySystem:postNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange)
xianjieModel:Set_reddotchangeflag(not xianjieModel:Get_reddotchangeflag())
end
self:unbindComponents()
end




function UIXianJie_noteFightWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
local fightLogNew=xianjieModel:Check_fightLogNewFlag()
local prefightLogNew=xianjieModel:Check_prefightLogNewFlag()
curPage=pageType.prepare
if fightLogNew and not prefightLogNew then
curPage=pageType.fight
end
filterType=0
filterPanelVisible=false
self.logList={}
self.inputstr=nil
self.searchCancelBtn:setActive(false)
self.searchBtn:setActive(true)
end
xianjieModel:jude_haveReward()
self:RefreshWin()
self:refreshFilterPanel()
if argtable and argtable.record then
self:onWarBtn()
local recordData=xianjieModel:Get_recordLogData()
if recordData then
UIManager:showWindow("UIXM_ZZSH_noteFightReportWin",recordData)
end
end
end

function UIXianJie_noteFightWin:onShowArgRecv(argtable)

end

function UIXianJie_noteFightWin:RefreshWin()
self:refreshPageWin()
end

function UIXianJie_noteFightWin:refreshPageWin(onlyRefreshPanel)
if not onlyRefreshPanel then
self.preparePanel:setActive(curPage==pageType.prepare)
self.warPanel:setActive(curPage==pageType.fight)
self.prepareBtnSelect:setActive(curPage==pageType.prepare)
self.warBtnSelect:setActive(curPage==pageType.fight)
end

if curPage==pageType.prepare then
xianjieModel:saveRecord_preFight()
xianjieModel:Update_prefightLogNewFlag()
self:refreshPrepareWin()
elseif curPage==pageType.fight then
xianjieModel:saveRecord_Fight()
xianjieModel:Update_fightLogNewFlag()
self:refreshWarfareWin()
end
end


function UIXianJie_noteFightWin:refreshPrepareWin()
local prepareLogTab=xianjieModel:Get_prefighttb()
if next(prepareLogTab)then
self.notLog:setActive(false)
local logList={}
for i=1,#prepareLogTab do
local cfgid=prepareLogTab[i].logtype
local cfg=cfgHelper.get1(cfg_fairylandlogconfig_get,cfgid)
if self.inputstr and self.inputstr~=""then
local logtxt=self:SetStr(cfg.str,nil,prepareLogTab[i],cfgid)
if string.find(logtxt,self.inputstr)then
logList[#logList+1]=prepareLogTab[i]
end
else
logList[#logList+1]=prepareLogTab[i]
end

end
local n=#logList
if n>1 then
table.sort(logList,function(a,b)
return a.sec>b.sec
end)
end
self.prepareLogGridPanel:setChildLayoutGroupCreateItems(n)
local logGridGrids=self.prepareLogGridPanel:getChildLayoutGroupGridList()
for i=1,#logList do
local logWidget=logGridGrids[i-1]
local prepareLog=logList[i]
local cfgid=prepareLog.logtype
local str_cfg=cfgHelper.get2(cfg_fairylandlogconfig_get,cfgid,"str")
local logtxt=self:SetStr(str_cfg,logWidget,prepareLog,cfgid)
logWidget:SetChildText(0,logtxt)

local time_str=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(prepareLog.sec)))
logWidget:SetChildText(1,time_str)
end
else
self.notLog:setActive(true)
end
end


function UIXianJie_noteFightWin:refreshWarfareWin()
local fightLogTab=xianjieModel:Get_fighttb()
local logList={}
self.LogScrollView:initData("log_Item",logList)
if next(fightLogTab)then
self.notLog:setActive(false)
for i=1,#fightLogTab do
local cfgid=fightLogTab[i].logtype
local cfg=cfgHelper.get1(cfg_fairylandlogconfig_get,cfgid)
local pvp_type=cfg.pvp_type
if not(pvp_type and filterType~=0 and pvp_type~=filterType)then
if self.inputstr and self.inputstr~=""then
local logtxt=self:SetStr(cfg.str,nil,fightLogTab[i],cfgid)
if string.find(logtxt,self.inputstr)then
logList[#logList+1]=fightLogTab[i]
end
else
logList[#logList+1]=fightLogTab[i]
end
end
end
local n=#logList
if n>1 then
table.sort(logList,function(a,b)
return a.sec>b.sec
end)
end
self.logList=logList
self.LogScrollView:initData("log_Item",logList)
local nowShowItemCount=self.logGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.logGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshLogItem(item.Widget,index)
end
end
else
self.notLog:setActive(true)
end
end


function UIXianJie_noteFightWin:onFreshAction(index,widget)
self:refreshLogItem(widget,index)
end

function UIXianJie_noteFightWin:refreshLogItem(item,idx)
if item==nil then
return
end

local datatb=self.logList[idx]
local cfgid=datatb.logtype
local recordguid=datatb.recordguid
local cfg=cfgHelper.get1(cfg_fairylandlogconfig_get,cfgid)
local str_cfg=cfg.str
local logtxt=self:SetStr(str_cfg,item,datatb,cfgid)
item:SetChildText(0,logtxt)


local rewards=datatb.list
if rewards then
item:SetChildActive(1,true)
item:SetChildLayoutGroupCreateItems(1,#rewards)
local grids=item:GetChildLayoutGroupGridList(1)
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
local itemid=reward.param_1
local count=reward.param_2
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
else
item:SetChildActive(1,false)
end

local isWin=cfg.is_win and cfg.is_win==1
item:SetChildActive(2,isWin)
item:SetChildActive(3,not isWin)

if recordguid and recordguid~=0 then
if cfg.report_str then
local result_str=self:SetResultStr(cfg.report_str,datatb,cfgid)
logtxt=result_str~=nil and result_str or logtxt
end
xianjieModel:Set_recordLogLookup(recordguid,logtxt)
item:SetChildActive(4,true)
item:SetChildButtonClick(4,function(...)
xianjieController:Send_20_245(recordguid)
end)
else
item:SetChildActive(4,false)
end

item:SetChildText(5,timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(datatb.sec))))
end


function UIXianJie_noteFightWin:SetResultStr(str_cfg,datatb,cfgid)
local json_str=datatb.params
local str_1=str_cfg

local tbstr=jsonHelper.decode(json_str)
local str_2=nil

if cfgid==27 or cfgid==28 or cfgid==38 then

str_2=FMT.fmt(str_1,tbstr[2])
elseif cfgid==29 or cfgid==30 then

str_2=FMT.fmt(str_1,tbstr[1])
elseif cfgid==33 or cfgid==34 or cfgid==39 then

local LDCfg=xianjieModel:getLingDiCfg(tbstr[3])
if not LDCfg then
logErr(FMT.fmt("领地配置未找到 日志id:{0} 领地id:{1}",cfgid,tbstr[3]))
return nil
end
str_2=FMT.fmt(str_1,LDCfg.name)
elseif cfgid==35 or cfgid==36 then

local LDCfg=xianjieModel:getLingDiCfg(tbstr[1])
if not LDCfg then
logErr(FMT.fmt("领地配置未找到 日志id:{0} 领地id:{1}",cfgid,tbstr[1]))
return nil
end
str_2=FMT.fmt(str_1,LDCfg.name)
end
return str_2
end


function UIXianJie_noteFightWin:SetStr(str_cfg,item,datatb,cfgid)
local json_str=datatb.params
local str_1=str_cfg


local tbstr=jsonHelper.decode(json_str)
local str_2=nil

if cfgid==19 or cfgid==20 or cfgid==29 or cfgid==30 then

str_2=FMT.fmt(str_1,tbstr[1])
elseif cfgid==23 or cfgid==24 or cfgid==31 then

local lineup=tbstr[1]==0 and"防守仙阵"or string.format("进攻仙阵%s",tbstr[1])
local LDCfg=xianjieModel:getLingDiCfg(tbstr[2])
if not LDCfg then
logErr(FMT.fmt("领地配置未找到 日志id:{0} 领地id:{1}",cfgid,tbstr[2]))
return""
end
str_2=FMT.fmt(str_1,lineup,LDCfg.name)
elseif cfgid==35 or cfgid==36 then

local LDCfg=xianjieModel:getLingDiCfg(tbstr[1])
if not LDCfg then
logErr(FMT.fmt("领地配置未找到 日志id:{0} 领地id:{1}",cfgid,tbstr[1]))
return""
end
str_2=FMT.fmt(str_1,LDCfg.name,tbstr[2])
elseif cfgid==37 then

local rewards=datatb.list
if not rewards then
logErr(FMT.fmt("奖励列表-list为空 日志id:{0}",cfgid))
return""
end
local moneyStr=""
for i=1,#rewards do
local reward=rewards[i]
local itemid=reward.param_1
local count=reward.param_2
local name=moneyModel.getMoneyName(itemid)
moneyStr=moneyStr..string.format("%s*%d、",name,count)
end
moneyStr=string.sub(moneyStr,1,-4)
str_2=FMT.fmt(str_1,moneyStr)
else

local lineup=tbstr[1]==0 and"防守仙阵"or string.format("进攻仙阵%s",tbstr[1])
if tbstr[3]then
local LDCfg=xianjieModel:getLingDiCfg(tbstr[3])
if not LDCfg then
logErr(FMT.fmt("领地配置未找到 日志id:{0} 领地id:{1}",cfgid,tbstr[3]))
return""
end
str_2=FMT.fmt(str_1,lineup,tbstr[2],LDCfg.name)
else
str_2=FMT.fmt(str_1,lineup,tbstr[2])
end
end





return str_2
end

function UIXianJie_noteFightWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIXianJie_noteFightWin:onPrepareBtn()
curPage=pageType.prepare
self:refreshPageWin()
end

function UIXianJie_noteFightWin:onWarBtn()
curPage=pageType.fight
self:refreshPageWin()
end

function UIXianJie_noteFightWin:onClearBtn()
end

function UIXianJie_noteFightWin:onFilter()
filterPanelVisible=not filterPanelVisible
self.filterPanel:setActive(filterPanelVisible)
end

function UIXianJie_noteFightWin:OnEvent(type)
if filterType~=type then
filterType=type
self:refreshFilterPanel()
self:refreshWarfareWin()
end
end

function UIXianJie_noteFightWin:refreshFilterPanel()
self.img_all:setActive(filterType==0)
self.img_atk:setActive(filterType==1)
self.img_def:setActive(filterType==2)
end

function UIXianJie_noteFightWin:onStartAction(index,widget)

end

function UIXianJie_noteFightWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
self.inputstr=nil
UIManager.info('请输入关键词')
return
end
if self.inputstr==inputstr then
return
end
if helper.check_spec_chars(inputstr)then
UIManager.info('关键词含敏感字符')
return
end
self.inputstr=inputstr
self.searchInput:setInputFieldValue('')
self:refreshPageWin(true)
self.searchCancelBtn:setActive(true)
self.searchBtn:setActive(false)
end

function UIXianJie_noteFightWin:onSearchCancelBtn()
if self.inputstr==nil then return end
self.inputstr=nil
self:refreshPageWin(true)
self.searchCancelBtn:setActive(false)
self.searchBtn:setActive(true)
end

function UIXianJie_noteFightWin:onSearchChange(str)

end