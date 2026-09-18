







def_class("UITianMoJieHelpRecordWin",UIWindowBase)









function UITianMoJieHelpRecordWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.empty=UIObject.get(self,2)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,3)
self.tips=UIText.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UITianMoJieHelpRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.tips);self.tips=nil;
end















local _this=nil
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)
local _itemCmp={
headBg=0,
head=1,
playerName=2,
serverName=3,
monsterName=4,
timeTx=5,
progressBar=6,
hurtTx=7,
new=8,
}



function UITianMoJieHelpRecordWin:onLoaded(...)
self:bindComponents()
_this=self

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self:addProNotify(34,126,self.on_34_126)

self:initTips()
end


function UITianMoJieHelpRecordWin:__delete()
self:unbindComponents()
_this=nil

tianMoJieModel:resetPlayerAssists()
end




function UITianMoJieHelpRecordWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.afterRefresh=argtable.afterRefresh
self:refreshView()
end


function UITianMoJieHelpRecordWin:onHide()

end




function UITianMoJieHelpRecordWin:onBackground()
self:onCloseBtn()
end


function UITianMoJieHelpRecordWin:onCloseBtn()
if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UITianMoJieHelpRecordWin:onClickActor(actorId)
otherPlayerController:openOtherPlayerInfoWin(actorId)
end

function UITianMoJieHelpRecordWin:refreshView(record)
self.timeline=tianMoJieModel:getSec()
self.datas=tianMoJieModel:getPlayerAssists()
local dataCnt=#self.datas
local empty=dataCnt<=0
self.enhancedscrollscript:initData(dataCnt,104,dataCnt)
self.empty:setActive(empty)

if not empty then
tianMoJieModel:saveRecordTime()
if self.afterRefresh then
self.afterRefresh()
end
end
end

function UITianMoJieHelpRecordWin:initTips()
local num=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"record")
self.tips:setText(FMT.fmt("（最多保存{0}条协助记录）",num))
end

function UITianMoJieHelpRecordWin.on_34_126()
_this:refreshView()
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local data=self.window.datas[dataIndex]
playerController:setHeadIcon(cell,_itemCmp.head,{iconInfo=data.iconInfo})
cell:SetChildButtonClick(_itemCmp.headBg,function()
self.window:onClickActor(data.actorid)
end)
cell:SetChildText(_itemCmp.playerName,data.actorname)
cell:SetChildText(_itemCmp.serverName,loginModel:getServerName(data.serverid))
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,data.tmid)
local monsterGroup=cfgHelper.get1(cfg_monstergroup_get,monsterCfg.monster)
cell:SetChildText(_itemCmp.monsterName,monsterGroup.name)
local timeStr=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(data.sec))
cell:SetChildText(_itemCmp.timeTx,timeStr)
cell:SetChildProgressValue(_itemCmp.progressBar,data.percent,10000)
cell:SetChildProgressText(_itemCmp.progressBar,FMT.fmt("{0}%",data.percent/100))
local hurtValue=math.floor(monsterCfg.hp*(data.percent/10000))
cell:SetChildText(_itemCmp.hurtTx,FMT.fmt("伤害：{0}",mathHelper.formatNumber3(hurtValue)))
local new=self.window.timeline<data.sec
cell:SetChildActive(_itemCmp.new,new)
end