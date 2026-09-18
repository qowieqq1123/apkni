







def_class("UIXM_XMDG_eventSelectDZWin",UIWindowBase)









function UIXM_XMDG_eventSelectDZWin:bindComponents()

self.roleListPanel=UIObject.get(self,0)
self.btnCommit=UIButton.get(self,1)
self.descTxt=UIText.get(self,2)
self.costObj=UIObject.get(self,3)
self.money1Root=UIObject.get(self,4)
self.txtCommit=UIText.get(self,5)
self.costIcon=UIImage.get(self,6)
self.costNumTxt=UIText.get(self,7)

self.btnCommit:setButtonClick(function()self:onBtnCommit()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXM_XMDG_eventSelectDZWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.btnCommit);self.btnCommit=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.txtCommit);self.txtCommit=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNumTxt);self.costNumTxt=nil;
end
















local _this=nil


function UIXM_XMDG_eventSelectDZWin:onLoaded(...)
_this=self
self:bindComponents()

local _OnClickRoleItemCallback=function(clicknum,i)
self:onClickItem(i+1)
end
self.roleListPanel:setChildScrollViewInit(-1,true,_OnClickRoleItemCallback,nil)
end


function UIXM_XMDG_eventSelectDZWin:__delete()
_this=nil
self:unbindComponents()
self:clearAllFMTweener()
end


function UIXM_XMDG_eventSelectDZWin:onHide()

end




function UIXM_XMDG_eventSelectDZWin:onShow(argtable,afterOnloaded)
self:clearAllFMTweener()
self.parentWin=argtable.parentWin
self.select_dz=argtable.select_dz
self.callback=argtable.callback

self.eventId=argtable.eventId
self.eventcfg=cfgHelper.get1(cfg_guilddigongeventconfig_get,self.eventId)

self.select_index=nil
self:refreshView()
self:initMoneyItem()
end

function UIXM_XMDG_eventSelectDZWin:refreshView()
self:refreshScrollView()

local showDesc=self.eventcfg.speed2~=nil
self.descTxt:setActive(showDesc)
if showDesc then
local jobType=self.eventcfg.speed2[1]
local str=xianmengdigongModel:get_eventCond_desc3(jobType)
local desc_str=FMT.fmt('弟子{0}等级可提高探索效率，降低探索风险',str)
self.descTxt:setText(desc_str)
end

local showcost=self.eventcfg.useXDL~=nil
self.costObj:setActive(showcost)
if showcost then
self.costIcon:setImageIcon(iconHelper.getIconName(eMoneyType.mtDiGongXingDongLi),false)
local num_str
local need=self.eventcfg.useXDL
local has=xianmengdigongModel:getXDL()
if has>=need then
num_str=tostring(need)
else
num_str=FMT.fmt('<color=#c82c2c>{0}</color>',need)
end
self.costNumTxt:setText(num_str)
end
end

function UIXM_XMDG_eventSelectDZWin:initDiscipleList()
self.disciplelist={}
local list=UIDiscipleModel:getSortList()
for i,data in ipairs(list)do
local locData={}
locData.disciple=data
local guid=data.discipleguid
local checkCurrent=self.select_dz~=nil and mathHelper.compareInt64(guid,self.select_dz)

locData.hp=xianmengdigongModel:getDZBlood(guid)
locData.chuiwei=locData.hp<=0
local flag=xianmengdigongModel:checkDZInRoom(guid)
locData.inRoom=flag
local tips=nil
if locData.inRoom then
tips='事件中'
end
local num1=0
local num2=0
local desc1=nil
local desc2=nil
local effectlist={}
local dzNeed=self.eventcfg.dzNeed
if dzNeed and#dzNeed>0 then
for i,v in ipairs(dzNeed)do
local s
local cur
if v[1]==1 then
local attrType=v[2]
local attrNum=v[3]
cur=eSpecialAttrFunc:getValue(attrType,guid)
s=xianmengdigongModel:get_eventCond_desc1(attrType,cur)
local check
if attrType==eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_VOC then
check=cur==attrNum
else
check=cur>=attrNum
end
if not check then
if tips==nil then
tips=xianmengdigongModel:get_eventCond_desc2(attrType,attrNum)
end
end
elseif v[1]==2 then
local speType=v[2]
local speid=v[3]
local spe=UIDiscipleModel:getDiscipleSpecialityByID(guid,speType,speid,true)
if spe then
local specfg=UIDiscipleModel:getSpecialityConfig(speType,speid)
table.insert(effectlist,specfg)
else
if tips==nil then



tips='缺指定特质'
end
end
end
if s then
if desc1==nil then
desc1=s
num1=cur
elseif desc2==nil then
desc2=s
num2=cur
end
end
end
end
locData.desc1=desc1
locData.desc2=desc2
locData.effectlist=effectlist
locData.tips=tips
locData.fight=UIDiscipleModel:getDiscipleFightValue(guid)
local sorts={}
locData.sorts=sorts
sorts[1]=checkCurrent==true and 1 or 0
if not locData.chuiwei and tips==nil then
sorts[2]=1
else
sorts[2]=0
end
sorts[3]=num1
sorts[4]=num2
sorts[5]=locData.fight
sorts[6]=guid

table.insert(self.disciplelist,locData)
end
end

function UIXM_XMDG_eventSelectDZWin:reSelectDisciple()
if self.select_dz then
local f
for i,v in ipairs(self.disciplelist)do
if mathHelper.compareInt64(v.disciple.discipleguid,self.select_dz)then
f=i
break
end
end
if f then
self.select_index=f
else
self.select_dz=nil
self.select_index=nil
end
else
self.select_index=nil
end
end

function UIXM_XMDG_eventSelectDZWin:refreshScrollView()
self:initDiscipleList()
mathHelper.sortWeightList(self.disciplelist)
self:reSelectDisciple()
self.roleListPanel:setChildScrollViewDelayCreateGrids(#self.disciplelist,2,0.02,1,false,false,function(id,item)
if _this==nil then return end
_this:refreshItem(id,item)
end)
self.grids=self.roleListPanel:getChildScrollViewItemWidgets()

if#self.disciplelist>0 and not self.select_index then
for i=1,#self.disciplelist do

local flag=self:firstSelectdz(i)
if flag then
break
end
end
end


end

function UIXM_XMDG_eventSelectDZWin:refreshItem(id,item)
local index=id+1
local data=self.disciplelist[index]
local disdata=data.disciple
local guid=disdata.discipleguid
local chuiwei=data.chuiwei


local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(6,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

comHelper.setChildModelRawImage(item,guid,1,0,eHeadCenterType.eHalf,nil,chuiwei)

local name=UIDiscipleModel:getDiscipleName(guid)
item:SetChildText(2,name)

local fight_str=FMT.fmt('<color=#7d3b17>战力</color> {0}',data.fight)
item:SetChildText(18,fight_str)

item:SetChildActive(0,self.select_index==index)

item:SetChildActive(9,chuiwei)
item:SetChildActive(10,chuiwei)
item:SetChildActive(11,chuiwei)
if chuiwei then
local func=function()
if _this==nil then return end
_this:onDZAddLife(index)
end
item:SetChildButtonClick(11,func,true)
end


local showDesc1=data.desc1~=nil
item:SetChildActive(16,showDesc1)
if showDesc1 then
item:SetChildText(3,data.desc1)
end
local showDesc2=data.desc2~=nil
item:SetChildActive(17,showDesc2)
if showDesc2 then
item:SetChildText(4,data.desc2)
end


local effectlist=data.effectlist
local showspe=effectlist~=nil and#effectlist>0
item:SetChildActive(5,showspe)
if showspe then
local count=#effectlist
item:SetChildLayoutGroupCreateItems(8,count)
local spegrids=item:GetChildLayoutGroupGridList(8)
for i=1,count do
local speitem=spegrids[i-1]
local effectcfg=effectlist[i]
UIDiscipleModel.refreshSpecialityItemExx(speitem,effectcfg)
speitem:SetChildButtonClick(1,function()
if _this==nil then return end
_this:onDescSlotClick(index,i)
end)
end
end


local hp=data.hp
item:SetChildIconFillAmount(14,hp/10000)



local tips=data.tips
local showTips=tips~=nil
item:SetChildActive(12,showTips)
if showTips then
item:SetChildText(13,tips)
end


local checkCurrent=data.checkCurrent
item:SetChildActive(7,checkCurrent)
end

function UIXM_XMDG_eventSelectDZWin:onDZAddLife(idx)
local data=self.disciplelist[idx]
local item=self.grids[idx-1]
local dzguid=data.disciple.discipleguid
local pos=item:GetChildScreenPointToLocalPointRectangle(11)
local args={dzguid=dzguid,posx=pos.x-40,posy=pos.y}
UIManager:showWindow('UIXM_XMDG_reliveWin',args)
end

function UIXM_XMDG_eventSelectDZWin:onDescSlotClick(disIdx,speIdx)
local data=self.disciplelist[disIdx]
local effects=data.effectlist
local cfg=effects[speIdx]
cfg.specialitytype=cfg.typo
local item=self.grids[disIdx-1]
local speitem=item:GetChildLayoutGroupGridItem(8,speIdx-1)
UIManager:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=data.disciple.discipleguid,config=cfg})
end

function UIXM_XMDG_eventSelectDZWin:refreshSelect(index,flag)
local item=self.grids[index-1]
item:SetChildActive(0,flag)
end

function UIXM_XMDG_eventSelectDZWin:onClickItem(index)
if self.select_index==index then return end
local old=self.select_index

local data=self.disciplelist[index]
if data.chuiwei then
UIManager.error('濒危弟子无法派遣')
return
elseif data.inRoom then
UIManager.error("该弟子正在执行其他事件")
return
elseif data.tips then
UIManager.error(data.tips)
return
end

self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
if old~=nil then
self:refreshSelect(old,false)
end
self:refreshSelect(index,true)

end

function UIXM_XMDG_eventSelectDZWin:firstSelectdz(index)
if self.select_index==index then return end
local old=self.select_index

local data=self.disciplelist[index]
if data.chuiwei then
return
elseif data.inRoom then
return
elseif data.tips then
return
end

self.select_index=index
self.select_dz=self.disciplelist[self.select_index].disciple.discipleguid
if old~=nil then
self:refreshSelect(old,false)
end
self:refreshSelect(index,true)
return true
end


function UIXM_XMDG_eventSelectDZWin:onBtnCommit()
if self.select_index==nil then
UIManager.error('请选择弟子')
return
end

local need=self.eventcfg.useXDL
if need~=nil then
local has=xianmengdigongModel:getXDL()
if has<need then
xianmengdigongController.xdlTips()
gainControl:showGainWin(eMoneyType.mtDiGongXingDongLi)
return
end
end

local data=self.disciplelist[self.select_index]
if data.chuiwei or data.tips then
return
end

local select_dz=self.select_dz


if xianmengdigongModel:isUnlockAll()and self:isFreeExploreEvent()then
self:showFreeExploreConfirmDialog(select_dz)
return
end

local callback=self.callback
if callback then
callback(select_dz)
end
end

function UIXM_XMDG_eventSelectDZWin:onClickClose()
self.parentWin:closeSelf()
end



function UIXM_XMDG_eventSelectDZWin:initMoneyItem()
local moneyType=eMoneyType.mtDiGongXingDongLi
local widget=self.money1Root:getChildWidgetBase()
local isAdd=true
local moneyVal=xianmengdigongModel:getXDL()
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(1,iconHelper.getIconName(moneyType),false)
widget:SetChildText(2,moneyStr)
widget:SetChildActive(3,isAdd)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:clickMoney()
end)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:clickMoney()
end)
end

function UIXM_XMDG_eventSelectDZWin:refreshMoneyItem(lastVal)
local moneyType=eMoneyType.mtDiGongXingDongLi
local widget=self.money1Root:getChildWidgetBase()
local moneyVal=xianmengdigongModel:getXDL()
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

function UIXM_XMDG_eventSelectDZWin:clickMoney()
gainControl:showGainWin(eMoneyType.mtDiGongXingDongLi)
end

function UIXM_XMDG_eventSelectDZWin:clearFMTweener(mtype)
if self.fmTweener==nil then return end
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UIXM_XMDG_eventSelectDZWin:clearAllFMTweener()
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener=nil
end
end



function UIXM_XMDG_eventSelectDZWin:rec_dzRelive(dzguid)
self:refreshView()
UIManager:closeWindow('UIXM_XMDG_reliveWin')
end


function UIXM_XMDG_eventSelectDZWin:showFreeExploreConfirmDialog(select_dz)
local need=self.eventcfg.useXDL or 0
local has=xianmengdigongModel:getXDL()or 0
if need<=0 then
local callback=self.callback
if callback then
callback(select_dz)
end
return
end

local maxTimes=math.floor(has/need)
local defaultTimes=1
local function refresh(num)
num=tonumber(num)or 1
if num<1 then
num=1
elseif num>maxTimes then
num=maxTimes
end

local totalCost=num*need

local content=FMT.fmt(
'请选择自由探索次数'..
'消耗<color=#ca631d>(行动令*{0}</color>)',
totalCost
)
return content
end

local itemList=nil
local show_data={
type='UIDialougeBuyCount',
title='自由探索',
refreshcallback=refresh,
max=maxTimes,
defaultCnt=defaultTimes,
tips=nil,
oktext='确定',
canceltext='取消',

okcallback=function(num)

num=tonumber(num)or 1
if num<1 then
num=1
elseif num>maxTimes then
num=maxTimes
end

local totalCost=num*need
local curHas=xianmengdigongModel:getXDL()
if curHas<totalCost then
xianmengdigongController.xdlTips()
gainControl:showGainWin(eMoneyType.mtDiGongXingDongLi)
return
end

local callback=self.callback
if callback then
callback(select_dz,num or 1)
end
end,
}

local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
function UIXM_XMDG_eventSelectDZWin:isFreeExploreEvent()

if not self.eventId then
return false
end
return self.eventId==10001
end
