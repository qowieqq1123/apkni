







def_class("UIDaoBingCollectWin",UIWindowBase)









function UIDaoBingCollectWin:bindComponents()

self.root=UIObject.get(self,0)
self.creater=UIObject.get(self,1)



end


function UIDaoBingCollectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.creater);self.creater=nil;
end


















function UIDaoBingCollectWin:onLoaded(...)
self:bindComponents()
end

function UIDaoBingCollectWin:__delete()
self:unbindComponents()
end

function UIDaoBingCollectWin:onShow(argtable,afterOnloaded)
self:freshInfo()
end

function UIDaoBingCollectWin:onHide()

end



function UIDaoBingCollectWin:freshInfo()
self:initCfg()
self:initListPanel()
end

function UIDaoBingCollectWin:initCfg()
local lookCfgs=table.deepCopy(cfg_lookupdaobingconfig())

local temp={}
local sortTag={}
local isLianDon
for color,itemids in pairs(lookCfgs)do
for i,itemid in ipairs(itemids)do
isLianDon=liandonModel:getIsLianDonItem(itemid)
if pfwindowslController:checkIsGameVersion_oumei()and isLianDon then

else
local has=daobingModel:hasDaoBingRecord(itemid)
local hideflag=itemsConfig.getConfig(itemid).hideflag
if has or(not has and hideflag~=true)then
if temp[color]==nil then temp[color]={}end
local tempids=temp[color]
tempids[#tempids+1]=itemid
sortTag[itemid]=(not has and 1000 or 0)+i
end
end
end
end


local colorCfgs={}
for color,_ in pairs(temp)do
colorCfgs[#colorCfgs+1]=color
end
table.sort(colorCfgs,function(a,b)
return a>b
end)
for _,itemids in pairs(temp)do
table.sort(itemids,function(a,b)
return sortTag[a]<sortTag[b]
end)
end
self.colorCfgs=colorCfgs
self.lookCfgs=temp

end


function UIDaoBingCollectWin:initListPanel()
local len=#self.colorCfgs
local func=function(idx)
local item=self.creater:getChildLayoutGroupGridItem(idx-1)
self:freshPageItem(item,idx)
end
self.creater:setChildLayoutGroupCreateItems(len,func)
end

function UIDaoBingCollectWin:freshPageItem(item,pageidx)
local color=self.colorCfgs[pageidx]
local itemids=self.lookCfgs[color]
local colorName=daobingConfig.getCommonConfig().colorfilter[color]
item:SetChildText(0,colorName)

local len=#itemids
local func=function(idx)
local childItem=item:GetChildLayoutGroupGridItem(1,idx-1)
childItem:SetChildButtonClick(3,function()
self:onChildItemClick(pageidx,idx)
end)
self:freshChildItem(childItem,pageidx,idx)
end
item:SetChildLayoutGroupCreateItems(1,len,func)
end

function UIDaoBingCollectWin:freshChildItem(item,pageidx,childidx)
local color=self.colorCfgs[pageidx]
local itemids=self.lookCfgs[color]
local itemid=itemids[childidx]
local itemCfg=itemsConfig.getConfig(itemid)
local has=daobingModel:hasDaoBingRecord(itemid)

item:SetChildIcon(1,iconHelper.getDaobingBigBgIcon(itemCfg.icon),true)

item:SetChildCSImageSprite(0,globalABLookup.daobingBagSprite,daobingConfig.getColorBg(itemCfg.color))

item:SetChildText(2,itemCfg.name)

item:SetChildImageExGray(0,not has)
item:SetChildImageExGray(1,not has)
item:SetChildImageExGray(4,not has)
item:SetChildImageExGray(5,not has)

local isLD=liandonModel:getIsLianDonItem(itemid)
item:SetChildActive(5,isLD)
end

function UIDaoBingCollectWin:onChildItemClick(pageidx,childidx)
local color=self.colorCfgs[pageidx]
local itemids=self.lookCfgs[color]
local itemid=itemids[childidx]
local maxjllv=daobingConfig.getJinglianMaxLv(itemid)
local maxstarlv=daobingConfig.getStarMaxLv(itemid)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eDaoBingCollect,
itemid=itemid})
end