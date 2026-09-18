







def_class("UIFuLuShowPrizeWin",UIWindowBase)









function UIFuLuShowPrizeWin:bindComponents()

self.backEffect=UIObject.get(self,0)
self.BaseItem=UIBaseItem.get(self,1)
self.addExpText=UIText.get(self,2)
self.ratingImg=UIImage.get(self,3)



end


function UIFuLuShowPrizeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.BaseItem);self.BaseItem=nil;
_UIObject_release(self.addExpText);self.addExpText=nil;
_UIObject_release(self.ratingImg);self.ratingImg=nil;
end

















local abName='ui/windows/fulu/sharedtextures/fulufang.ab'


function UIFuLuShowPrizeWin:onLoaded(...)
self:bindComponents()

UIManager.setMoneyMsgShowState(false,true)
end


function UIFuLuShowPrizeWin:__delete()
self.backEffect:setChildShowEffect(0,false)
self:unbindComponents()

UIManager.setMoneyMsgShowState(true,true)
end




function UIFuLuShowPrizeWin:onShow(argtable,afterOnloaded)
self.backEffect:setChildShowEffect(10014,true)
local grade=argtable[1]
local id=argtable[2]
local rewards=argtable[3]
local ubdId=argtable[4]
local config
if grade~=0 then
config=cfgHelper.get1(cfg_fulufangconfig_get,id)
else
config=cfgHelper.get1(cfg_yufufangconfig_get,id)
end
self.items=rewards

local item=self.items[1]
local itemid=item.itemid
local conf={itemid=itemid,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.BaseItem:setChildPropData(prop)
self.BaseItem:setBaseItemClickEvent(function(...)
self:onClickItem(...)
end)


local proSkillExp=config.proskill_exp
local addPro=proSkillExp[1]
local proType=addPro[1]
local addVal=addPro[2]
local allAddVal=addVal
local sfId=zongmenModel:getMountainId()
local bdData=zongmenModel:getBuildingData(ubdId)
local dzId=bdData.dizi_id
if dzId then
local addRate=UIDiscipleModel:getDiscipleProskillRate(dzId,proType)
allAddVal=math.floor(allAddVal*(1+addRate/100))
end
local proCfg=cfgHelper.get1(cfg_discipleproskillconfig_get,proType)
local name=UIDiscipleModel:getDiscipleName(dzId)
local isTempName=name==nil or name==''
local expStr=isTempName and''or FMT.fmt('<color=#ca631d>{2}</color>{0}经验增加{1}点',proCfg.name,allAddVal,name)
self.addExpText:setText(expStr)

if grade>0 then
local imgName=cfgHelper.get2(cfg_fubaoratingconfig_get,grade,'imgname')
self.ratingImg:setSprite(abName,imgName)
end
end


function UIFuLuShowPrizeWin:onHide()

end



function UIFuLuShowPrizeWin:onClickItem(id,index,guid,attach)
local item=self.items[1]
local itemid=item.itemid
local itemguid=item.itemguid
if itemid==-1 then
return
end
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
else
loggerUtil.logErrFMT('没有找到此道具：',itemid)
end
end

function UIFuLuShowPrizeWin:onClickClose()
self:closeSelf()
end