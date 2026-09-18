







def_class("UIDiscipleCuiTiWin",UIWindowBase)









function UIDiscipleCuiTiWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.backEffect=UIObject.get(self,1)
self.cuitiEffect=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.ctSpine=UIObject.get(self,4)
self.attrGrid=UIObject.get(self,5)
self.brokeEffect=UIObject.get(self,6)
self.floorNameTxt=UIText.get(self,7)
self.costGoodGrid=UIObject.get(self,8)
self.commitBtn=UIButton.get(self,9)
self.fullTips=UIText.get(self,10)
self.commitBtnTxt=UIText.get(self,11)
self.upReddot=UIObject.get(self,12)
self.limitLTTxt=UIText.get(self,13)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)



end


function UIDiscipleCuiTiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.cuitiEffect);self.cuitiEffect=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ctSpine);self.ctSpine=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.brokeEffect);self.brokeEffect=nil;
_UIObject_release(self.floorNameTxt);self.floorNameTxt=nil;
_UIObject_release(self.costGoodGrid);self.costGoodGrid=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.fullTips);self.fullTips=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.upReddot);self.upReddot=nil;
_UIObject_release(self.limitLTTxt);self.limitLTTxt=nil;
end
















local _this


function UIDiscipleCuiTiWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.onDiscipleCuiTiChange,self.onDiscipleCuiTiChange)
self:addNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
local pos=self:getChildCanvas(-1)
self.root:setChildCanvas(pos[1],pos[2]+2)
end


function UIDiscipleCuiTiWin:__delete()
self.backEffect:setChildShowEffect(0,false)
self.brokeEffect:setChildShowEffect(0,false)
_this=nil
self:unbindComponents()
end


function UIDiscipleCuiTiWin:onHide()

end

function UIDiscipleCuiTiWin.onDiscipleCuiTiChange(dis_guid,ctlv_o,ctlv)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.dis_guid)then return end
if ctlv_o==nil then return end
local floor=UIDiscipleModel:getCuiTiFloor(ctlv)
local o_floor=UIDiscipleModel:getCuiTiFloor(ctlv_o)
if floor~=o_floor then
_this:refreshInfo()
UIManager:showWindow('UIDiscipleCuiTiBrokeWin',{dis_guid=dis_guid,ctlv=ctlv,oldctlv=ctlv_o})
else
_this:playBrokeAnim()
end
end

function UIDiscipleCuiTiWin.onItemListChanged(args)
if _this==nil then return end
_this:refreshInfo()
end




function UIDiscipleCuiTiWin:onShow(argtable,afterOnloaded)
self:showWindow("UITopMaskWin")

self.dis_guid=argtable.dis_guid

self:refreshInfo()

self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4912,1,{},0,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end

function UIDiscipleCuiTiWin:refreshInfo()
local netData=UIDiscipleModel:getDiscipleData(self.dis_guid)
local qzctlv=netData.qzctlv
self.qzctlv=qzctlv
local qzctexp=netData.qzctexp
local qzcfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,qzctlv)
local n_qzcfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,qzctlv+1)
local isfull=n_qzcfg==nil
local isBroke=not isfull and n_qzcfg.floor~=qzcfg.floor


local spineid,effectid=UIDiscipleModel:getCuiTiFloorSpine(qzctlv)
if spineid~=nil then
if self.cuitiSpine~=spineid then
self.cuitiSpine=spineid
self.cuitiEffect:setChildShowEffect(0,false)
self.ctSpine:setChildUIModelShowTarget(spineid,0.25,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.8,function()
_this.cuitiEffect:setChildShowEffect(effectid,true)
end)
end)
end
else
self.ctSpine:setChildUIModelRemoveTarget()
self.cuitiEffect:setChildShowEffect(0,false)
end

local floorname,jie=UIDiscipleModel:getCuiTiNameEx(qzctlv,3)
self.floorNameTxt:setText(floorname)

local lookup2=UIDiscipleModel:getDiscipleAttrLookupX(self.dis_guid,DISCIPLE_ATTRIBUTE_TYPE.eQiZhen)
local rate2=UIDiscipleModel:getDZQiZhan2LianTianRate(self.dis_guid)
local attrlist=UIDiscipleModel.getDZCuiTiAttrChange(qzctlv,qzctlv+1,lookup2,rate2)
local grids=self.attrGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local attr=attrlist[i]
local isshow=attr~=nil
item:SetChildActive(-1,isshow)
if isshow then
local attrID=attr[1]
local attrValue=attr[2]
local addValue=attr[3]
local isadd=addValue~=nil and addValue>0
item:SetChildActive(2,isadd)
if attrID~=-1 then
local attrname=cfgHelper.get2(cfg_attributesconfig_get,attrID,'attrname')
item:SetChildText(0,attrname)
item:SetChildText(1,helper.getAttributeStr1(attrID,attrValue))
if isadd then
item:SetChildText(3,addValue)
end
else
item:SetChildText(1,FMT.fmt('{0}%',attrValue))
if isadd then
item:SetChildText(3,FMT.fmt('{0}%',addValue))
end
end
end
end

self.costGoodGrid:setActive(not isfull)
self.commitBtn:setActive(not isfull)
self.fullTips:setActive(isfull)
if not isfull then
local costs=UIDiscipleModel:getDZCuiTiUpCost(self.dis_guid)or{}
local c2=#costs
self.costGoodGrid:setChildLayoutGroupCreateItems(c2)
local grid=self.costGoodGrid:getChildLayoutGroupGridList()
for i=1,c2 do
local data=costs[i]
local item=grid[i-1]
local itemID=data[1]
local itemID_=itemID
local needNum=data[2]
local hasNum
if itemID==-1 then
hasNum=qzctexp
itemID_=cfgHelper.getdef1(cfg_discipleqizhencuiticonfig,'showItemID')
else
hasNum=itemsModel.getCount(itemID)
end
local str
if itemsConfig.isMoney(itemID)then
str=FMT.fmt('{0}/{1}',mathHelper.formatNumber(hasNum),mathHelper.formatNumber(needNum))
elseif itemID==-1 then
str=FMT.fmt('{0}/{1}',mathHelper.formatNumber4(hasNum,1),mathHelper.formatNumber4(needNum,1))
else
str=FMT.fmt('{0}/{1}',hasNum,needNum)
end
if hasNum<needNum then
str=toColorString(FONT_COLOR.eRedColor,str)
end
local conf={itemid=itemID_,itemcount='',showname=false,showCountBG=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildText(1,str)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onGoodItemClick(itemID_)
end)
end

local isEnough=UIDiscipleModel:checkDZCuiTiReddot(self.dis_guid)
self.upReddot:setActive(isEnough)
end

local btn_str
if isBroke then
btn_str='突破'
else
btn_str='淬体'
end
self.commitBtnTxt:setText(btn_str)
local limit_str
if qzcfg.lianti~=nil then
if netData.liantilv<qzcfg.lianti then
limit_str=FMT.fmt('炼体需达到{0}期',UIDiscipleModel:getLTName(qzcfg.lianti))
end
end
self.limitLTTxt:setText(limit_str or'')
end

function UIDiscipleCuiTiWin:onGoodItemClick(itemID)
tipsManager.showTips({itemid=itemID,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIDiscipleCuiTiWin:onCommitBtn()
if self.isPlaying then return end
local isEnough,itemID,needItemCount=UIDiscipleModel:checkDZCuiTiReddot(self.dis_guid)
if not isEnough then
if itemID~=nil then
if itemID==-2 then
local netData=UIDiscipleModel:getDiscipleData(self.dis_guid)
local ctlv=netData.qzctlv
local ltlv_=cfgHelper.get2(cfg_discipleqizhencuiticonfig_get,ctlv,'lianti')
UIManager.error(FMT.fmt('炼体需达到{0}期',UIDiscipleModel:getLTName(ltlv_)))
else
if itemID==-1 then
itemID=cfgHelper.getdef1(cfg_discipleqizhencuiticonfig,'showItemID')
local str=FMT.fmt('{0}不足，可服用奇珍道具增加',itemsConfig.getItemName(itemID))
UIManager.error(str)
else
UIManager.error('材料不足')
gainControl:showCommonGainWin_item(itemID,{needCount=needItemCount})
end
end
end
return
end
UIDiscipleController:reqCuiTiUp(self.dis_guid)
end

function UIDiscipleCuiTiWin:playBrokeAnim()
self.isPlaying=true
local func=function()
if _this==nil then return end
_this.playTimer=nil
_this.isPlaying=false
_this.brokeEffect:setChildShowEffect(0,false)
self:refreshInfo()
end
self.playTimer=self:setTimer(3.2,1,func)
self.brokeEffect:setChildShowEffect(discipleLookup.confgs.ltbrokeeffectID,true)


AudioManager.playAudio(618)
end