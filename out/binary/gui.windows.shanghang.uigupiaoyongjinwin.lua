







def_class("UIGuPiaoYongJinWin",UIWindowBase)









function UIGuPiaoYongJinWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.content=UILinkImageText.get(self,1)
self.content2=UILinkImageText.get(self,2)
self.content3=UILinkImageText.get(self,3)
self.content4=UILinkImageText.get(self,4)
self.getRewardBtn=UIButton.get(self,5)
self.ScrollView=UIScrollView.get(self,6)
self.desc=UIText.get(self,7)
self.up2=UIObject.get(self,8)
self.down2=UIObject.get(self,9)
self.Content=UIObject.get(self,10)
self.up=UIObject.get(self,11)
self.down=UIObject.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)



end


function UIGuPiaoYongJinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.content2);self.content2=nil;
_UIObject_release(self.content3);self.content3=nil;
_UIObject_release(self.content4);self.content4=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.up2);self.up2=nil;
_UIObject_release(self.down2);self.down2=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.up);self.up=nil;
_UIObject_release(self.down);self.down=nil;
end



















function UIGuPiaoYongJinWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIGuPiaoYongJinWin:__delete()
self:unbindComponents()
end




function UIGuPiaoYongJinWin:onShow(argtable,afterOnloaded)


local lingyu=shangHangModel:getActorMoneyToday()or 0

if lingyu==0 then lingyu=1 end

local cfg=cfgHelper.get(cfg_shanghangbaseconfig_get,1)
local daily_reward_conf=cfg.daily_reward_conf





local finMoney=shangHangModel:getYesterdayTotalMoney()or 0
local changeMoney=shangHangModel:getYesterday_total_yq_diff()
local yesterdayMoney=finMoney-changeMoney

local iconStr=shangHangModel.getYuQuanIconStr(32)

local rank=shangHangModel:getMyRank()

self.content:setText(FMT.fmt("资产变化：{0}{1}",iconStr,mathHelper.formatNumber5(yesterdayMoney,2)))
self.content2:setText(mathHelper.formatNumber5(finMoney,2))
local yingli=mathHelper.floor(((finMoney/yesterdayMoney)-1)*10000)/100
if yingli>0 then
self.content3:setText(FMT.fmt("<color={1}>{0}%</color>",yingli,FONT_COLOR_VAL[FONT_COLOR.eRedColor]))
elseif yingli==0 then
self.content3:setText(yingli)
else
self.content3:setText(FMT.fmt("<color={1}>{0}%</color>",yingli,FONT_COLOR_VAL[FONT_COLOR.eGreenColor]))
end

self.up:setActive(yingli>0)
self.down:setActive(yingli<0)

self.up2:setActive(yingli>0)
self.down2:setActive(yingli<0)

if not shangHangController:send_248_99()then
self:refreshRank()
end

local limit=cfg.money_rewards_limit[1]

local propData={itemsComponentHelper.getCommonFillData({itemid=daily_reward_conf[4],itemcount=0},{showname=false,itemcount=mathHelper.formatNumber5(lingyu>limit and limit or lingyu,2)})}
local propDataCnt=#propData
self.ScrollView:freshGridsNum(propDataCnt,1,propDataCnt,false)
self.ScrollView:initPropData(propData)

if cfg.yongjinText then
for i,v in ipairs(cfg.yongjinText)do
if yingli>=v[1]and yingli<=v[2]then
self.desc:setText(v[3])
end
end
end
end


function UIGuPiaoYongJinWin:onHide()

end

function UIGuPiaoYongJinWin:refreshRank()
local rank=shangHangModel:getMyRank()
self.content4:setText(FMT.fmt("当前排名：{0}",rank==0 and'未上榜'or FMT.fmt("{0}",rank)))
end





function UIGuPiaoYongJinWin:onCloseBtn()
self:closeSelf()
end



function UIGuPiaoYongJinWin:onGetRewardBtn()
local lingyu=shangHangModel:getActorMoneyToday()
if lingyu>0 then
socketManager:send_248_97(0)
self:closeSelf()
end
end

