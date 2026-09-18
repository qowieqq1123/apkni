







def_class("UIYunZhouZhenTuMainWin",UIWindowBase)









function UIYunZhouZhenTuMainWin:bindComponents()

self.root=UIObject.get(self,0)
self.ztRoot=UIObject.get(self,1)
self.AllAttrbtn=UIButton.get(self,2)
self.strengthenBtn=UIButton.get(self,4)
self.costicon=UIObject.get(self,5)
self.costnum=UIText.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.strengthPanel=UIObject.get(self,8)
self.sgreddot=UIObject.get(self,9)
self.tipsbtn=UIButton.get(self,10)
self.ztItem=UIObject.get(self,11)
self.ztItem1=UIObject.get(self,12)
self.ztItem2=UIObject.get(self,13)
self.ztItem3=UIObject.get(self,14)
self.ztItem4=UIObject.get(self,15)
self.ztItem5=UIObject.get(self,16)
self.callbackBtn=UIButton.get(self,17)
self.ZTroots=UIObject.get(self,18)
self.bgModel=UIObject.get(self,19)
self.bgModel2=UIObject.get(self,20)
self.bgspine=UIObject.get(self,21)
self.lbtnpanel=UIObject.get(self,22)
self.zteffect=UIObject.get(self,23)

self.AllAttrbtn:setButtonClick(function()self:onAllAttrbtn()end)

self.strengthenBtn:setButtonClick(function()self:onStrengthenBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.callbackBtn:setButtonClick(function()self:onCallbackBtn()end)



end


function UIYunZhouZhenTuMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ztRoot);self.ztRoot=nil;
_UIObject_release(self.AllAttrbtn);self.AllAttrbtn=nil;
_UIObject_release(self.strengthenBtn);self.strengthenBtn=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.costnum);self.costnum=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.strengthPanel);self.strengthPanel=nil;
_UIObject_release(self.sgreddot);self.sgreddot=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.ztItem);self.ztItem=nil;
_UIObject_release(self.ztItem1);self.ztItem1=nil;
_UIObject_release(self.ztItem2);self.ztItem2=nil;
_UIObject_release(self.ztItem3);self.ztItem3=nil;
_UIObject_release(self.ztItem4);self.ztItem4=nil;
_UIObject_release(self.ztItem5);self.ztItem5=nil;
_UIObject_release(self.callbackBtn);self.callbackBtn=nil;
_UIObject_release(self.ZTroots);self.ZTroots=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.bgspine);self.bgspine=nil;
_UIObject_release(self.lbtnpanel);self.lbtnpanel=nil;
_UIObject_release(self.zteffect);self.zteffect=nil;
end
















local _this
local ztitemidx=
{
selfitem=0,
icon=1,
name=2,
btn=3,
reddot=4,
lock=5,
selectsp=6,
spine=7,
}
local xqitemidx=
{
toppanel=0,
zticon=1,
ztname=2,
ztlvl=16,
ztup=17,
ztuptxt=18,

attrpanel=3,
attrlist=4,

skillpanel=5,
skillicon=6,
skillname=7,
skilldesc=8,
skillup=19,
skilluptxt=20,

bottonpanel=9,
costlist=10,
costroot=11,
ymjimg=12,
longclicktip=13,
qianhuatxt=14,
locktxt=15,

skillbtn=21,
}
local UpBtnName={"激 活","升 级","突 破"}
local abname='ui/windows/xianyungang/yunzhouzhentu_atlas_pak.ab'
local mapDefaultScale=1
local mapDefaultBigScale=1.2
local ZTPos=
{
[0]={0,0},
[1]={132,-224},
[2]={127,52},
[3]={-380,110},
[4]={-140,-136},
[5]={-495,-284},
[6]={-641,-61},
}
local filter={}
local temp={}



function UIYunZhouZhenTuMainWin:onLoaded(...)
self:bindComponents()
_this=self
self.ztlist={self.ztItem,self.ztItem1,self.ztItem2,self.ztItem3,self.ztItem4,self.ztItem5}
self.selectZTid=0
self.widgetXQ=self.strengthPanel:getWidgetBase()
self.isShowXQ_Win=false
self.canjumpztid=0

self:addNotify(notifyConfig.onYunZhouZhenTuUpLevel,function(...)self:onYunZhouZhenTuUpLevel(...)end)
self.strengthenBtn:setChildLongPress(1,function()
if not _this then return end
_this:onLongPressStrengthenBtn()
end,nil)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)


if deviceHelper.getAPILevel()>=12 then
local s_func=function(pos)
if _this==nil then return end
_this.lockClick=true
_this.lockClickTime=Time.realtimeSinceStartup
_this.lockClickPos=pos












end
local e_func=function(pos)
if _this==nil then return end
_this.lockClick=false

end
self.ZTroots:setChildDragStartAndEndEvent(s_func,e_func)
end
end


function UIYunZhouZhenTuMainWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
_this=nil
end

function UIYunZhouZhenTuMainWin.on_item_changed(changeType,itemguid,_itemid,oldcount,newcount)
if _this.isShowXQ_Win then
local widgetNode=_this.widgetXQ
local cost=_this.usecost
if cost then
widgetNode:SetChildActive(xqitemidx.costlist,true)
widgetNode:SetChildLayoutGroupCreateItems(xqitemidx.costlist,#cost,function(idx)
local item=widgetNode:GetChildLayoutGroupGridItem(xqitemidx.costlist,idx-1)
local costdata=cost[idx]
local itemid=costdata[1]
local needNum=costdata[2]
local hasNum=0
if moneyConfig.isMoney(itemid)then
hasNum=moneyModel.getMoney(itemid)
else
hasNum=bagModel.getItemCountById(itemid)
end
local grayNum=hasNum>=needNum and 0 or 1
local hasColor=hasNum>=needNum and FONT_COLOR.eGrayWhiteTxtColor or FONT_COLOR.eRedColor
hasNum=FMT.fmt('{0}',mathHelper.formatNumber9(hasNum,1))
needNum=FMT.fmt('{0}',mathHelper.formatNumber9(needNum,1))

local countdesc=toColorString(hasColor,FMT.fmt('{0}/{1}',hasNum,needNum))
local conf={itemid=itemid,itemcount=countdesc,showCountBG=true,showname=false,gray=grayNum}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(-1,propdata)
end)
end
end
end


function UIYunZhouZhenTuMainWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_UIYunZhouZhenTuMainWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIYunZhouZhenTuMainWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UIYunZhouZhenTuMainWin:onAllAttrbtn()
self:enableDrag(false)
self:showWindow('UIYunZhouZhenTuAttrWin')
end

function UIYunZhouZhenTuMainWin:onSkillbtn(selectZTid)
self:enableDrag(false)
self:showWindow('UIYunZhouZhenTuSkillWin',{ztid=selectZTid})
end


function UIYunZhouZhenTuMainWin:onCallbackBtn()

self.selectZTid=0
self:playLeaveAnim()
self:switchbtn(1)
self:cancelselect()

self.bgModel2:setChildModelAnimationState(3601,1,nil)
local func=function()
if _this==nil then return end

self.isBigState=false
self:enableDrag(false)
end

self:jumpZTPos(0,func)
self:defaultMap(true)
end

function UIYunZhouZhenTuMainWin:onZhenTuClick(ztid)
if self.selectZTid==ztid then
return
end

self.selectZTid=ztid


self:cancelselect()
local item=self.ztlist[self.selectZTid]:getWidgetBase()
if item then
item:SetChildActive(ztitemidx.selectsp,true)
end
local func=function()
if _this==nil then return end
self:switchbtn(2)
self:refreshRightNodePanel(ztid)
end

if self.isBigState then



self:jumpZTPos(self.selectZTid,func)

else



self.isBigState=true
self.bgModel2:setChildModelAnimationState(3602,1,nil)
self:delayDo(0.6,function()
self:bigMap()
self:enableDrag(true)
self:jumpZTPos(self.selectZTid,nil)
self:playEnterAnim()
self:delayDo(0.1,func)
end)
end
end


function UIYunZhouZhenTuMainWin:onStrengthenBtn()
end
function UIYunZhouZhenTuMainWin:onLongPressStrengthenBtn()
if not self.prohibitState then
local ztid=self.selectZTid
if ztid>0 then
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local ztcfg=cfg_yunzhouzhentuconfig_get(ztid)
local ZhenTuMaxlvl=ztcfg.ZhenTuMaxlvl
local level=0
if yzztData then
level=yzztData.level
end
if level<ZhenTuMaxlvl then
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
local state,itemid,itemNum=self:checkStrengthen(cfg.useItems)
if state then
if not self.prohibitState then
self.prohibitState=true
YunZhouZhenTuController:send_6_190(ztid)

end
else
gainControl:showCommonGainWin_item(itemid,{needCount=itemNum})
end
else
UIManager.info("当前阵图已满级")
end
end
end
end





function UIYunZhouZhenTuMainWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.winlua:SetChildSpineAnimation(self.bgspine:getID(),1,1,nil)
UIManager:hideWindow('UITopMoneyWin')
end
if argtable then

end

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
end
self.bgModel:setChildUIModelShowTarget(6412,1,nil,eAnimationID.stand)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel2:getID(),true,true,true)
end
self.bgModel2:setChildUIModelShowTarget(6413,1,nil,eAnimationID.stand)


self.lockClick=false
self.isBigState=false
self.ztRoot:setChildSizeDelta(2180,1100)
self:resetMapLimit()
self:enableDrag(false)
self:defaultMap()

self.isShowXQ_Win=false
self.prohibitState=false
self.selectZTid=0
self:switchbtn(1)
self:freshZTList()


if argtable and argtable.isjump then
local _ztid=self.canjumpztid
if _ztid>0 then
self:delayDo(0.5,function()
if _this==nil then return end
self:onZhenTuClick(_ztid)
end)
end
end
end


function UIYunZhouZhenTuMainWin:onHide()

end
function UIYunZhouZhenTuMainWin:onCloseBtn()
self:closeSelf()
end


function UIYunZhouZhenTuMainWin:playEnterAnim()
self.strengthPanel:setChildAnchoredPosition(Vector2(600,1))
self.strengthPanel:setChildDOAnchorPosX(-24,0.4,nil)
end
function UIYunZhouZhenTuMainWin:playLeaveAnim()
self.strengthPanel:setChildDOAnchorPosX(600,0.4,nil)
end


function UIYunZhouZhenTuMainWin:switchbtn(flag)

if flag==2 then
self.isShowXQ_Win=true
self.closeBtn:setActive(false)
self.callbackBtn:setActive(true)




self.strengthPanel:setActive(true)
self.strengthPanel:setChildCanvasGroupDOFade(1,0.2,nil)
self.lbtnpanel:setActive(false)
self.lbtnpanel:setChildCanvasGroupDOFade(0,0.2,nil)
else
self.isShowXQ_Win=false
self.closeBtn:setActive(true)
self.callbackBtn:setActive(false)




self.strengthPanel:setChildCanvasGroupDOFade(0,0.4,function()
if _this==nil then return end
self.strengthPanel:setActive(false)
end)
self.lbtnpanel:setChildCanvasGroupDOFade(1,0.4,function()
if _this==nil then return end
self.lbtnpanel:setActive(true)
end)
end
end

function UIYunZhouZhenTuMainWin:onYunZhouZhenTuUpLevel(ztid,level)
if _this==nil then return end
if self.selectZTid~=ztid then return end
self:setZTEffect()

local func=function()
self:freshZTSingle(ztid,ztid)
self:refreshRightNodePanel(ztid)
self.prohibitState=false
end


func()
end


function UIYunZhouZhenTuMainWin:freshZTList()
for ztid,v in ipairs(self.ztlist)do
local widget=v:getWidgetBase()
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local ztcfg=cfg_yunzhouzhentuconfig_get(ztid)
local ZhenTuMaxlvl=ztcfg.ZhenTuMaxlvl

local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
effectLevel=cfg.effectLevel
end


local str=ztcfg.name
if isActive then

widget:SetChildActive(ztitemidx.spine,true)
widget:SetChildActive(ztitemidx.icon,false)
local spineid=ztcfg.spineid or 6417
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
widget:SetChildUIModelEnableInitUISpineParaEx(ztitemidx.spine,true,true,true)
end
widget:SetChildUIModelShowTarget(ztitemidx.spine,spineid,1,{},eAnimationID.stand)

widget:SetChildActive(ztitemidx.lock,false)
if level>=ZhenTuMaxlvl then
str=FMT.fmt('{0} <color=#f1ce78>{1}级</color>',ztcfg.name,level)
else
str=FMT.fmt('{0} <color=#f1ce78>{1}级</color>',ztcfg.name,level)
end
else

widget:SetChildActive(ztitemidx.spine,false)
widget:SetChildActive(ztitemidx.icon,true)
local iconname=ztcfg.icon or'button_yzzt_1'
widget:SetChildCSImageSprite(ztitemidx.icon,abname,iconname)
widget:SetChildGray(ztitemidx.icon,true)

widget:SetChildActive(ztitemidx.lock,true)
str=FMT.fmt('{0} <color=#c82c2c>未激活</color>',ztcfg.name)
end
widget:SetChildText(ztitemidx.name,str)


local reddot=self:getYZZTSingleReddot(ztid)
if self.canjumpztid and self.canjumpztid<=0 then
self.canjumpztid=ztid
end
widget:SetChildActive(ztitemidx.reddot,reddot)


widget:SetChildActive(ztitemidx.selectsp,self.selectZTid==ztid)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
widget:SetChildUIModelEnableInitUISpineParaEx(ztitemidx.selectsp,true,true,true)
end
widget:SetChildUIModelShowTarget(ztitemidx.selectsp,6421,1,{},eAnimationID.stand)


widget:SetChildButtonClick(ztitemidx.btn,function()
if _this==nil then return end
self:onZhenTuClick(ztid)
end)
end
end

function UIYunZhouZhenTuMainWin:cancelselect()
for ztid,v in ipairs(self.ztlist)do
local widget=v:getWidgetBase()
widget:SetChildActive(ztitemidx.selectsp,false)
end
end

function UIYunZhouZhenTuMainWin:freshZTSingle(index,ztid)
local widget=self.ztlist[index]:getWidgetBase()
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local ztcfg=cfg_yunzhouzhentuconfig_get(ztid)
local ZhenTuMaxlvl=ztcfg.ZhenTuMaxlvl

local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
effectLevel=cfg.effectLevel
end


local str=ztcfg.name
if isActive then

widget:SetChildActive(ztitemidx.spine,true)
widget:SetChildActive(ztitemidx.icon,false)
local spineid=ztcfg.spineid or 6417
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
widget:SetChildUIModelEnableInitUISpineParaEx(ztitemidx.spine,true,true,true)
end
widget:SetChildUIModelShowTarget(ztitemidx.spine,spineid,1,{},eAnimationID.stand)

widget:SetChildActive(ztitemidx.lock,false)
if level>=ZhenTuMaxlvl then
str=FMT.fmt('{0} <color=#549327>{1}级</color>',ztcfg.name,level)
else
str=FMT.fmt('{0} <color=#f1ce78>{1}级</color>',ztcfg.name,level)
end
else

widget:SetChildActive(ztitemidx.spine,false)
widget:SetChildActive(ztitemidx.icon,true)
local iconname=ztcfg.icon or'button_yzzt_1'
widget:SetChildCSImageSprite(ztitemidx.icon,abname,iconname)
widget:SetChildGray(ztitemidx.icon,true)

widget:SetChildActive(ztitemidx.lock,true)
str=FMT.fmt('{0} <color=#c82c2c>未激活</color>',ztcfg.name)
end
widget:SetChildText(ztitemidx.name,str)


local reddot=self:getYZZTSingleReddot(ztid)
widget:SetChildActive(ztitemidx.reddot,reddot)
end


function UIYunZhouZhenTuMainWin:refreshRightNodePanel(ztid)
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
effectLevel=cfg.effectLevel
end
local ztcfg=cfg_yunzhouzhentuconfig_get(ztid)
local ZhenTuMaxlvl=ztcfg.ZhenTuMaxlvl
local MaxSkilllvl=ztcfg.MaxSkilllvl and#ztcfg.MaxSkilllvl

local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
local canUpSkill=false
local zstype=cfg.zstype
local jzattr=cfg.jzattr
local unlock=cfg.unlock
local isMaxlvl=false


self.widgetXQ:SetChildCSImageSprite(xqitemidx.zticon,abname,ztcfg.icon)

self.widgetXQ:SetChildText(xqitemidx.ztname,ztcfg.name)
self.widgetXQ:SetChildText(xqitemidx.qianhuatxt,UpBtnName[zstype])


self.widgetXQ:SetChildActive(xqitemidx.ztup,false)
if isActive then
self.widgetXQ:SetChildText(xqitemidx.ztlvl,FMT.fmt('<color=#f1ce78>{0}级</color>',level))
if level>=ZhenTuMaxlvl then
isMaxlvl=true

else
self.widgetXQ:SetChildActive(xqitemidx.ztup,true)
end
else
self.widgetXQ:SetChildText(xqitemidx.ztlvl,'<color=#c82c2c>未激活</color>')
end


self.widgetXQ:SetChildButtonClick(xqitemidx.skillbtn,function()
if _this==nil then return end
self:onSkillbtn(ztid)
end)


if jzattr then
local nextjzattr
if level<ZhenTuMaxlvl then
local nextcfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level+1]
nextjzattr=nextcfg.jzattr
end

local attrs=self:getAttrInfoList(jzattr,nextjzattr)
self.widgetXQ:SetChildLayoutGroupCreateItems(xqitemidx.attrlist,#attrs,function(index)
local item=self.widgetXQ:GetChildLayoutGroupGridItem(xqitemidx.attrlist,index-1)
local data=attrs[index]
local name=helper.getAttributeName(data.attrId)
local sVal=helper.getAttributeStrEx(data.attrId,data.attrVal)
local str=FMT.fmt('{0}：{1}',name,sVal)
item:SetChildText(0,str)
item:SetChildActive(1,data.isAdd)
if data.isAdd then
local addVal=helper.getAttributeStrEx(data.attrId,data.addVal)
item:SetChildText(1,addVal)
end
end)
end


local skillicon=ztcfg.skillicon

self.widgetXQ:SetChildCSImageSprite(xqitemidx.skillicon,abname,skillicon)

if level<ZhenTuMaxlvl then
local nextcfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level+1]
canUpSkill=nextcfg.effectLevel>effectLevel
end

if effectLevel>0 then
self.widgetXQ:SetChildGray(xqitemidx.skillicon,false)

local name=FMT.fmt('<color=#f1ce78>{0}  {1}级</color>',ztcfg.skillname,effectLevel)
self.widgetXQ:SetChildText(xqitemidx.skillname,name)
if canUpSkill and effectLevel<MaxSkilllvl then
self.widgetXQ:SetChildActive(xqitemidx.skillup,true)
else
self.widgetXQ:SetChildActive(xqitemidx.skillup,false)
end


local descs=ztcfg.Upskilldesc
local parmdescs=ztcfg.Upskilldesc2
if canUpSkill and effectLevel<MaxSkilllvl then
parmdescs=ztcfg.Upskilldesc3
end
local desc=''
xpcall(function()
desc=self:getSkillZTDesc(ztid,descs,parmdescs,effectLevel)
end,function(err)
logErr(FMT.fmt('技能描述参数报错,当前云舟阵图技能等级{0}',effectLevel))
end)
self.widgetXQ:SetChildText(xqitemidx.skilldesc,desc)
else
self.widgetXQ:SetChildGray(xqitemidx.skillicon,true)

local name=FMT.fmt('{0}<color=#c82c2c>（未激活）</color>',ztcfg.skillname)
self.widgetXQ:SetChildText(xqitemidx.skillname,name)
self.widgetXQ:SetChildActive(xqitemidx.skillup,false)


local descs=ztcfg.Upskilldesc
local parmdescs=ztcfg.Upskilldesc2
local desc=''
xpcall(function()
desc=self:getSkillZTDesc(ztid,descs,parmdescs,effectLevel)
end,function(err)
logErr(FMT.fmt('技能描述参数报错,当前云舟阵图技能等级{0}',effectLevel))
end)
desc=FMT.fmt("<color=#827f78>{0}</color>",desc)
self.widgetXQ:SetChildText(xqitemidx.skilldesc,desc)
end


local isunlock,lockStr=self:checkUnlockNode(unlock)
if isunlock then
self.widgetXQ:SetChildActive(xqitemidx.bottonpanel,true)
self.widgetXQ:SetChildActive(xqitemidx.locktxt,false)

local cost=cfg.useItems
_this.usecost=cost
self:refreshStrengthenBtn(self.widgetXQ,cost)


if isMaxlvl then
self.widgetXQ:SetChildActive(xqitemidx.ymjimg,true)
self.strengthenBtn:setActive(false)
else
self.strengthenBtn:setActive(true)
self.widgetXQ:SetChildActive(xqitemidx.ymjimg,false)


local state=self:checkStrengthen(cost)
self.sgreddot:setActive(state)
end
else
self.widgetXQ:SetChildActive(xqitemidx.bottonpanel,false)
self.widgetXQ:SetChildActive(xqitemidx.locktxt,true)
self.widgetXQ:SetChildActive(xqitemidx.ymjimg,false)
self.widgetXQ:SetChildText(xqitemidx.locktxt,lockStr)
end
end

function UIYunZhouZhenTuMainWin:getSkillZTDesc(ztid,descs,parmdescs,effectLevel)
local desc=''









desc=FMT.fmt(descs,unpack(parmdescs[effectLevel]))
return desc
end

function UIYunZhouZhenTuMainWin:checkStrengthen(cost)
if cost then
local state=true
local gainItemId
local gainNum
for k,itemdata in pairs(cost)do
local itemid=itemdata[1]
local hasNum=itemsModel.getCount(itemid)
if moneyConfig.isMoney(itemid)then
hasNum=moneyModel.getMoney(itemid)
else
hasNum=bagModel.getItemCountById(itemid)
end
local neednum=itemdata[2]
state=state and hasNum>=neednum
if not state then
gainItemId=itemid
gainNum=neednum
break
end
end
return state,gainItemId,gainNum
else
return true
end
end

function UIYunZhouZhenTuMainWin:refreshStrengthenBtn(widgetNode,cost)

if cost then
widgetNode:SetChildActive(xqitemidx.costlist,true)
widgetNode:SetChildLayoutGroupCreateItems(xqitemidx.costlist,#cost,function(idx)
local item=widgetNode:GetChildLayoutGroupGridItem(xqitemidx.costlist,idx-1)
local costdata=cost[idx]
local itemid=costdata[1]
local needNum=costdata[2]
local hasNum=0
if moneyConfig.isMoney(itemid)then
hasNum=moneyModel.getMoney(itemid)
else
hasNum=bagModel.getItemCountById(itemid)
end
local grayNum=hasNum>=needNum and 0 or 1
local hasColor=hasNum>=needNum and FONT_COLOR.eGrayWhiteTxtColor or FONT_COLOR.eRedColor
hasNum=FMT.fmt('{0}',mathHelper.formatNumber9(hasNum,1))
needNum=FMT.fmt('{0}',mathHelper.formatNumber9(needNum,1))

local countdesc=toColorString(hasColor,FMT.fmt('{0}/{1}',hasNum,needNum))
local conf={itemid=itemid,itemcount=countdesc,showCountBG=true,showname=false,gray=grayNum}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)

item:SetChildPropData(-1,propdata)
item:SetBaseItemClickEvent(-1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end)
else
widgetNode:SetChildActive(xqitemidx.costlist,false)
end
end

function UIYunZhouZhenTuMainWin:getAttrInfoList(attrs1,attrs2)
local attrs=attrs1
local attrLookup={}
local attrTypeList={}
for index,attrInfo in ipairs(attrs)do
attrLookup[attrInfo[1]]=attrInfo[2]
attrTypeList[#attrTypeList+1]=attrInfo[1]
end
local curSkillInfo=attrs
local nextSkillInfo=attrs2
local transTable=function(list)
local temp={}
if list then
for index,data in ipairs(list)do
temp[data[1]]=data[2]
end
end
return temp
end
local attrInfoList={}
local curAttrLookup=transTable(curSkillInfo)
local nextAttrLookup=transTable(nextSkillInfo or curSkillInfo)
for index,atype in ipairs(attrTypeList)do
local temp={}
temp.attrId=atype
temp.attrVal=attrLookup[atype]
temp.isAdd=nextAttrLookup[atype]~=nil
if temp.isAdd then
temp.addVal=nextAttrLookup[atype]-curAttrLookup[atype]
end
if temp.addVal==0 then
temp.isAdd=false
end
attrInfoList[index]=temp
end
return attrInfoList
end


function UIYunZhouZhenTuMainWin:getYZZTSingleReddot(ztid)
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local ztcfg=cfg_yunzhouzhentuconfig_get(ztid)
local ZhenTuMaxlvl=ztcfg.ZhenTuMaxlvl
local level=0
if yzztData then
level=yzztData.level
end

if level<ZhenTuMaxlvl then
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
local reddot=self:checkUnlockNode(cfg.unlock)
if reddot then
reddot=self:checkStrengthen(cfg.useItems)
return reddot
else
return false
end
end
return false
end

function UIYunZhouZhenTuMainWin:setZTEffect()
self.zteffect:setChildShowEffect(10060,true)
end



function UIYunZhouZhenTuMainWin:defaultMap(flag)
if flag then
self.ztRoot:setChildDOScale(mapDefaultScale,0.4,function()
if _this==nil then return end
end)
else
self.ztRoot:setScale(Vector3(mapDefaultScale,mapDefaultScale,mapDefaultScale))
end
end

function UIYunZhouZhenTuMainWin:bigMap()
self.ztRoot:setScale(Vector3(mapDefaultBigScale,mapDefaultBigScale,mapDefaultBigScale))
end

function UIYunZhouZhenTuMainWin:enableDrag(flag)
self.ZTroots:setChildDragZoomEnable(flag)
end

function UIYunZhouZhenTuMainWin:ShowEnableDrag()
if self.isBigState then
self.ZTroots:setChildDragZoomEnable(true)
end
end

function UIYunZhouZhenTuMainWin:resetMapLimit()
self.ZTroots:setChildZoomLimit(1.2,1.2)
end

function UIYunZhouZhenTuMainWin:jumpZTPos(selectZTid,func)
local Pos=ZTPos[selectZTid]or{0,0}
self.ZTroots:subMoveToTargetPos(Vector3(Pos[1],Pos[2],0),0.1,true,func)
end


function UIYunZhouZhenTuMainWin:checkUnlockNode(unlock)
local lockStr=''
if unlock then
for k,lockdata in ipairs(unlock)do
if lockdata then
if lockdata[1]==1 then
local zmLevel=zongmenModel:getLevel()
lockStr=FMT.fmt('宗门达到{0}级解锁',lockdata[2])
if zmLevel<lockdata[2]then
return false,lockStr
end

elseif lockdata[1]==2 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eFabaoJinglian]={ITEM_FILTER_COMPARE.eGreaterEquals,pream2}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao
local num=0
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,true)
for i,v in ipairs(baglist)do
num=num+1
end
if num<pream1 then
local equiplist=fabaoModel.getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do
num=num+1
end
end
lockStr=FMT.fmt('{0}件法宝的精炼等级\n达到{1}级解锁',pream1,pream2)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==3 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eVocEquip
local num=0
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eVocEquip,filter,false,true)
for i,v in ipairs(baglist)do
if v.itemData and v.itemData.enhancelv and v.itemData.enhancelv>=pream2 then
num=num+1
end
end
if num<pream1 then
local equiplist=vocEquipModel:getEquipByFilter(filter)
for i,v in ipairs(equiplist)do
if v.itemData and v.itemData.enhancelv>=pream2 then
num=num+1
end
end
end
lockStr=FMT.fmt('{0}件职业装备的强化等级\n达到{1}级解锁',pream1,pream2)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==4 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eFabaoLingXingLv]={ITEM_FILTER_COMPARE.eGreaterEquals,pream2}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao
local num=0
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter,false,true)
for i,v in ipairs(baglist)do
num=num+1
end
if num<pream1 then
local equiplist=fabaoModel.getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do
num=num+1
end
end
lockStr=FMT.fmt('{0}件法宝的蕴养等级\n达到{1}级解锁',pream1,pream2)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==5 then
local pream1=lockdata[2]
local pream2=lockdata[3]
local num=0
local disciples=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(disciples)do
if v.netData.net.qzctlv and v.netData.net.qzctlv>=pream2 then
num=num+1
end
end
local floorname,jie=UIDiscipleModel:getCuiTiNameEx2(pream2)
lockStr=FMT.fmt('{0}名弟子的炼体淬体\n达到{1}解锁',pream1,floorname)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==6 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFubao
local num=0
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFubaoBag,filter,false,true)
for i,v in ipairs(baglist)do
local lzData=UIYuFuLingZhenControl:getLingZhenData(v.itemguid)
if lzData then
local level=UIYuFuLingZhenControl:countTotalLevel(lzData)
if level>=pream2 then
num=num+1
end
end
end
if num<pream1 then

local fblist=UIFuLuFangModel:getAllFubaoLookDatas()
if fblist then
for i,v in pairs(fblist)do
local lzData=UIYuFuLingZhenControl:getLingZhenData(v.itemguid)
if lzData then
local level=UIYuFuLingZhenControl:countTotalLevel(lzData)
if level>=pream2 then
num=num+1
end
end
end
end
end
lockStr=FMT.fmt('{0}个玉符的灵阵总等级\n达到{1}级解锁',pream1,pream2)
if num<pream1 then
return false,lockStr
end

elseif lockdata[1]==7 then
local pream1=lockdata[2]
local pream2=lockdata[3]
table.clear(filter)
filter[ITEM_FILTER_TYPE.eStarLv]={ITEM_FILTER_COMPARE.eGreaterEquals,pream2}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eDaoBing
local num=0
table.clear(temp)
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eDaoBingBag,filter,false,true)
for i,v in ipairs(baglist)do
num=num+1
end
if num<pream1 then
local equiplist=daobingModel:getEquipByFilter(filter,true)
for i,v in ipairs(equiplist)do
num=num+1
end
end
lockStr=FMT.fmt('{0}件道兵的星级达到{1}星',pream1,pream2)
if num<pream1 then
return false,lockStr
end
end
end
end
else
return true
end
return true,lockStr
end



function UIYunZhouZhenTuMainWin:jumpRoom2()
local posx=378
local posy=378
local scale=self.ztRoot:getScale()
local func=function()
if _this==nil then return end


self:resetMapLimit2()

end
self.ZTroots:subMoveToTargetPos(Vector3(-posx*scale.x,-posy*scale.x,0),0.1,true,func)
end

function UIYunZhouZhenTuMainWin:testtttjumps()
_this:jumpRoom2()
end

