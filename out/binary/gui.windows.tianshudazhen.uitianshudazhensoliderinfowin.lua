







def_class("UITianShuDaZhenSoliderInfoWin",UIWindowBase)









function UITianShuDaZhenSoliderInfoWin:bindComponents()

self.btnXunLian=UIButton.get(self,0)
self.notEnoughRoot=UIObject.get(self,1)
self.num=UIText.get(self,2)
self.setScrollView=UIObject.get(self,3)
self.zsScrollView=UIObject.get(self,4)
self.temp=UIText.get(self,5)

self.btnXunLian:setButtonClick(function()self:onBtnXunLian()end)



end


function UITianShuDaZhenSoliderInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnXunLian);self.btnXunLian=nil;
_UIObject_release(self.notEnoughRoot);self.notEnoughRoot=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.setScrollView);self.setScrollView=nil;
_UIObject_release(self.zsScrollView);self.zsScrollView=nil;
_UIObject_release(self.temp);self.temp=nil;
end

















local _iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"


function UITianShuDaZhenSoliderInfoWin:onLoaded(...)
self:bindComponents()
end


function UITianShuDaZhenSoliderInfoWin:__delete()
self:unbindComponents()
end




function UITianShuDaZhenSoliderInfoWin:onShow(argtable,afterOnloaded)
self:refreshInfo()


end


function UITianShuDaZhenSoliderInfoWin:onHide()

end





function UITianShuDaZhenSoliderInfoWin:onBtnXunLian()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eYunJiaYing,mapid=mapIdType.fort}})
end

function UITianShuDaZhenSoliderInfoWin:refreshInfo()
local soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy)
local data=tianshudazhenModel:getYunZhouSetData()
self.soldierlist=data.soldierlist or{}
local soldierCnt=0
for i,v in ipairs(data.soldierlist)do
soldierCnt=soldierCnt+v[2]
end
local setCnt=soldierCnt

local cnt=math.min(soldierCnt,allSoldierCount)
local enough=cnt>=setCnt
self.num:setText(enough and FMT.fmt('大阵驻守修士数量：{0}/{1}',cnt,setCnt)or
FMT.fmt('大阵驻守修士数量：<color=#c82c2c>{0}</color>/{1}',cnt,setCnt))

self.notEnoughRoot:setActive(not enough)

self:refreshZSInfo()
end

function UITianShuDaZhenSoliderInfoWin:refreshZSInfo()
local soldierlist=tianshudazhenModel:getCurSoldiers()
local cnt=#soldierlist
self.zsScrollView:setChildScrollViewCreateGrids(cnt,cnt)
local grids=self.zsScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local soldierInfo=soldierlist[i]
local moneytype=soldierInfo[1]
local cnt=soldierInfo[2]
local id=yunjiayingModel:getSoldierLevelByMoneyType(moneytype)
local cfg=cfg_fairylandsoldierconfig_get(id)
local bgIconName=cfg.bgIcon
widget:SetChildCSImageSprite(1,_iconAb,cfg.bgIcon)
widget:SetChildCSImageSprite(3,_iconAb,cfg.nameIcon)
widget:SetChildText(2,cnt)
end
self.temp:setActive(cnt<=0)
self.zsScrollView:setChildScrollRectEnable(cnt>6)
local soldierlist=tianshudazhenModel:getCurSoldiersSetting()
local cnt=#soldierlist
self.setScrollView:setChildScrollViewCreateGrids(cnt,cnt)
local grids=self.setScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local soldierInfo=soldierlist[i]
local moneytype=soldierInfo[1]
local cnt=soldierInfo[2]
local id=yunjiayingModel:getSoldierLevelByMoneyType(moneytype)
local cfg=cfg_fairylandsoldierconfig_get(id)
local bgIconName=cfg.bgIcon
widget:SetChildCSImageSprite(1,_iconAb,cfg.bgIcon)
widget:SetChildCSImageSprite(3,_iconAb,cfg.nameIcon)
widget:SetChildText(2,cnt)
end
self.setScrollView:setChildScrollRectEnable(cnt>6)
end
