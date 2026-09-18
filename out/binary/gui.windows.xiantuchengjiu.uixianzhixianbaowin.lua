







def_class("UIXianZhiXianBaoWin",UIWindowBase)









function UIXianZhiXianBaoWin:bindComponents()

self.baseAttrList=UIObject.get(self,0)
self.beidognDesc=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.expInfo=UIText.get(self,3)
self.fullLevelImg=UIObject.get(self,4)
self.level=UIText.get(self,5)
self.model=UIObject.get(self,6)
self.name=UIImage.get(self,7)
self.reddot=UIObject.get(self,8)
self.Root=UIObject.get(self,9)
self.uiRoot=UIObject.get(self,10)
self.upLevelBar=UIObject.get(self,11)
self.upLevelBtn=UIButton.get(self,12)
self.uplevelProgress=UIObject.get(self,13)
self.upLevelTip=UIText.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.upLevelBtn:setButtonClick(function()self:onUpLevelBtn()end)



end


function UIXianZhiXianBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baseAttrList);self.baseAttrList=nil;
_UIObject_release(self.beidognDesc);self.beidognDesc=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.expInfo);self.expInfo=nil;
_UIObject_release(self.fullLevelImg);self.fullLevelImg=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.upLevelBar);self.upLevelBar=nil;
_UIObject_release(self.upLevelBtn);self.upLevelBtn=nil;
_UIObject_release(self.uplevelProgress);self.uplevelProgress=nil;
_UIObject_release(self.upLevelTip);self.upLevelTip=nil;
end
















local CmpBaseAttrSlotIndex={
name=0,
val=1,
upImg=2,
addVal=3,
}




function UIXianZhiXianBaoWin:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.on_money_changed,function(...)self:on_money_changed(...)end)
self:addNotify(notifyConfig.onGuBaoSkillLevelChange,function(...)self:onGuBaoSkillLevelChange(...)end)
self.oldEffectId=0
end


function UIXianZhiXianBaoWin:__delete()
self:unbindComponents()
end




function UIXianZhiXianBaoWin:onShow(argtable,afterOnloaded)
self:refreshAll()
end


function UIXianZhiXianBaoWin:onHide()

end



function UIXianZhiXianBaoWin:refreshAll()
local effectid,gbName=xianzhiConfig.getXianZhiXianBaoModelInfo()
if self.oldEffectId~=effectid then
self.model:setChildShowEffect(effectid,true)
self.oldEffectId=effectid
end
local gbid=xianzhiConfig.getBaseInfo('gbid')
local gbCfg=itemsConfig.getConfig(gbid,ITEM_CONFIG_TYPE.eGuBao)

local isXzFull=xianzhiModel:checkXzFull()


local xblevel=xianzhiModel:getXianBaoLevel()
self.level:setText(FMT.fmt("仙宝等级：{0}级",xblevel))

local maxLv=#gbCfg.level
local isMax=xblevel>=maxLv
local isShowExp=isXzFull and(not isMax)

local attrInfoList,speInfoData=self:getAttrInfoList(xblevel)

local attrLen=#attrInfoList
local attrCreateFunc=function(index)
local aitem=self.baseAttrList:getChildLayoutGroupGridItem(index-1)
local data=attrInfoList[index]

local name=helper.getAttributeName(data.attrId)
local sVal=helper.getAttributeStrEx(data.attrId,data.attrVal)
aitem:SetChildText(CmpBaseAttrSlotIndex.name,name)
aitem:SetChildText(CmpBaseAttrSlotIndex.val,sVal)
aitem:SetChildActive(CmpBaseAttrSlotIndex.upImg,data.isAdd)
aitem:SetChildActive(CmpBaseAttrSlotIndex.addVal,data.isAdd)
if data.isAdd then
local addVal=helper.getAttributeStrEx(data.attrId,data.addVal)
aitem:SetChildText(CmpBaseAttrSlotIndex.addVal,addVal)
end
end
self.baseAttrList:setChildLayoutGroupCreateItems(attrLen,attrCreateFunc)

self.uplevelProgress:setActive(isShowExp)
self.expInfo:setActive(isShowExp)
self.upLevelBtn:setActive(isShowExp)
self.fullLevelImg:setActive(isMax)
if isXzFull and(not isMax)then
self:refreshExp()
end


local upRateJCT=xianzhiController.getChangeXianZhiWagesRateJCT()
local isShowUpLevelTip=upRateJCT>0
self.upLevelTip:setActive(isShowUpLevelTip)
if isShowUpLevelTip then
self.upLevelTip:setText(FMT.fmt("仙职提升至{0}重天可升级被动属性",upRateJCT))
end


local xianzhiWagesRate=xianzhiController.getGBSKil_XianZhiWagesRate()
local info
if speInfoData[2]>0 and(not isMax)then
info=FMT.fmt("仙职每日俸禄比例提升+{0}<color=#549327>(+{1})%</color>",xianzhiWagesRate,speInfoData[2])
else
info=FMT.fmt("仙职每日俸禄比例提升+{0}%",xianzhiWagesRate)
end
self.beidognDesc:setText(info)

local upState,lostInfo=xianzhiModel:checkCanUpXianBaoLevel()
self.reddot:setActive(upState)
end

function UIXianZhiXianBaoWin:refreshExp()
local gbid=xianzhiConfig.getBaseInfo('gbid')
local gbCfg=itemsConfig.getConfig(gbid,ITEM_CONFIG_TYPE.eGuBao)
local xblevel=gubaoModel:getSkillLv(gbid)
local uplevelCost=gbCfg.level[xblevel][1]
local exp=itemsModel.getCount(uplevelCost[1])
local sexp=uplevelCost[2]
local info=FMT.fmt("{0}/{1}",exp,sexp)
self.expInfo:setText(info)
self.upLevelBar:setChildIconFillAmount(exp/sexp)
end

function UIXianZhiXianBaoWin:getAttrInfoList(lv)
local gbid=xianzhiConfig.getBaseInfo('gbid')
local attrLookup=gubaoModel:getAttrLookup(gbid,true)

local gbCfg=itemsConfig.getConfig(gbid,ITEM_CONFIG_TYPE.eGuBao)

local attrTypeList={}
for index,attrInfo in ipairs(gbCfg.attr)do
attrTypeList[#attrTypeList+1]=attrInfo[1]
end

local gbSkillLv=gubaoModel:getSkillLv(gbid)
local curSkillInfo=gbCfg.skill[gbSkillLv]
local nextSkillInfo=gbCfg.skill[gbSkillLv+1]

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
local curAttrLookup=transTable(curSkillInfo[1])
local nextAttrLookup=transTable(nextSkillInfo and nextSkillInfo[1]or curSkillInfo[1])

for index,atype in ipairs(attrTypeList)do
local temp={}
temp.attrId=atype
temp.attrVal=attrLookup[atype]
temp.isAdd=nextAttrLookup[atype]~=nil
if temp.isAdd then
temp.addVal=nextAttrLookup[atype]-curAttrLookup[atype]
end
attrInfoList[index]=temp
end



local speSkillValDefInfo={0,0}





return attrInfoList,speSkillValDefInfo
end

function UIXianZhiXianBaoWin:on_money_changed(mtype)
if mtype==eMoneyType.mtDaoXun then
self:refreshAll()
end
end

function UIXianZhiXianBaoWin:onGuBaoSkillLevelChange(gbid,skilllv,oldLv)
local sgbid=xianzhiConfig.getBaseInfo('gbid')
if sgbid==gbid then
self:refreshAll()
end
end





function UIXianZhiXianBaoWin:onCloseBtn()
self:closeSelf()
end



function UIXianZhiXianBaoWin:onUpLevelBtn()
if xianzhiModel:checkXzFull()then
local gbid=xianzhiConfig.getBaseInfo('gbid')
local upState,lostInfo=xianzhiModel:checkCanUpXianBaoLevel()
if upState then
gubaoController:req_16_7(gbid)
else
gainControl:showGainWin(lostInfo[1],lostInfo[2])
end
end
end

