







def_class("UIXianGuanWenXuanVoteTipsWin",UIWindowBase)









function UIXianGuanWenXuanVoteTipsWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.desc=UIText.get(self,2)
self.moneyRoot1=UIObject.get(self,3)
self.moneyRoot2=UIObject.get(self,4)
self.okBtn=UIButton.get(self,5)
self.root=UIObject.get(self,6)
self.sliderPanel_1=UIObject.get(self,7)
self.sliderPanel_2=UIObject.get(self,8)
self.title=UIText.get(self,9)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)
self.sliderPanel={
self.sliderPanel_1,
self.sliderPanel_2,
}



end


function UIXianGuanWenXuanVoteTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.moneyRoot1);self.moneyRoot1=nil;
_UIObject_release(self.moneyRoot2);self.moneyRoot2=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sliderPanel_1);self.sliderPanel_1=nil;
_UIObject_release(self.sliderPanel_2);self.sliderPanel_2=nil;
_UIObject_release(self.title);self.title=nil;
self.sliderPanel=nil;
end
















local ComSliderIndex={
slider=0,
handleImg=1,
selectCntText=2,
subBtn=3,
addBtn=4,
name=5,
subImg=6,
addImg=7,
icon=8,
iconBg=9,
}




function UIXianGuanWenXuanVoteTipsWin:onLoaded(...)
self:bindComponents()
self._onItemListChanged=function(...)self:onItemListChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self._onItemListChanged)
end


function UIXianGuanWenXuanVoteTipsWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_list_changed,self._onItemListChanged)
end




function UIXianGuanWenXuanVoteTipsWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.curJobId=argtable.job
self.actorId=argtable.actorId
self.vote=argtable.vote
self.actorName=argtable.actorName

self.minList={}
self.maxList={}
self.valList={}

local config=xianguanController:getJingXuanConfig(XianGuanCampaignType.eWenXuan)
local wxData=xianguanModel:getWenXuanData()
local free_max
local itemid
local free_nameStr
local free_iconname
if self.vote==1 then
local use_vote_agree_num=wxData and wxData.use_vote_agree_num or 0
free_max=config.free_vote_agree-use_vote_agree_num
itemid=config.item_vote_agree
free_nameStr="支持票"
free_iconname="image_dianzan_1"
else
local use_vote_against_num=wxData and wxData.use_vote_against_num or 0
free_max=config.free_vote_against-use_vote_against_num
itemid=config.item_vote_against
free_nameStr="反对票"
free_iconname="image_dianzan_2"
end
self.itemid=itemid
local itemCount=bagModel.getNotExpireItemCountById(itemid)
local iconName=iconHelper.getIconName(itemid)
for i=1,2 do
local widget=self.sliderPanel[i]:getChildWidgetBase()
local max=0
local nameStr
if i==1 then
max=free_max
nameStr=free_nameStr
else
max=itemCount
nameStr=itemsConfig.getItemName(itemid)
end

self.minList[i]=0
self.maxList[i]=max
self.valList[i]=i==1 and max or 0
local lock=max<=0

widget:SetChildText(ComSliderIndex.name,nameStr)
widget:SetChildActive(ComSliderIndex.iconBg,i==1)
if i==1 then
widget:SetChildCSImageSprite(ComSliderIndex.icon,globalABLookup.xianguanJingXuan,free_iconname)
else
widget:SetChildIcon(ComSliderIndex.icon,iconName,true)
end

widget:SetChildImageRaycast(ComSliderIndex.handleImg,not lock)
widget:SetChildSliderInit(ComSliderIndex.slider,self.valList[i],self.minList[i],self.maxList[i],function(val)
self.valList[i]=val
self:onSelect(widget,i)
self:freshInfo()
end)
widget:SetChildButtonClick(ComSliderIndex.subBtn,function()
if lock or self.valList[i]<=self.minList[i]then
UIManager.error('已达到最小值')
return
end
self.valList[i]=self.valList[i]-1
widget:SetChildSliderValue(ComSliderIndex.slider,self.valList[i])
self:onSelect(widget,i)
self:freshInfo()
end)
widget:SetChildButtonClick(ComSliderIndex.addBtn,function()
if lock or self.valList[i]>=self.maxList[i]then
UIManager.error('数量不足')
return
end
self.valList[i]=self.valList[i]+1
widget:SetChildSliderValue(ComSliderIndex.slider,self.valList[i])
self:onSelect(widget,i)
self:freshInfo()
end)
end
local widget1=self.winlua:GetChildWidgetBase(self.moneyRoot1:getID())
widget1:SetChildCSImageSprite(0,globalABLookup.xianguanJingXuan,free_iconname)
widget1:SetChildText(1,free_max)
widget1:SetChildActive(3,false)

local widget2=self.winlua:GetChildWidgetBase(self.moneyRoot2:getID())
widget2:SetChildIcon(0,iconName,false)
widget2:SetChildText(1,itemCount)
widget2:SetChildActive(3,true)
widget2:SetChildButtonClick(2,function()
gainControl:showGainWin(itemid)
end)
end


function UIXianGuanWenXuanVoteTipsWin:onHide()

end

function UIXianGuanWenXuanVoteTipsWin:freshInfo()
local totleVal=0
for i,val in ipairs(self.valList)do
totleVal=totleVal+val
end

local str
if self.vote==1 then

str="投<color=#7d3b17>{0}</color>张<color=#7d3b17>支持票</color>，助力<color=#549327>{1}</color>登临仙位"
else
str="投<color=#7d3b17>{0}</color>张<color=#7d3b17>反对票</color>，斩断<color=#549327>{1}</color>的仙官之路"
end
self.desc:setText(FMT.fmt(str,totleVal,self.actorName))
end

function UIXianGuanWenXuanVoteTipsWin:onSelect(widget,i)
local val=self.valList[i]
local min=self.minList[i]
local max=self.maxList[i]
widget:SetChildText(ComSliderIndex.selectCntText,val)

widget:SetChildGray(ComSliderIndex.subImg,val<=min)
widget:SetChildGray(ComSliderIndex.addImg,val>=max)
end

function UIXianGuanWenXuanVoteTipsWin:onItemListChanged(list)
if list==nil then return end

for i,v in ipairs(list)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]

if self.itemid==itemid then
local itemCount=bagModel.getNotExpireItemCountById(itemid)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot2:getID())
widget:SetChildText(1,itemCount)
break
end
end
end





function UIXianGuanWenXuanVoteTipsWin:onBackground()
self:onCloseBtn()
end



function UIXianGuanWenXuanVoteTipsWin:onCloseBtn()
if self.parentwin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end



function UIXianGuanWenXuanVoteTipsWin:onOkBtn()
if self.valList[1]==0 and self.valList[2]==0 then
UIManager.error("请选择投票数量")
return
end
xianguanController:req_send_40_8(self.actorId,self.vote,self.valList[1],self.valList[2],{officerId=self.curJobId})
self:onCloseBtn()
end

