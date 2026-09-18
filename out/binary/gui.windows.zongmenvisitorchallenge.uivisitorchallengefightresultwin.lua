







def_class("UIVisitorChallengeFightResultWin",UIWindowBase)









function UIVisitorChallengeFightResultWin:bindComponents()

self.Root=UIObject.get(self,0)
self.Pool=UIGameobjectClone.new(self,1)
self.conditionList=UIObject.get(self,2)
self.tgslpanel=UIObject.get(self,3)
self.headdatapanel=UIObject.get(self,4)
self.Middle=UIObject.get(self,5)
self.TitleTx=UIText.get(self,6)
self.TitleIcon=UIImage.get(self,7)
self.TextNum=UIText.get(self,8)
self.ResRoot=UIObject.get(self,9)
self.ScrollView=UIScrollView.get(self,10)
self.ResIcon=UIImage.get(self,11)
self.ResTx=UIText.get(self,12)
self.Content=UIObject.get(self,13)
self.centerTipsTx=UIText.get(self,14)
self.progressBar=UIProgress.get(self,15)
self.TipsTx=UIText.get(self,16)
self.otherpanel=UIObject.get(self,17)
self.selfpanel=UIObject.get(self,18)
self.otherimg=UIObject.get(self,19)
self.selfimg=UIObject.get(self,20)
self.otherserver=UIText.get(self,21)
self.othername=UIText.get(self,22)
self.selfserver=UIText.get(self,23)
self.headIcontwo=UIButton.get(self,24)
self.headIcon=UIButton.get(self,25)
self.shareBtn=UIButton.get(self,26)
self.selfname=UIText.get(self,27)
self.selffrightvalue=UIText.get(self,28)
self.otherfrightvalue=UIText.get(self,29)
self.tgsltxt6=UIText.get(self,30)
self.tgslpmpanel=UIObject.get(self,31)
self.tgslgobtn=UIButton.get(self,32)
self.tgsltxt7=UIText.get(self,33)
self.tgslbtn=UIButton.get(self,34)
self.tsglimg1=UIObject.get(self,35)
self.tgsltxt5=UIText.get(self,36)
self.tgsliconbg=UIObject.get(self,37)
self.tsglimg2=UIObject.get(self,38)
self.tgsltxt4=UIText.get(self,39)
self.tgsltxt2=UIText.get(self,40)
self.tgsltxt1=UIText.get(self,41)
self.tgsltxt3=UIText.get(self,42)
self.tgsltxtup2=UIObject.get(self,43)
self.tgsltxtup=UIObject.get(self,44)
self.tgsltxtup3=UIObject.get(self,45)
self.tgsltxtup4=UIObject.get(self,46)
self.tgslicon=UIImage.get(self,47)
self.tgsltxtup6=UIImage.get(self,48)
self.tgsltxtup7=UIImage.get(self,49)
self.tgslpmtxt=UIText.get(self,50)
self.tgslpmtxtup=UIObject.get(self,51)
self.tgslpmtxtup2=UIObject.get(self,52)
self.tgslpmicon=UIImage.get(self,53)
self.tgslpmicontxt=UIText.get(self,54)

self.headIcontwo:setButtonClick(function()self:onHeadIcontwo()end)

self.headIcon:setButtonClick(function()self:onHeadIcon()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.tgslgobtn:setButtonClick(function()self:onTgslgobtn()end)

self.tgslbtn:setButtonClick(function()self:onTgslbtn()end)



end


function UIVisitorChallengeFightResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.conditionList);self.conditionList=nil;
_UIObject_release(self.tgslpanel);self.tgslpanel=nil;
_UIObject_release(self.headdatapanel);self.headdatapanel=nil;
_UIObject_release(self.Middle);self.Middle=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.ResRoot);self.ResRoot=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.ResIcon);self.ResIcon=nil;
_UIObject_release(self.ResTx);self.ResTx=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.centerTipsTx);self.centerTipsTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
_UIObject_release(self.otherpanel);self.otherpanel=nil;
_UIObject_release(self.selfpanel);self.selfpanel=nil;
_UIObject_release(self.otherimg);self.otherimg=nil;
_UIObject_release(self.selfimg);self.selfimg=nil;
_UIObject_release(self.otherserver);self.otherserver=nil;
_UIObject_release(self.othername);self.othername=nil;
_UIObject_release(self.selfserver);self.selfserver=nil;
_UIObject_release(self.headIcontwo);self.headIcontwo=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.selfname);self.selfname=nil;
_UIObject_release(self.selffrightvalue);self.selffrightvalue=nil;
_UIObject_release(self.otherfrightvalue);self.otherfrightvalue=nil;
_UIObject_release(self.tgsltxt6);self.tgsltxt6=nil;
_UIObject_release(self.tgslpmpanel);self.tgslpmpanel=nil;
_UIObject_release(self.tgslgobtn);self.tgslgobtn=nil;
_UIObject_release(self.tgsltxt7);self.tgsltxt7=nil;
_UIObject_release(self.tgslbtn);self.tgslbtn=nil;
_UIObject_release(self.tsglimg1);self.tsglimg1=nil;
_UIObject_release(self.tgsltxt5);self.tgsltxt5=nil;
_UIObject_release(self.tgsliconbg);self.tgsliconbg=nil;
_UIObject_release(self.tsglimg2);self.tsglimg2=nil;
_UIObject_release(self.tgsltxt4);self.tgsltxt4=nil;
_UIObject_release(self.tgsltxt2);self.tgsltxt2=nil;
_UIObject_release(self.tgsltxt1);self.tgsltxt1=nil;
_UIObject_release(self.tgsltxt3);self.tgsltxt3=nil;
_UIObject_release(self.tgsltxtup2);self.tgsltxtup2=nil;
_UIObject_release(self.tgsltxtup);self.tgsltxtup=nil;
_UIObject_release(self.tgsltxtup3);self.tgsltxtup3=nil;
_UIObject_release(self.tgsltxtup4);self.tgsltxtup4=nil;
_UIObject_release(self.tgslicon);self.tgslicon=nil;
_UIObject_release(self.tgsltxtup6);self.tgsltxtup6=nil;
_UIObject_release(self.tgsltxtup7);self.tgsltxtup7=nil;
_UIObject_release(self.tgslpmtxt);self.tgslpmtxt=nil;
_UIObject_release(self.tgslpmtxtup);self.tgslpmtxtup=nil;
_UIObject_release(self.tgslpmtxtup2);self.tgslpmtxtup2=nil;
_UIObject_release(self.tgslpmicon);self.tgslpmicon=nil;
_UIObject_release(self.tgslpmicontxt);self.tgslpmicontxt=nil;
end















local _divTime=0.1
local this



function UIVisitorChallengeFightResultWin:onLoaded(...)
this=self
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIVisitorChallengeFightResultWin:__delete()
self:unbindComponents()
end




function UIVisitorChallengeFightResultWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}

self.battleId=self.argtable.battleId

local title=self.argtable.title
if title then
self.TitleTx:setActive(title.text~=nil)
if title.text then self.TitleTx:setText(title.text)end
self.TitleIcon:setActive(title.icon~=nil)
if title.icon then self.TitleIcon:setSprite(title.icon.abName,title.icon.assetName)end
self.TextNum:setActive(title.num~=nil)
if title.num then self.TextNum:setText(title.num)end
else
self.TitleTx:setActive(true)
self.TitleTx:setText("<color=#7D3B17>获得物品</color>")
end

local progressData=self.argtable.progress
self.progressBar:setActive(progressData~=nil)
if progressData then
self.progressBar:setProgressValue(math.floor(progressData[1]/progressData[2]*10000),10000)
if progressData[3]then
self:delayDo(2,function()
self.progressBar:setProgress(math.floor(progressData[3]/progressData[2]*10000),10000)
end)
end
end

local money=self.argtable.money
self.ResRoot:setActive(money~=nil)
if money then
self.ResIcon:setActive(money.icon~=nil)
if money.icon then self.ResIcon:setSprite(money.icon.abName,money.icon.assetName)end
self.ResTx:setActive(money.text~=nil)
if money.text then self.ResTx:setText(money.text)end
end

local items=self.argtable.items
if items then
table.sort(items,function(a,b)
return a.sortWeight>b.sortWeight
end)

local cnt=#items
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*90+8,100)
if cnt<=7 then
self.Content:setAnchors(0.5,1,0.5,1)
end
local config={}

for i,v in ipairs(items)do
v.conf={showname=false}
local singleInfo={}
singleInfo.name='UIShowPrizeChildItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.delay=0.8+_divTime*(i-1)
singleInfo.args=v
config[#config+1]=singleInfo

end
self.Pool:createObjectList(config)
end


local headdata=self.argtable.headdata_param
this.headdata_param=self.argtable.headdata_param
if headdata and#headdata>0 then

self.headdatapanel:setActive(true)
self.TitleTx:setActive(false)
local headParams_self
headParams_self={iconInfo=headdata[3],scale=0.8}
playerController:setHeadIcon(self.winlua,self.headIcon:getID(),headParams_self)
self.selfname:setText(headdata[8])
local serverName=loginModel:getServerName(headdata[2])
local str=FMT.fmt('[{0}]',serverName)
self.selfserver:setText(str)

local headParams
headParams={iconInfo=headdata[6],scale=0.8}
playerController:setHeadIcon(self.winlua,self.headIcontwo:getID(),headParams)
self.othername:setText(headdata[7]or'')
local otherserverName=loginModel:getServerName(headdata[5])
local otherstr=FMT.fmt('[{0}]',otherserverName)
self.otherserver:setText(otherstr)
self.shareBtn:setActive(headdata[9])


local selfFright=headdata[10]
local otherFright=headdata[11]
if selfFright then
local value=mathHelper.int64_to_number(selfFright)
self.selfpanel:setActive(true)
self.selffrightvalue:setText(mathHelper.formatNumber(value))
else
self.selfpanel:setActive(false)
end
if otherFright then
local value=mathHelper.int64_to_number(otherFright)
self.otherpanel:setActive(true)
self.otherfrightvalue:setText(mathHelper.formatNumber(value))
else
self.otherpanel:setActive(false)
end
end


local challengeId=zmvisitchallengeModel:getVisitorChallengeId()
local levelId=self.argtable.data.pass_id
local result=self.argtable.data.fight_res
local conditionStrList=cfgHelper.get3(cfg_visitorchallengelayerconfig_get,challengeId,levelId,'targettrlist')
self.conditionList:setChildLayoutGroupCreateItems(#conditionStrList,function(index)
local item=self.conditionList:getChildLayoutGroupGridItem(index-1)
local conditionStr=conditionStrList[index][1]
item:SetChildText(0,conditionStr)
item:SetChildActive(1,result==1)
item:SetChildActive(2,result==0)
end)
end


function UIVisitorChallengeFightResultWin:onHide()

end



