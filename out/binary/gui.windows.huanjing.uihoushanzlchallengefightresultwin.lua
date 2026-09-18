







def_class("UIHouShanZLChallengeFightResultWin",UIWindowBase)









function UIHouShanZLChallengeFightResultWin:bindComponents()

self.Root=UIObject.get(self,0)
self.Pool=UIGameobjectClone.new(self,1)
self.Middle=UIObject.get(self,2)
self.Botton=UIObject.get(self,3)
self.TitleIcon=UIImage.get(self,4)
self.TextNum=UIText.get(self,5)
self.TitleTx=UIText.get(self,6)
self.ResRoot=UIObject.get(self,7)
self.ScrollView=UIScrollView.get(self,8)
self.ResIcon=UIImage.get(self,9)
self.ResTx=UIText.get(self,10)
self.Content=UIObject.get(self,11)
self.progressBar=UIProgress.get(self,12)
self.centerTipsTx=UIText.get(self,13)
self.TipsTx=UIText.get(self,14)
self.sdTip=UILinkImageText.get(self,15)
self.backBtn=UIButton.get(self,16)
self.nextBtn=UIButton.get(self,17)
self.nextBtnTxt=UILinkImageText.get(self,18)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)



end


function UIHouShanZLChallengeFightResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.Middle);self.Middle=nil;
_UIObject_release(self.Botton);self.Botton=nil;
_UIObject_release(self.TitleIcon);self.TitleIcon=nil;
_UIObject_release(self.TextNum);self.TextNum=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.ResRoot);self.ResRoot=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.ResIcon);self.ResIcon=nil;
_UIObject_release(self.ResTx);self.ResTx=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.centerTipsTx);self.centerTipsTx=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
_UIObject_release(self.sdTip);self.sdTip=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.nextBtnTxt);self.nextBtnTxt=nil;
end















local _divTime=0.1
local this



function UIHouShanZLChallengeFightResultWin:onLoaded(...)
self:bindComponents()
this=self
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIHouShanZLChallengeFightResultWin:__delete()
self:unbindComponents()
end




function UIHouShanZLChallengeFightResultWin:onShow(argtable,afterOnloaded)
self.argtable=argtable or{}
self.data=self.argtable.data or{}
self.battleId=self.argtable.battleId
self.type=self.data.zlType
self.layer=self.data.layer
self.state=self.argtable.state

self.isCanNext=false

self.TitleTx:setActive(true)
self.TitleTx:setText("<color=#7D3B17>获得物品</color>")

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

self:refresh()
end

function UIHouShanZLChallengeFightResultWin:refresh()


local isGray
local tip
local btntxt
if self.state==1 then
local state=UIHuanJingControl:getLayerState(self.type,self.layer+1)
isGray=state~=HouShanZhenLingLayerStateList.Challenge
if state==HouShanZhenLingLayerStateList.FinishAll then
tip='所有关卡已挑战完成'
end
btntxt='继续挑战'
elseif self.state==2 then
local state=UIHuanJingControl:checkSdCondition(self.type,self.layer)
isGray=false
local sdUse=cfgHelper.get3(cfg_houshanzhenlingjiecengconfig_get,self.type,self.layer,'sdUse')
local itemName=itemsConfig.getItemName(sdUse[1])
local itemNum=itemsModel.getCount(sdUse[1])
local itemIconName=iconHelper.getIconName(sdUse[1])
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,30)
local sdUseStr=itemNum>=sdUse[2]and sdUse[2]or toColorString(FONT_COLOR.eRedColor,sdUse[2])

btntxt=FMT.fmt("继续({0} {1})",sdUseStr,iconStr)
local content="{0}:{1} {2}"
tip=FMT.fmt(content,itemName,itemNum,iconStr)








end
self.backBtn:setActive(self.state~=1)
self.nextBtn:setActive(self.state~=1)
self.nextBtn:setButtonEnable(not isGray,isGray)
self.nextBtnTxt:setText(btntxt)
self.sdTip:setActive(tip~=nil)
if tip then
self.sdTip:setText(tip)
end
end


function UIHouShanZLChallengeFightResultWin:onHide()

end





function UIHouShanZLChallengeFightResultWin:onBackBtn()
UIManager:invokeUIMethod(self.argtable.parentWin,'onCloseTips')
end



function UIHouShanZLChallengeFightResultWin:onNextBtn()

if self.isCanNext then return end

if self.state==1 then


if UIHuanJingControl:getLayerState(self.type,self.layer+1)~=HouShanZhenLingLayerStateList.Challenge then
return
end

local type=self.type
local layer=self.layer

local func=function()
UIHuanJingControl:doNextFight(type,layer+1)
loadingControl.closeCloud()
end
loadingControl.openCloud(func,1.5)
else

UIHuanJingControl:doSaoDang(self.type,self.layer)
end
end

