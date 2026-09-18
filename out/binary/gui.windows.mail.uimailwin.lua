







def_class("UIMailWin",UIWindowBase)

local _format=string.format
local _floor=math.floor









function UIMailWin:bindComponents()

self.allDeleteButton=UIButton.get(self,0)
self.allPrizeButton=UIButton.get(self,1)
self.attachGoodsContent=UIObject.get(self,2)
self.bgClose=UIButton.get(self,3)
self.checkText=UIText.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.Content=UIObject.get(self,6)
self.haveMail=UIObject.get(self,7)
self.mailAttach=UIObject.get(self,8)
self.mailContentTxt=UILinkImageText.get(self,9)
self.mailCountText=UIText.get(self,10)
self.mailScroller=UILoopListView.new(self,11)
self.mailSendTime=UIText.get(self,12)
self.mailTitle=UIObject.get(self,13)
self.mailTitlelong=UIObject.get(self,14)
self.mailTitleTxt=UIText.get(self,15)
self.mailTypeTxt=UIText.get(self,16)
self.notHaveMail=UIObject.get(self,17)
self.prizeButton=UIButton.get(self,18)
self.prized=UIObject.get(self,19)
self.richTextBtn=UIButton.get(self,20)
self.richTextBtnText=UIText.get(self,21)
self.root=UIObject.get(self,22)
self.sortTypeDropdown=UIDropdown.get(self,23)
self.tybg=UIImage.get(self,24)

self.allDeleteButton:setButtonClick(function()self:onAllDeleteButton()end)

self.allPrizeButton:setButtonClick(function()self:onAllPrizeButton()end)

self.bgClose:setButtonClick(function()self:onBgClose()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mailScroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.prizeButton:setButtonClick(function()self:onPrizeButton()end)

self.richTextBtn:setButtonClick(function()self:onRichTextBtn()end)



end


function UIMailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.allDeleteButton);self.allDeleteButton=nil;
_UIObject_release(self.allPrizeButton);self.allPrizeButton=nil;
_UIObject_release(self.attachGoodsContent);self.attachGoodsContent=nil;
_UIObject_release(self.bgClose);self.bgClose=nil;
_UIObject_release(self.checkText);self.checkText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.haveMail);self.haveMail=nil;
_UIObject_release(self.mailAttach);self.mailAttach=nil;
_UIObject_release(self.mailContentTxt);self.mailContentTxt=nil;
_UIObject_release(self.mailCountText);self.mailCountText=nil;
self.mailScroller:deleteSelf();self.mailScroller=nil;
_UIObject_release(self.mailSendTime);self.mailSendTime=nil;
_UIObject_release(self.mailTitle);self.mailTitle=nil;
_UIObject_release(self.mailTitlelong);self.mailTitlelong=nil;
_UIObject_release(self.mailTitleTxt);self.mailTitleTxt=nil;
_UIObject_release(self.mailTypeTxt);self.mailTypeTxt=nil;
_UIObject_release(self.notHaveMail);self.notHaveMail=nil;
_UIObject_release(self.prizeButton);self.prizeButton=nil;
_UIObject_release(self.prized);self.prized=nil;
_UIObject_release(self.richTextBtn);self.richTextBtn=nil;
_UIObject_release(self.richTextBtnText);self.richTextBtnText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.tybg);self.tybg=nil;
end



















local _this=nil

local _mail_cmp_index=
{
select=0,
name=1,
time=2,
read=3,
prize=4,
namelong=5,
isExpire=6,
}

local _item_cmp_index=
{
cmpQuality=0,
cmpIcon=1,
cmpCountTxt=2,
cmpLock=3,
cmpStageTxt=4,
cmpSelect=5,
cmpAni=6,
}

local curSortType=nil
local toBeDelList={}

local sortTypeName=
{
"发送时间",
"剩余时间"
}

local sortType=
{
sendTime=0,
expireTime=1
}


function UIMailWin:onLoaded(...)
_this=self
self:bindComponents()

self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.mailScroller:getID())

webGLHelper:uiWindowCloseCamera(self.tybg)

self:initUI()
mailProtocolController.req_mail_list()

self.win=false
self.isCheck=true
self.isSetDrop=true
self.icExpireCheck=true
self.isReverseSort=false
self.isChangeAction=false
self.isShowMaxTips=false
self.mailList=mailModel:get_mail_list()


local glableCfg=cfg_globalconfig_get(1)
self.emailMaxCount=glableCfg.maxmail
self.defMailExpire=glableCfg.mailautodelete

self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
self.sortTypeDropdown:setOption(sortTypeName)

curSortType=sortType.sendTime
end


function UIMailWin:__delete()
self:unbindComponents()
_this=nil

webGLHelper:uiWindowShowCamera()

self.mailList=nil
self.win=false



mailController:closeMailUI()
end




function UIMailWin:onShow(argtable,afterOnloaded)
self:refresh(argtable)
end

function UIMailWin:refresh(argtable)
local oldLen=self.mailList~=nil and#self.mailList or 0
local mailList=mailModel:get_mail_list()
local len=mailList~=nil and#mailList or 0
if self:checkMailCountIsFull()then
self.isCheck=false
self:delMailByFull()
end
self:updateData(argtable)
self:refreshUI(argtable.isSelect)

if len>oldLen then

self.sortTypeDropdown:setValue(curSortType-1)
end
if self.isShowMaxTips==false then
self:onMaxToDelMail()
end
end



function UIMailWin:saveSortType()
userActorSetting.set('curMailSortType',curSortType)
userActorSetting.flush()
end

function UIMailWin:onDropdownChange(idx)
local mailId=nil
curSortType=idx+1

if#self.mailList>0 then
if not self.mailIndex then
self.mailIndex=1
end
mailId=self.mailList[self.mailIndex].mailId
end

self:sortByDiffTime(curSortType)
mailModel:set_sortType(curSortType)

if self.isChangeAction then
UIManager:invokeUIMethod("UIMailWin","refresh",{isSelect=true})
else
self.isChangeAction=true
end
end


function UIMailWin:onSortOrderClick()
self:sortByDiffTime(curSortType,true)


if not self.isReverseSort then
self.isReverseSort=true
else
self.isReverseSort=false
end


self.mailIndex=1
UIManager:invokeUIMethod("UIMailWin","refresh",{})
end


function UIMailWin:sortByDiffTime(timeType,flag)
if#self.mailList>0 then
table.sort(self.mailList,
function(a,b)

local weight_a=0
local weight_b=0

if not a.isRead then
weight_a=1
end

if not b.isRead then
weight_b=1
end

local expireTime_a=self:countMailExpireTime(a.mailId)or 0
local expireTime_b=self:countMailExpireTime(b.mailId)or 0

if timeType==1 then
if flag then
if not self.isReverseSort then


if weight_a~=weight_b then
return weight_a>weight_b
else
return(a.time*10000+a.mailId)<(b.time*10000+b.mailId)
end
else

return(a.time*10000+a.mailId+weight_a*1000000000000)>(b.time*10000+b.mailId+weight_b*1000000000000)
end
else
return(a.time*10000+a.mailId+weight_a*1000000000000)>(b.time*10000+b.mailId+weight_b*1000000000000)
end
else
if flag then
if not self.isReverseSort then
if weight_a~=weight_b then
return weight_a>weight_b
else
return(expireTime_a*10000+a.mailId)<(expireTime_a*10000+b.mailId)
end

else
return(expireTime_a*10000+a.mailId+weight_a*1000000000000)>(expireTime_b*10000+b.mailId+weight_b*1000000000000)
end
else
return(expireTime_a*10000+a.mailId+weight_a*1000000000000)>(expireTime_b*10000+b.mailId+weight_b*1000000000000)
end
end
end)

end
end


function UIMailWin:sortByDel()
for i,v in ipairs(self.mailList)do
if v.attNum<=0 then

table.insert(toBeDelList,{mailId=v.mailId,expireTime=v.expireTime,isRead=v.isRead})
end
end

if toBeDelList then
table.sort(toBeDelList,
function(a,b)

local weight_a=0
local weight_b=0
local expireTime_a=self:countMailExpireTime(a.mailId)
local expireTime_b=self:countMbilExpireTime(b.mailId)

if not a.isRead then
weight_a=1
end

if not b.isRead then
weight_b=1
end

return(expireTime_a*10000+a.mailId+weight_a*1000000000000)>(expireTime_b*10000+b.mailId+weight_b*1000000000000)
end)
end
end


function UIMailWin:sortMail()
table.sort(self.mailList,function(a,b)return(a.time*10000+a.mailId)<(b.time*10000+b.mailId)end)
end



function UIMailWin:checkMailCountIsFull()
local num=mailModel:get_eMailCount()
if num>self.emailMaxCount then
return true
else
return false
end
end


function UIMailWin:delMailByFull()
self:sortMail()

for i=1,self.emailMaxCount do
local v=self.mailList[i]
if v then
table.insert(toBeDelList,v)
else
break
end
end

self.mailList=toBeDelList
end


function UIMailWin:get_mail_index(mailId)
for i,v in pairs(self.mailList)do
if tonumber(tostring(v.mailId))==tonumber(tostring(mailId))then
return i
end
end
end


function UIMailWin:updateMaildata(mailIdList,isPrize)
for k,v in ipairs(mailIdList)do

local index=self:get_mail_index(v)
self.mailList[index].isRead=true

if isPrize then
self.mailList[index].isPrize=isPrize
end
self:freshMailItem(index)
end
self:refreshDetail()
self:refreshBtns()
end

function UIMailWin:updateData(argtable)
if self.isUpdating then
self.needUpdate=true
self.needUpdate_arg=argtable
return
end

if argtable.reqData or self.isInit then
self.mailList=mailModel:get_mail_list()
self.win=false
end

self:filterMailExpire()
self.isUpdating=true
self.isInit=argtable and argtable.isInit or false
self.mailIndex=self.mailIndex or self.mailIndexList_FilterExpire[1]or 1

if argtable.mailId then
self.mailIndex=self:get_mail_index(argtable.mailId)
end

if argtable.index then

if self.mailList then
self.mailIndex=argtable.index
else
self.mailIndex=nil
end
end

if not self.win and self.isInit then
self.win=true
self:sortByDiffTime(curSortType)
end


local nowMail=self.mailList and self.mailList[self.mailIndex]
if nowMail and nowMail.isRead==false and self.isInit==true then
mailProtocolController.req_mail_oper(eMailSendOperType.eRead,1,{nowMail.mailId})
end

self.isUpdating=false

if self.needUpdate then
local arg=self.needUpdate_arg
self.needUpdate_arg=nil
self.needUpdate=false
return self:refresh(arg)
end
end

function UIMailWin:format_time_stamp3(time,force)
local day=86400
local hour=3600
local min=60
local str=nil
if time>day then
local v1=_floor(time/day)
local v2=time%day/hour
if math.floor(v2)~=0 or force then
str=_format('%d天%d时',v1,v2)
else
str=_format('%d天',v1)
end
elseif time>hour then
local v1=_floor(time/hour)
local v2=time%hour/min
if math.floor(v2)~=0 or force then
str=_format('%d时%d分',v1,v2)
else
str=_format('%d时',v1)
end
elseif time>min then
local v1=_floor(time/min)
str=_format('%d分钟',v1)
else
str=_format('%d分钟',1)
end
return str
end


function UIMailWin:countMailExpireTime(mailId)
local time=0
local index=self:get_mail_index(mailId)
local nowTime=timeHelper.getServerLongTime()
local sengTime=self.mailList[index].time
local expireTime=self.mailList[index].expireTime
sengTime=timeHelper.convertLongStamp(sengTime)

if not expireTime then

return false
end

if expireTime==0 and self.defMailExpire then
if self.mailList[index].attNum>0 then
time=self.defMailExpire[2]*86400
else
time=self.defMailExpire[1]*86400
end
expireTime=time

end

local lerp=nowTime-sengTime

if expireTime>lerp then
return expireTime-lerp
else
return 1
end
end



function UIMailWin:initUI()

end

function UIMailWin:refreshUI(argtable)
self:refreshMailList(argtable)
self:refreshDetail()
self:refreshBtns()
self:refreshMailCounts()
end

function UIMailWin:refreshMailCounts()
local num=mailModel:get_eMailCount()
local str=FMT.fmt("{0}/{1}",num,self.emailMaxCount)
self.mailCountText:setText(str)
end

function UIMailWin:refreshBtns()
local mailList=self.mailList
local hasMail=#mailList>0

local mailIdList={}
for i,v in ipairs(self.mailList)do
local hasAttach=#v.items>0
if hasAttach and v.isPrize==false then
mailIdList[#mailIdList+1]=v.mailId
end
end

local canPrize=#mailIdList>0

self.allDeleteButton:setActive(hasMail)
self.allPrizeButton:setActive(hasMail)

self.winlua:SetChildButtonEnable(self.allPrizeButton:getID(),canPrize,not canPrize)
end

function UIMailWin:refreshMailList(argtable)

local mailList=self.mailIndexList_FilterExpire
local hasMail=#mailList>0
self.haveMail:setActive(hasMail)
self.notHaveMail:setActive(not hasMail)
if hasMail then
local createCount=#mailList
local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.mailScroller:initData('UIMail_mailItem',createList)

if argtable then
self.mailScroller:jumpItem(self.mailIndex)
end

self.mailScroller:setActive(true)
end
end

function UIMailWin:onStartAction()

end

function UIMailWin:onFreshAction(i,slot)

local mailIndex=i
local mailData=self.mailList[mailIndex]
slot:SetChildActive(_mail_cmp_index.select,mailIndex==self.mailIndex)
local titlestr,islong=self:checklengthover(mailData.title)
if islong then
slot:SetChildText(_mail_cmp_index.name,'')
slot:SetChildText(_mail_cmp_index.namelong,FMT.fmt("{0}",titlestr))
else
slot:SetChildText(_mail_cmp_index.name,FMT.fmt("{0}",titlestr))
slot:SetChildText(_mail_cmp_index.namelong,'')
end


slot:SetChildActive(_mail_cmp_index.read,mailData.isRead)

local time
local residueTime=self:countMailExpireTime(mailData.mailId)
if residueTime then
time=self:format_time_stamp3(residueTime)
else
residueTime=1
time="1分钟"
end
slot:SetChildText(_mail_cmp_index.time,FMT.fmt("有效期: {0}",time))

if residueTime>=86400 then
slot:SetChildActive(_mail_cmp_index.isExpire,false)
else
slot:SetChildActive(_mail_cmp_index.isExpire,true)
end

local hasAttach=#mailData.items>0
slot:SetChildActive(_mail_cmp_index.prize,hasAttach and not mailData.isPrize)

slot:SetChildButtonClick(-1,function(...)
if _this==nil then return end
_this:onMailClick(nil,i)
end)
end

function UIMailWin:freshMailItem(idx)
local nowShowItemCount=self.loopListViewCmp.ShownItemCount

for i=0,nowShowItemCount-1 do
local item=self.loopListViewCmp:GetShownItemByIndex(i)
local index=item.ItemIndex
if index==idx-1 then
self:onFreshAction(idx,item.Widget)
break
end
end
end

function UIMailWin:freshSelectItem(idx,flag)
local nowShowItemCount=self.loopListViewCmp.ShownItemCount

for i=0,nowShowItemCount-1 do
local item=self.loopListViewCmp:GetShownItemByIndex(i)
local index=item.ItemIndex
if index==idx-1 then
local widget=item.Widget
widget:SetChildActive(0,flag)
break
end
end
end


function UIMailWin:checklengthover(str)

local charList=string.toTable(str)
local newstr=nil
local islong=false
if pfwindowslController:checkIsGameVersion_yuenan()then
if charList and#charList>25 then
islong=true
newstr=FMT.fmt("{0}...",utf8.sub(str,1,25))
return newstr or str,islong
else
return str,islong
end
else
if charList and#charList>8 then
islong=true
newstr=FMT.fmt("{0}{1}{2}{3}{4}{5}{6}{7}...",charList[1],charList[2],charList[3],charList[4],charList[5],charList[6],charList[7],charList[8])
return newstr or str,islong
else
return str,islong
end
end
end

function UIMailWin:refreshDetail()
self:refreshDetailText()
self:refreshAttach()
end

function UIMailWin:refreshDetailText()
local mailData=self.mailList[self.mailIndex]
if not mailData then

self.mailContentTxt:setText(FMT.fmt("{0}",""))

self:refreshRichTextBtn()
return
end
local titlestr,islong=self:checklengthover(mailData.title)
if islong then
self.mailTitle:setActive(false)
self.mailTitlelong:setActive(true)
else
self.mailTitle:setActive(true)
self.mailTitlelong:setActive(false)
end
self.mailTitleTxt:setText(FMT.fmt("{0}",mailData.title))
local sendtime=os.date(pfwindowslController:getDateFormatForVersion(),timeHelper.convertLongStamp(mailData.time))





self.mailSendTime:setText(FMT.fmt("{0}",sendtime))

local textViewWidth=self.mailContentTxt:getChildSizeDeltaX()
local btnList,str=mailController.checkBtnRichText(mailData.content,true)
if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()or
pfwindowslController:checkIsGameVersion_HWFT_PC()then
str=self:checkStartStr(str)
local checkStr=comHelper.getCheckLayoutStr(self.checkText:getGameObject(),textViewWidth,str)

self.mailContentTxt:setText(FMT.fmt("{0}",checkStr))

else

self.mailContentTxt:setText(FMT.fmt("{0}",str))
end


self:refreshRichTextBtn(btnList)
end

function UIMailWin:refreshRichTextBtn(btnList)
if btnList and next(btnList)then
local btnParam=btnList[1]
local btnStyleParam=mailConfig.getRichTextBtnStyleParam(btnParam.style)
if btnStyleParam then
local abName=btnStyleParam[1]
local btnImage=btnStyleParam[2]
self.richTextBtn:setCSImageSprite(abName,btnImage)
end
local btnName=btnParam.name
local btnColor=btnParam.color
local btnText=FMT.fmt("<color={0}>{1}</color>",btnColor,btnName)
local argsStr=btnParam.argsStr
self.richTextBtnText:setText(btnText)
self.richTextBtn:setActive(true)

self.widget:SetChildButtonClick(self.richTextBtn:getID(),function()
mailController.checkBtnFunc(argsStr)
end)
else
self.richTextBtn:setActive(false)
end
end

function UIMailWin:refreshAttach()
local hasMail=#self.mailList>0
if not hasMail then
self.mailAttach:setActive(false)
self.prizeButton:setActive(false)
else
local mailData=self.mailList[self.mailIndex]
local hasAttach=mailData and#mailData.items>0 or false
self.mailAttach:setActive(hasAttach)
self.prizeButton:setActive(hasAttach and not mailData.isPrize)
if hasAttach then
self.prized:setActive(mailData.isPrize)
self:refreshItemList()
end
end
end

function UIMailWin:refreshItemList()
local itemList=self.mailList[self.mailIndex].items
local func=function(index)
local item=self.attachGoodsContent:getChildLayoutGroupGridItem(index-1)
self:refreshGoodItem(item,index)
end
self.attachGoodsContent:setChildLayoutGroupCreateItems(#itemList,func)
end

function UIMailWin:refreshGoodItem(item,index)
local itemList=self.mailList[self.mailIndex].items
local isPrize=self.mailList[self.mailIndex].isPrize
local mailguid=self.mailList[self.mailIndex].mailId
local data=itemList[index]
local num=tonumber(tostring(data.count))
local itemID=data.itemId
local itemguid=mailModel:getItemguid(mailguid,itemID)

local isEquip=itemsConfig.isEquip(itemID)
local isFabao=itemsConfig.isFabao(itemID)
local itemExtraData=data.itemData or{}
local jinglianlv=isEquip and itemExtraData.jinglianlv or
isFabao and itemExtraData.jilianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local num_str
local showCountBG
if num>1 then
num_str=tostring(num)
showCountBG=true
else
if jinglianStr and jinglianStr~=''then
num_str=jinglianStr
showCountBG=true
else
num_str=''
showCountBG=false
end
end
local grayNum=0
if isPrize then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
end
local iconName=isFabao and itemsModel.getIconName({itemid=itemID,itemData=itemExtraData})or nil
local conf={itemid=itemID,itemguid=itemguid,itemcount=num_str,showname=false,showCountBG=showCountBG,showStage=true,gray=grayNum,iconName=iconName}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onAttachClick(data.itemData,...)end)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
end


function UIMailWin:filterMailExpire()
self.mailIndexList_FilterExpire={}
if not self.mailList or not next(self.mailList)then

return
end

local expireMailIdlList={}
for i,v in ipairs(self.mailList)do
local mailId=v.mailId
local isExpire=mailModel:checkMailExpire(mailId)

if mailModel:checkMailExpireTime(mailId)and self.icExpireCheck then
isExpire=true
end

if isExpire then

table.insert(expireMailIdlList,mailId)
else

table.insert(self.mailIndexList_FilterExpire,i)
end
end

self.icExpireCheck=false

if next(expireMailIdlList)then

local count=#expireMailIdlList
mailProtocolController.req_mail_oper(eMailSendOperType.eDelete,count,expireMailIdlList)
end

if#expireMailIdlList>0 then


end
end


function UIMailWin:onMailClick(chickNum,index)
local mailIndex=self.mailIndexList_FilterExpire[index]

if self.mailIndex==mailIndex then return end
self.lastIndex=self.mailIndex
self.mailIndex=mailIndex
local mailData=self.mailList[self.mailIndex]
if not mailData then
return
end

if self.lastIndex and self.lastIndex<=#self.mailList then
self:freshSelectItem(self.lastIndex,false)
end
self:freshSelectItem(self.mailIndex,true)
if mailData.isRead then
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
self:refreshDetail()
self:refreshBtns()
else
mailProtocolController.req_mail_oper(eMailSendOperType.eRead,1,{mailData.mailId})
end
end


function UIMailWin:onAttachClick(itemData,id,index,guid,attach)
if id==-1 then
return
end
local itemCfg=itemsConfig.getConfig(id)
if itemCfg then
tipsManager.showTips({itemid=id,itemguid=guid,itemData=itemData})
else
loggerUtil.logErrFMT('没有找到此道具：',id)
end
end



function UIMailWin:onMaxToDelMail()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMaxMailOpenTips)
local num=mailModel:get_eMailCount()
if num>=self.emailMaxCount and not flag then
self.isShowMaxTips=true
self:setTimer(0.02,1,function()
local showdata=
{
type='UIDialouge',
title='提示',
content='邮件数量已达上限，是否要删除已读且无附件的邮件？\n<color=#ca631d>（达到上限后将无法收到新邮件）</color>',
oktext='一键删除',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local mailIdList=_this:getAllDeleteList()
local hasMail=#mailIdList>0
if not hasMail then
UIManager.info('没有可删除的邮件')
return
end
mailProtocolController.req_mail_oper(eMailSendOperType.eDelete,#mailIdList,mailIdList)
UIManager.info('已删除已读无奖励邮件')
end,
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMaxMailOpenTips,flag)
end,
showclosebtn=true,
}
_this.comfirmDialog=UIDialogManager.newDialog(showdata)
_this.comfirmDialog:show()
end)
end
end

function UIMailWin:getAllDeleteList()
local mailIdList={}
for i,v in ipairs(self.mailList)do
local check=false
if v.isRead then
local hasAttach=#v.items>0
if not hasAttach then
check=true
else
if v.isPrize then
check=true
end
end
if check then
mailIdList[#mailIdList+1]=v.mailId
end
end
end
return mailIdList
end



function UIMailWin:onAllDeleteButton()
local showdata=
{
type='UIDialougeHighest',
title='一键删除',
content='将为祖师删除已读且无附件的信件',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local mailIdList=_this:getAllDeleteList()
local hasMail=#mailIdList>0
if not hasMail then
UIManager.info('没有可删除的信件')
return
end
mailProtocolController.req_mail_oper(eMailSendOperType.eDelete,#mailIdList,mailIdList)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


function UIMailWin:onAllPrizeButton()

local mailIdList={}
local finishCheckBagType_lookup={}



local hasNonEquipAttachMail=false

for _,v in ipairs(self.mailList)do
local hasAttach=#v.items>0

if hasAttach and v.isPrize==false then

local itemList=v.items
local hasEquipAttach=false
local isContinue=false
for _,item in ipairs(itemList)do
local itemId=item.itemId
local bagType=itemsConfig.getBagType(itemId)

if bagType and bagType==BAG_TYPE.eEquipBag then
hasEquipAttach=true


local isFull=finishCheckBagType_lookup[bagType]or bagHelper.isBagFull(bagType)
if isFull then
finishCheckBagType_lookup[bagType]=true
isContinue=true
break
end
end


if itemsConfig.isMoney(itemId)and moneyModel.checkMoneyOverflow(itemId,item.count)then
isContinue=true
break
end
end

if not isContinue then
mailIdList[#mailIdList+1]=v.mailId
end

if not hasEquipAttach then
hasNonEquipAttachMail=true
end
end
end


local unclaimedMailCount=0
for _,mail in ipairs(self.mailList)do
if not mail.isPrize then
unclaimedMailCount=unclaimedMailCount+1
end
end

local canPrizeMailCount=#mailIdList

local hasMail=canPrizeMailCount>0 or unclaimedMailCount>0
if not hasMail then
UIManager.error("回禀祖师，信件中已无奖励可领取")
return
end


if hasMail and finishCheckBagType_lookup[BAG_TYPE.eEquipBag]==true then
bagHelper.showTipsWhenEquipBagFull(hasNonEquipAttachMail)
end


if canPrizeMailCount>0 then
mailProtocolController.req_mail_oper(eMailSendOperType.ePrize,#mailIdList,mailIdList)
end
end


function UIMailWin:onPrizeButton()
local mailData=self.mailList[self.mailIndex]
if not mailData then
return
end


local itemList=mailData.items
local isPrize=mailData.isPrize
local finishCheckBagType_lookup={}
if isPrize==false then
for i,v in ipairs(itemList)do
local itemId=v.itemId


if itemsConfig.isMoney(itemId)and moneyModel.checkMoneyOverflow(itemId,v.count)then
return
end


local bagType=itemsConfig.getBagType(itemId)

if bagType
and bagType==BAG_TYPE.eEquipBag
and bagHelper.checkBagFull(bagType)then
return
end
end
end

mailProtocolController.req_mail_oper(eMailSendOperType.ePrize,1,{mailData.mailId})
end

function UIMailWin:onBgClose()
self:closeSelf()
end

function UIMailWin:onCloseBtn()
self:closeSelf()
end



function UIMailWin:checkStartStr(str)
local charList=string.toTable(str)
local char=charList[1]
if char==" "or char=="　"or char=="\194\160"or char=="\t"then

return str
end


local isSpecialStart=false
local specialStartList={"亲爱的","尊敬的","祖师大人"}
for i=1,#specialStartList do
local specialStr=specialStartList[i]
local targetFirstIndex=string.find(str,specialStr)
if targetFirstIndex and targetFirstIndex==1 then
isSpecialStart=true
break
end
end
if isSpecialStart then

return str
end


local startStr=FMT.fmt("\t\t{0}",str)
return startStr
end



function UIMailWin:test_setMailData(title,content)
local mailData=self.mailList[self.mailIndex]
mailData.title=title
mailData.content=content
self:refreshDetailText()
end
