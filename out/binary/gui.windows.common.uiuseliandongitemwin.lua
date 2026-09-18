







def_class("UIUseLianDongItemWin",UIWindowBase)









function UIUseLianDongItemWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.descTxt=UIText.get(self,1)
self.goodsPanel=UIObject.get(self,2)
self.okButton=UIButton.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIUseLianDongItemWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.goodsPanel);self.goodsPanel=nil;
_UIObject_release(self.okButton);self.okButton=nil;
end


















local _this=nil

function UIUseLianDongItemWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIUseLianDongItemWin:__delete()
self:unbindComponents()
_this=nil
end




function UIUseLianDongItemWin:onShow(argtable,afterOnloaded)


local list=argtable[1]

local desc_str=""
if argtable[2]then
if argtable[2]==1 then

local itemlist=list[1]
local itemcfg=itemsConfig.getConfig(itemlist[1])

local funcparam=itemcfg.funcparam
local discipleid=funcparam and funcparam.discipleid or nil
if discipleid then
local isShuWuDZ=UIDiscipleModel:isShuWuDisciple(discipleid)
if isShuWuDZ then
local glid=liandonModel:CheckDiZi_Guanlian(discipleid)
local diziname=cfgHelper.get2(cfg_discipleconfig_get,discipleid,'name')
if glid then

local gldiziname=cfgHelper.get2(cfg_discipleconfig_get,glid,'name')
local desc=cfgHelper.getlang('use_guanlianShuWu_item_tips1')
desc_str=string.format(desc,diziname,gldiziname)
else
local desc=cfgHelper.getlang('use_guanlianShuWu_item_tips2')
desc_str=string.format(desc,diziname)
end
end
end
elseif argtable[2]==4 then

local itemlist=list[1]
local xbid=itemlist.xbId
if xbid then
local xbname=cfgHelper.get2(cfg_xianbaoconfig_get,xbid,'name')
local glid=liandonModel:CheckXB_Guanlian(xbid)

if glid then
local glname=cfgHelper.get2(cfg_xianbaoconfig_get,glid,'name')
local desc=cfgHelper.getlang('use_guanlianXB_item_tips1')
desc_str=string.format(desc,xbname,glname)
else
local desc=cfgHelper.getlang('use_guanlianXB_item_tips2')
desc_str=string.format(desc,xbname)
end
end
end
end
self.descTxt:setText(desc_str)
local c=#list
self.goodsPanel:setChildLayoutGroupCreateItems(c)
local grids=self.goodsPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local d=list[i]
local itemid=d[1]
local itemnum=d[2]
local itemcount,showCountBG

itemcount=tostring(itemnum)
showCountBG=true

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(itemid,nil,nil,nil,d)
end)


local itemid2=d[3]
local itemnum2=d[4]
local itemcount2,showCountBG2

itemcount2=tostring(itemnum2)
showCountBG2=true
local conf={itemid=itemid2,itemcount=itemcount2,showCountBG=showCountBG2,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(1,prop)
item:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
_this:onClickItem(itemid2,nil,nil,nil)
end)

end
end

function UIUseLianDongItemWin:onClickItem(itemId,index,guid,attach,data)
if data and data.xbId then
tipsManager.showTipsXB({attach={xbItemId=itemId},formType=TIPS_FORM_TYPE.eXianBaoBag,tipsType=TIPS_TYPE.eCommonXianBao,itemid=data.xbId,bg=false,funType=TIPS_FUNC_TYPE.eXianBao,})
else
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

end


function UIUseLianDongItemWin:onHide()

end





function UIUseLianDongItemWin:onCloseBtn()
self:closeSelf()
end



function UIUseLianDongItemWin:onOkButton()
self:closeSelf()
end

