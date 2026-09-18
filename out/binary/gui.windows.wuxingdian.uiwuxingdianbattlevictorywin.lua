







def_class("UIWuXingDianBattleVictoryWin",UIWindowBase)









function UIWuXingDianBattleVictoryWin:bindComponents()

self.Pool=UIGameobjectClone.new(self,0)
self.ResIcon=UIImage.get(self,1)
self.ResTx=UIText.get(self,2)
self.ResRoot=UIObject.get(self,3)
self.ScrollView=UIScrollView.get(self,4)
self.otherserver=UIText.get(self,5)
self.othername=UIText.get(self,6)
self.selfserver=UIText.get(self,7)
self.selfname=UIText.get(self,8)
self.shareBtn=UIButton.get(self,9)
self.headIcontwo=UIButton.get(self,10)
self.headIcon=UIButton.get(self,11)
self.Middle=UIObject.get(self,12)
self.headdatapanel=UIObject.get(self,13)
self.centerTipsTx=UIText.get(self,14)
self.TipsTx=UIText.get(self,15)
self.progressBar=UIProgress.get(self,16)
self.TextNum=UIText.get(self,17)
self.TitleIcon=UIImage.get(self,18)
self.TitleTx=UIText.get(self,19)
self.Content=UIObject.get(self,20)
self.stars_1=UIObject.get(self,21)
self.stars_2=UIObject.get(self,22)
self.stars_3=UIObject.get(self,23)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.headIcontwo:setButtonClick(function()self:onHeadIcontwo()end)

self.headIcon:setButtonClick(function()self:onHeadIcon()end)
self.stars={
self.stars_1,
self.stars_2,
self.stars_3,
}



end


function UIWuXingDianBattleVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.ResIcon);self.ResIcon=nil;
_UIObject_release(self.ResTx);self.ResTx=nil;
_UIObject_release(self.ResRoot);self.ResRoot=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.otherserver);self.otherserver=nil;
_UIObject_release(self.othername);self.othername=nil;
_UIObject_release(self.selfserver);self.selfserver=nil;
_UIObject_release(self.selfname);self.selfname=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.headIcontwo);self.headIcontwo=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.Middle);self.Middle=nil;
_UIObject_release(self.headdatapanel);self.headdatapanel=nil;
_UIObject_release(self.centerTipsTx);self.centerTipsTx=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.stars_1);self.stars_1=nil;
_UIObject_release(self.stars_2);self.stars_2=nil;
_UIObject_release(self.stars_3);self.stars_3=nil;
self.stars=nil;
end


















local _divTime=0.1
local this


function UIWuXingDianBattleVictoryWin:onLoaded(...)
this=self
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIWuXingDianBattleVictoryWin:__delete()
self:unbindComponents()
end





























function UIWuXingDianBattleVictoryWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}
local starTag=argtable.starTag or 0
local wxdId=argtable.wxdId
local layer=argtable.layer

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

local tips=self.argtable.tips
self.TipsTx:setText(tips or"")

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
self.centerTipsTx:setText(items and#items>0 and''or'当前层数已通关，无法再次获得奖励')


local headdata=self.argtable.headdata_param
this.headdata_param=self.argtable.headdata_param
if headdata and#headdata>0 then

self.headdatapanel:setActive(true)
self.TitleTx:setActive(false)
local headParams_self
headParams_self={iconInfo=headdata[3],scale=0.8}
playerController:setHeadIcon(self.winlua,self.headIcon:getID(),headParams_self)
self.selfname:setText(headdata[8])
local serverName=loginModel:getServerName(headdata[2],true)
local str=FMT.fmt('[{0}]',serverName)
self.selfserver:setText(str)

local headParams
headParams={iconInfo=headdata[6],scale=0.8}
playerController:setHeadIcon(self.winlua,self.headIcontwo:getID(),headParams)
self.othername:setText(headdata[7]or'')
local otherserverName=loginModel:getServerName(headdata[5],true)
local otherstr=FMT.fmt('[{0}]',otherserverName)
self.otherserver:setText(otherstr)
self.shareBtn:setActive(headdata[9])
end

local stardesc=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'stardesc')
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local target_condition=layerCfg.target_condition or{}
for i=1,3 do
local targetInfo=target_condition[i]
self.stars[i]:setActive(targetInfo~=nil)
if targetInfo~=nil then
local targetType=targetInfo[1]
local desc=stardesc[targetType]
if#targetInfo>1 then
local t=table.getRange(targetInfo,2)
desc=FMT.fmt(desc,unpack(t))
end
local widget=self.stars[i]:getChildWidgetBase()
local pass=mathHelper.getBitValue(starTag,i-1)
widget:SetChildActive(0,pass)
widget:SetChildText(1,desc)
end
end
end


function UIWuXingDianBattleVictoryWin:onHide()

end




function UIWuXingDianBattleVictoryWin:onHeadIcon()

end
function UIWuXingDianBattleVictoryWin:onHeadIcontwo()

end

function UIWuXingDianBattleVictoryWin:onShareBtn()
UIManager:showWindow('UIShareQieCuoInfoWin',{guid=self.disciple_guid,headdata=this.headdata_param,result=1,zhanbao=nil})
end
