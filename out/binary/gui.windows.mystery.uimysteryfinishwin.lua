







def_class("UIMysteryFinishWin",UIWindowBase)









function UIMysteryFinishWin:bindComponents()

self.root=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.effectgrid=UIObject.get(self,2)
self.maskClick=UIButton.get(self,3)
self.model=UIObject.get(self,4)
self.btnRoot=UIObject.get(self,5)
self.failClick=UIButton.get(self,6)
self.targetRoot=UIObject.get(self,7)
self.eventTips=UIText.get(self,8)
self.titleRoot=UIObject.get(self,9)
self.ListPanel=UIObject.get(self,10)
self.effectName=UIObject.get(self,11)
self.continueButton=UIButton.get(self,12)
self.finishButton=UIButton.get(self,13)

self.maskClick:setButtonClick(function()self:onMaskClick()end)

self.failClick:setButtonClick(function()self:onFailClick()end)

self.continueButton:setButtonClick(function()self:onContinueButton()end)

self.finishButton:setButtonClick(function()self:onFinishButton()end)



end


function UIMysteryFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effectgrid);self.effectgrid=nil;
_UIObject_release(self.maskClick);self.maskClick=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.btnRoot);self.btnRoot=nil;
_UIObject_release(self.failClick);self.failClick=nil;
_UIObject_release(self.targetRoot);self.targetRoot=nil;
_UIObject_release(self.eventTips);self.eventTips=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.effectName);self.effectName=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.finishButton);self.finishButton=nil;
end



















local modelId=2059

local listPos={0,-46}
local gridSize={92,92}

local timeAcc=5


function UIMysteryFinishWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryFinishWin:__delete()
self.effectgrid:setChildLayoutGroupClearAllItems()
if self.ListTimer then
self:stopTimerByID(self.ListTimer)
end
self:unbindComponents()
end





function UIMysteryFinishWin:onShow(argtable,afterOnloaded)
self.itemList=argtable.itemList or{}

mysteryAIManager:set_mystery_state(false)

local list={}
local lookUp={}

for i,v in ipairs(self.itemList)do
local itemId=v[1]
local handle
local guid=tostring(v[3])
if v[3]and guid~='0'and guid~='nil'then
handle=guid
else
if itemsConfig.isEquip(itemId)then
handle=FMT.fmt("{0}{1}",itemId,i)
else
handle=itemId
end
end
local data=lookUp[handle]
if not data then
lookUp[handle]=v
else
local num=data[2]
local new=data[4]or v[4]
lookUp[handle]={itemId,num+v[2],v[3],new}
end
end
for i,v in pairs(lookUp)do
table.insert(list,v)
end
table.sort(list,function(a,b)
local itemida,itemidb
local isTeZhia,isTeZhib=false,false
local isGaiLva,isGaiLvb=false,false
local isActReward_a,isActReward_b=false,false
if type(a)=='table'then
itemida=a[1]
itemidb=b[1]
isTeZhia=a[2]==-2
isGaiLva=a[2]==-1
isTeZhib=b[2]==-2
isGaiLvb=b[2]==-1
isActReward_a=a.isActReward
isActReward_b=b.isActReward
else
itemida=a
itemidb=b
end
local aConfig=itemsConfig.getConfig(itemida)
local bConfig=itemsConfig.getConfig(itemidb)


local aRareLv=itemsConfig.getRareLv(itemida)
local bRareLv=itemsConfig.getRareLv(itemidb)
local aScore=aRareLv*10000000+itemida
local bScore=bRareLv*10000000+itemidb

if not isGaiLva then
aScore=aScore+1000000
end
if not isGaiLvb then
bScore=bScore+1000000
end

aScore=aScore+aConfig.color*100000
bScore=bScore+bConfig.color*100000

if itemsConfig.isGubao(itemida)then
aScore=aScore+200000000
elseif not itemsConfig.isEquip(itemida)then
aScore=aScore+100000000
end

if itemsConfig.isGubao(itemidb)then
bScore=bScore+200000000
elseif not itemsConfig.isEquip(itemidb)then
bScore=bScore+100000000
end

if isActReward_a then
aScore=aScore+1000000000
end

if isActReward_b then
bScore=bScore+1000000000
end

return aScore>bScore
end)

self.itemList=list

local hasContinue=true
local fbid=MysteryModel:get_cur_fbid()
self.fbid=fbid
if fbid then
local cfg=cfg_secretscenefubenconfig_get(fbid)
if cfg.uiOpen then
local uiOpenCfg=cfg_secretsceneuishowconfig_get(cfg.uiOpen)
if uiOpenCfg then
hasContinue=uiOpenCfg.continueButton
end
end
end
self.continueButton:setActive(hasContinue)

local delayCb=function()
self.root:setActive(true)
self.titleRoot:setChildCanvasGroupAlpha(0)
self.titleRoot:setChildCanvasGroupDOFade(1,1,nil)
self.effectName:setChildShowEffect(10081,true)
self.model:setChildUIModelShowTarget(modelId,1,{},eAnimationID.run,false)
self.modelMove=self.model:setChildDOLocalMoveX(0,0.6,function()
self.model:setChildModelAnimationState(eAnimationID.idle6)
self:refreshRewardPanel()
end)








end

local progress=MysteryModel:get_fb_progress()or 0
if progress<100 then
delayCb()
self.failClick:setActive(true)
self.continueButton:setActive(false)
self.finishButton:setActive(false)
else
self.failClick:setActive(false)
self.root:setActive(false)
self.effect:setChildShowEffect(10079,true)
local delay=self:setTimer(2,1,delayCb)
end

local isOpenAuto,reason=MysteryGuildOrder.isOrderSetupOpen(fbid)
if isOpenAuto and MysteryGuildOrder:findEvent()then
self.eventTips:setActive(true)
else
self.eventTips:setActive(false)
end


end



function UIMysteryFinishWin:onHide()


end

function UIMysteryFinishWin:playAnim(anim)
self.winlua:SetChildModelAnimationState(self.model:getID(),anim)
end

function UIMysteryFinishWin:refreshRewardPanel()
if not self.itemList or not next(self.itemList)then
self.model:setChildCanvasGroupDOFade(0,1)
self:doFadeBtnRoot()
return
end
local length=#self.itemList
if length<9 then
self.ListPanel:setChildAnchoredPosition(Vector2.New(listPos[1]+gridSize[1]/2*(9-length),listPos[2]))
end
self.effectgrid:setChildLayoutGroupCreateItems(length)
self.ListPanel:setChildScrollViewCreateGrids(length,9)
self.grids=self.ListPanel:getChildScrollViewItemWidgets()
local count=self.grids.Count
self.ListCreateIndex=0
self.ListTimer=self:setTimer(0.2,count,function()
if self and not self.isClose then
local item=self.grids[self.ListCreateIndex]
if item then
self:refreshItem(self.ListCreateIndex,item)
end
self.ListCreateIndex=self.ListCreateIndex+1
end
end)




end

function UIMysteryFinishWin:doFadeBtnRoot()
self.btnRoot:setChildCanvasGroupAlpha(0)
self.btnRoot:setChildCanvasGroupDOFade(1,1)
end

function UIMysteryFinishWin:refreshItem(id,item)
id=id+1
local itemData=self.itemList[id]
if not itemData then
return
end
local effectCmp=self.effectgrid:getChildLayoutGroupGridItem(id-1)
if effectCmp then
effectCmp:SetChildShowEffect(1,10077,true)
local endPos=item:GetChildPosition(0)
local length=#self.itemList
length=length>3 and length-2 or 1
if id==length then
self.model:setChildCanvasGroupDOFade(0,1)
self:doFadeBtnRoot()
end
effectCmp:SetChildDOJump(1,endPos,1,1,1.2,function()
effectCmp:SetChildShowEffect(1,10078,true)
item:SetChildCanvasGroupDOFade(0,1,0.8,nil)
end)

end
item:SetChildCanvasGroupAlpha(0,0)
local config=itemsConfig.getConfig(itemData[1])
local itemStage=config.stage
if itemStage then
itemData.stage=itemStage
end
widgetHelper.setNormalRewardItem(item,0,itemData)
end






function UIMysteryFinishWin:onMaskClick()
if self.ListTimer then
self:stopTimerByID(self.ListTimer)
local count=self.grids.Count
if self.ListCreateIndex<count then
for i=self.ListCreateIndex,count-1 do
local item=self.grids[i]
if item then
self:refreshItem(i,item)
end
end
end
self.ListTimer=nil
end
end



function UIMysteryFinishWin:onFinishButton()
MysteryModel:set_fb_finish(eMysteryQuitType.eFinish)
notifySystem:postNotify(notifyConfig.on_mystery_finish,self.fbid)
MysteryController.send_4_27()
UIManager:closeWindow("UIMysteryFinishWin")
end



function UIMysteryFinishWin:onContinueButton()
notifySystem:postNotify(notifyConfig.on_mystery_finish,self.fbid)
mysteryAIManager:set_mystery_state(false)
MysteryModel:set_continue_flag(true)
UIManager:closeWindow("UIMysteryFinishWin")
end

function UIMysteryFinishWin:onFailClick()
MysteryModel:set_fb_finish(eMysteryQuitType.eFail)
MysteryController.send_4_27()
MysteryController.send_4_4(MysteryModel:get_cur_fbid())
UIManager:closeWindow("UIMysteryFinishWin")
end