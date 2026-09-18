







def_class("UIXM_ZZSH_entitySelectWin",UIWindowBase)









function UIXM_ZZSH_entitySelectWin:bindComponents()

self.money1Root=UIObject.get(self,0)
self.uiPanel=UIObject.get(self,1)
self.maskBlock=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.tabList=UIObject.get(self,5)
self.searchBtn=UIButton.get(self,6)
self.searLock=UIObject.get(self,7)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)



end


function UIXM_ZZSH_entitySelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searLock);self.searLock=nil;
end
















local _this


function UIXM_ZZSH_entitySelectWin:onLoaded(...)
_this=self
self:bindComponents()

self.pageConfig=
{
[1]={
page=1,
win='UIXM_ZZSH_monsterSelectWin',
name='异兽',
infotype=zhengzhanshanhaiModel.qbType.eMonster,
checkReddot=function(self_,win)
return win:checkQingBaoReddot(self_.infotype)
end,
},
[2]={
page=2,
win='UIXM_ZZSH_resourceSelectWin',
name='宝地',
infotype=zhengzhanshanhaiModel.qbType.eResource,
checkReddot=function(self_,win)
return win:checkQingBaoReddot(self_.infotype)
end,
}
}

if UILSZDControl:isLingShanOpen()then
self.pageConfig[3]={
page=3,
win='UILingShanIntelligenceWin',
name='灵山',
infotype=zhengzhanshanhaiModel.qbType.eLingShan,
checkReddot=function(self_,win)
return UILSZDControl:checkQingBaoReddot()
end,
}
end

self.winList={}
self.pageLookup={}
for i,v in ipairs(self.pageConfig)do
self.pageLookup[v.page]=i
end
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)

self.mapView=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','getMapView')
local cost=zhengzhanshanhaiController:getZZSHCfg_search(1,'consume')
self.moneyType=cost[1][1]
end

function UIXM_ZZSH_entitySelectWin:getMapView()
return self.mapView
end


function UIXM_ZZSH_entitySelectWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','refreshMask')
UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','refreshMask')
end


function UIXM_ZZSH_entitySelectWin:onHide()

end

function UIXM_ZZSH_entitySelectWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if moneyType==_this.moneyType then
_this:refreshMoney()
end
end




function UIXM_ZZSH_entitySelectWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
end
self:initQingBaoList()
local page=1
if argtable then
if argtable.page then
page=argtable.page
end
self.data=argtable.data
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#self.pageConfig
self.tabList:setChildLayoutGroupCreateItems(cnt)
local grids=self.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.pageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
item:SetChildNewBieComponentId(3,FMT.fmt('UIXM_ZZSH_entitySelectWin.shqbtab_{0}',i))
end
end
self:onMenuItemClick(idx,true)
self.data=nil
self:initMoney()
self:refreshSearchBtn()
end

function UIXM_ZZSH_entitySelectWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(14,0.2,nil)
else
self.root:setChildCanvasGroupAlpha(1)
end
end

function UIXM_ZZSH_entitySelectWin:playLeaveAnim()
UIManager:invokeUIMethod('UIXM_ZZSH_monsterSelectWin','playLeaveAnim')
UIManager:invokeUIMethod('UIXM_ZZSH_resourceSelectWin','playLeaveAnim')
UIManager:invokeUIMethod('UILingShanIntelligenceWin','playLeaveAnim')
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil
self:closeSelf()
end)
end

function UIXM_ZZSH_entitySelectWin:initQingBaoList()
local isChange=false
local list=zhengzhanshanhaiModel:getNearQingBaoEx()
local temp=self.qblist
local lp1={}
if temp then
for i,v in ipairs(temp)do
lp1[v[1]]=true
end
end
self.qblist={}
local lp2={}
for i,qbguid in ipairs(list)do
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbguid)
local reddot=qbData:checkNewSign()and 1 or 0
local d={qbguid,reddot}
table.insert(self.qblist,d)
lp2[qbguid]=true
end
for qbguid,v in pairs(lp1)do
if lp2[qbguid]==nil then
isChange=true
break
end
end
if not isChange then
for qbguid,v in pairs(lp2)do
if lp1[qbguid]==nil then
isChange=true
break
end
end
end
return isChange
end

function UIXM_ZZSH_entitySelectWin:checkQingBaoReddot(infotype)
for i,d in ipairs(self.qblist)do
local qbData=zhengzhanshanhaiModel:getQingBaoData(d[1])
if qbData then
if qbData.infotype==infotype and d[2]==1 then
return true
end
end
end
return false
end

function UIXM_ZZSH_entitySelectWin:getQingBaoList(infotype,isInit)
local isChange=true
if isInit then
isChange=self:initQingBaoList()
self:refreshAllMenuItemReddot()
end
if isChange then
local list={}
for i,d in ipairs(self.qblist)do
local qbData=zhengzhanshanhaiModel:getQingBaoData(d[1])
if qbData then
if qbData.infotype==infotype then
table.insert(list,d)
end
end
end
return list
end
return nil
end

function UIXM_ZZSH_entitySelectWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.tabList:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(0,flag)
end

function UIXM_ZZSH_entitySelectWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.tabList:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.pageConfig[idx]
local isReddot=cfg:checkReddot(self)
item:SetChildActive(2,isReddot)
end

function UIXM_ZZSH_entitySelectWin:refreshAllMenuItemReddot()
local cnt=#self.pageConfig
local grids=self.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
self:refreshMenuItemReddot(item,i)
end
end

function UIXM_ZZSH_entitySelectWin:onMenuItemClick(idx,isInit)
if self.closeLock then return end
local cfg=self.pageConfig[idx]
if cfg.page==self.curPage then
return
end
local old=self.curPage
self.curPage=cfg.page
if old~=nil then
local idx_=self.pageLookup[old]
self:refreshMenuItemSelect(nil,idx_,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuItemReddot(nil,idx)
self:refreshMenuPage(isInit)
end

function UIXM_ZZSH_entitySelectWin:refreshMenuPage(isInit)
local idx=self.pageLookup[self.curPage]
local cfg=self.pageConfig[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args={}
args.parentWin='UIXM_ZZSH_entitySelectWin'
args.page=self.curPage
args.data=self.data
args.isInit=isInit
self:showWindow(win,args)
end
end

function UIXM_ZZSH_entitySelectWin:refreshSearchBtn()
local check=true
local myActorid=playerModel:getActorID()
if not xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSearch)then
check=false
end
if check then
local lv=xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHRefreshResource)
check=lv>0
end
self.searchBtn:setImageExGray(not check)
self.searLock:setActive(not check)
end

function UIXM_ZZSH_entitySelectWin:onSearchBtn()
local myActorid=playerModel:getActorID()
if not xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSearch)then
UIManager.error('仙盟盟主或副盟主才能在周围搜寻异兽和宝地')
return
end
local lv=xianmengModel:GetSkill_Effect(eXMMouLueEffectType.eZZSHRefreshResource)
if lv<=0 then
UIManager.error('研究仙盟谋略“天眼洞悉”方可使用')
return
end
local cur=zhengzhanshanhaiModel:getSearchNum()

local cost=zhengzhanshanhaiController:getZZSHCfg_search(lv,'consume')
local moneyType=cost[1][1]
local need=cost[1][2]
local have=moneyModel.getMoney(moneyType)
local moneyName=moneyModel.getMoneyName(moneyType)
local colorStr=have>=need and"549327"or"FF0000"
local iconStr=iconHelper.getIconName(moneyType)
local costStr=FMT.fmt("<color=#{0}>{1}</color>枚{2}quad-icon={3}-quad",colorStr,need,moneyName,iconStr)
local num_str
if cur>0 then
num_str=tostring(cur)
else
num_str=FMT.fmt('<color=#549327>{0}</color>',cur)
end

local contentStr=FMT.fmt("是否消耗{0}在仙盟据点附近搜寻异兽或宝地？\n（今日剩余搜索次数：{1}）\n<color=#c82c2c>搜寻的异兽、宝地每天23点消失</color>",costStr,num_str)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',

okcallback=function(...)
if _this==nil then return end
if cur<=0 then
UIManager.error('今日搜寻次数已用完')
return
end
if not moneyModel.checkEnoughMoney(moneyType,need)then
local str=FMT.fmt('{0}不足',moneyModel.getMoneyName(moneyType))
UIManager.error(str)
gainControl:showGainWin(moneyType)
return
end
zhengzhanshanhaiController:reqSearch()
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)



local havetime=self:judetime()

local showtime=zhengzhanshanhaiController:getZZSHCfg_search_getdef('showtime')
if havetime<showtime*3600 then
local func=function(...)
local remove=zhengzhanshanhaiController:getZZSHCfg('remove')
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,remove,0,0)
local cur=gameUtilityModel.getServerLongTime()
if cur>t1 then
local w=timeHelper.getWeakDateEx2(cur)
if w==5 then
t1=t1+(24-remove)*3600
else
t1=t1+86400
end
end
local lerp=t1-cur
return lerp
end
local remove=zhengzhanshanhaiController:getZZSHCfg('remove')
local contentStr=FMT.fmt("搜寻出的异兽、宝地每天23点消失，距离23点还有：<color=#c82c2c>{0}</color>，是否继续？")
local showdata1=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',

okcallback=function(...)
comfirmDialog:show()
end,
timefunc=func,
showclosebtn=true,
}
local comfirmDialog1=UIDialogManager.newDialog(showdata1)
comfirmDialog1:show()
else
comfirmDialog:show()
end




end

function UIXM_ZZSH_entitySelectWin:onMaskBlock()
if _this==nil then return end
if self.closeLock then return end
self:onCloseBtn()
end

function UIXM_ZZSH_entitySelectWin:onCloseBtn()
if _this==nil then return end
if self.closeLock then return end
self:playLeaveAnim()
end

function UIXM_ZZSH_entitySelectWin:rec_search()
if UIManager:isActive('UIXM_ZZSH_monsterInfoWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','clearMapView')
UIManager:closeWindow('UIXM_ZZSH_monsterInfoWin')
end
if UIManager:isActive('UIXM_ZZSH_resourceInfoWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','clearMapView')
UIManager:closeWindow('UIXM_ZZSH_resourceInfoWin')
end
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',g_x,g_y,0,false,0,function()
if _this==nil then return end
_this.mapView.g_x=g_x
_this.mapView.g_y=g_y
UIManager:invokeUIMethod('UIXM_ZZSH_monsterSelectWin','refreshView')
UIManager:invokeUIMethod('UIXM_ZZSH_resourceSelectWin','refreshView')
end)
end
end



function UIXM_ZZSH_entitySelectWin:initMoney()
local widget=self.money1Root:getWidgetBase()
local moneyType=self.moneyType
local moneyVal=moneyModel.getMoney(moneyType)
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(1,iconHelper.getIconName(moneyType),false)
widget:SetChildText(2,moneyStr)
widget:SetChildActive(3,true)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onAddClick(moneyType)
end)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:clickMoney(moneyType)
end)
end

function UIXM_ZZSH_entitySelectWin:refreshMoney()
local widget=self.money1Root:getWidgetBase()
local moneyVal=zhengzhanshanhaiModel:getXuKongLing()
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildText(2,moneyStr)
end

function UIXM_ZZSH_entitySelectWin:onAddClick(moneyType)
self:clickMoney(moneyType)
end

function UIXM_ZZSH_entitySelectWin:clickMoney(moneyType)
gainControl:showGainWin(moneyType)
end


function UIXM_ZZSH_entitySelectWin:judetime()
local remove=zhengzhanshanhaiController:getZZSHCfg('remove')
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,remove,0,0)
local cur=gameUtilityModel.getServerLongTime()
if cur>t1 then
local w=timeHelper.getWeakDateEx2(cur)
if w==5 then
t1=t1+(24-remove)*3600
else
t1=t1+86400
end
end
local lerp=t1-cur
return lerp
end


