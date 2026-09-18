







def_class("UIPlayerChangeSuitWin",UIWindowBase)









function UIPlayerChangeSuitWin:bindComponents()

self.activeItemsList=UIScrollViewSlow.get(self,0)
self.closebtn=UIButton.get(self,1)
self.left=UIObject.get(self,2)
self.liandonBtn=UIButton.get(self,3)
self.mask=UIObject.get(self,4)
self.rightbutton=UIObject.get(self,5)
self.righttop=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.selectBtn=UIButton.get(self,8)
self.showmodel=UIObject.get(self,9)
self.suiScrollView=UIObject.get(self,10)
self.suitList=UIObject.get(self,11)
self.selecttxt=UIText.get(self,12)
self.selectReddot=UIObject.get(self,13)
self.attrRoot=UIObject.get(self,14)
self.attr_1=UIObject.get(self,15)
self.attr_2=UIObject.get(self,16)
self.attr_3=UIObject.get(self,17)
self.effect=UIObject.get(self,18)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)
self.attr={
self.attr_1,
self.attr_2,
self.attr_3,
}



end


function UIPlayerChangeSuitWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeItemsList);self.activeItemsList=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.rightbutton);self.rightbutton=nil;
_UIObject_release(self.righttop);self.righttop=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.showmodel);self.showmodel=nil;
_UIObject_release(self.suiScrollView);self.suiScrollView=nil;
_UIObject_release(self.suitList);self.suitList=nil;
_UIObject_release(self.selecttxt);self.selecttxt=nil;
_UIObject_release(self.selectReddot);self.selectReddot=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.attr_1);self.attr_1=nil;
_UIObject_release(self.attr_2);self.attr_2=nil;
_UIObject_release(self.attr_3);self.attr_3=nil;
_UIObject_release(self.effect);self.effect=nil;
self.attr=nil;
end



















function UIPlayerChangeSuitWin:onLoaded(...)
self:bindComponents()



self.activeItemsList:bindSlowWidget(function(...)self:bandActiveItem(...)end)
self.activeItemsList:setSlowClickAction(function(...)self:onClickActiveItem(...)end)

self:addNotify(notifyConfig.on_item_changed,function(...)self:on_item_changed(...)end)
end


function UIPlayerChangeSuitWin:__delete()
self:unbindComponents()
end




function UIPlayerChangeSuitWin:onShow(argtable,afterOnloaded)
self:dealData()

self.selectIndex=1

self:refreshWin()
end


function UIPlayerChangeSuitWin:onHide()

end





function UIPlayerChangeSuitWin:onSelectBtn()
local data=self.data[self.selectIndex]
local cfg=data.cfg
local suitId=cfg.id
local canActive=playerImageModel:canActiveSuitAttr(suitId)
if canActive then
playerImageController:reqActiveSuitAttr(suitId)
return
end
UIManager.info("选择成功")
local imageList=playerImageModel:getPlayerImage()
local sex=playerModel:getActorSex()
for itemid,isUnlock in pairs(data.activeItemListState)do
if isUnlock then
local itemCfg=itemsConfig.getConfig(itemid)
local list=itemCfg.funcparam and itemCfg.funcparam.list and itemCfg.funcparam.list[sex]
if list then
for index,partdata in pairs(list)do
imageList[partdata[1]]=partdata[2]
end
end
end
end
UIManager:showWindow("UIPlayerChangeImageWin",{playerImage=imageList})
self:closeSelf()
end



function UIPlayerChangeSuitWin:onClosebtn()
self:closeSelf()
end

function UIPlayerChangeSuitWin:onLiandonBtn()
local data=self.data[self.selectIndex]
UIManager:showWindow('UITipLianDonWin',{linkageId=data.cfg.linkageId})
end

function UIPlayerChangeSuitWin:on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if self.lookupActiveItem[itemid]then
self:dealData()
self:refreshWin()
end
end

function UIPlayerChangeSuitWin:refreshWin()
self:freshLeft()
self:freshRightTop()
self:freshRightBotton()
self:freshSelectBtn()
self:freshAttr()
end

function UIPlayerChangeSuitWin:activeStateChange()
self:dealData()
self:freshLeft()
self:freshSelectBtn()
self:freshAttr()
end

function UIPlayerChangeSuitWin:dealData()


























































playerImageModel:dealAllSuitConfig()
self.data=playerImageModel:getSuitData()
self.lookupActiveItem=playerImageModel:getLookupActiveItem()

end

function UIPlayerChangeSuitWin:bandSuitItem(index,item)
local data=self.data[index]
local sex=playerModel:getActorSex()
local isLD=liandonModel:getIsLianDonPlayerSuit(data.cfg.id)

item:SetChildActive(-1,true)

local scale=data.cfg.modelparam.scale or 1
local ani=eAnimationID.idle
local offsetX=data.cfg.modelparam.offsetx or 0
local offsetY=data.cfg.modelparam.offsety or 0

comHelper.setChildPlayerImage(item,0,data.imageList,sex,scale,ani,offsetX,offsetY,false)

item:SetChildText(1,data.name)
item:SetChildActive(2,index==self.selectIndex)
item:SetChildActive(3,not data.isUnlock)
item:SetChildActive(4,data.reddot)
item:SetChildActive(5,isLD)
end

function UIPlayerChangeSuitWin:onClickSuitItem(index,item)
local preitem=self.suitList:getChildLayoutGroupGridItem(self.selectIndex-1)
preitem:SetChildActive(2,false)

item:SetChildActive(2,true)
self.selectIndex=index
self:freshRightTop()
self:freshRightBotton()
self:freshAttr()
self:freshSelectBtn()
end

function UIPlayerChangeSuitWin:bandActiveItem(index,item)
local sex=playerModel:getActorSex()
local data=self.data[self.selectIndex]
local partData=data.parts[index]
local itemid=data.loopUpItem[partData[1]]
local tabid=partData[1]
local id=partData[2]


item:SetChildActive(-1,true)




local isUnlock=data.activeItemListState[itemid]
item:SetChildActive(1,not isUnlock)
item:SetChildActive(2,not isUnlock)

local imageCfg=playerImageConfig.getSubConfig(tabid,id)
local bgspine=imageCfg and imageCfg.bgspine or nil
local spineid=imageCfg and imageCfg.spineid or nil
local scale=bgspine and bgspine[2]or 1
local offsetX=bgspine and bgspine[3]or 0
local offsetY=bgspine and bgspine[4]or 0
local components={}
if tabid==PLAYER_IMAGE_TYPE.eFace or bgspine==nil then
components={spineid}
else
components={bgspine[1],spineid}
end
local body=playerImageConfig.getPlayerImageBody(sex)


item:SetChildUIModelShowTarget(4,
body,
scale,
components,
eAnimationID.idle,
true,
false,
0)
if offsetX~=0 or offsetY~=0 then
item:SetChildUIModelShowTargetOffset(4,offsetX,offsetY)
end
end

function UIPlayerChangeSuitWin:onClickActiveItem(id,index,guid,attach)
local data=self.data[self.selectIndex]
local partData=data.parts[index]
local itemid=data.loopUpItem[partData[1]]




if not data.activeItemListState[itemid]then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,
itemid=itemid,
showModel=true,
backType=TIPS_BACK_TYPE.eBag,
})
end
end

function UIPlayerChangeSuitWin:freshLeft()
local suitLen=#self.data



self.suitList:setChildLayoutGroupCreateItems(suitLen,function(index)
local item=self.suitList:getChildLayoutGroupGridItem(index-1)
self:bandSuitItem(index,item)

item:SetBaseItemClickEvent(-1,function()
self:onClickSuitItem(index,item)
end)
end)
end

function UIPlayerChangeSuitWin:freshRightTop()
local data=self.data[self.selectIndex]
local sex=playerModel:getActorSex()
local isLD=liandonModel:getIsLianDonPlayerSuit(data.cfg.id)

local scale=data.cfg.modelparam2.scale or 1
local ani=eAnimationID.idle
local offsetX=data.cfg.modelparam2.offsetx or 0
local offsetY=data.cfg.modelparam2.offsety or 0

comHelper.setChildPlayerImage(self.showmodel:getWidgetBase(),-1,data.imageList,sex,scale,ani,offsetX,offsetY,playerController:supportDynamic())


self.liandonBtn:setActive(isLD)
end

function UIPlayerChangeSuitWin:freshRightBotton()

local data=self.data[self.selectIndex]
local partlen=#data.parts
self.activeItemsList:clearSlowItems()
self.activeItemsList:freshSlowGrids(partlen,1,partlen,not self.activeStZero)
self.activeStZero=true
end


function UIPlayerChangeSuitWin:freshAttr()
local data=self.data[self.selectIndex]
local cfg=data.cfg
local suitId=cfg.id
local attrList=cfg.attr
if not attrList then
self.attrRoot:setActive(false)
return
end
self.attrRoot:setActive(true)
local isActive=playerImageModel:checkSuitAttrActive(suitId)
for i,v in ipairs(self.attr)do
if attrList[i]then
local attr=attrList[i]
v:setActive(true)
local item=v:getChildWidgetBase()
local name,value=equipsHelper.getAttr(attr[1],attr[2])

local valStr=string.format("<color=%s>+%s</color>",isActive and"#4f851b"or"#7E7E7E",value)
item:SetChildText(1,name)
item:SetChildText(2,valStr)

else
v:setActive(false)
end
end
end

function UIPlayerChangeSuitWin:freshSelectBtn()
local data=self.data[self.selectIndex]
local cfg=data.cfg
local suitId=cfg.id
local canSelect=data.isCanSelect
local canActive=playerImageModel:canActiveSuitAttr(suitId)
if canActive then
self.selecttxt:setText("激活")
self.selectReddot:setActive(true)
else
self.selecttxt:setText("选择")
self.selectReddot:setActive(false)
end
self.selectBtn:setActive(canSelect or canActive)
end

function UIPlayerChangeSuitWin:playEffect()
self.effect:setChildShowEffect(10060,true)
end
