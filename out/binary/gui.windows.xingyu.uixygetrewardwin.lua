







def_class("UIXYGetRewardWin",UIWindowBase)









function UIXYGetRewardWin:bindComponents()

self.icon=UIImage.get(self,0)
self.colorFlag=UIImage.get(self,1)
self.nameImg=UIImage.get(self,2)
self.result=UIText.get(self,3)
self.rewardView=UIObject.get(self,4)
self.rewardList=UIObject.get(self,5)
self.bgModel=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.detailBtn=UIButton.get(self,8)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)



end


function UIXYGetRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.colorFlag);self.colorFlag=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.result);self.result=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
end















local abName="ui/windows/xingyu/xingyu_atlas_pak.ab"



function UIXYGetRewardWin:onLoaded(...)
self:bindComponents()
self.bgModel:setChildUIModelShowTarget(5654,1,nil,eAnimationID.enter,false,false,0,function()
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end)
end


function UIXYGetRewardWin:__delete()
self:unbindComponents()
end




function UIXYGetRewardWin:onShow(argtable,afterOnloaded)

local xyId=argtable.xyId
self.xyId=xyId
self.rtype=argtable.rtype
local allRewardList=argtable.itemList
local teamList=argtable.teamList

local xyCfg=XingYuModel:getXingYuConfig(xyId)
local jsIconAssest=xyCfg.jsIconAssest
local jsColorAssest=xyCfg.jsColorAssest
local nameiconAssest=xyCfg.nameiconAssest
self.icon:setSprite(abName,jsIconAssest)
self.colorFlag:setSprite(abName,jsColorAssest)
self.nameImg:setSprite(abName,nameiconAssest)

local tipsStr=""
local gjFlag
local maxHzWin,maxHzFail,maxZdzWin,maxZdzFail=0,0,0,0
for i,xingyuTeam in ipairs(teamList or{})do
if xingyuTeam.zdzfail==0 and xingyuTeam.zdzwin>0 then
gjFlag=true
break
end
if maxHzWin<xingyuTeam.hzqwin then
maxHzWin=xingyuTeam.hzqwin
end
if maxHzFail<xingyuTeam.hzqfail then
maxHzFail=xingyuTeam.hzqfail
end
if maxZdzWin<xingyuTeam.zdzwin then
maxZdzWin=xingyuTeam.zdzwin
end
if maxZdzFail<xingyuTeam.zdzfail then
maxZdzFail=xingyuTeam.zdzfail
end
end


if gjFlag then
tipsStr="获得争夺战<color=#f1ce78>第1名</color>"
else
if maxZdzWin>0 or maxZdzFail>0 then

tipsStr=FMT.fmt("<color=#f1ce78>第{0}轮</color>  争夺惜败",maxZdzFail)
else

tipsStr=FMT.fmt("<color=#f1ce78>第{0}轮</color>  混战惜败",maxHzFail)
end
end

self.result:setText(tipsStr)

self.rewardList:setChildLayoutGroupCreateItems(#allRewardList,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=allRewardList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)
end


function UIXYGetRewardWin:onHide()

end




function UIXYGetRewardWin:onCloseBtn()
XingYuController.req_35_108(self.rtype,self.xyId)
self:closeSelf()
end

function UIXYGetRewardWin:onDetailBtn()
local args={}
local xyId=self.xyId
args.xyId=xyId
local teamList,zdzTeamNum,hzTeamNum
local guidList
if self.rtype==1 then
teamList=XingYuModel:getLastXingYuData_teamList(xyId)


guidList=XingYuModel:getLastXingYuData_teamGuidList(xyId)
else
teamList=XingYuModel:getXingYuData_teamList(xyId)


guidList=XingYuModel:getXingYuData_teamGuidList(xyId)
end

local hzList={}
local zdList={}

















for i,xingyuTeam in ipairs(teamList or{})do
local teamp={}
teamp.teamIndex=xingyuTeam.index
teamp.guidList=guidList and guidList[teamp.teamIndex]or nil

if xingyuTeam.zdzfail~=0 then
teamp.isWin=false
teamp.showRound=xingyuTeam.zdzfail
table.insert(zdList,teamp)
elseif xingyuTeam.hzqfail~=0 then
teamp.isWin=false
teamp.showRound=xingyuTeam.hzqfail
table.insert(hzList,teamp)
elseif xingyuTeam.tsevtResult~=2 and xingyuTeam.glttFlag~=1 then
teamp.isWin=true
teamp.isGJ=true
teamp.showRound=xingyuTeam.zdzWin
table.insert(zdList,teamp)
else

end


















end


args.hzList=hzList
args.zdList=zdList
UIManager:showWindow("UIXYTeamStateChangeWin",args)
end
