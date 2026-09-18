







def_class("UIXianGongInfluenceNPCGiftWin",UIWindowBase)









function UIXianGongInfluenceNPCGiftWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.giftBtn=UIButton.get(self,1)
self.giftList=UIObject.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.tips=UIText.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.giftBtn:setButtonClick(function()self:onGiftBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIXianGongInfluenceNPCGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.giftBtn);self.giftBtn=nil;
_UIObject_release(self.giftList);self.giftList=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
end















local _this=nil
local _giftItemCmp={
item=0,
slider=1,
lock=2,
add=3,
del=4,
num=5,
other=6,
}



function UIXianGongInfluenceNPCGiftWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianGongNPCRelationChange,self.onXianGongNPCRelationChange)
self:addNotify(notifyConfig.onXianGongNPCDailyFreeChange,self.onXianGongNPCDailyFreeChange)

self.selectList={}
self.selectValue=0
self.maxList={}
end


function UIXianGongInfluenceNPCGiftWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGongInfluenceNPCGiftWin:onShow(argtable,afterOnloaded)
self.npcId=argtable.npc
self.parentWin=argtable.parentWin
self.callback=argtable.callback
self.npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,self.npcId)
self:refreshGiftList()
end


function UIXianGongInfluenceNPCGiftWin:onHide()

end




function UIXianGongInfluenceNPCGiftWin:onCloseBtn()
if self.callback then
self.callback()
end

if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIXianGongInfluenceNPCGiftWin:onGiftBtn()
local sendList={}
for i,v in pairs(self.selectList)do
if v>0 then
local info=self.npcCfg.recv_list[i]
local itemId=info[1]
local count=itemsModel.getCount(itemId)
if count>=v then
table.insert(sendList,{itemId,v})
else
self:refreshGiftList()
UIManager.info("礼物数量不足")
return
end
end
end

if#sendList>0 then
local free=xjFactionNPCModel:getNPCDailyFree(self.npcId)
local max=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"daily_feel_gift_limit")
if free>=max then
local npcCfg=cfgHelper.get1(cfg_xianjieshilijiaohunpcconfig_get,self.npcId)
local name=cfgHelper.get2(cfg_npcimageconfig_get,npcCfg.image,"name")
local content=FMT.fmt("<color=#9D6C54>{0}</color>今日送礼好感已达上限，再赠礼无法获得好感度，是否继续赠礼？",name)
UIDialogManager.getCommonDialog(nil,content,function()
xjFactionNPCController:send_37_106(self.npcId,sendList)
end)
else
local over=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"daily_feel_gift_over_tips")
local temp=self.selectValue+free-max
if temp>=over then
local content=FMT.fmt("赠礼好感度为：{0}，部分礼物超过上限，超出的部分将不会获得好感度。是否继续赠礼？",self.selectValue)

UIDialogManager.getCommonDialog(nil,content,function()

xjFactionNPCController:send_37_106(self.npcId,sendList)
end)
else
xjFactionNPCController:send_37_106(self.npcId,sendList)
end
end
else
UIManager.info("请先选择需要赠送的礼物")
end
end

function UIXianGongInfluenceNPCGiftWin:refreshGiftList()
table.clear(self.maxList)
self.selectValue=0
self.giftList:setChildLayoutGroupCreateItems(#self.npcCfg.recv_list,function(index)
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local info=self.npcCfg.recv_list[index]
local itemId=info[1]
local cond=info[2]
local limit=info[3]
local open=xjFactionNPCModel:checkConditionsEx(cond)
item:SetChildActive(_giftItemCmp.item,open)
item:SetChildActive(_giftItemCmp.lock,not open)
if open then
local itemConf={itemid=itemId,itemcount="",showCountBG=false,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(_giftItemCmp.item,propData)
item:SetBaseItemClickEvent(_giftItemCmp.item,itemsComponentHelper.onItemClickEx)

local have=itemsModel.getCount(itemId)
local over=xjFactionNPCModel:getNPCGiftNumMax(self.npcId,limit[1],limit[2])
local count=xjFactionNPCModel:getNPCGiftCount(self.npcId,itemId)
local num=self.selectList[index]or 0
local max=0
if over then
max=over>=0 and math.min(have,over-count)or have
end
self.maxList[index]=max
num=math.min(num,max)
self.selectList[index]=num

local addValue=cfgHelper.get2(cfg_xianjieshilijiaohugiftconfig_get,itemId,"add_feel")
self.selectValue=self.selectValue+addValue*num

local showSlider=over>0 and count<over
item:SetChildActive(_giftItemCmp.slider,showSlider)
if showSlider then
item:SetChildLongPress(_giftItemCmp.add,_giftItemCmp.add,function(id)
self:onClickAdd(index)
end,nil)
item:SetChildLongPress(_giftItemCmp.del,_giftItemCmp.del,function(id)
self:onClickDel(index)
end,nil)

item:SetChildSliderInit(_giftItemCmp.slider,num,0,max,function(value)
self:onSliderChange(index,value)
end)
item:SetChildText(_giftItemCmp.num,FMT.fmt("<color=#65615f>数量：</color>{0}/{1}",mathHelper.formatNumber(num),mathHelper.formatNumber(max)))
item:SetChildGraphicGray(_giftItemCmp.slider,max<=0,true)
item:SetChildText(_giftItemCmp.other,"")
else
item:SetChildText(_giftItemCmp.other,"已达到赠送次数上限")
end
else
item:SetChildActive(_giftItemCmp.slider,false)
item:SetChildText(_giftItemCmp.other,"")
end
end)
self:refreshTips()
end

function UIXianGongInfluenceNPCGiftWin:refreshTips()
local max=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"daily_feel_gift_limit")
local cur=xjFactionNPCModel:getNPCDailyFree(self.npcId)
cur=math.min(cur,max)
local selectStr=""
if self.selectValue and self.selectValue>0 then
if(cur+self.selectValue)>=max then
selectStr=FMT.cfmt(FONT_COLOR.eRedColor,"({0})",self.selectValue)
else
selectStr=FMT.cfmt(FONT_COLOR.eGreenColor,"({0})",self.selectValue)
end
end
local tipsStr=FMT.fmt("<color=#9D6C54>今日好感上限：</color>{0}{2}/{1}",cur,max,selectStr)
self.tips:setText(tipsStr)
end

function UIXianGongInfluenceNPCGiftWin:onClickAdd(index)
local num=self.selectList[index]or 0
local max=self.maxList[index]or 0
if num+1<=max then













local item=self.giftList:getChildLayoutGroupGridItem(index-1)
item:SetChildSliderValue(_giftItemCmp.slider,num+1)
end
end

function UIXianGongInfluenceNPCGiftWin:onClickDel(index)
local num=self.selectList[index]or 0
if num-1>=0 then
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
item:SetChildSliderValue(_giftItemCmp.slider,num-1)
end
end

function UIXianGongInfluenceNPCGiftWin:onSliderChange(index,value)
local oldValue=self.selectList[index]or 0
if oldValue~=value then
local info=self.npcCfg.recv_list[index]
local itemId=info[1]
local addValue=cfgHelper.get2(cfg_xianjieshilijiaohugiftconfig_get,itemId,"add_feel")
local item=self.giftList:getChildLayoutGroupGridItem(index-1)
local max=self.maxList[index]

local _max=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"daily_feel_gift_limit")
local _cur=xjFactionNPCModel:getNPCDailyFree(self.npcId)
local _delta=value-oldValue
local temp=self.selectValue+(value-oldValue)*addValue
if _delta>0 then
if _cur+self.selectValue>=_max then
item:SetChildSliderValue(_giftItemCmp.slider,oldValue)
return
elseif _cur+temp-_max>addValue then
item:SetChildSliderValue(_giftItemCmp.slider,math.ceil((_max-_cur-self.selectValue+oldValue*addValue)/addValue))
return
end
end











self.selectList[index]=value
self.selectValue=self.selectValue+(value-oldValue)*addValue
item:SetChildText(_giftItemCmp.num,FMT.fmt("<color=#65615f>数量：</color>{0}/{1}",mathHelper.formatNumber(value),mathHelper.formatNumber(max)))

self:refreshTips()
end
end

function UIXianGongInfluenceNPCGiftWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='xiangongshili_npc_gift_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIXianGongInfluenceNPCGiftWin.onXianGongNPCRelationChange(npcId,changeLv,reputationLvChange,source)
if changeLv and _this.npcId==npcId and source==2 then
_this:refreshGiftList()
end
end

function UIXianGongInfluenceNPCGiftWin.onXianGongNPCDailyFreeChange(npcId,oldVal)
if _this.npcId==npcId then
table.clear(_this.selectList)
_this.selectValue=0
_this:refreshGiftList()

local max=cfgHelper.get2(cfg_xianjieshilijiaohuconstconfig_get,1,"daily_feel_gift_limit")
if oldVal<max then
UIManager:showWindow("UICommonEffectWin",{effect=18063})
end
elseif npcId==nil then
_this:refreshTips()
end
end


function UIXianGongInfluenceNPCGiftWin:checkIsFull(value,_oldValue,_selectValue,_max,_cur,addValue)
local oldValue=_oldValue or 0
local selectValue=0
if _selectValue then
selectValue=_selectValue+(value-1-oldValue)*addValue
end
if selectValue and selectValue>0 then
if(_cur+selectValue)>=_max then

return true
else
return false
end
else
return false
end
end
