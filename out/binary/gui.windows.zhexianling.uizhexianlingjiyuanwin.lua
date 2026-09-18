







def_class("UIZheXianLingJiYuanWin",UIWindowBase)









function UIZheXianLingJiYuanWin:bindComponents()

self.raycast=UIObject.get(self,0)
self.itemsRoot=UIObject.get(self,1)
self.btnGet=UIButton.get(self,2)
self.btnCost=UIButton.get(self,3)
self.jiYuanNum=UIText.get(self,4)
self.dressToggle=UIToggleButton.get(self,5)
self.item=UIObject.get(self,6)
self.dressToggleText=UIText.get(self,7)
self.spine=UIObject.get(self,8)
self.root=UIObject.get(self,9)

self.btnGet:setButtonClick(function()self:onBtnGet()end)

self.btnCost:setButtonClick(function()self:onBtnCost()end)



end


function UIZheXianLingJiYuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.raycast);self.raycast=nil;
_UIObject_release(self.itemsRoot);self.itemsRoot=nil;
_UIObject_release(self.btnGet);self.btnGet=nil;
_UIObject_release(self.btnCost);self.btnCost=nil;
_UIObject_release(self.jiYuanNum);self.jiYuanNum=nil;
_UIObject_release(self.dressToggle);self.dressToggle=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.dressToggleText);self.dressToggleText=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.root);self.root=nil;
end


















function UIZheXianLingJiYuanWin:onLoaded(...)
self:bindComponents()
self.itemlist={}
local itemlist=self.itemlist
itemlist[#itemlist+1]=self.item1
itemlist[#itemlist+1]=self.item2
itemlist[#itemlist+1]=self.item3
itemlist[#itemlist+1]=self.item4
itemlist[#itemlist+1]=self.item5
itemlist[#itemlist+1]=self.item6
itemlist[#itemlist+1]=self.item7
itemlist[#itemlist+1]=self.item8
itemlist[#itemlist+1]=self.item9
itemlist[#itemlist+1]=self.item10
self.isToggle=userActorSetting.get('skipZXLJiYuan',false)
self.dressToggle:setToggleChange(function(...)self:onToggleChanged(...)end)
self:freshToggle(self.isToggle)
self.dressToggleText:setText('跳过动画')
local itemDatas=zheXianLingModel:getJiYuanItemConfig()
self.itemDatas=itemDatas
self.circle=self.winlua:GetChildList(self.itemsRoot:getID())
self.circle:SetTweenEndTime(1)
end

function UIZheXianLingJiYuanWin:__delete()
self:stopBgAudioSound()
if self.playtimer then
self:stopTimerByID(self.playtimer)
end
self:unbindComponents()
end

function UIZheXianLingJiYuanWin:onShow(argtable,afterOnloaded)
self.winlua:SetChildImageRaycast(self.raycast:getID(),false)
self.jiyuanid=zheXianLingModel:getJiYuanId()
self:freshJiYuan()
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self.winlua:SetChildUIModelShowTarget(self.spine:getID(),3045,1,{},2051,false,false,0)

AudioManager.playAudio(531)
local func=function()
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.3)
end
if self.playtimer then
self:stopTimerByID(self.playtimer)
end
self.playtimer=self:delayDo(1.5,func)

self:stopBgAudioSound()
self.bgAudioHandleId=nil

local fadeTime=0.75
self.bgAudioHandleId=AudioManager.playAudio(537,nil,nil,fadeTime)
end

function UIZheXianLingJiYuanWin:onHide()
self:stopBgAudioSound()
self.circle:StopAutoMove()
self.winlua:SetChildImageRaycast(self.raycast:getID(),false)
if self.playtimer then
self:stopTimerByID(self.playtimer)
end
self.playtimer=nil
end



function UIZheXianLingJiYuanWin:freshJiYuan()
self:initCircle()
self:freshOther()
end

function UIZheXianLingJiYuanWin:freshOther()
local times=zheXianLingModel:getJiYuanTimes()
self.jiYuanNum:setText(FMT.fmt('机缘次数：{0}',times))
end

function UIZheXianLingJiYuanWin:freshItem(i)
if i==nil then return end
local itemData=self.itemDatas[i]
local widget=self.circle:GetItemWidgetByIndex(i)
local itemid=itemData[1]
local num=itemData[2]
local isNotPrize=not zheXianLingModel:isPrizeJiYuan(i)
local grayNum=isNotPrize and 0 or 3
local conf={gray=grayNum,iconColor=0,showname=false,itemid=itemid,showCountBG=num>1,
itemcount=num>1 and num or'',showStage=false,colorEffect=isNotPrize}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
local widget1=widget:GetChildWidgetBase(0)
widget1:SetPropData(propData)
widget1:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end

function UIZheXianLingJiYuanWin:hideEffects()
for i=1,10 do
local widget=self.circle:GetItemWidgetByIndex(i)
widget:SetChildQualityEffect(1,-1)
end
end

function UIZheXianLingJiYuanWin:freshToggle(isToggle)
self.dressToggle:setToggle(isToggle)
end

function UIZheXianLingJiYuanWin:freshNextTitlePanel()
local data=zheXianLingModel:getData()
local book_id=data.book_id
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local nextid=bookCfg.nextid
if nextid then
local desc=zheXianLingModel:getOpenBookCnd(nextid)
self.nextLimit:setText(desc)
self.nextTitle:setText('全新卷章即将开启')
else
self.nextLimit:setText('')
self.nextTitle:setText('所有卷章已完成')
end
end

function UIZheXianLingJiYuanWin:initCircle()
local num=10
self.circle.m_CreateCount=num
self.circle:IntializeEditor()
for i=1,num do
self:freshItem(i)
end
self.circle.IsAutoCircle=true
end

function UIZheXianLingJiYuanWin:playAni()


AudioManager.playAudio(532)

self.circle:ScrollToIndex(self.idx,3,-1,5)
self.winlua:SetChildImageRaycast(self.raycast:getID(),true)
self.isPlay=true
end

function UIZheXianLingJiYuanWin:slowMove()

end




function UIZheXianLingJiYuanWin:onBtnGet()

end



function UIZheXianLingJiYuanWin:onBtnCost()
if zheXianLingModel:hasJiYuanTimes()then
socketManager:send_27_4()
else
UIManager.error('没有机缘次数')
gainControl:showGainWin(eMoneyType.mtJiYuan)
end
end

function UIZheXianLingJiYuanWin:onToggleChanged(name,isToggle,data)
if self.isToggle==isToggle then return end
self.isToggle=isToggle

userActorSetting.flushVal('skipZXLJiYuan',isToggle)
self:freshToggle(isToggle)
end

function UIZheXianLingJiYuanWin:onPirze(idx)
self.idx=idx
if not self.isToggle then
self:playAni()
else
self:playEnd()
end
end

function UIZheXianLingJiYuanWin:playEnd()
self.isPlay=false
if self.idx then
self.circle:JumpToIndex(self.idx)
end
self.winlua:SetChildImageRaycast(self.raycast:getID(),false)
self:freshOther()

zheXianLingController.showJiYuanPrize()
self.itemDatas=zheXianLingModel:getJiYuanItemConfig()
for i=1,10 do
self:freshItem(i)
end
end

function UIZheXianLingJiYuanWin:onPlayStart()
if self.enableCricleTimer then
self:stopTimerByID(self.enableCricleTimer)
end
self.enableCricleTimer=nil
end

function UIZheXianLingJiYuanWin:onPlayEnd()

self:playEnd()
self.circle.IsAutoCircle=true
end

function UIZheXianLingJiYuanWin:onDragStart()
self.isDrag=true
self.circle.IsAutoCircle=false
if self.enableCricleTimer then
self:stopTimerByID(self.enableCricleTimer)
end
self.enableCricleTimer=nil
end

function UIZheXianLingJiYuanWin:onDragEnd()
self.isDrag=false
if self.enableCricleTimer then
self:stopTimerByID(self.enableCricleTimer)
end
self.enableCricleTimer=self:delayDo(5,function()
if not self or self.isClose or self.isDrag then return end
self.circle.IsAutoCircle=true
end)
end

function UIZheXianLingJiYuanWin:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end
