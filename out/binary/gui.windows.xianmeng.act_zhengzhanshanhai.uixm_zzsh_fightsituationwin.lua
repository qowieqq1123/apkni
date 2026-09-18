







def_class("UIXM_ZZSH_FightSituationWin",UIWindowBase)









function UIXM_ZZSH_FightSituationWin:bindComponents()

self.resultItem=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.noSign=UIObject.get(self,3)
self.waitFightBtnModel=UIObject.get(self,4)
self.waitFightBtn=UIButton.get(self,5)
self.arrow=UIObject.get(self,6)
self.waitFightPanel=UIObject.get(self,7)
self.defXMObj=UIObject.get(self,8)
self.LogScrollView=UIObject.get(self,9)
self.attactXMObj=UIObject.get(self,10)
self.xmBgatk=UIImage.get(self,11)
self.xmKuangatk=UIImage.get(self,12)
self.attackTeamNum=UIText.get(self,13)
self.attackXM=UIText.get(self,14)
self.xmIconatk=UIImage.get(self,15)
self.winIconatk=UIImage.get(self,16)
self.xmIcondef=UIImage.get(self,17)
self.winIcondef=UIImage.get(self,18)
self.xmBgdef=UIImage.get(self,19)
self.xmKuangdef=UIImage.get(self,20)
self.defendTeamNum=UIText.get(self,21)
self.defendXM=UIText.get(self,22)
self.itemsScrollView=UIEnhancedScrollerLua.get(self,23)
self.noSignTxt=UIText.get(self,24)
self.logGridPanel=UIObject.get(self,25)
self.attackInfo=UIObject.get(self,26)
self.defendInfo=UIObject.get(self,27)
self.logTips=UIText.get(self,28)
self.moneyGrid=UIObject.get(self,29)

self.waitFightBtn:setButtonClick(function()self:onWaitFightBtn()end)



end


function UIXM_ZZSH_FightSituationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.resultItem);self.resultItem=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.waitFightBtnModel);self.waitFightBtnModel=nil;
_UIObject_release(self.waitFightBtn);self.waitFightBtn=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.waitFightPanel);self.waitFightPanel=nil;
_UIObject_release(self.defXMObj);self.defXMObj=nil;
_UIObject_release(self.LogScrollView);self.LogScrollView=nil;
_UIObject_release(self.attactXMObj);self.attactXMObj=nil;
_UIObject_release(self.xmBgatk);self.xmBgatk=nil;
_UIObject_release(self.xmKuangatk);self.xmKuangatk=nil;
_UIObject_release(self.attackTeamNum);self.attackTeamNum=nil;
_UIObject_release(self.attackXM);self.attackXM=nil;
_UIObject_release(self.xmIconatk);self.xmIconatk=nil;
_UIObject_release(self.winIconatk);self.winIconatk=nil;
_UIObject_release(self.xmIcondef);self.xmIcondef=nil;
_UIObject_release(self.winIcondef);self.winIcondef=nil;
_UIObject_release(self.xmBgdef);self.xmBgdef=nil;
_UIObject_release(self.xmKuangdef);self.xmKuangdef=nil;
_UIObject_release(self.defendTeamNum);self.defendTeamNum=nil;
_UIObject_release(self.defendXM);self.defendXM=nil;
_UIObject_release(self.itemsScrollView);self.itemsScrollView=nil;
_UIObject_release(self.noSignTxt);self.noSignTxt=nil;
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
_UIObject_release(self.attackInfo);self.attackInfo=nil;
_UIObject_release(self.defendInfo);self.defendInfo=nil;
_UIObject_release(self.logTips);self.logTips=nil;
_UIObject_release(self.moneyGrid);self.moneyGrid=nil;
end
















local _this
local aniEnum={
open=2188,
close=2189,
openStand=2190,
closeStand=2191,
}
local UIItemScroller=simple_class(UIEnhancedScroller)


function UIXM_ZZSH_FightSituationWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollscript=UIItemScroller(self.itemsScrollView:getGameObject(),self.itemsScrollView:getCSharpObject(),nil,nil)
end


function UIXM_ZZSH_FightSituationWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXM_ZZSH_FightSituationWin:onShow(argtable,afterOnloaded)
self.targetid=argtable[1]
self.curSelctIndex=argtable[2]
self.targetData=zhengzhanshanhaiModel:getpvpTargetData(tostring(self.targetid))

if afterOnloaded then
self.waitFightPanelVisible=true
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(5290,1,{},2040,false,false,0,function()
if _this==nil then return end
self:delayDo(0.25,function()
_this.root:setChildCanvasGroupDOFade(1,0.35,nil)
end)
end)
local anim=self.waitFightPanelVisible and aniEnum.openStand or aniEnum.closeStand
self.waitFightBtnModel:setChildUIModelShowTarget(5363,1,{},anim,false,false,0,nil)
self.arrow:setRotation(0,self.waitFightPanelVisible and 180 or 0,0)
end
self:refreshView()
self:refreshItemsSV()
if self.curSelctIndex then
self.scrollscript:jumpToDataIndex(self.curSelctIndex-1,0,0,true,0,0,nil)
end
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
end

function UIXM_ZZSH_FightSituationWin:refreshTime()
if self.initSV then
self.scrollscript:doRefreshActiveCellViews()
end
end

function UIXM_ZZSH_FightSituationWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UIXM_ZZSH_FightSituationWin:refreshView()
local attactInfo
if self.curSelctIndex then
attactInfo=zhengzhanshanhaiModel:getPvPAttackData(self.targetid,self.curSelctIndex)
end
local isshow=false
local hasDef=false
local hasAtk=false
local tips_str
if attactInfo then
hasAtk=true
if mathHelper.validInt64(attactInfo.defendguildid)then
hasDef=true
if attactInfo.res~=0 then
isshow=true
else
tips_str='暂无信息'
end
else
if attactInfo.res~=0 then
local atkName
local xmData=zhengzhanshanhaiModel:getXMData(attactInfo.attackguildid)
if xmData then
atkName=xmData.guildname
end
if atkName==nil or atkName==''then
atkName="已解散仙盟"
end
tips_str=FMT.fmt('<color=#C82C2C>{0}</color>已成功占领无主领地',atkName)
else
tips_str='暂无信息'
end
end
else
tips_str='暂无信息'
end
self.attactXMObj:setActive(hasAtk)
if hasAtk then
self:refreshAtkInfo(attactInfo)
end
self.defXMObj:setActive(hasDef)
if hasDef then
self:refreshDefInfo(attactInfo)
end
self.LogScrollView:setActive(isshow)
self.noSign:setActive(not isshow)
if isshow then
self:refreshFightInfo(attactInfo)
else
self.noSignTxt:setText(tips_str or'')
end
end

function UIXM_ZZSH_FightSituationWin:refreshAtkInfo(attactInfo)
local abname=globalABLookup.xianmengicons

local atkTeamData=zhengzhanshanhaiModel:getXMData(attactInfo.attackguildid)
local atkName=atkTeamData.guildname
local atkTeamNum=attactInfo.attackteamnum
self.attackXM:setText(atkName==""and"已解散仙盟"or atkName)
self.attackTeamNum:setText(FMT.fmt("队伍数：{0}",atkTeamNum))
local atkGuildIcon=atkTeamData.guildicon>0 and xianmengModel.splitGuildIcon(atkTeamData.guildicon)or xianmengModel.getDefualtGuildIamge()

self.xmIconatk:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,atkGuildIcon.icon,'icon'))

self.xmKuangatk:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,atkGuildIcon.kuang,'icon'))

self.xmBgatk:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,atkGuildIcon.bg,'icon'))

local showWin=attactInfo.res~=0
self.winIconatk:setActive(showWin)
if showWin then
local winIcon=attactInfo.res==1 and'image_pqjsshengbai_1'or'image_pqjsshengbai_2'
self.winIconatk:setSprite(globalABLookup.global,winIcon)
end
end

function UIXM_ZZSH_FightSituationWin:refreshDefInfo(attactInfo)
local abname=globalABLookup.xianmengicons

local defTeamData=zhengzhanshanhaiModel:getXMData(attactInfo.defendguildid)
local defName=defTeamData.guildname
local defTeamNum=attactInfo.defendteamnum
self.defendXM:setText(defName==""and"已解散仙盟"or defName)
self.defendTeamNum:setText(FMT.fmt("队伍数：{0}",defTeamNum))
local defGuildIcon=defTeamData.guildicon>0 and xianmengModel.splitGuildIcon(defTeamData.guildicon)or xianmengModel.getDefualtGuildIamge()

self.xmIcondef:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,defGuildIcon.icon,'icon'))

self.xmKuangdef:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,defGuildIcon.kuang,'icon'))

self.xmBgdef:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,defGuildIcon.bg,'icon'))

local showWin=attactInfo.res~=0
self.winIcondef:setActive(showWin)
if showWin then
local winIcon=attactInfo.res==2 and'image_pqjsshengbai_1'or'image_pqjsshengbai_2'
self.winIcondef:setSprite(globalABLookup.global,winIcon)
end
end

function UIXM_ZZSH_FightSituationWin:refreshFightInfo(attactInfo)
local abname=globalABLookup.xianmengicons
local atkTeamNum=attactInfo.attackteamnum
local defTeamNum=attactInfo.defendteamnum

local n=attactInfo.len
local fightDetailList=attactInfo.list
self.logGridPanel:setChildLayoutGroupCreateItems(n)
if n>0 then
local logGridGrids=self.logGridPanel:getChildLayoutGroupGridList()
for i=1,#fightDetailList do
local logWidget=logGridGrids[i-1]
local fightDetail=fightDetailList[i]
local is_win=fightDetail.res==1
logWidget:SetChildActive(0,is_win)
logWidget:SetChildActive(1,not is_win)
if is_win then
defTeamNum=defTeamNum-1
else
atkTeamNum=atkTeamNum-1
end


local attackWidget=logWidget:GetChildWidgetBase(2)


attackWidget:SetChildText(0,atkTeamNum)
attackWidget:SetChildText(1,tostring(fightDetail.attackteamfight))
attackWidget:SetChildText(2,fightDetail.attackname)
local rate1=fightDetail.attackteampower/zhengzhanshanhaiModel.maxLingLi
attackWidget:SetChildIconFillAmount(4,rate1)
attackWidget:SetChildText(3,FMT.fmt("灵力值：{0}%",fightDetail.attackteampower))


local defendWidget=logWidget:GetChildWidgetBase(3)


defendWidget:SetChildText(0,defTeamNum)
defendWidget:SetChildText(1,tostring(fightDetail.defendteamfight))
defendWidget:SetChildText(2,fightDetail.defendname)
local rate2=fightDetail.defendteampower/zhengzhanshanhaiModel.maxLingLi
defendWidget:SetChildIconFillAmount(4,rate2)
defendWidget:SetChildText(3,FMT.fmt("灵力值：{0}%",fightDetail.defendteampower))


if fightDetail.fightlogid and fightDetail.fightlogid~=""then
local reportId=fightDetail.fightlogid
logWidget:SetChildActive(4,true)
logWidget:SetChildButtonClick(4,function()
local args={nil,reportId,eRePlayerType.shanhailog,nil,3,nil,nil,is_win and 1 or 0}
args.log_jump_args={self.targetid,self.curSelctIndex}
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local isSeason=shSeasonId~=-1
local isBigCrossServer=isSeason
fightController:send_254_29(reportId,args,true,isBigCrossServer,nil,isSeason)
end)
else
logWidget:SetChildActive(4,false)
end
end
end

if attactInfo.res==1 or attactInfo.res==2 then
local atkTeamData=zhengzhanshanhaiModel:getXMData(attactInfo.attackguildid)
local atkName=atkTeamData.guildname
local atkGuildIcon=atkTeamData.guildicon>0 and xianmengModel.splitGuildIcon(atkTeamData.guildicon)or xianmengModel.getDefualtGuildIamge()
local defTeamData=zhengzhanshanhaiModel:getXMData(attactInfo.defendguildid)
local defName=defTeamData.guildname
local defGuildIcon=defTeamData.guildicon>0 and xianmengModel.splitGuildIcon(defTeamData.guildicon)or xianmengModel.getDefualtGuildIamge()

self.resultItem:setActive(true)

local atkWin=attactInfo.res==1

local oriAtkTeamNum=attactInfo.attackteamnum
local oriDefTeamNum=attactInfo.defendteamnum

local result_atk=self.attackInfo:getWidgetBase()

result_atk:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,atkGuildIcon.icon,'icon'))

result_atk:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,atkGuildIcon.kuang,'icon'))

result_atk:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,atkGuildIcon.bg,'icon'))

result_atk:SetChildActive(3,atkWin)
result_atk:SetChildActive(4,not atkWin)
result_atk:SetChildText(5,FMT.fmt("{0}/{1}",atkTeamNum,oriAtkTeamNum))
result_atk:SetChildText(6,atkName==""and"已解散仙盟"or atkName)

local result_def=self.defendInfo:getWidgetBase()

result_def:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,defGuildIcon.icon,'icon'))

result_def:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,defGuildIcon.kuang,'icon'))

result_def:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,defGuildIcon.bg,'icon'))

result_def:SetChildActive(3,not atkWin)
result_def:SetChildActive(4,atkWin)
result_def:SetChildText(5,FMT.fmt("{0}/{1}",defTeamNum,oriDefTeamNum))
result_def:SetChildText(6,defName==""and"已解散仙盟"or defName)

local logTxt=nil
if attactInfo.getDesc and type(attactInfo.getDesc)=='function'then
logTxt=attactInfo:getDesc()
end
self.logTips:setText(logTxt and FMT.fmt("{0} {1}",logTxt,atkWin and'成功'or'失败')or'未知行动')


local showReward=attactInfo.plunderlistlen>0
self.moneyGrid:setActive(showReward)
if showReward then
local grids=self.moneyGrid:getChildCommonLayoutGroupWidgetList()
local moneys=attactInfo.plunderList
for i=1,grids.Count do
local moneyItem=grids[i-1]
local money=moneys[i]
local show=money~=nil
moneyItem:SetChildActive(-1,show)
if show then
local moneyType=money.param_1
local moneyStr=mathHelper.formatNumber(money.param_2,true)
moneyItem:SetChildText(0,moneyStr)
moneyItem:SetChildIcon(1,iconHelper.getIconName(moneyType),true)
end
end
end
else
self.resultItem:setActive(false)
end
end



function UIXM_ZZSH_FightSituationWin:refreshItemsSV()
if not self.initSV then
self.initSV=true
local n=self.targetData.len
self.scrollscript:initData(nil,252,n)
else
self.scrollscript:doRefreshActiveCellViews()
end
end

function UIItemScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIItemScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIItemScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local teamData=_this.targetData.teams2[dataIndex]

item:SetChildButtonClick(0,function()
self:onItemClick(dataIndex)
end)

local isSelect=dataIndex==_this.curSelctIndex
self:refreshItemSelect(dataIndex,item,isSelect)

local xmname_str
local xmData=zhengzhanshanhaiModel:getXMData(teamData.guildid)
if xmData then
xmname_str=xmData.guildname
end
if xmname_str then
xmname_str=FMT.fmt('{0} 仙阵{1}',xmname_str,teamData.teamtype)
else
xmname_str='仙盟已解散'
end
item:SetChildText(2,xmname_str)

self:refreshItemState(dataIndex,item)

item:SetChildText(4,tostring(dataIndex))
end

function UIItemScroller:refreshItemState(dataIndex,item)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
local teamData=_this.targetData.teams2[dataIndex]

local state,name,time=zhengzhanshanhaiModel:getPvPTeamState(teamData,true,true)
local state_str
if time~=nil then
state_str=FMT.fmt('<color=#549327>{0}</color>到达',timeHelper.format_time_stamp3(time))
else
state_str=name
end
item:SetChildText(3,state_str)
end

function UIItemScroller:refreshItemSelect(dataIndex,item,flag)
if _this==nil then return end
if item==nil then
item=self:GetCell(dataIndex-1)
end
if item==nil then return end
item:SetChildActive(1,flag)
return true
end

function UIItemScroller:onItemClick(dataIndex)
if _this==nil then return end
if not _this:checkClickLock()then
return
end
local teamData=_this.targetData.teams2[dataIndex]
if teamData then
local state,name,time=zhengzhanshanhaiModel:getPvPTeamState(teamData)
if state>2 then
if _this.curSelctIndex==dataIndex then return end
if _this.curSelctIndex then
self:refreshItemSelect(_this.curSelctIndex,nil,false)
end
_this.curSelctIndex=dataIndex
self:refreshItemSelect(_this.curSelctIndex,nil,true)
zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(_this.targetid,_this.curSelctIndex)
end
end
end




function UIXM_ZZSH_FightSituationWin:onWaitFightBtn()
if self.lockClick then return end
self.waitFightPanelVisible=not self.waitFightPanelVisible
self.arrow:setRotation(0,self.waitFightPanelVisible and 180 or 0,0)
self.waitFightBtnModel:setChildModelAnimationState(self.waitFightPanelVisible and aniEnum.open or aniEnum.close,1,
function()
if _this==nil then return end
_this.lockClick=true
_this:delayDo(0.1,function()
_this.lockClick=nil
if _this.waitFightPanelVisible then
_this.waitFightPanel:setActive(true)
end
end)

end)
if not self.waitFightPanelVisible then
self.waitFightPanel:setActive(false)
end
end

function UIXM_ZZSH_FightSituationWin:rec_data(targetid,idx)
if mathHelper.compareInt64(targetid,self.targetid)and self.curSelctIndex==idx then
self:refreshView()
end
end