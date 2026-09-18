







def_class("tipsChildGuBaoMetrialDesc",UICloneObject)





tipsChildGuBaoMetrialDesc.abName="ui/windows/tips/child/tipschildgubaometrialdesc.ab"

tipsChildGuBaoMetrialDesc.assetName="tipsChildGuBaoMetrialDesc"


function tipsChildGuBaoMetrialDesc:bindComponents()

self.desc=UIText.get(self,0)
self.collectObjet=UIObject.get(self,1)
self.collectProgress=UIProgress.get(self,2)

end


function tipsChildGuBaoMetrialDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.collectObjet);self.collectObjet=nil;
_UIObject_release(self.collectProgress);self.collectProgress=nil;
end







function tipsChildGuBaoMetrialDesc:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoMetrialDesc:__delete()
self:unbindComponents()
end


function tipsChildGuBaoMetrialDesc:onHide()

end

function tipsChildGuBaoMetrialDesc:onShow(args)
local data=args.argtable
local childType=args.childType
local itemid=data.itemid
local gbid=gubaoLookup:good2GuBao(itemid)
local attach=data.attach
local formType=data.formType

local itemcfg=itemsConfig.getConfig(itemid)

local desc_str=itemcfg.desc
desc_str=desc_str..'\n'

local pieceItem=gubaoLookup:gubao2GoodPiece(gbid)
local pieceNum=bagModel.getItemCountById(pieceItem)
local isActive=formType~=TIPS_FORM_TYPE.eLink and gubaoModel:checkActive(gbid)
local glid=liandonModel:CheckGB_Guanlian(gbid)
local glactiveflag=false
if glid and not isActive then
isActive=formType~=TIPS_FORM_TYPE.eLink and gubaoModel:checkActive(glid)
glactiveflag=gubaoModel:checkActive(glid)
end

local isPiece=pieceItem==itemid
if isActive then

local star_str='当前星级：{0}星'
if not glactiveflag then
desc_str=desc_str..FMT.fmt(star_str,gubaoModel:getStar(gbid))
else
desc_str=desc_str..FMT.fmt(star_str,gubaoModel:getStar(glid))
end
desc_str=desc_str..'\n'

local piece_str='碎片数量：{0}'
desc_str=desc_str..FMT.fmt(piece_str,pieceNum)
end

local need
if not isActive then
if isPiece then
need=cfgHelper.get3(cfg_gubaoconfig_get,gbid,'active',itemid)
local gbname=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'name')
desc_str=desc_str..FMT.fmt('集齐{0}个碎片可以激活{1}',need,gbname)
else
desc_str=desc_str..'未激活'

desc_str=desc_str..'\n'

local piece_str='碎片数量：{0}'
desc_str=desc_str..FMT.fmt(piece_str,pieceNum)
end
end
self.desc:setText(desc_str)

local showProgress=formType~=TIPS_FORM_TYPE.eLink and not isActive and isPiece
self.collectObjet:setActive(showProgress)
if showProgress then
local cur=pieceNum
if cur>need then
cur=need
end
local str=FMT.fmt('{0}/{1}',pieceNum,need)
self.collectProgress:setProgressValue(cur,need)
self.collectProgress:setChildProgressText(str)
end
end

