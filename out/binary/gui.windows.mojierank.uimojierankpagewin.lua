







def_class("UIMoJieRankPageWin",UIWindowBase)









function UIMoJieRankPageWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.titleText=UIText.get(self,2)
self.btnClose=UIButton.get(self,3)
self.back=UIObject.get(self,4)
self.infoPanel=UIObject.get(self,5)
self.descScrollView=UIObject.get(self,6)
self.descContent=UIObject.get(self,7)
self.desc=UIText.get(self,8)
self.adaptation=UIObject.get(self,9)
self.gainScrollerView=UIObject.get(self,10)
self.jfbtn=UIButton.get(self,11)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.jfbtn:setButtonClick(function()self:onJfbtn()end)



end


function UIMoJieRankPageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.descContent);self.descContent=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.adaptation);self.adaptation=nil;
_UIObject_release(self.gainScrollerView);self.gainScrollerView=nil;
_UIObject_release(self.jfbtn);self.jfbtn=nil;
end
















local _this
local gainItemCmpIndex={
icon=0,
name=1,
lockImg=2,
goBtn=3,
bg=4,
garyImg=5,
state=6,
selectBg=7,
specialBg=8,
}



function UIMoJieRankPageWin:onLoaded(...)
self:bindComponents()
_this=self
self.gainScrollerView:setChildScrollViewInit(-1,true,nil,nil)
self.descScrollHeight=self.winlua:GetChildSizeDeltaY(self.descScrollView:getID())
end


function UIMoJieRankPageWin:__delete()
self:unbindComponents()
_this=nil
end


function UIMoJieRankPageWin:onJfbtn()
if self.rankType then
self:showWindow('UIMoJieRankRuleWin_New',{rankType=self.rankType})
elseif self.tips then

UIManager:showWindow('UIRuleWin',self.tips)
end
end




function UIMoJieRankPageWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.infoPanel:setChildCanvasGroupAlpha(0)
self.back:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,nil)
end
self.rankType=argtable.rankType
self.tips=argtable.tips

local func=function()
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)
end
self:delayDo(0.3,func)


local titleName=argtable.titleName or'提升排名'
self.titleText:setText(titleName)


local goodDesc=argtable.goodDesc
self.desc:setText(goodDesc)

local showList=argtable.showList
self:refreshGainList(showList)
end


function UIMoJieRankPageWin:onHide()

end

function UIMoJieRankPageWin:onCloseClick()
self:closeSelf()
end
function UIMoJieRankPageWin:onBtnClose()
self:onCloseClick()
end


function UIMoJieRankPageWin:getSortList(showList)
local list={}
for k,data in ipairs(showList)do
local jump=data.jump
local lock=data.lock
local canjump,dojump,tips=self:checkJump(jump,lock)
local sort=canjump and 0 or 1
local weight=k+sort*1000
table.insert(list,{info=data,canjump=canjump,dojump=dojump,tips=tips,weight=weight})
end
if#list>1 then
table.sort(list,function(a,b)
return a.weight<b.weight
end)
end
return list
end


function UIMoJieRankPageWin:refreshGainList(ShowList)
local showList=self:getSortList(ShowList)

self.gainScrollerView:setChildScrollViewCreateGrids(#showList,1)
local grids=self.gainScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local item=grids[i-1]
local data=showList[i]
local info=data.info
local jump=info.jump
local hasJump=jump~=nil
item:SetChildText(gainItemCmpIndex.name,info.desc)
item:SetChildActive(gainItemCmpIndex.bg,true)

local canjump=data.canjump
local dojump=data.dojump
local tips=data.tips

if hasJump then
if canjump then
item:SetChildActive(gainItemCmpIndex.goBtn,true)
item:SetChildActive(gainItemCmpIndex.lockImg,false)
else
item:SetChildActive(gainItemCmpIndex.goBtn,false)
item:SetChildActive(gainItemCmpIndex.lockImg,true)
end
else
item:SetChildActive(gainItemCmpIndex.goBtn,false)
item:SetChildActive(gainItemCmpIndex.lockImg,false)
end

local clickBgFun=function(...)
if _this==nil then return end
if hasJump then
if canjump then
jumpManager:jump(dojump)
else
UIManager.info(tips)
end
else
logErr('没有配置跳转')
end
end
item:SetChildButtonClick(gainItemCmpIndex.bg,clickBgFun)
item:SetChildActive(gainItemCmpIndex.state,false)
item:SetChildActive(gainItemCmpIndex.specialBg,false)

item:SetChildActive(gainItemCmpIndex.garyImg,false)
end
end


function UIMoJieRankPageWin:checkJump(jump,lock)
local parem=lock
if not parem then
return true,jump,''
end
local id=parem[1]
local tips=''

if id==1 then
local devildom_stage=parem[2]
tips=parem[3]

local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local nowTime=timeHelper.getServerShortTime()
if nowTime<enterData.eTime then
local csid=xianjieModel:getMoJieEnterConfig("csid")
if csid and seasonController:checkSeasonStageBegined(csid,devildom_stage)then
return true,jump,tips
end
end
end
elseif id==2 then
local devildom_stage=parem[2]
local jieduan=parem[3]
tips=parem[4]

local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local nowTime=timeHelper.getServerShortTime()
if nowTime<enterData.eTime then
local csid=xianjieModel:getMoJieEnterConfig("csid")
if csid and seasonController:checkSeasonStageBegined(csid,devildom_stage)then
local State=xianjieModel:getMoJunState()
if State and jieduan==State then
return true,jump,tips
end
end
end
end

elseif id==3 then
local devildom_stage=parem[2]
tips=parem[3]

local chapteridx=xianjieController:getMoJieSaiJiChapteridx()
if chapteridx and devildom_stage==chapteridx then
return true,jump,tips
end

elseif id==4 then
local devildom_stage=parem[2]
tips=parem[3]

local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local nowTime=timeHelper.getServerShortTime()
if nowTime<enterData.eTime then
local csid=xianjieModel:getMoJieEnterConfig("csid")
if csid and seasonController:checkSeasonStageBegined(csid,devildom_stage)then
tips=parem[4]

local selfXyGateList=xianjieModel:getMoJieGateIdListWithSelfXianYu()
if selfXyGateList then
for _,gateId in ipairs(selfXyGateList)do
local ownXmGuid=xianjieModel:getMoJieGateOwnXmGuid(gateId)
if not ownXmGuid then
local jump2={id=9702,args={gateid=gateId}}
return true,jump2,tips
end
end
end
end
end
end
end
return false,jump,tips
end
