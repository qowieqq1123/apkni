







def_class("UIXianShuBuyLevelWin",UIWindowBase)









function UIXianShuBuyLevelWin:bindComponents()

self.countSlider=UIObject.get(self,0)
self.cutBtn=UIButton.get(self,1)
self.addBtn=UIButton.get(self,2)
self.scrollView=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.des=UIText.get(self,5)
self.buyBtn=UIButton.get(self,6)
self.level=UIText.get(self,7)
self.needText=UIText.get(self,8)
self.needIcon=UIImage.get(self,9)

self.cutBtn:setButtonClick(function()self:onCutBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)



end


function UIXianShuBuyLevelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.countSlider);self.countSlider=nil;
_UIObject_release(self.cutBtn);self.cutBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.des);self.des=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.needText);self.needText=nil;
_UIObject_release(self.needIcon);self.needIcon=nil;
end



















function UIXianShuBuyLevelWin:onLoaded(...)
self:bindComponents()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

UIManager:showWindow('UITopMoneyWin',{{2},{3}})
end


function UIXianShuBuyLevelWin:__delete()
self.scrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()

UIManager:hideWindow('UITopMoneyWin')
end




function UIXianShuBuyLevelWin:onShow(argtable,afterOnloaded)
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,UIXianShuControl:getCurrentId())
local maxLevel=cfg.max_lv
local level=UIXianShuControl:getLevel()
self.selectLevel=level+1
self.minLevel=self.selectLevel
self.maxLevel=maxLevel
self.createCount=1
self:setInfo(level,self.selectLevel)
self.winlua:SetChildSliderInit(self.countSlider:getID(),self.selectLevel,self.selectLevel,maxLevel,function(val)
if val~=self.selectLevel then
self.selectLevel=val
self:setInfo(level,val)
end
end)
end


function UIXianShuBuyLevelWin:onHide()

end

function UIXianShuBuyLevelWin:setInfo(currLevel,buyLevel)
self.des:setText(FMT.fmt('仙书等级提升至 <size=28><color=#7d3b17>{0}</color></size> 级，可获得以下奖励',buyLevel))
self.buyLevelNum=buyLevel-currLevel
self.level:setText(FMT.fmt('购买{0}级：',self.buyLevelNum))

self.scrollView:setChildScrollViewStopGridCreate()

self.scrollView:setChildScrollViewCreateGrids(0,0)

local datas=UIXianShuControl:getRewardDataInRange(currLevel+1,buyLevel)
local len=#datas
self.scrollView:setChildScrollViewDelayCreateGrids(len,0,0.02,self.createCount,false,false,function(index,item)
local data=datas[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)

local buyCfg=cfgHelper.get2(cfg_fairybookbaseconfig_get,1,'consume')
local ntype=buyCfg[1][1]
local nvalue=buyCfg[1][2]
self.needIcon:setChildIcon(iconHelper.getIconName(ntype),true)
local need=nvalue*self.buyLevelNum
local have=moneyModel.getMoney(ntype)
if have>=need then
self.needText:setText(need)
else
self.needText:setText(FMT.fmt('<color=red>{0}</color>',need))
end
end


function UIXianShuBuyLevelWin:onBuyBtn()
local buyCfg=cfgHelper.get2(cfg_fairybookbaseconfig_get,1,'consume')
local ntype=buyCfg[1][1]
local nvalue=buyCfg[1][2]
local need=nvalue*self.buyLevelNum
local have=moneyModel.getMoney(ntype)
if have>=need then
UIXianShuControl:reqBuyLevel(self.selectLevel)
self:onCloseClick()
else
gainControl:showGainWin(ntype)
end
end

function UIXianShuBuyLevelWin:onAddBtn()
if self.selectLevel>=self.maxLevel then
return
end
self.createCount=18
self.winlua:SetChildSliderValue(self.countSlider:getID(),self.selectLevel+1)
self.createCount=1
end

function UIXianShuBuyLevelWin:onCutBtn()
if self.selectLevel<=self.minLevel then
return
end
self.createCount=18
self.winlua:SetChildSliderValue(self.countSlider:getID(),self.selectLevel-1)
self.createCount=1
end

function UIXianShuBuyLevelWin:onCloseClick()
self:closeSelf()
end