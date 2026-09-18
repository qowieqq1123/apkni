







def_class("UIXM_ZZSH_signWin",UIWindowBase)









function UIXM_ZZSH_signWin:bindComponents()

self.root=UIObject.get(self,0)
self.movePanel=UIObject.get(self,1)
self.infoPanel=UIObject.get(self,2)
self.back2Btn=UIButton.get(self,3)
self.blockBG=UIObject.get(self,4)
self.filterBtn=UIButton.get(self,5)
self.noSign=UIObject.get(self,6)
self.signGridPanel=UIObject.get(self,7)
self.signPageLeftBtn=UIButton.get(self,8)
self.signPageRightBtn=UIButton.get(self,9)
self.signNumTxt=UIText.get(self,10)
self.signPageTxt=UIText.get(self,11)
self.signInfoOne=UIObject.get(self,12)
self.signInfoTwo=UIObject.get(self,13)
self.signSetupBtn=UIButton.get(self,14)
self.signDelBtn=UIButton.get(self,15)
self.signAllBtn=UIButton.get(self,16)
self.signBackBtn=UIButton.get(self,17)
self.money1Root=UIObject.get(self,18)
self.money2Root=UIObject.get(self,19)
self.moveBtn=UIButton.get(self,20)
self.backBtn=UIButton.get(self,21)
self.money2cost=UIObject.get(self,22)
self.money1cost=UIObject.get(self,23)

self.back2Btn:setButtonClick(function()self:onBack2Btn()end)

self.filterBtn:setButtonClick(function()self:onFilterBtn()end)

self.signPageLeftBtn:setButtonClick(function()self:onSignPageLeftBtn()end)

self.signPageRightBtn:setButtonClick(function()self:onSignPageRightBtn()end)

self.signSetupBtn:setButtonClick(function()self:onSignSetupBtn()end)

self.signDelBtn:setButtonClick(function()self:onSignDelBtn()end)

self.signAllBtn:setButtonClick(function()self:onSignAllBtn()end)

self.signBackBtn:setButtonClick(function()self:onSignBackBtn()end)

self.moveBtn:setButtonClick(function()self:onMoveBtn()end)

self.backBtn:setButtonClick(function()self:onBackBtn()end)



end


function UIXM_ZZSH_signWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.movePanel);self.movePanel=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.back2Btn);self.back2Btn=nil;
_UIObject_release(self.blockBG);self.blockBG=nil;
_UIObject_release(self.filterBtn);self.filterBtn=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.signGridPanel);self.signGridPanel=nil;
_UIObject_release(self.signPageLeftBtn);self.signPageLeftBtn=nil;
_UIObject_release(self.signPageRightBtn);self.signPageRightBtn=nil;
_UIObject_release(self.signNumTxt);self.signNumTxt=nil;
_UIObject_release(self.signPageTxt);self.signPageTxt=nil;
_UIObject_release(self.signInfoOne);self.signInfoOne=nil;
_UIObject_release(self.signInfoTwo);self.signInfoTwo=nil;
_UIObject_release(self.signSetupBtn);self.signSetupBtn=nil;
_UIObject_release(self.signDelBtn);self.signDelBtn=nil;
_UIObject_release(self.signAllBtn);self.signAllBtn=nil;
_UIObject_release(self.signBackBtn);self.signBackBtn=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.money2Root);self.money2Root=nil;
_UIObject_release(self.moveBtn);self.moveBtn=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.money2cost);self.money2cost=nil;
_UIObject_release(self.money1cost);self.money1cost=nil;
end
















local _this=nil
local signNumOnPage=5


function UIXM_ZZSH_signWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIXM_ZZSH_signWin:__delete()
_this=nil
self:unbindComponents()
self:clearAllFMTweener()
if UIManager:isActive('UIXM_ZZSH_posInfoWin')then
UIManager:closeWindow('UIXM_ZZSH_posInfoWin')
end
end


function UIXM_ZZSH_signWin:onHide()

end

function UIXM_ZZSH_signWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if _this.pageModel==2 then
_this:refreshMoneyItemEx(moneyType,lastVal)
end
end




function UIXM_ZZSH_signWin:onShow(argtable,afterOnloaded)
self.pageModel=argtable.pageModel or 1
self.signModle=1
self.curSignPage=1

self:refreshView()
if self.pageModel==1 then
self:onFilterBtn()
end
if self:checkInMoveModel()then
zhengzhanshanhaiModel:invokeFunc3('refreshCircleSign')
end
end

function UIXM_ZZSH_signWin:checkInRecordModel()
return self.pageModel==1
end

function UIXM_ZZSH_signWin:checkInMoveModel()
return self.pageModel==2
end

function UIXM_ZZSH_signWin:refreshView()
local showMove=self.pageModel==2
self.movePanel:setActive(showMove)
self.back2Btn:setActive(not showMove)
if showMove then
local move=zhengzhanshanhaiController:getZZSHCfg('move')
local moneys={}
for i,v in ipairs(move)do
table.insert(moneys,{v[1]})
end
self:initMoneyData(moneys)

self:refreshMoveCost(0)
end
end

function UIXM_ZZSH_signWin:refreshMoveCost(dis)
local xmData=zhengzhanshanhaiModel:getMyXMData()
if zhengzhanshanhaiModel:getEntity(xmData.ojbID)then
zhengzhanshanhaiModel:invokeFunc(xmData.ojbID,'refreshCircleSign')
end
local move=zhengzhanshanhaiController:getZZSHCfg('move')
for i=1,2 do
local data=move[i]
local widgetName=FMT.fmt('money{0}cost',i)
local isshow=data~=nil
self[widgetName]:setActive(isshow)
if isshow then
local moneyType=data[1]
local moneyNum=data[2]*dis
local widget=self[widgetName]:getChildWidgetBase()
local hasNum=moneyModel.getMoney(moneyType)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
local num_str
if hasNum>=moneyNum then
num_str=tostring(moneyNum)
else
num_str=FMT.fmt('<color=#C82C2C>{0}</color>',moneyNum)
end
widget:SetChildText(1,num_str)
end
end
end



function UIXM_ZZSH_signWin:initMoneyData(datas)
local moneyList={}
local moneyLookup={}
for i=1,2 do
local data=datas[i]
local widgetName=FMT.fmt('money{0}Root',i)
local isshow=data~=nil
self[widgetName]:setActive(isshow)
if isshow then
local moneyType=data[1]
local isAdd=data[2]
local widget=self[widgetName]:getChildWidgetBase()
local d={widget,moneyType,isAdd}
moneyList[i]=d
if moneyType then
moneyLookup[moneyType]=d
end
end
end
self.moneyList=moneyList
self.moneyLookup=moneyLookup

for i,money in ipairs(self.moneyList)do
self:initMoneyItem(money)
end
end

function UIXM_ZZSH_signWin:initMoneyItem(money)
local moneyType=money[2]
local widget=money[1]
local isshow=moneyType~=nil
widget:SetChildActive(-1,isshow)
if isshow then
local isAdd=money[3]~=1
local moneyVal=moneyModel.getMoney(moneyType)
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(1,iconHelper.getIconName(moneyType),false)
widget:SetChildText(2,moneyStr)
widget:SetChildActive(3,isAdd)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onAddClick(moneyType)
end)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:clickMoney(moneyType)
end)
end
end

function UIXM_ZZSH_signWin:refreshMoneyItemEx(moneyType,lastVal)
if not self.moneyLookup then return end
local money=self.moneyLookup[moneyType]
if money then
self:refreshMoneyItem(money,lastVal)
end
end

function UIXM_ZZSH_signWin:refreshMoneyItem(money,lastVal)
local moneyType=money[2]
local widget=money[1]
local isshow=moneyType~=nil
widget:SetChildActive(-1,isshow)
if isshow then
local moneyVal=moneyModel.getMoney(moneyType)
self:clearFMTweener(moneyType)
if self.fmTweener==nil then self.fmTweener={}end
self.fmTweener[moneyType]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(2,moneyStr)
end,moneyVal,1)
end
end

function UIXM_ZZSH_signWin:onAddClick(moneyType)
self:clickMoney(moneyType)
end

function UIXM_ZZSH_signWin:clickMoney(moneyType)
gainControl:showGainWin(moneyType)
end

function UIXM_ZZSH_signWin:clearFMTweener(mtype)
if self.fmTweener==nil then return end
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UIXM_ZZSH_signWin:clearAllFMTweener()
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener=nil
end
end



function UIXM_ZZSH_signWin:onFilterBtn()
self.filterFlag=not self.filterFlag
local icon=self.filterFlag and'button_sjbiaoshi_2'or'button_sjbiaoshi_1'
self.filterBtn:setCSImageSprite(globalABLookup.zzshicons,icon)
self:refreshInfoPanel()
end

function UIXM_ZZSH_signWin:refreshInfoPanel()
local isshow=self.filterFlag==true
self.infoPanel:setActive(isshow)
if isshow then
if self.signList==nil then
self:initSignList()
end
local c=#self.signList
local isshow=c>0
self.noSign:setActive(not isshow)
self.signInfoOne:setActive(isshow and self.signModle==1)
self.signInfoTwo:setActive(isshow and self.signModle==2)
self.signGridPanel:setActive(isshow)
if isshow then
self:refreshSignGridPanel()
end
self:refreshSingNum()
self:refreshSingPageNum()
end
end



function UIXM_ZZSH_signWin:initSignList()
local signList=zhengzhanshanhaiModel:getSignRecord()
self.signList=table.weakCopy(signList)

local c=#self.signList
local maxSignPage
if c>0 then
maxSignPage=math.ceil(c/signNumOnPage)
else
maxSignPage=0
end
self.maxSignPage=maxSignPage
if self.curSignPage and self.curSignPage>self.maxSignPage then
if self.maxSignPage>0 then
self.curSignPage=self.maxSignPage
end
end
local isGray=self.maxSignPage<=0
self.signPageLeftBtn:setChildImageExGray(isGray)
self.signPageRightBtn:setChildImageExGray(isGray)
end

function UIXM_ZZSH_signWin:refreshSingNum()
local cur=#self.signList
local max=zhengzhanshanhaiController:getZZSHCfg('maxSignNum')
local str=FMT.fmt('收藏 {0}/{1}',cur,max)
self.signNumTxt:setText(str)
end

function UIXM_ZZSH_signWin:refreshSingPageNum()
local page_str
if self.maxSignPage>0 then
page_str=FMT.fmt('{0}/{1}',self.curSignPage,self.maxSignPage)
else
page_str='--'
end
self.signPageTxt:setText(page_str)
end

function UIXM_ZZSH_signWin:refreshSignGridPanel()
local list={}
local c=#self.signList
local min=(self.curSignPage-1)*signNumOnPage+1
local max=math.min(c,self.curSignPage*signNumOnPage)
if min<=max then
for i=min,max do
table.insert(list,self.signList[i])
end
end
self.signPageList=list
local cc=#self.signPageList

self.signGridPanel:setChildLayoutGroupCreateItems(cc)
local grids=self.signGridPanel:getChildLayoutGroupGridList()
for i=1,cc do
local item=grids[i-1]
local d=self.signPageList[i]

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onSignItemClick(i)
end)

local idx=(self.curSignPage-1)*signNumOnPage+i
item:SetChildText(4,tostring(idx))

local name_str=d.name or'未知'
item:SetChildText(1,name_str)

local pos_str=FMT.fmt('（{0},{1}）',d.x,d.y)
item:SetChildText(2,pos_str)

self:refeshSigntemToggle(item,i)
end
end

function UIXM_ZZSH_signWin:onSignItemClick(idx)
if self.lockClick then return end
if self.signModle==1 then

local d=self.signPageList[idx]

UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',d.x,d.y,0,false,0)
else
local idx_=(self.curSignPage-1)*signNumOnPage+idx
local flag=self:checkSignSelected(idx_)
if self.signSelect==nil then
self.signSelect={}
end
if flag then
self.signSelect[idx_]=nil
else
self.signSelect[idx_]=true
end
self:refeshSigntemToggle(nil,idx)
end
end

function UIXM_ZZSH_signWin:refeshSigntemToggle(item,idx)
if item==nil then
item=self.signGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local idx_=(self.curSignPage-1)*signNumOnPage+idx
local showToggle=self.signModle==2
item:SetChildActive(3,showToggle)
if showToggle then
local isSelected=self:checkSignSelected(idx_)
local icon=isSelected and'image_dygou_2'or'image_dygou_1'
item:SetChildCSImageSprite(3,globalABLookup.global,icon)
end
end

function UIXM_ZZSH_signWin:checkSignSelected(idx)
local isSelected=false
if self.signSelect then
isSelected=self.signSelect[idx]==true
end
return isSelected
end

function UIXM_ZZSH_signWin:onSignPageLeftBtn()
if self.maxSignPage<=0 then return end
local old=self.curSignPage
local cur=old
if cur>1 then
cur=cur-1
else
cur=self.maxSignPage
end
if old~=cur then
self.curSignPage=cur
self:refreshSignGridPanel()
self:refreshSingPageNum()
end
end

function UIXM_ZZSH_signWin:onSignPageRightBtn()
if self.maxSignPage<=0 then return end
local old=self.curSignPage
local cur=old
if cur<self.maxSignPage then
cur=cur+1
else
cur=1
end
if old~=cur then
self.curSignPage=cur
self:refreshSignGridPanel()
self:refreshSingPageNum()
end
end

function UIXM_ZZSH_signWin:onSignSetupBtn()
self.signModle=2
self:refreshInfoPanel()
end

function UIXM_ZZSH_signWin:onSignBackBtn()
self.signModle=1
self.signSelect=nil
self:refreshInfoPanel()
end

function UIXM_ZZSH_signWin:onSignDelBtn()
if self.signSelect==nil or next(self.signSelect)==nil then
UIManager.error('请选择要删除的标记')
return
end
local idxs={}
for idx,v in pairs(self.signSelect)do
table.insert(idxs,idx)
end
self.signSelect=nil
self.signList=nil
zhengzhanshanhaiModel:removeSignRecord(idxs)
self:refreshInfoPanel()
end

function UIXM_ZZSH_signWin:handleSignRefresh()
self.signList=nil
self.signSelect=nil
self:refreshInfoPanel()
end

function UIXM_ZZSH_signWin:onSignAllBtn()
local c=#self.signList
if self.signSelect==nil then
self.signSelect={}
end
local cc=#self.signPageList
local isall=true
for i=1,cc do
local idx_=(self.curSignPage-1)*signNumOnPage+i
if self.signSelect[idx_]==nil then
isall=false
break
end
end
for i=1,cc do
local idx_=(self.curSignPage-1)*signNumOnPage+i
if isall then
self.signSelect[idx_]=nil
else
self.signSelect[idx_]=true
end
end
local grids=self.signGridPanel:getChildLayoutGroupGridList()
for i=1,cc do
local item=grids[i-1]
self:refeshSigntemToggle(item,i)
end
end



function UIXM_ZZSH_signWin:onBackBtn()
self:onCloseBtn()
end

function UIXM_ZZSH_signWin:onBack2Btn()
self:onCloseBtn()
end

function UIXM_ZZSH_signWin:onMoveBtn()
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPFight then
return
end

local myActorid=playerModel:getActorID()
if not xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)then
UIManager.error('只有盟主或副盟主可以移动仙盟')
return
end

local movePos=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','getMoveXMPos')
if movePos==nil then
UIManager.error('请选择要移动的位置')
return
end
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if movePos[1]==g_x and movePos[2]==g_y then
UIManager.error('请选择要移动的位置')
return
end
local dis=mathHelper.distance(movePos[1],movePos[2],g_x,g_y)
dis=math.ceil(dis)

local move=zhengzhanshanhaiController:getZZSHCfg('move')
for i,v in ipairs(move)do
local id=v[1]
local need=v[2]*dis
local have=moneyModel.getMoney(id)
if have<need then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(id)))
gainControl:showGainWin(id)
return
end
end

if raceState==eZZSH_State.ePVPStandby and zhengzhanshanhaiModel:hasPvPOrder()then
local showdata=
{
type='UIDialouge',
title='提示',
content='移动后将会取消一切指令，是否确认？',
oktext='确定',
canceltext='取消',
okcallback=function()
zhengzhanshanhaiController:reqMove(movePos[1],movePos[2])
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
zhengzhanshanhaiController:reqMove(movePos[1],movePos[2])
end
end

function UIXM_ZZSH_signWin:onCloseBtn()
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','activeSignModel',false)
end

function UIXM_ZZSH_signWin:rec_movePos()

self:onCloseBtn()
end