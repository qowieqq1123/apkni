







def_class("UIXianGongInfluenceMainWin",UIWindowBase)









function UIXianGongInfluenceMainWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.content=UIObject.get(self,1)
self.descTx=UIText.get(self,2)
self.leftArrow=UIButton.get(self,3)
self.menuList=UIObject.get(self,4)
self.nameImg=UIImage.get(self,5)
self.rightArrow=UIButton.get(self,6)
self.scrollView=UILoopListView.new(self,7)
self.swButton=UIButton.get(self,8)
self.swEmotImg=UIImage.get(self,9)
self.swNameImg=UIImage.get(self,10)
self.swProgress=UIProgress.get(self,11)
self.swReddot=UIObject.get(self,12)
self.titleBgImg=UIImage.get(self,13)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.swButton:setButtonClick(function()self:onSwButton()end)



end


function UIXianGongInfluenceMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
_UIObject_release(self.swButton);self.swButton=nil;
_UIObject_release(self.swEmotImg);self.swEmotImg=nil;
_UIObject_release(self.swNameImg);self.swNameImg=nil;
_UIObject_release(self.swProgress);self.swProgress=nil;
_UIObject_release(self.swReddot);self.swReddot=nil;
_UIObject_release(self.titleBgImg);self.titleBgImg=nil;
end















local _this=nil
local _ab='ui/windows/xiangong/xiangongshili_atlas_pak.ab'
local _menuItemCmp={
bg=0,
select=1,
name=2,
reddot=3,
}
local _npcItemCmp={
rawImage=0,
name=1,
bg=2,
relationLvTx=3,
relationValueTx=4,
message=5,
event=6,
lock=7,
visit=8,
relationLvBg=9,
}
local _npcItemName="npcItem"
local _npcItemWidth=207
local _npcViewWidth=1046



function UIXianGongInfluenceMainWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianGongNPCRelationChange,self.onXianGongNPCRelationChange)
self:addNotify(notifyConfig.onTaskChange,self.onTaskChange)
self:addNotify(notifyConfig.onTaskCondition,self.onTaskCondition)
self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.onXianJieFactionReddotChange,self.onXianJieFactionReddotChange)
self:addNotify(notifyConfig.onXianGongNPCDailyFreeChange,self.onXianGongNPCDailyFreeChange)
self:addProNotify(37,111,self.on_37_111)
self:addProNotify(37,105,self.on_37_105)
self:addProNotify(37,107,self.on_37_107)
self:addProNotify(37,108,self.on_37_108)
self:addProNotify(37,109,self.on_37_109)
self.openedWins={}
UIFullXJForceControl:hideWindow("UIXianJieForceWin")
end


function UIXianGongInfluenceMainWin:__delete()
self:unbindComponents()
_this=nil
if UIManager:findActiveWindow("UIXianJieForceWin")then
UIFullXJForceControl:showWindow("UIXianJieForceWin",{Forceid=self.enterId})
end
end




function UIXianGongInfluenceMainWin:onShow(argtable,afterOnloaded)
if argtable then
self.parentWin=argtable.parentWin
self.callback=argtable.callback
self.enterId=argtable.select
self:updateMenuData(argtable.select)
self:refreshMenuList()
self:refreshFactionPanel()
if argtable.clickNpc then
self:onClickNPC(argtable.clickNpc,argtable.weakGuide)
end
if argtable.clickReputation then
self:openSwPanel(argtable.clickReputation)
end
end
end


function UIXianGongInfluenceMainWin:onHide()

end




function UIXianGongInfluenceMainWin:onCloseBtn()
for id,_ in pairs(self.openedWins)do
local winName=UIFullXJForceControl:getForceMainWinName(id)
if id==self.enterId then
if id==self.factionCfg.id then
UIManager:invokeUIMethod(winName,"showRoot",true)
else
UIFullXJForceControl:showWindow(winName)
end
else
UIFullXJForceControl:closeWindow(winName)
end
end

if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXianGongInfluenceMainWin:onLeftArrow()
local pos=self.content:getChildAnchoredPosition()
local index=math.ceil(-pox.x/_npcItemWidth)
if index>1 then
self.scrollView:jumpItem(index-1)
end
end


function UIXianGongInfluenceMainWin:onRightArrow()
local pos=self.content:getChildAnchoredPosition()
local index=math.ceil((-pox.x+_npcViewWidth)/_npcItemWidth)
if index<#self.menuDatas then
self.scrollView:jumpItem(index+1)
end
end

function UIXianGongInfluenceMainWin:onScrollValueChanged()
self:refreshArrow()
end

function UIXianGongInfluenceMainWin:onSwButton()





self:openSwPanel()

end

function UIXianGongInfluenceMainWin:openSwPanel(level)
local args={
faction=self.factionCfg.id,
level=level,
parentWin=self,
}
self:showWindow("UIXianGongInfluenceReputationWin",args)
end

function UIXianGongInfluenceMainWin:onStartAction()
end

function UIXianGongInfluenceMainWin:onFreshAction(index,widget)
self:refreshNPCItem(index,widget)
end

function UIXianGongInfluenceMainWin:updateMenuData(select)
local config=cfg_xianjieforceconfig()
self.menuDatas={}
for id,cfg in pairs(config)do
if xianjieModel:judeForceisOpen(id)then
table.insert(self.menuDatas,id)
end
end
table.sort(self.menuDatas,function(a,b)
return config[a].explore_paixu<config[b].explore_paixu
end)

local temp=select and table.findValue(self.menuDatas,select)or nil
self.menuSelect=temp or self.menuSelect or 1
self.factionCfg=cfgHelper.get1(cfg_xianjieforceconfig_get,self.menuDatas[self.menuSelect])
self.openedWins[self.factionCfg.id]=true

local winName=UIFullXJForceControl:getForceMainWinName(self.factionCfg.id)
if UIManager:isActive(winName)then
UIManager:invokeUIMethod(winName,"showRoot",false)
else
UIFullXJForceControl:showWindow(winName,{onlyBg=true})
end
end

function UIXianGongInfluenceMainWin:refreshMenuList()
self.menuList:setChildLayoutGroupCreateItems(#self.menuDatas,function(index)
local item=self.menuList:getChildLayoutGroupGridItem(index-1)
local id=self.menuDatas[index]
local cfg=cfgHelper.get1(cfg_xianjieforceconfig_get,id)
local reddot=xjFactionNPCModel:getFactionReddot(id)
item:SetChildButtonClick(_menuItemCmp.bg,function()
self:onClickMenu(index)
end)
item:SetChildActive(_menuItemCmp.select,self.menuSelect==index)
item:SetChildText(_menuItemCmp.name,cfg.name)
item:SetChildActive(_menuItemCmp.reddot,reddot)
end)
end

function UIXianGongInfluenceMainWin:refreshMenuReddot(index)
local item=self.menuList:getChildLayoutGroupGridItem(index-1)
local id=self.menuDatas[index]
local reddot=xjFactionNPCModel:getFactionReddot(id)
item:SetChildActive(_menuItemCmp.reddot,reddot)
end

function UIXianGongInfluenceMainWin:refreshAllMenuReddot()
self.menuList:setChildLayoutGroupCreateItems(#self.menuDatas,function(index)
local item=self.menuList:getChildLayoutGroupGridItem(index-1)
local id=self.menuDatas[index]
local reddot=xjFactionNPCModel:getFactionReddot(id)
item:SetChildActive(_menuItemCmp.reddot,reddot)
end)
end

function UIXianGongInfluenceMainWin:onClickMenu(index)
if self.menuSelect~=index then
if self.menuSelect then
local item=self.menuList:getChildLayoutGroupGridItem(self.menuSelect-1)
item:SetChildActive(_menuItemCmp.select,false)

local winName=UIFullXJForceControl:getForceMainWinName(self.factionCfg.id)
UIFullXJForceControl:hideWindow(winName)
end

self.menuSelect=index
self.factionCfg=cfgHelper.get1(cfg_xianjieforceconfig_get,self.menuDatas[self.menuSelect])
self.openedWins[self.factionCfg.id]=true

local item=self.menuList:getChildLayoutGroupGridItem(self.menuSelect-1)
item:SetChildActive(_menuItemCmp.select,true)

self:refreshFactionPanel()

local winName=UIFullXJForceControl:getForceMainWinName(self.factionCfg.id)
UIFullXJForceControl:showWindow(winName,{onlyBg=true})
end
end

function UIXianGongInfluenceMainWin:refreshFactionPanel()

self.titleBgImg:setSprite(_ab,self.factionCfg.factionTitleBgImg)
self.nameImg:setSprite(_ab,self.factionCfg.nameImg)
self.descTx:setText(self.factionCfg.shiLiDesc)

self:refreshFactionReputation(true)

self:refreshNPCList()
end

function UIXianGongInfluenceMainWin:refreshFactionReputation(all)
local total,level,stepCur,stepMax=xjFactionNPCModel:getReputationValue(self.factionCfg.id)

if stepCur<stepMax then
self.swProgress:setProgressValue(stepCur,stepMax)
else
self.swProgress:setProgressValue(10000,10000)
end
if all then
local reddot=xjFactionNPCModel:getReputationReddot(self.factionCfg.id)
local cfg=cfgHelper.get1(cfg_xianjiefeellevelconfig_get,level)
self.swEmotImg:setSprite(_ab,cfg.emotImage)
self.swNameImg:setSprite(_ab,cfg.nameImage)
self.swReddot:setActive(reddot)
end
end

function UIXianGongInfluenceMainWin:refreshNPCList()
local createList={}
for i,v in ipairs(self.factionCfg.npc_list)do
table.insert(createList,i)
end
self.scrollView:initData(_npcItemName,createList)
self.scrollView:jumpItem(1)
self:refreshArrow()

if self.contentTween and self.contentTween:IsActive()then
self.contentTween:Kill()
self.contentTween=nil
end
self.content:setChildCanvasGroupAlpha(0)
self.contentTween=self.content:setChildCanvasGroupDOFade(1,0.5)
end

function UIXianGongInfluenceMainWin:refreshNPCItem(index,widget)
local npcID=self.factionCfg.npc_list[index]
local npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,npcID)
local imageCfg=cfgHelper.get1(cfg_npcimageconfig_get,npcCfg.image)
local rTotal,rLv,rExp,rMax=xjFactionNPCModel:getNPCRelation(npcID)
local messages=xjFactionNPCModel:getNPCMessages(npcID)
local haveGift=xjFactionNPCModel:haveNPCGift(npcID)
local over=xjFactionNPCModel:haveNPCOverGift(npcID)
local lock=xjFactionNPCModel:isNPCLock(npcID)
local taskData=xjFactionNPCModel:getNPCTaskData(npcID)
local visit=xjFactionNPCModel:hasNPCEnoughVisitItem(npcID)
local lvCfg=cfgHelper.get1(cfg_xianjieshilijiaohufeellevelconfig_get,rLv)
comHelper.setChildModelRawImage_npc(widget,imageCfg.id,_npcItemCmp.rawImage,eAnimationID.stand,eHeadCenterType.eHalf,nil,nil)
widget:SetChildGraphicGray(_npcItemCmp.rawImage,lock)
widget:SetChildText(_npcItemCmp.name,imageCfg.name)
widget:SetChildButtonClick(_npcItemCmp.bg,function()
self:onClickNPC(index)
end)
widget:SetChildText(_npcItemCmp.relationLvTx,lvCfg.name)
widget:SetChildText(_npcItemCmp.relationValueTx,rExp==rMax and"已满"or tostring(rExp))
widget:SetChildActive(_npcItemCmp.message,not lock and#messages>0)
widget:SetChildActive(_npcItemCmp.event,not lock and(taskData~=nil or over or haveGift))
widget:SetChildActive(_npcItemCmp.lock,lock)
widget:SetChildActive(_npcItemCmp.visit,lock and visit)
widget:SetChildActive(_npcItemCmp.relationLvBg,not lock)
end

function UIXianGongInfluenceMainWin:onClickNPC(index,weakGuide)
local npcID=self.factionCfg.npc_list[index]
local lock=xjFactionNPCModel:isNPCLock(npcID)
local visit=xjFactionNPCModel:hasNPCEnoughVisitItem(npcID)
if not lock or visit then
local args={
parentWin=UIFullXJForceControl,
npc=npcID,
weakGuide=weakGuide,
onClose=function()
UIFullXJForceControl:showWindow("UIXianGongInfluenceMainWin")
end
}
UIFullXJForceControl:showWindow("UIXianGongInfluenceNPCInteractWin",args)
UIFullXJForceControl:hideWindow(self.__name)
else
UIManager.info("无人引荐，贸然造访恐有不适")
end
end

function UIXianGongInfluenceMainWin:refreshArrow()
local pos=self.content:getChildAnchoredPosition()
local width=self.content:getChildSizeDeltaX()
if#self.factionCfg.npc_list>6 then
self.leftArrow:setActive(pos.x<-_npcItemWidth)
self.rightArrow:setActive(pos.x>-width+_npcItemWidth)
else
self.leftArrow:setActive(false)
self.rightArrow:setActive(false)
end
end

function UIXianGongInfluenceMainWin.onXianGongNPCRelationChange(npcId,npcLvChange,reputationLvChange)
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
local index=table.findValue(_this.menuDatas,faction)

if _this.menuSelect==index then
local npcIdx=table.findValue(_this.factionCfg.npc_list,npcId)
if npcIdx then
local widget=_this.scrollView:getListViewItemWidgetByDataIndex(npcIdx)
if widget then
local rTotal,rLv,rExp,rMax=xjFactionNPCModel:getNPCRelation(npcId)
local lvCfg=cfgHelper.get1(cfg_xianjieshilijiaohufeellevelconfig_get,rLv)
widget:SetChildText(_npcItemCmp.relationLvTx,lvCfg.name)
widget:SetChildText(_npcItemCmp.relationValueTx,rExp==rMax and"已满"or tostring(rExp))

if npcLvChange then
local messages=xjFactionNPCModel:getNPCMessages(npcId)
local haveGift=xjFactionNPCModel:haveNPCGift(npcId)
local over=xjFactionNPCModel:haveNPCOverGift(npcId)
local lock=xjFactionNPCModel:isNPCLock(npcId)
local taskData=xjFactionNPCModel:getNPCTaskData(npcId)
local visit=xjFactionNPCModel:hasNPCEnoughVisitItem(npcId)
widget:SetChildActive(_npcItemCmp.message,not lock and#messages>0)
widget:SetChildActive(_npcItemCmp.event,not lock and(taskData~=nil or over or haveGift))
widget:SetChildActive(_npcItemCmp.visit,lock and visit)
end
end
end

_this:refreshFactionReputation(reputationLvChange)
end
end

function UIXianGongInfluenceMainWin.onXianGongNPCDailyFreeChange(npcId,faction)

end

function UIXianGongInfluenceMainWin.onTaskCondition(taskid)
local npcId=xjFactionNPCModel:findNPCByTask(taskid)
if npcId then
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
local index=table.findValue(_this.menuDatas,faction)
if _this.menuSelect==index then
local npcIdx=table.findValue(_this.factionCfg.npc_list,npcId)
if npcIdx then
local widget=_this.scrollView:getListViewItemWidgetByDataIndex(npcIdx)
if widget then
local haveGift=xjFactionNPCModel:haveNPCGift(npcId)
local over=xjFactionNPCModel:haveNPCOverGift(npcId)
local lock=xjFactionNPCModel:isNPCLock(npcId)
local taskData=xjFactionNPCModel:getNPCTaskData(npcId)
widget:SetChildActive(_npcItemCmp.event,not lock and(taskData~=nil or over or haveGift))
end
end
end
_this:refreshAllMenuReddot()
end
end

function UIXianGongInfluenceMainWin.onTaskChange(taskid,taskstate)
if taskstate==taskModel.taskDoingState or taskstate==taskModel.taskRewardState then return end

local npcId=xjFactionNPCModel:findNPCByTask(taskid)
if npcId then
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
local index=table.findValue(_this.menuDatas,faction)
if _this.menuSelect==index then
local npcIdx=table.findValue(_this.factionCfg.npc_list,npcId)
if npcIdx then
local widget=_this.scrollView:getListViewItemWidgetByDataIndex(npcIdx)
if widget then
local haveGift=xjFactionNPCModel:haveNPCGift(npcId)
local over=xjFactionNPCModel:haveNPCOverGift(npcId)
local lock=xjFactionNPCModel:isNPCLock(npcId)
local taskData=xjFactionNPCModel:getNPCTaskData(npcId)
widget:SetChildActive(_npcItemCmp.event,not lock and(taskData~=nil or over or haveGift))
end
end
end
_this:refreshAllMenuReddot()
end
end

function UIXianGongInfluenceMainWin.on_item_list_changed(array,guidLookup,idLookup)
local unlocks={}
for itemId,_ in pairs(idLookup)do
local npcs=xjFactionNPCModel:findNPCByUnlockItemId(itemId)
if npcs then
for idx,npcId in ipairs(npcs)do
unlocks[npcId]=true
end
end
end
for index,npcId in pairs(_this.factionCfg.npc_list)do
local widget=_this.scrollView:getListViewItemWidgetByDataIndex(index)
if widget then
local lock=xjFactionNPCModel:isNPCLock(npcId)
local visit=xjFactionNPCModel:hasNPCEnoughVisitItem(npcId)
widget:SetChildActive(_npcItemCmp.visit,lock and visit)
end
end
end

function UIXianGongInfluenceMainWin.onXianJieFactionReddotChange(factionList)
for idx,faction in ipairs(factionList)do
local index=table.findValue(_this.menuDatas,faction)
if index then
_this:refreshMenuReddot(index)
end
end
end

function UIXianGongInfluenceMainWin.on_37_111(args)
_this:refreshMenuList()
_this:refreshFactionPanel()
end

function UIXianGongInfluenceMainWin.on_37_105(result,npcId)
if result~=0 then return end
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
local index=table.findValue(_this.menuDatas,faction)

if _this.menuSelect==index then
local npcIdx=table.findValue(_this.factionCfg.npc_list,npcId)
if npcIdx then
local widget=_this.scrollView:getListViewItemWidgetByDataIndex(npcIdx)
if widget then
local messages=xjFactionNPCModel:getNPCMessages(npcId)
local over=xjFactionNPCModel:haveNPCOverGift(npcId)
local haveGift=xjFactionNPCModel:haveNPCGift(npcId)
local lock=xjFactionNPCModel:isNPCLock(npcId)
local taskData=xjFactionNPCModel:getNPCTaskData(npcId)
local visit=xjFactionNPCModel:hasNPCEnoughVisitItem(npcId)
widget:SetChildGraphicGray(_npcItemCmp.rawImage,lock)
widget:SetChildActive(_npcItemCmp.message,not lock and#messages>0)
widget:SetChildActive(_npcItemCmp.event,not lock and(taskData~=nil or over or haveGift))
widget:SetChildActive(_npcItemCmp.lock,lock)
widget:SetChildActive(_npcItemCmp.visit,lock and visit)
widget:SetChildActive(_npcItemCmp.relationLvBg,not lock)
end
end
end
end

function UIXianGongInfluenceMainWin.on_37_107(result,npcId)
if result~=0 then return end
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
local index=table.findValue(_this.menuDatas,faction)

if _this.menuSelect==index then
local npcIdx=table.findValue(_this.factionCfg.npc_list,npcId)
if npcIdx then
local widget=_this.scrollView:getListViewItemWidgetByDataIndex(npcIdx)
if widget then
local over=xjFactionNPCModel:haveNPCOverGift(npcId)
local haveGift=xjFactionNPCModel:haveNPCGift(npcId)
local lock=xjFactionNPCModel:isNPCLock(npcId)
local taskData=xjFactionNPCModel:getNPCTaskData(npcId)
widget:SetChildActive(_npcItemCmp.event,not lock and(taskData~=nil or over or haveGift))
end
end
end
end

function UIXianGongInfluenceMainWin.on_37_108(result,message)
if result~=0 then return end
local npcList=xjFactionNPCModel:findNPCListByMessage(message)
local refreshList={}
if npcList then
for _,npcId in ipairs(npcList)do
local faction=xjFactionNPCModel:findFactionByNpc(npcId)
local index=table.findValue(_this.menuDatas,faction)
if _this.menuSelect==index then
local npcIdx=table.findValue(_this.factionCfg.npc_list,npcId)
if npcIdx then
table.insert(refreshList,npcIdx)
end
end
end
end

for i,v in ipairs(refreshList)do
local widget=_this.scrollView:getListViewItemWidgetByDataIndex(v)
if widget then
local npcId=_this.factionCfg.npc_list[v]
local messages=xjFactionNPCModel:getNPCMessages(npcId)
local lock=xjFactionNPCModel:isNPCLock(npcId)
widget:SetChildActive(_npcItemCmp.message,not lock and#messages>0)
end
end
end

function UIXianGongInfluenceMainWin.on_37_109(result,faction)
if result~=0 then return end
if faction==_this.factionCfg.id then
local reddot=xjFactionNPCModel:getReputationReddot(faction)
_this.swReddot:setActive(reddot)
end
end