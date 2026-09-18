







def_class("UIActivityCalendarWin",UIWindowBase)









function UIActivityCalendarWin:bindComponents()

self.fbg=UIObject.get(self,0)
self.dateScrollView=UIObject.get(self,1)
self.dateContent=UIObject.get(self,2)
self.datecreater=UIObject.get(self,3)
self.activtyScrollView=UIObject.get(self,4)
self.activtyContent=UIObject.get(self,5)
self.rightBtn=UIButton.get(self,6)
self.leftBtn=UIButton.get(self,7)
self.empty=UIObject.get(self,8)
self.tipsbtn=UIButton.get(self,9)
self.pageChangeBtn=UIButton.get(self,10)
self.openDaytip=UIObject.get(self,11)
self.openDay=UIText.get(self,12)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.pageChangeBtn:setButtonClick(function()self:onPageChangeBtn()end)



end


function UIActivityCalendarWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fbg);self.fbg=nil;
_UIObject_release(self.dateScrollView);self.dateScrollView=nil;
_UIObject_release(self.dateContent);self.dateContent=nil;
_UIObject_release(self.datecreater);self.datecreater=nil;
_UIObject_release(self.activtyScrollView);self.activtyScrollView=nil;
_UIObject_release(self.activtyContent);self.activtyContent=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.pageChangeBtn);self.pageChangeBtn=nil;
_UIObject_release(self.openDaytip);self.openDaytip=nil;
_UIObject_release(self.openDay);self.openDay=nil;
end


















local dateItemCmp={
datecontent=0,
bg=1,
todayFlag=2,
}
local activtyTypeRootCmp={
activtyTypeRoot=0,
activtytitlebg=1,
activtytitle=2,
activtytypeItem=3,
titleRoot=4,
}

local activtytypeItemCmp={
activtytypeItem=0,
proImage=1,
inforoot=2,
icon=3,
name=4,
date=5,
bgCreater=6,
click=7,
shenlue=8,
n_select=9,
normal=10,
gary=11,
g_select=12,
newBie=13,
}

local bgItemCmp={
todayFlag=0,
}

local datelen
local limitCount
local todayshowIndex
local dateWidth=113
local daySc=24*60*60
local leftoffest=2
local contentWidth
local pageCount=8

function UIActivityCalendarWin:onLoaded(...)
self:bindComponents()
datelen=welfareModel:getCalendarLen()
todayshowIndex=welfareModel:getTodayPos()
limitCount=welfareModel:getLimitCount()
local sc=UIManager.defaultCanvas_trans.localScale
self.screenWidth=UnityEngine.Screen.width/sc.x>1624 and 1624 or UnityEngine.Screen.width/sc.x
self.screenhight=UnityEngine.Screen.height/sc.y>750 and 750 or UnityEngine.Screen.height/sc.y
self.viewWidth=1020
self.viewhight=545
self.viewCount=9
self.nextPageFirstIndex=10
self.nextPageFirstPosX=(self.nextPageFirstIndex-1)*dateWidth
contentWidth=dateWidth*datelen+3.5

self.activtyScrollViewPos=self.activtyScrollView:getChildAnchoredPosition()
welfareModel:setActivityCalendarReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
end


function UIActivityCalendarWin:__delete()
self:unbindComponents()
end




function UIActivityCalendarWin:onShow(argtable,afterOnloaded)

if argtable then
self.newBiw=argtable.newbie==1
end
self.curPage=true
self:createDateList()
self:refreshDateList()
self:createActivtyContent()
self:refreshActivtyContent()
self:refreshBtn()
local openday=timeHelper.getServerOpenDay()
self.openDaytip:setActive(openday>0)
self.openDay:setText(string.format("本服已开启：%s天",openday))
end


function UIActivityCalendarWin:onHide()

end
function UIActivityCalendarWin:onShowArgRecv(argtable)

if argtable then
self.newBiw=argtable.newbie==1
end
if self.newBiw then

self:checkNewBiwPos()
return
end
self.activtyContent:setChildAnchoredPos(0,0)
end

function UIActivityCalendarWin:createDateList()
self.datecreater:setChildLayoutGroupClearAllItems()
self.datecreater:setChildLayoutGroupCreateItems(datelen)
self.dategrids=self.datecreater:getChildLayoutGroupGridList()
end

function UIActivityCalendarWin:refreshDateList()

local startshowTime=welfareModel:getCalendarInfo()
for i=1,datelen do
local dateitem=self.dategrids[i-1]
local serverStamp=startshowTime+daySc*(i-1)
local timeInfo=timeHelper.dateServerStampData(serverStamp)
local weekIdx=timeHelper.getWeakDateEx3(serverStamp)
local weekStr=''
if weekIdx==7 then
weekStr='日'
else
weekStr=mathHelper.numberToChinese(weekIdx)
end
if i==todayshowIndex then
dateitem:SetChildActive(dateItemCmp.todayFlag,true)
dateitem:SetChildText(dateItemCmp.datecontent,FMT.fmt("<color=#ca631d>{0}月{1}日\n 星期{2}</color> ",timeInfo.month,timeInfo.day,weekStr))
if pfwindowslController:checkIsGameVersion_yuenan()then
weekStr=timeHelper.format_week_chinese(weekIdx%7)
dateitem:SetChildText(dateItemCmp.datecontent,FMT.fmt("<color=#ca631d>Ngày {1} tháng {0}\n{2}</color>",timeInfo.month,timeInfo.day,weekStr))
end
else
dateitem:SetChildText(dateItemCmp.datecontent,FMT.fmt("{0}月{1}日\n 星期{2} ",timeInfo.month,timeInfo.day,weekStr))
if pfwindowslController:checkIsGameVersion_yuenan()then
weekStr=timeHelper.format_week_chinese(weekIdx%7)
dateitem:SetChildText(dateItemCmp.datecontent,FMT.fmt("Ngày {1} tháng {0}\n {2}",timeInfo.month,timeInfo.day,weekStr))
end
end
end
end

function UIActivityCalendarWin:createActivtyContent()
self.activtyContent:setChildLayoutGroupClearAllItems()
local activtyTypeContent=self:getActivtyContentCfg()
local activtyTypeCount=#activtyTypeContent
if activtyTypeCount<=0 then
self.empty:setActive(true)
else
self.empty:setActive(false)
end
self.activtyContent:setChildLayoutGroupCreateItems(activtyTypeCount)
local y=self.activtyContent:getChildSizeDeltaY()
self.activtyContent:setChildSizeDelta(contentWidth,y)
self.contentGrids=self.activtyContent:getChildLayoutGroupGridList()
self.subgrids={}
local count=0
for i=1,activtyTypeCount do
local item=self.contentGrids[i-1]
local typeContent=activtyTypeContent[i].actList
local typeCount=#typeContent
count=count+typeCount
local lenhight=activtyTypeCount*40+count*69
if i==activtyTypeCount and lenhight<545 then
typeCount=typeCount+math.ceil((545-lenhight)/69)
end
item:SetChildLayoutGroupCreateItems(activtyTypeRootCmp.activtyTypeRoot,typeCount)
local subgrids=item:GetChildLayoutGroupGridList(activtyTypeRootCmp.activtyTypeRoot)
self.subgrids[i]=subgrids
for ii=1,typeCount do
local subitem=subgrids[ii-1]
subitem:SetChildLayoutGroupCreateItems(activtytypeItemCmp.bgCreater,datelen,function(index)
if index==todayshowIndex then
local bgitem=subitem:GetChildLayoutGroupGridItem(activtytypeItemCmp.bgCreater,index-1)
bgitem:SetChildActive(bgItemCmp.todayFlag,true)
end
end)
end
end
end

function UIActivityCalendarWin:refreshActivtyContent()
local activtyTypeContent=self:getActivtyContentCfg()
local activtyTypeCount=#activtyTypeContent
local viewWidth=self.viewWidth
self.changePosItemList={}
self.changePosTitleList={}
local count=0
local subCount=0
self.newBiwPos={}
for i=1,activtyTypeCount do
local item=self.contentGrids[i-1]
local typeCfg=activtyTypeContent[i]
item:SetChildText(activtyTypeRootCmp.activtytitle,typeCfg.typeName)
local tltieTemp={}
tltieTemp.item=item
self.changePosTitleList[#self.changePosTitleList+1]=tltieTemp

local typeContent=activtyTypeContent[i].actList
local typeCount=#typeContent
count=count+typeCount
local lenhight=activtyTypeCount*40+count*69
if i==activtyTypeCount and lenhight<545 then
typeCount=typeCount+math.ceil((545-lenhight)/69)
self.activtyScrollView:setChildScrollRectEnable(false)
end
for ii=1,typeCount do
subCount=subCount+1
local subitem=self.subgrids[i][ii-1]
local subtempCfg=typeContent[ii]
if subtempCfg then





local timeInfo=subtempCfg.timeInfo
local posindex=timeInfo.posIndex
local len=timeInfo.actLen

subitem:SetChildAnchoredPos(activtytypeItemCmp.proImage,(posindex-1)*dateWidth,0)
subitem:SetChildAnchoredPos(activtytypeItemCmp.inforoot,(posindex-1)*dateWidth,0)


subitem:SetChildCSImageSprite(activtytypeItemCmp.icon,subtempCfg.iconCfg[1],subtempCfg.iconCfg[2])
local isDoing=self:checkActivtyDoing(subtempCfg)
subitem:SetChildActive(activtytypeItemCmp.gary,not isDoing)
subitem:SetChildGray(activtytypeItemCmp.icon,not isDoing)


local startTimeInfo=timeInfo.startTimeInfo
local endTimeInfo=timeInfo.endTimeInfo
local isSamemmonth=startTimeInfo.month==endTimeInfo.month
local str
if isSamemmonth then
str=FMT.fmt("{0}月{1}日~{2}日",startTimeInfo.month,startTimeInfo.day,endTimeInfo.day)
else
str=FMT.fmt("{0}月{1}日~{2}月{3}日",startTimeInfo.month,startTimeInfo.day,endTimeInfo.month,endTimeInfo.day)
end
subitem:SetChildText(activtytypeItemCmp.name,isDoing and subtempCfg.name or FMT.fmt("<color=#45403e>{0}</color> ",subtempCfg.name))

subitem:SetChildText(activtytypeItemCmp.date,isDoing and str or FMT.fmt("<color=#45403e>{0}</color> ",str))
subitem:SetChildSizeDelta(activtytypeItemCmp.proImage,len*dateWidth,0)

subitem:SetChildButtonClick(activtytypeItemCmp.click,function()
self:onClick(i,ii,subtempCfg,subitem)
end)
subitem:SetChildButtonClick(activtytypeItemCmp.newBie,function()
self:onClick(i,ii,subtempCfg,subitem)
end)
local toNextPagelen=self.nextPageFirstIndex-posindex
local curpageShenlueFlag=toNextPagelen==1

if curpageShenlueFlag or posindex==datelen then
subitem:SetChildActive(activtytypeItemCmp.shenlue,true)
subitem:SetChildAnchoredPos(activtytypeItemCmp.shenlue,(posindex-1)*dateWidth,0)
subitem:SetChildActive(activtytypeItemCmp.inforoot,false)
end

if posindex<self.nextPageFirstIndex then

local nextPagelen=len-toNextPagelen

if len>toNextPagelen then
local temp={}
temp.item=subitem
temp.pos={x=(posindex-1)*dateWidth,y=0}
temp.len={old=len*dateWidth,new=nextPagelen*dateWidth}
temp.curpageShenlueFlag=curpageShenlueFlag
if nextPagelen>limitCount then
temp.isActive=true

else

temp.isActive=false
local nextshenluePos=(len+posindex-2)*dateWidth
if curpageShenlueFlag then
temp.nextshenluePos=nextshenluePos
else
subitem:SetChildActive(activtytypeItemCmp.shenlue,true)
subitem:SetChildAnchoredPos(activtytypeItemCmp.shenlue,nextshenluePos,0)
end
end
self.changePosItemList[#self.changePosItemList+1]=temp
end
end
if isDoing and not self.newBiwPos.doingItem then
self.newBiwPos.doingItem=subitem
self.newBiwPos.d_posY=i*40+(subCount-1)*69
self.newBiwPos.d_nextFlag=posindex>=self.nextPageFirstIndex
subitem:SetChildNewBieComponentId(activtytypeItemCmp.newBie,"UIActivityCalendarWin.newBieItem")
end
if not isDoing and not self.newBiwPos.not_doingItem then
self.newBiwPos.not_doingItem=subitem
self.newBiwPos.nd_posY=i*40+(subCount-1)*69
self.newBiwPos.nd_nextFlag=posindex>=self.nextPageFirstIndex
end
else
subitem:SetChildActive(activtytypeItemCmp.proImage,false)
subitem:SetChildActive(activtytypeItemCmp.inforoot,false)
end
end
end

if not self.newBiwPos.doingItem and self.newBiwPos.not_doingItem then
self.newBiwPos.not_doingItem:SetChildNewBieComponentId(activtytypeItemCmp.newBie,"UIActivityCalendarWin.newBieItem")
end
self:checkNewBiwPos()
end

function UIActivityCalendarWin:checkNewBiwPos()
if not self.newBiw then
return
end
self.newBiw=nil
local nextFlag,posY
if self.newBiwPos.doingItem then
nextFlag=self.newBiwPos.d_nextFlag
posY=self.newBiwPos.d_posY
elseif self.newBiwPos.not_doingItem then
nextFlag=self.newBiwPos.nd_nextFlag
posY=self.newBiwPos.nd_posY
end
if nextFlag and self.curPage then
self:onRightBtn()
end
if posY then
local movex=contentWidth-self.viewWidth
self.activtyContent:setChildAnchoredPos(self.curPage and 0 or-movex,posY)
end
end

function UIActivityCalendarWin:refreshBtn()
self.rightBtn:setActive(self.curPage)
self.leftBtn:setActive(not self.curPage)
end

function UIActivityCalendarWin:onRightBtn()
self.curPage=false
self:refreshBtn()
self:moveContent()
end

function UIActivityCalendarWin:onLeftBtn()
self.curPage=true
self:refreshBtn()
self:moveContent()
end

function UIActivityCalendarWin:onPageChangeBtn()
UIManager:closeWindow('UIActivityDetailWin')
self:cancelSelect()
if self.curPage then
self:onRightBtn()
else
self:onLeftBtn()
end
end


function UIActivityCalendarWin:onTipsbtn()
local d={}
d.title='日历说明'
d.mode=3
d.name='actCalendar_Tips_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UIActivityCalendarWin:moveContent()
local movex=contentWidth-self.viewWidth
self.dateContent:setChildAnchoredPos(self.curPage and 0 or-movex,-70)
local nowPos=self.activtyContent:getChildAnchoredPosition()
self.activtyContent:setChildAnchoredPos(self.curPage and 0 or-movex,nowPos.y)
for i,v in ipairs(self.changePosItemList or{})do
local subitem=v.item
local pos=v.pos
local len=v.len
subitem:SetChildAnchoredPos(activtytypeItemCmp.inforoot,self.curPage and pos.x or self.nextPageFirstPosX,pos.y)
subitem:SetChildAnchoredPos(activtytypeItemCmp.proImage,self.curPage and pos.x or self.nextPageFirstPosX,pos.y)
subitem:SetChildSizeDelta(activtytypeItemCmp.proImage,self.curPage and len.old or len.new,0)
if self.curPage then
subitem:SetChildActive(activtytypeItemCmp.inforoot,not v.curpageShenlueFlag)
else
subitem:SetChildActive(activtytypeItemCmp.inforoot,v.isActive)
end
if v.nextshenluePos then
if self.curPage then
subitem:SetChildAnchoredPos(activtytypeItemCmp.shenlue,pos.x,pos.y)
else
subitem:SetChildAnchoredPos(activtytypeItemCmp.shenlue,v.nextshenluePos,pos.y)
end
end
end
for i,v in ipairs(self.changePosTitleList or{})do
local item=v.item
item:SetChildAnchoredPos(activtyTypeRootCmp.titleRoot,self.curPage and 0 or self.nextPageFirstPosX,0)
end
end





function UIActivityCalendarWin:checkActivtyDoing(data)






return welfareController:checkActivtyDoing(data)

end

function UIActivityCalendarWin:getActivtyContentCfg()











return welfareModel:getShowCalendarCfg()
end

function UIActivityCalendarWin:onClick(type,index,subtempCfg,subitem)
self.lastsubitem=subitem
subitem:SetChildActive(activtytypeItemCmp.n_select,true)
subitem:SetChildActive(activtytypeItemCmp.g_select,true)
local Position=subitem:GetChildPosition(activtytypeItemCmp.inforoot)

local ScreenPoint=CS.CSGUIManager.Instance:WorldToScreenPoint(Position)






local pos=self.activtyScrollViewPos
local args={
data=subtempCfg,
screenPoint=ScreenPoint,
screenWidth=self.screenWidth,
screenhight=self.screenhight,
viewOffest={
top=self.screenhight/2-pos.y-self.viewhight/2,
bottom=self.screenhight/2+pos.y-self.viewhight/2,
left=self.screenWidth/2+pos.x-self.viewWidth/2,
right=self.screenWidth/2-pos.x-self.viewWidth/2,
},
posOffest={
top=22,
bottom=12,
left=0,
right=0,
},
callbackFun=function()
if self.lastsubitem then
self.lastsubitem:SetChildActive(activtytypeItemCmp.n_select,false)
self.lastsubitem:SetChildActive(activtytypeItemCmp.g_select,false)
end
end






}
UIManager:showWindow('UIActivityDetailWin',args)
end

function UIActivityCalendarWin:cancelSelect()
if self.lastsubitem then
self.lastsubitem:SetChildActive(activtytypeItemCmp.n_select,false)
self.lastsubitem:SetChildActive(activtytypeItemCmp.g_select,false)
end
end












