







def_class("UIXMFXZYWin",UIWindowBase)









function UIXMFXZYWin:bindComponents()

self.feishengRoot=UIObject.get(self,0)
self.FSTrule=UIButton.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.left=UIObject.get(self,3)
self.logGridPanel=UIObject.get(self,4)
self.LogScrollView=UILoopListView.new(self,5)
self.noneSeek=UIObject.get(self,6)
self.noneShare=UIObject.get(self,7)
self.notinfo=UIObject.get(self,8)
self.onekeyhelp=UIButton.get(self,9)
self.progressBar=UIProgress.get(self,10)
self.progressTx=UIText.get(self,11)
self.reddot=UIObject.get(self,12)
self.refreshBtn=UIButton.get(self,13)
self.rewardicon=UIImage.get(self,14)
self.right=UIObject.get(self,15)
self.root=UIObject.get(self,16)
self.scrollerScript=UIEnhancedScrollerLua.get(self,17)
self.seekList=UIObject.get(self,18)
self.seekRoot=UIObject.get(self,19)
self.seekTx=UIText.get(self,20)
self.seekView=UIScrollViewSlow.get(self,21)
self.shareRoot=UIObject.get(self,22)
self.shareTx=UIText.get(self,23)
self.sortConditionButton=UIButton.get(self,24)

self.FSTrule:setButtonClick(function()self:onFSTrule()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.LogScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.onekeyhelp:setButtonClick(function()self:onOnekeyhelp()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)



end


function UIXMFXZYWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.feishengRoot);self.feishengRoot=nil;
_UIObject_release(self.FSTrule);self.FSTrule=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.logGridPanel);self.logGridPanel=nil;
self.LogScrollView:deleteSelf();self.LogScrollView=nil;
_UIObject_release(self.noneSeek);self.noneSeek=nil;
_UIObject_release(self.noneShare);self.noneShare=nil;
_UIObject_release(self.notinfo);self.notinfo=nil;
_UIObject_release(self.onekeyhelp);self.onekeyhelp=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.rewardicon);self.rewardicon=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollerScript);self.scrollerScript=nil;
_UIObject_release(self.seekList);self.seekList=nil;
_UIObject_release(self.seekRoot);self.seekRoot=nil;
_UIObject_release(self.seekTx);self.seekTx=nil;
_UIObject_release(self.seekView);self.seekView=nil;
_UIObject_release(self.shareRoot);self.shareRoot=nil;
_UIObject_release(self.shareTx);self.shareTx=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
end















local _this=nil
local _leftConfig={
{
name="分享",
showRoot=function(win,show)
win.shareRoot:setActive(show)
if show then
xianmengModel:resetFilterDataq_fenxiangziyuan()
end
end,
initView=function(win)
win.right:setActive(true)
win:refreshShareCount()
win:refreshShareList()
end,
refreshView=function(win)
win.right:setActive(true)
win:refreshShareList()
end,
refreshList=function(win)
win.right:setActive(true)
win:refreshShareList()
end,
reddotfun=function()
return false
end,

openfunc=function()
return true
end,
},
{
name="求助",
showRoot=function(win,show)
win.seekRoot:setActive(show)
end,
initView=function(win)
win.right:setActive(true)
win:refreshSeekCount()
win:refreshSeekList()
win:refreshSeekView(true)
end,
refreshView=function(win,change)
win.right:setActive(true)
if change then
win:refreshSeekView(true)
end
end,
refreshList=function(win)
win.right:setActive(true)
win:refreshSeekCount()
win:refreshSeekList()
end,
reddotfun=function()
return false
end,

openfunc=function()
return true
end,
},

{
name="协助",
showRoot=function(win,show)
win.feishengRoot:setActive(show)
end,

initView=function(win)

FeiShengTaiController:SendXMHelp_feisheng()
win.right:setActive(false)
win:RefreshFeiShengTaiWin()
end,
refreshView=function(win,change)
win.right:setActive(false)
win:RefreshFeiShengTaiWin()
end,
refreshList=function(win)

end,

reddotfun=function()
return FeiShengTaiModel:ShowHelpReddot()
end,

openfunc=function()
local member_reduce_conf=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'member_reduce_conf')
local needlv=member_reduce_conf[2]
local zmlv=zongmenModel:getLevel()
return needlv<=zmlv
end,
},

}
local _rightConfig={
{
name="全部",
type=nil,
},
{
name="材料",
type=ITEM_MAIN_TYPE.eMaterials,
},
{
name="古宝",
type=ITEM_MAIN_TYPE.eGubao,
},
}
local _filterName={
{
'品质',
{
{name='绿色'},
{name='蓝色'},
{name='紫色'},
{name='橙色'},
{name='红色'},
},
},
{
'可分享',
{
{name='只显示可分享的'},
},
},
}
local _shareItemCmp={
item=0,
name=1,
rewardBtn=2,
button=3,
num=4,
rewardIcon=5,
rewardNum=6,
least=7,
completed=8,
shared=9,
}
local _seekItemCmp={
item=0,
num=1,
downBtn=2,
progressBar=3,
completed=4,
}
local _leftCmp={
name1=0,
name2=1,
notSelected=2,
selected=3,
reddot=4,
}
local _rightCmp={
name=0,
selected=1,
}
local _seekViewCol=4
local _seekViewRow=7
local _seekViewPageNum=_seekViewCol*_seekViewRow
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIXMFXZYWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.on_item_changed,self.onItemChanged)
notifySystem:listenNotify(notifyConfig.onXMFXZYInit,self.onXMFXZYInit)
notifySystem:listenNotify(notifyConfig.onXMFXZYAdd,self.onXMFXZYAdd)
notifySystem:listenNotify(notifyConfig.onXMFXZYDelete,self.onXMFXZYDelete)
notifySystem:listenNotify(notifyConfig.onXMFXZYSeek,self.onXMFXZYSeek)
notifySystem:listenNotify(notifyConfig.onXMFXZYShare,self.onXMFXZYShare)
notifySystem:listenNotify(notifyConfig.onXMFXZYProgress,self.onXMFXZYProgress)
notifySystem:listenNotify(notifyConfig.onXMFXZYComplete,self.onXMFXZYComplete)

self.seekView:setSlowClickAction(function(...)self:onSeekViewClick(...)end)
self.seekView:bindSlowWidget(function(...)self:onSeekViewBindGrid(...)end)
self.enhancedscrollscript=UIPrepareEnScroller(self.scrollerScript:getGameObject(),self.scrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self


xianmengController:req_protocol_20_41()

self:initLeftTabs()
self:initRightTabs()
self:initPanel()

local id=self.LogScrollView:getID()
self.logGridPanelCmp=self.winlua:GetChildLoopListView2(id)

end


function UIXMFXZYWin:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_item_changed,self.onItemChanged)
notifySystem:removelistener(notifyConfig.onXMFXZYInit,self.onXMFXZYInit)
notifySystem:removelistener(notifyConfig.onXMFXZYAdd,self.onXMFXZYAdd)
notifySystem:removelistener(notifyConfig.onXMFXZYDelete,self.onXMFXZYDelete)
notifySystem:removelistener(notifyConfig.onXMFXZYSeek,self.onXMFXZYSeek)
notifySystem:removelistener(notifyConfig.onXMFXZYShare,self.onXMFXZYShare)
notifySystem:removelistener(notifyConfig.onXMFXZYProgress,self.onXMFXZYProgress)
notifySystem:removelistener(notifyConfig.onXMFXZYComplete,self.onXMFXZYComplete)

if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end

xianmengModel:resetFilterDataq_fenxiangziyuan()
end




function UIXMFXZYWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.15,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
if argtable and argtable.tabIndex then
self:onClickLeftTab(argtable.tabIndex)
end
end


function UIXMFXZYWin:onHide()
self.rSelect=1
self:refreshRightTabs()

xianmengModel:resetFilterDataq_fenxiangziyuan()
end

function UIXMFXZYWin:onShowArgRecv()
if self.lSelect then
self:checkRefreshView(self.lSelect,self.rSelect)
end
end



function UIXMFXZYWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='xmfxzy_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXMFXZYWin:onRefreshBtn()
if self.cdTimer then
local interval=math.max(self.cdUtil-timeHelper.getServerShortTime(),0)
UIManager.error(FMT.fmt('{0}秒后可刷新',interval))
return
end
self.cdUtil=timeHelper.getServerShortTime()+5
self.cdTimer=self:delayDo(5,function()
self.cdTimer=nil
end)
xianmengController:req_protocol_20_41()
end

function UIXMFXZYWin:onSortConditionButton()
local filterFlag=xianmengModel:getFilterData_fenxiangziyuan()
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')
args.pos=1
args.extraWin='UIFilterWin'
local extraParams={filterName=_filterName,filterFlag=filterFlag,comfirmCallback=self.onSortConditionComfirm}
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end


function UIXMFXZYWin.onSortConditionComfirm(data)
xianmengModel:setFilterData_fenxiangziyuan(data.filterFlag)
_this:refreshShareList()
end

function UIXMFXZYWin:checkRefreshView(left,right)
if not self.inited then return end
if self.refreshViewFlag[left]==nil then
_leftConfig[left].initView(self)
self.refreshViewFlag[left]=right
self.refreshListFlag[left]=true
else
_leftConfig[left].refreshView(self,self.refreshViewFlag[left]~=right)
self.refreshViewFlag[left]=right
end
end

function UIXMFXZYWin:checkRefreshList(left)
if not self.inited then return end
if left and not self.refreshListFlag[left]then
_leftConfig[left].refreshList(self)
self.refreshListFlag[left]=true
end
end

function UIXMFXZYWin:initPanel()
self.inited=xianmengModel:checkData_fenxiangziyuan()
if self.inited then
self.refreshViewFlag={}
self.refreshListFlag={}
self.rSelect=self.rSelect or 1
self.lSelect=self.lSelect or 1

local item=self.left:getChildLayoutGroupGridItem(self.lSelect-1)
item:SetChildActive(_leftCmp.notSelected,false)
item:SetChildActive(_leftCmp.selected,true)
item=self.right:getChildLayoutGroupGridItem(self.rSelect-1)
item:SetChildActive(_rightCmp.selected,true)

for i,v in ipairs(_leftConfig)do
v.showRoot(self,i==self.lSelect)
end

if xianmengModel:checkData_fenxiangziyuan()then
self:checkRefreshView(self.lSelect,self.rSelect)
end
end
end

function UIXMFXZYWin:initLeftTabs()
self.left:setChildLayoutGroupCreateItems(#_leftConfig,function(index)
local item=self.left:getChildLayoutGroupGridItem(index-1)
local config=_leftConfig[index]
local selected=self.lSelect==index
if config.openfunc(self)then
item:SetChildActive(-1,true)
item:SetChildText(_leftCmp.name1,config.name)
item:SetChildText(_leftCmp.name2,config.name)
item:SetChildActive(_leftCmp.notSelected,not selected)
item:SetChildActive(_leftCmp.selected,selected)
item:SetChildButtonClick(-1,function()
self:onClickLeftTab(index)
end)
item:SetChildActive(_leftCmp.reddot,config.reddotfun(self))
else
item:SetChildActive(-1,false)
end

end)
end

function UIXMFXZYWin:onClickLeftTab(index)
if index~=self.lSelect then

if self.lSelect then
local item=self.left:getChildLayoutGroupGridItem(self.lSelect-1)
item:SetChildActive(_leftCmp.notSelected,true)
item:SetChildActive(_leftCmp.selected,false)
local lConfig=_leftConfig[self.lSelect]
lConfig.showRoot(self,false)
end

self.rSelect=1
self.lSelect=index

local item=self.left:getChildLayoutGroupGridItem(self.lSelect-1)
item:SetChildActive(_leftCmp.notSelected,false)
item:SetChildActive(_leftCmp.selected,true)

local lConfig=_leftConfig[self.lSelect]
lConfig.showRoot(self,true)

self:refreshRightTabs()
self:checkRefreshView(self.lSelect,self.rSelect)
end
end

function UIXMFXZYWin:initRightTabs()
self.right:setChildLayoutGroupCreateItems(#_rightConfig,function(index)
local item=self.right:getChildLayoutGroupGridItem(index-1)
local config=_rightConfig[index]
item:SetChildText(_rightCmp.name,config.name)
item:SetChildActive(_rightCmp.selected,self.rSelect==index)
item:SetChildButtonClick(-1,function()
self:onClickRightTab(index)
end)
end)
end

function UIXMFXZYWin:refreshRightTabs()
local rightTabs=self.right:getChildLayoutGroupGridList()
for i=1,rightTabs.Count do
local item=self.right:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(_rightCmp.selected,self.rSelect==i)
end
end

function UIXMFXZYWin:onClickRightTab(index)
if index~=self.rSelect then
if self.rSelect then
local item=self.right:getChildLayoutGroupGridItem(self.rSelect-1)
item:SetChildActive(_rightCmp.selected,false)
end
self.rSelect=index
local item=self.right:getChildLayoutGroupGridItem(self.rSelect-1)
item:SetChildActive(_rightCmp.selected,true)
self:checkRefreshView(self.lSelect,self.rSelect)
end
end

function UIXMFXZYWin:refreshShareCount()
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"answer_askfor")
local cur=xianmengModel:getShareTimes_fenxiangziyuan()
local least=max-cur
if least<=0 then
least=FMT.cfmt(FONT_COLOR.eRedColor,least)
end
self.shareTx:setText(FMT.fmt("本日剩余分享数: {0}",least))
end

function UIXMFXZYWin:refreshShareList()
local filterBit=xianmengModel:getFilterBit_fenxiangziyuan()
local itemType=_rightConfig[self.rSelect].type
local shareListData=xianmengModel:getShareOtherFilterSort_fenxiangziyuan(filterBit[1],itemType,filterBit[2])
local countChange=self.shareListData==nil
if self.shareListData then
local oldCnt=#self.shareListData
local newCnt=#shareListData
countChange=oldCnt~=newCnt
end
self.shareListData=shareListData
if countChange then
local dataCnt=#self.shareListData
self.enhancedscrollscript:initData(self.shareListData,100,dataCnt)
self.noneShare:setActive(dataCnt<=0)
else
self.enhancedscrollscript:doRefreshActiveCellViews()
end
end

function UIXMFXZYWin:onClickShare(data)
local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
local cur=xianmengModel:getShareTimes_fenxiangziyuan()
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"answer_askfor")
if cur and cur<max then
local have=itemsModel.getCount(data.item)
local need=config.num
if have>=need then
if xianmengModel:containShareRecord_fenxiangziyuan(data.guidStr)then
UIManager.error("已分享过")
else
UIManager:showWindow("UIXMFXZYShareWin",data)
end
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(data.item)))
end
else
UIManager.error("本日分享次数已达上限")
end
end

function UIXMFXZYWin:refreshSeekCount()
local max=cfgHelper.get2(cfg_guildbaseconfig_get,1,"askfor")
local cur=xianmengModel:getSeekTimes_fenxiangziyuan()
local least=max-cur
if least<=0 then
least=FMT.cfmt(FONT_COLOR.eRedColor,least)
end
self.seekTx:setText(FMT.fmt("本周剩余求助次数：{0}/{1}",least,max))
end

function UIXMFXZYWin:refreshSeekList()
self.seekListData=xianmengModel:getShareOwnerSort_fenxiangziyuan()
local seekListDataCnt=#self.seekListData
self.noneSeek:setActive(seekListDataCnt<=0)
self.seekList:setChildLayoutGroupCreateItems(seekListDataCnt,function(index)
local item=self.seekList:getChildLayoutGroupGridItem(index-1)
local guidStr=self.seekListData[index]
local data=xianmengModel:getOwnerData_fenxiangziyuan(guidStr)
local itemId=data.item
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemId)
local completed=data.progress>=config.max
local conf={itemid=itemId,itemcount="",showCountBG=false,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_seekItemCmp.item,prop)
item:SetBaseItemClickEvent(_seekItemCmp.item,itemsComponentHelper.onItemClick)

item:SetChildButtonClick(_seekItemCmp.downBtn,function()
self:onClickDelist(guidStr)
end)
local p=Mathf.Clamp(data.progress,0,config.max)
item:SetChildProgressValue(_seekItemCmp.progressBar,math.floor(p/config.max*10000),10000)
item:SetChildProgressText(_seekItemCmp.progressBar,FMT.fmt("{0}/{1}",p*config.num,config.max*config.num))
item:SetChildActive(_seekItemCmp.downBtn,not completed)
item:SetChildActive(_seekItemCmp.completed,completed)
if not completed then
item:SetChildImageExGray(_seekItemCmp.downBtn,data.progress>0)
end
end)
end

function UIXMFXZYWin:onClickDelist(guidStr)
local data=xianmengModel:getOwnerData_fenxiangziyuan(guidStr)
if data.progress<=0 then
xianmengController:req_protocol_20_43(data.guid)
else
UIManager.error("已有盟友分享物品给祖师，不能下架求助了")
end
end

function UIXMFXZYWin:refreshSeekView(reset)
if reset then
local itemType=_rightConfig[self.rSelect].type
self.seekViewData=xianmengModel:getSeekItemSort_fenxiangziyuan(itemType)
self.seekViewPageCnt=math.ceil(#self.seekViewData/_seekViewPageNum)

self.seekView:clearSlowItems()
self.curSeekViewPage=1
end
local showNum=self.curSeekViewPage*_seekViewPageNum
local showRow=showNum/_seekViewCol
self.seekView:freshSlowGrids(showNum,showRow,_seekViewCol,reset)
end

function UIXMFXZYWin:refreshAllSeekViewItem()
self.seekView:freshAllItems()
end

function UIXMFXZYWin:onSeekViewEdgeEvent()
if self.curSeekViewPage>=self.seekViewPageCnt then return end
self.curSeekViewPage=self.curSeekViewPage+1
self:refreshSeekView(false)
end

function UIXMFXZYWin:onSeekViewClick(itemid,index,itemguid,attach)
if itemid then
tipsManager.showTips({itemid=itemid,formType=TIPS_FORM_TYPE.eXMFXZY})
end
end

function UIXMFXZYWin:onSeekViewBindGrid(index,item)
local itemId=self.seekViewData[index]
if itemId then
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemId)
local itemNum=itemsModel.getCount(itemId)
local countStr=mathHelper.formatNumber(itemNum)
if itemNum<=0 then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
local gray=0
if not xianmengModel:checkConditions_fenxiangziyuan(config.condition)then
gray=6
elseif xianmengModel:findOwnerDataSameTypeData_fenxiangziyuan(itemId)then
gray=1
end
local conf={
itemid=itemId,
itemcount=countStr,
showCountBG=true,
showname=false,
showStage=true,
gray=gray,
}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onSeekViewClick(...)
end)
else
local prop=itemsComponentHelper.getCommonTempDataSmall()
item:SetChildPropData(0,prop)
end
end

function UIXMFXZYWin.onXMFXZYInit()
if _this and not _this.isClose then
if _this.inited then
_this.refreshListFlag={}
_this:checkRefreshList(_this.lSelect)
else
_this:initPanel()
end
end
end

function UIXMFXZYWin.onXMFXZYAdd(data)
if _this and not _this.isClose then
local flag=xianmengModel:isOtherData_fenxiangziyuan(data.guidStr)
local index=flag and 1 or 2
_this.refreshListFlag[index]=nil
if _this.lSelect==index then
_this:checkRefreshList(_this.lSelect)
if _this.lSelect==2 then
_this:refreshAllSeekViewItem()
end
end
end
end

function UIXMFXZYWin.onXMFXZYDelete(data)
if _this and not _this.isClose then
local flag=data.actor==playerModel:getActorID()
local index=flag and 2 or 1
_this.refreshListFlag[index]=nil
if _this.lSelect==index then
_this:checkRefreshList(_this.lSelect)
if _this.lSelect==2 then
_this:refreshSeekView(true)
end
end
end
end

function UIXMFXZYWin.onXMFXZYSeek()
if _this and not _this.isClose then
if _this.refreshViewFlag[2]then
_this:refreshSeekCount()
end
end
end

function UIXMFXZYWin.onXMFXZYShare()
if _this and not _this.isClose then
if _this.refreshViewFlag[1]then
_this:refreshShareCount()
end
end
end

function UIXMFXZYWin.onXMFXZYProgress(key,share)
if _this and not _this.isClose then
local flag=xianmengModel:isOwnerData_fenxiangziyuan(key)
local index=flag and 2 or 1
if _this.lSelect==index then
if not flag then

if share then
_this:refreshShareList()
else
local startIdx=_this.enhancedscrollscript:getStartCellViewIndex()
local endIdx=_this.enhancedscrollscript:getEndCellViewIndex()
for i=startIdx,endIdx do
local guidStr=_this.shareListData[i+1]
if guidStr==key then
local data=xianmengModel:getOtherData_fenxiangziyuan(key)
local cell=_this.enhancedscrollscript:GetCell(i)
local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
cell:SetChildText(_shareItemCmp.least,(config.max-data.progress)*config.num)
break
end
end
end
else

for idx,guidStr in ipairs(_this.seekListData)do
if guidStr==key then
local item=_this.seekList:getChildLayoutGroupGridItem(idx-1)
local data=xianmengModel:getOwnerData_fenxiangziyuan(guidStr)
local itemId=data.item
local config=cfgHelper.get1(cfg_guildaskforconfig_get,itemId)
item:SetChildImageExGray(_seekItemCmp.downBtn,data.progress>0)
local p=Mathf.Clamp(data.progress,0,config.max)
item:SetChildProgressValue(_seekItemCmp.progressBar,math.floor(p/config.max*10000),10000)
item:SetChildProgressText(_seekItemCmp.progressBar,FMT.fmt("{0}/{1}",p*config.num,config.max*config.num))
break
end
end
end
end
end
end

function UIXMFXZYWin.onXMFXZYComplete(key)
if _this and not _this.isClose then
local flag=xianmengModel:isOwnerData_fenxiangziyuan(key)
local index=flag and 2 or 1
_this.refreshListFlag[index]=nil
if _this.lSelect==index then
_this:checkRefreshList(_this.lSelect)
end
end
end

function UIXMFXZYWin.onItemChanged(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil or _this.isClose then return end
if _this.lSelect==1 then
local startIdx=_this.enhancedscrollscript:getStartCellViewIndex()
local endIdx=_this.enhancedscrollscript:getEndCellViewIndex()
for i=startIdx,endIdx do
local key=_this.shareListData[i+1]
local data=xianmengModel:getOtherData_fenxiangziyuan(key)
if data and data.item==itemid then
local cell=_this.enhancedscrollscript:GetCell(i)
local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
local have=itemsModel.getCount(data.item)
local check=have>=config.num
local color=check and"#549327"or"#C82C2C"
cell:SetChildText(_shareItemCmp.num,FMT.fmt("<color={1}>拥有：{0}</color>",have,color))
cell:SetChildImageExGray(_shareItemCmp.button,not check)
end
end

elseif _this.lSelect==3 then

else
for index,itemId in ipairs(_this.seekViewData)do
if itemId==itemid then
_this.seekView:freshSlowItem(index-1)
end
end
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
if self.window and self.window.isClose then
return
end
local key=self.window.shareListData[dataIndex]
local data=xianmengModel:getOtherData_fenxiangziyuan(key)
local config=cfgHelper.get1(cfg_guildaskforconfig_get,data.item)
local completed=xianmengModel:isDataFullProgressEx_fenxiangziyuan(data)

local conf={
itemid=data.item,
showCountBG=false,
showStage=true,
itemcount="",
showname=false,

gray=completed and 1 or 0,
}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=nil
cell:SetChildPropData(_shareItemCmp.item,prop)
cell:SetBaseItemClickEvent(_shareItemCmp.item,itemsComponentHelper.onItemClickEx)

local p=math.max(0,config.max-data.progress)
cell:SetChildText(_shareItemCmp.least,p>0 and p*config.num or"")

local nameStr=xianmengModel:getXMMemberName(data.actor)or""
cell:SetChildText(_shareItemCmp.name,nameStr)

local shared=xianmengModel:containShareRecord_fenxiangziyuan(key)
local numStr=""
cell:SetChildActive(_shareItemCmp.button,not completed and not shared)
cell:SetChildActive(_shareItemCmp.shared,not completed and shared)
cell:SetChildActive(_shareItemCmp.completed,completed)
if not completed then
local have=itemsModel.getCount(data.item)
local check=have>=config.num
local color=check and"#549327"or"#C82C2C"
numStr=FMT.fmt("<color={1}>拥有：{0}</color>",have,color)

cell:SetChildButtonClick(_shareItemCmp.button,function()
self.window:onClickShare(data)
end)
cell:SetChildImageExGray(_shareItemCmp.button,not check)
end
cell:SetChildText(_shareItemCmp.num,numStr)

cell.gameObject.name=tostring(dataIndex)
end



function UIXMFXZYWin:RefreshFeiShengTaiWin()


local helptable=FeiShengTaiModel:GetXMHelpData()
local helplen=helptable.len

local itemIdList={}
self.LogScrollView:initData("UIfeishengitem",itemIdList)
self.notinfo:setActive(helplen<=0)
if helplen<0 then

logErr("数据有问题")
return
end
local helpdata=helptable.data

for i=1,helplen do

itemIdList[i]=i
end

self.LogScrollView:initData("UIfeishengitem",itemIdList)
local nowShowItemCount=self.logGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.logGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshItem(item.Widget,index)
end
end

self:refreshRewardProgress()
self.onekeyhelp:setActive(FeiShengTaiModel:JudeHaveHelp())
self.reddot:setActive(FeiShengTaiModel:ShowHelpReddot())
end

local itemcmp=
{
name=0,
desc=1,
nametxt=2,
headicon=3,
mybg=4,
helpbtn=5,
yet=6,
headiconclick=7,
}

function UIXMFXZYWin:refreshItem(item,idx)
if item==nil then

return
end
local helptable=FeiShengTaiModel:GetXMHelpData()

local helpdata=helptable.data[idx]


local basiccfg=cfgHelper.get1(cfg_feishengjctjbasicconfig_get,1)
local helptype=helpdata.type
local log_text=basiccfg.log_text
local actor_id=helpdata.actor_id
local server_id=helpdata.server_id


local weiyi_id=helpdata.id

local max_reduce_conf=basiccfg.max_reduce_conf

if helptype==0 then
log_text=log_text[1]

local maxnum=max_reduce_conf[helpdata.lvl]

local feishenLv=string.format("[%d/%d]",helpdata.lvl-1,4)
local help_cntstr=string.format("%d/%d",helpdata.help_cnt,maxnum)
local color='#549327'
if helpdata.help_cnt>=maxnum then
color='#c82c2c'
end
local str=FMT.fmt(log_text,feishenLv,help_cntstr,color)
item:SetChildText(itemcmp.desc,str)
item:SetChildActive(itemcmp.helpbtn,helpdata.help_cnt<maxnum and helpdata.self_help_cnt~=1)

elseif helptype==1 then
log_text=log_text[2]
local feishenLv=string.format("[等级：]",helpdata.lvl)
local help_cntstr=string.format("%d",helpdata.help_cnt)
local str=FMT.fmt(log_text,feishenLv,help_cntstr)
item:SetChildText(itemcmp.desc,str)
end

local actor_name=string.format("%s",helpdata.actor_name)
local link=FMT.fmt("<a;{0};{1};1;14,{2},{3};/>",actor_name,FONT_COLOR.eOrangeColor,actor_id,server_id)

item:SetChildText(itemcmp.nametxt,link)

item:SetChildButtonClick(itemcmp.headiconclick,function()

local myActorid=playerModel:getActorID()
if not mathHelper.compareInt64(myActorid,actor_id)then
local _server_id=tonumber(server_id)
local now_severid=playerModel:getActorServerID()
local attach=nil
if now_severid~=_server_id then
attach={serverid=_server_id}
end
otherPlayerController:openOtherPlayerInfoWin(actor_id,nil,nil,attach)
else
UIManager.info("目标为自己，查看失败")
end
end)

item:SetChildActive(itemcmp.mybg,playerModel:getActorID()==actor_id)
item:SetChildButtonClick(itemcmp.helpbtn,function()
if helptype==0 then

local maxnum=max_reduce_conf[helpdata.lvl]
if helpdata.help_cnt>=maxnum then
UIManager.info("被协助次数已达到上限")
end
end

FeiShengTaiController:SendHelpXMPeople(weiyi_id)
FeiShengTaiController:SendXMHelp_feisheng()
end)
local maxnum=max_reduce_conf[helpdata.lvl]

item:SetChildActive(itemcmp.yet,helpdata.self_help_cnt==1)
item:SetChildActive(itemcmp.helpbtn,helpdata.help_cnt<maxnum and helpdata.self_help_cnt~=1)


if playerModel:getActorID()==actor_id then
item:SetChildActive(itemcmp.helpbtn,false)
playerController:setHeadIcon(item,itemcmp.headicon,{iconInfo=playerModel:getActorIconInfo(),scale=HEAD_SCALE_TYPE.e60x60})
else
local iconInfo=helpdata.iconInfo
playerController:setHeadIcon(item,itemcmp.headicon,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
end

end


function UIXMFXZYWin:onStartAction()

end


function UIXMFXZYWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end


function UIXMFXZYWin:refreshRewardProgress(index)
local feishengdata=FeiShengTaiModel:GetXMHelpData()
local id=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,"show_help_rewards")
local cnt=FeiShengTaiModel:GetXMItemNum(id)

local max_help_rewards=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,"max_help_rewards")
local show_help_rewards=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,"show_help_rewards")
if max_help_rewards then
local max=max_help_rewards[show_help_rewards]
self.progressTx:setText(FMT.fmt("{0}/{1}",cnt,max))

self.progressBar:setProgressValue(math.floor(cnt/max*10000),10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",cnt,max))

end

self.rewardicon:setImageIcon(iconHelper.getIconName(id))
end

function UIXMFXZYWin:onOnekeyhelp()
if not FeiShengTaiModel:JudeHaveHelp()then
UIManager.info("目前没有可协助")
return
end
FeiShengTaiController:SendHelpXMPeople(0)
FeiShengTaiController:SendXMHelp_feisheng()
end

function UIXMFXZYWin:onFSTrule()
tipsManager.closeTips()
local d={}
d.title='规则说明'
d.mode=3
d.name='feishengtai_help_rule_%d'
d.closeCB=function()
end
UIManager:showWindow('UIRuleWin',d)
end


function UIXMFXZYWin:feishengtaiRefresh()
local item=self.left:getChildLayoutGroupGridItem(2)
local config=_leftConfig[3]
if config.openfunc(self)then
item:SetChildActive(_leftCmp.reddot,config.reddotfun(self))
end
self:RefreshFeiShengTaiWin()
end