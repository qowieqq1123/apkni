







def_class("UIAquariumLingYunWin",UIWindowBase)









function UIAquariumLingYunWin:bindComponents()

self.scrollView=UIObject.get(self,0)
self.lingyun=UIText.get(self,1)
self.helpBtn=UIButton.get(self,2)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIAquariumLingYunWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.lingyun);self.lingyun=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
end



















function UIAquariumLingYunWin:onLoaded(...)
self:bindComponents()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIAquariumLingYunWin:__delete()
self:unbindComponents()

UIAquariumControl:recordLingYunFlagData()
UIManager:callWindowFunc('UIAquariumWin','setYLReddot')
end




function UIAquariumLingYunWin:onShow(argtable,afterOnloaded)
local lingyun=UIAquariumControl:countTotalLingyun()

local cfgs=cfg_yuelongchiprogressconfig()
local len=#cfgs
local passCount=0
local checkData=UIAquariumControl:getLingYunFlagData()
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local lastCfg=cfgs[i-1]
local cfg=cfgs[i]
local nextCfg=cfgs[i+1]
local checkLast=lastCfg~=nil
local checkNext=nextCfg~=nil
local pass=lingyun>=cfg.lingyun
passCount=passCount+(pass and 1 or 0)
item:SetChildActive(0,pass)
item:SetChildActive(3,pass)
item:SetChildText(1,cfg.lingyun)
local yt,val=next(cfg.show_percent)
local tname=UIAquariumControl:getYuTypeName(yt)
item:SetChildText(2,FMT.fmt('<color=#6833c0>{0}</color> 图鉴属性提升{1}%',tname,val))
local isEnd=i==len
item:SetChildActive(4,not isEnd)
item:SetChildActive(5,isEnd)
item:SetChildActive(8,pass and not checkData[i])
local jd=0
if pass then
if checkNext then
local hf=(nextCfg.lingyun-cfg.lingyun)/2
local dv=lingyun-cfg.lingyun
jd=math.min(1,(dv/hf)*0.5+0.5)
else
jd=1
end
else
if checkLast then
local hf=(cfg.lingyun-lastCfg.lingyun)/2
local dv=lingyun-lastCfg.lingyun-hf
if isEnd then
jd=math.min(1,dv/hf)
else
jd=math.min(0.5,(dv/hf)*0.5)
end
else
jd=math.min(0.5,(lingyun/cfg.lingyun)*0.5)
end
end
jd=math.max(0,jd)
local fid=isEnd and 7 or 6
item:SetChildIconFillAmount(fid,jd)
end
self.scrollView:setChildScrollViewSelectItem(passCount,false,false,true)


self.lingyun:setText(lingyun)
end


function UIAquariumLingYunWin:onHide()

end




function UIAquariumLingYunWin:onHelpBtn()
UIAquariumControl:showRuleTips()
end

function UIAquariumLingYunWin:onCloseClick()
self:closeSelf()
end