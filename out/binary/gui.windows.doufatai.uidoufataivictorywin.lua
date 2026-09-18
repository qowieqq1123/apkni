







def_class("UIDouFaTaiVictoryWin",UIWindowBase)









function UIDouFaTaiVictoryWin:bindComponents()

self.Pool=UIGameobjectClone.new(self,0)
self.rankChange=UIText.get(self,1)
self.rank=UIText.get(self,2)
self.changeImg=UIObject.get(self,3)
self.ryValueMax=UIText.get(self,4)
self.continueButton=UIButton.get(self,5)
self.quitButton=UIButton.get(self,6)
self.wendaoIcon=UIImage.get(self,7)
self.wendaoText=UIText.get(self,8)
self.Content=UIObject.get(self,9)
self.honorIcon=UIImage.get(self,10)
self.honorText=UIText.get(self,11)
self.ScrollView=UIScrollView.get(self,12)

self.continueButton:setButtonClick(function()self:onContinueButton()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)



end


function UIDouFaTaiVictoryWin:unbindComponents()
local _UIObject_release=UIObject.release
self.Pool:deleteSelf();self.Pool=nil;
_UIObject_release(self.rankChange);self.rankChange=nil;
_UIObject_release(self.rank);self.rank=nil;
_UIObject_release(self.changeImg);self.changeImg=nil;
_UIObject_release(self.ryValueMax);self.ryValueMax=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.wendaoIcon);self.wendaoIcon=nil;
_UIObject_release(self.wendaoText);self.wendaoText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.honorIcon);self.honorIcon=nil;
_UIObject_release(self.honorText);self.honorText=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end


















local _divTime=0.08

function UIDouFaTaiVictoryWin:onLoaded(...)
self:bindComponents()
local _onClickItemCallBack=function(...)
self:onClickItemCallBack(...)
end
self.ScrollView:setClickAction(_onClickItemCallBack)
end


function UIDouFaTaiVictoryWin:__delete()
self:unbindComponents()
end




function UIDouFaTaiVictoryWin:onShow(argtable,afterOnloaded)
local wendao=argtable[1]
local honor=argtable[2]
local dailyHonor=argtable[3]
local newRank=argtable[4]
local rewardsLen=argtable[5]
local rewards=argtable[6]
local actorId=argtable[7]
local shareStr=argtable[8]
local battleId=argtable[9]

self.shareStr=shareStr
self.battleId=battleId

local lastData=douFaTaiModel:getLastData()
local lastRank=lastData.rank

local change=math.abs(lastRank-newRank)
self.rank:setText(FMT.fmt('排名：{0}',newRank))
self.changeImg:setActive(lastRank>0 and change~=0)
self.rankChange:setText(change)

local curWenDao=lastData.wendao
local wendaoIconName=douFaTaiModel:getWenDaoIconName()
self.wendaoIcon:setImageIcon(wendaoIconName,false)
local wendaoStr=''
if wendao>0 then
wendaoStr=FMT.fmt('{0}<color=green>（+{1}）</color>',curWenDao,wendao)
else
wendaoStr=curWenDao
end
self.wendaoText:setText(wendaoStr)

local config=douFaTaiModel:getDouFaTaiBasicConfig()
local maxHonor=config.max_honor
local honorId=maxHonor[1]

local honorIconName=iconHelper.getIconName(honorId)
self.honorIcon:setImageIcon(honorIconName,false)

local honorToday=douFaTaiModel:get_honorToday()
local honorStr=''
if honor>0 then
honorStr=FMT.fmt('<color=green>+{0}</color>（{1}/{2}）',honor,dailyHonor,maxHonor[2])
else
honorStr='已达获取上限'
end



self.ryValueMax:setActive(honorToday>=maxHonor[2])


self.honorText:setText(honorStr)
douFaTaiModel:set_tempHonorToday()

if rewardsLen>0 then

for i,v in ipairs(rewards)do
v.itemcount=v.num

end
end


self.items=rewards
if self.items then
local propData={}
for i,v in ipairs(self.items)do
table.insert(propData,itemsComponentHelper.getCommonFillData(v,{showname=false,showStageBg=true,showCountBG=true}))
end
local propDataCnt=#propData










self.winlua:SetChildSizeDelta(self.Content:getID(),propDataCnt*90+8,100)
if propDataCnt<=7 then
self.Content:setAnchors(0.5,1,0.5,1)
end
local c={}
for i,v in ipairs(self.items)do
v.conf={showname=false}
local singleInfo={}
singleInfo.name='UIShowPrizeChildItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.delay=0.5+_divTime*(i-1)
singleInfo.args=v
c[#c+1]=singleInfo

end
self.Pool:createObjectList(c)
end

self.quitButton:setActive(false)
self.continueButton:setActive(false)
end


function UIDouFaTaiVictoryWin:onHide()

end

function UIDouFaTaiVictoryWin:onClickItemCallBack(id,index,guid,attach)
local item=self.items[index]
tipsManager.showTips({itemid=item.itemid,itemguid=item.itemguid})
end



function UIDouFaTaiVictoryWin:onQuitButton()
douFaTaiController.closeBattle(self.battleId)
end

function UIDouFaTaiVictoryWin:onContinueButton()
if self.shareStr then
local str=self.shareStr
local ret=chatControl.reqPublicMesg(CHAT_CHANNNEL.eWorld,str)
if ret~=nil then
UIManager.info('分享成功')
end
else
UIManager.error('分享失败')
end
douFaTaiController.closeBattle(self.battleId)
end
