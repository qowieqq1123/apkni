







def_class("UIBaoLingShuShowPrizeWin",UIWindowBase)









function UIBaoLingShuShowPrizeWin:bindComponents()

self.creater=UIGameobjectClone.new(self,0)
self.qifuOneText=UIText.get(self,1)
self.qifuOneCost=UIObject.get(self,2)
self.qifuOneMoneyImg=UIImage.get(self,3)
self.qifuTenMoneyTxt=UIText.get(self,4)
self.qifuOneMoneyTxt=UIText.get(self,5)
self.Content=UIObject.get(self,6)
self.effect=UIObject.get(self,7)
self.qifuTenMoneyImg=UIImage.get(self,8)
self.qifuOneBtn=UIButton.get(self,9)
self.qifuTenBtn=UIButton.get(self,10)
self.qifuOneFreeText=UIText.get(self,11)
self.moneyAddTips=UIText.get(self,12)
self.moneyIcon=UIImage.get(self,13)

self.qifuOneBtn:setButtonClick(function()self:onQifuOneBtn()end)

self.qifuTenBtn:setButtonClick(function()self:onQifuTenBtn()end)



end


function UIBaoLingShuShowPrizeWin:unbindComponents()
local _UIObject_release=UIObject.release
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.qifuOneText);self.qifuOneText=nil;
_UIObject_release(self.qifuOneCost);self.qifuOneCost=nil;
_UIObject_release(self.qifuOneMoneyImg);self.qifuOneMoneyImg=nil;
_UIObject_release(self.qifuTenMoneyTxt);self.qifuTenMoneyTxt=nil;
_UIObject_release(self.qifuOneMoneyTxt);self.qifuOneMoneyTxt=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.qifuTenMoneyImg);self.qifuTenMoneyImg=nil;
_UIObject_release(self.qifuOneBtn);self.qifuOneBtn=nil;
_UIObject_release(self.qifuTenBtn);self.qifuTenBtn=nil;
_UIObject_release(self.qifuOneFreeText);self.qifuOneFreeText=nil;
_UIObject_release(self.moneyAddTips);self.moneyAddTips=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
end

















local _divTime=0.1
local _colomn=5
local _ycell=74
local _yPace=30
local _top=5
local _yViewSize=135

local _left=24
local _xcell=74
local _xPace=16

function UIBaoLingShuShowPrizeWin:onLoaded(...)
self:bindComponents()
end

function UIBaoLingShuShowPrizeWin:__delete()
self:unbindComponents()
end

function UIBaoLingShuShowPrizeWin:onShow(argtable,afterOnloaded)
local stageId=baoLingShuController.fightStage.stageID
local ent=baoLingShuController.fightStage:getEntity(stageId+1)
ent:stopBehavior()
local config={}
for i,v in ipairs(argtable[1])do
local singleInfo={}
singleInfo.name='UIBaoLingShuShowPrizeItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.delay=_divTime*(i-1)
singleInfo.args=v
config[#config+1]=singleInfo
end
self:setContentLayout(#config)
self.creater:createObjectList(config)

local configId=argtable[2]
self:fillBtns(configId)
self.effect:setChildShowEffect(10014,true)

local drawNum=argtable[1]and#argtable[1]or 0
local cfg=cfgHelper.get1(cfg_baolingtreeconfig_get,configId)
local addMoneyCfg=cfg.lingye or{}
local addMoneyId=addMoneyCfg[1]
local addMoneyCountSingle=addMoneyCfg[2]
if addMoneyId and drawNum>0 then
self.moneyAddTips:setActive(true)
local moneyName=moneyModel.getMoneyName(addMoneyId)
local moneyCount=addMoneyCountSingle*drawNum
self.moneyAddTips:setText(FMT.fmt("{0}+{1}",moneyName,moneyCount))
self.moneyIcon:setImageIcon(moneyModel.getIconNameEx(addMoneyId),false)
else
self.moneyAddTips:setActive(false)
end
end

function UIBaoLingShuShowPrizeWin:setContentLayout(len)
local row=math.ceil(len/_colomn)
local ySize=_top+row*(_yPace+_ycell)
local colomn=math.min(len,_colomn)
local xSize=_left+colomn*(_xPace+_xcell)
self.winlua:SetChildSizeDelta(self.Content:getID(),xSize,ySize)
if ySize>=_yViewSize then
self.winlua:SetChildAnchoredPos(self.Content:getID(),0,_yViewSize-ySize)
else
self.winlua:SetChildAnchoredPos(self.Content:getID(),0,0)
end
end

function UIBaoLingShuShowPrizeWin:onHide()

end

function UIBaoLingShuShowPrizeWin:fillBtns(id)
local config=cfgHelper.get1(cfg_baolingtreeconfig_get,id)
local freenum=baoLingShuModel:get_baolingshu_free_num()
local notFree=freenum<=0
self.qifuOneCost:setActive(notFree)
self.qifuOneText:setText(notFree and'许愿1次'or'免费许愿')
local cost=config.useItem
local itemid=cost[1]
local itemNum=cost[2]
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem<itemNum then

local lerpCnt=itemNum-haveItem
itemid=cost[3]
itemNum=cost[4]*lerpCnt
end
local freenum_str
if notFree then
freenum_str=''
local iconName=iconHelper.getIconName(itemid)
self.qifuOneMoneyImg:setImageIcon(iconName)
self.qifuOneMoneyTxt:setText(itemNum)
else
freenum_str=FMT.fmt('免费许愿: <color=#CA631D>{0}</color>次',freenum)
end
self.qifuOneFreeText:setText(freenum_str)


local itemid_ten=cost[1]
local itemNum_ten=cost[2]*10
local haveItem_ten=bagControl.invokeFuncByItemId(itemid_ten,'getItemCountByItemID',itemid_ten)
if haveItem_ten<itemNum_ten then


itemid_ten=cost[3]

itemNum_ten=cost[4]*10
end
local iconName=iconHelper.getIconName(itemid_ten)
self.qifuTenMoneyImg:setImageIcon(iconName)
self.qifuTenMoneyTxt:setText(itemNum_ten)
end


function UIBaoLingShuShowPrizeWin:onQifuOneBtn()
UIManager:invokeUIMethod("UIBaoLingShuWin","onQifuBtnOne")
self:closeSelf()
end

function UIBaoLingShuShowPrizeWin:onQifuTenBtn()
UIManager:invokeUIMethod("UIBaoLingShuWin","onQifuBtnTen")
self:closeSelf()
end

function UIBaoLingShuShowPrizeWin:onClickClose()
UIManager:callWindowFunc('UIBaoLingShuWin','fadeShowDZ')
self:closeSelf()
end