







function xianmengdigongModel:get_mapOffsetY_none()
return self.mapOffsetY_none
end

function xianmengdigongModel:initMapData_none()
local mapID=0
self.data_none={}
self.data_none.mapID=mapID
local mapcfg=self.mapConfigs[mapID]
self.data_none.mapcfg=mapcfg

local half_r=math.floor(mapcfg.roomRow/2)
local half_c=math.floor(mapcfg.roomCol/2)
local roomWidth=mapcfg.roomWidth
local roomHeight=mapcfg.roomHeight
local mapSkinCfg=xianmengdigongModel:get_mapSkinCfg(mapcfg.mapSkinID)
local lerpH=(mapSkinCfg.topHeight+mapSkinCfg.mapTopSide)-(mapSkinCfg.bottomHeight+mapSkinCfg.mapBottomSide)
if lerpH~=0 then
self.mapOffsetY_none=-lerpH/2
else
self.mapOffsetY_none=0
end


self.data_none.enterID=xianmengdigongModel:getID(mapcfg.enter[1],mapcfg.enter[2])
local e_pos={mapcfg.enter[1],mapcfg.enter[2]}
self.data_none.enterPos=e_pos
self.data_none.enterLocalPos={e_pos[1]*roomWidth,e_pos[2]*roomHeight}

local mapGridLookup={}
for c=-half_c,half_c do
for r=half_r,-half_r,-1 do
local id=xianmengdigongModel:getID(c,r)
mapGridLookup[id]=true
end
end

local mapZSGridLookup={}
if mapcfg.zs and#mapcfg.zs>0 then
for i,v in ipairs(mapcfg.zs)do
local x=v[1]
local y=v[2]
local id=xianmengdigongModel:getID(x,y)
if mapGridLookup[id]then
local g={id=id,x=x,y=y,width=roomWidth,height=roomHeight,posx=x*roomWidth,posy=y*roomHeight+self.mapOffsetY_none}
xianmengdigongModel:initGrid_none(g,v)
mapZSGridLookup[id]=g
end
end
end
self.data_none.mapZSGridLookup=mapZSGridLookup
end

function xianmengdigongModel:getmapcfg_none()
return self.data_none.mapcfg
end


function xianmengdigongModel:getTargetRoomPos_none()
local data_none=self.data_none
if data_none then
return data_none.enterPos,data_none.enterLocalPos
end
return nil,nil
end

function xianmengdigongModel:initGrid_none(g,cfg)

if cfg[3]>1 and cfg[3]~=6 then
g.skinID=cfg[3]
else
g.skinID=0
end

g.zs={cfg[4],cfg[5],cfg[6],cfg[7]}


end

function xianmengdigongModel:getmapGridListSort_none(pos)
local list={}
local data_none=self.data_none
if data_none then
if data_none.mapZSGridLookup then
pos=pos or data_none.enterPos
for id_,g in pairs(data_none.mapZSGridLookup)do
g.disAnySort=mathHelper.distance2(pos[1],pos[2],g.x,g.y)
table.insert(list,g)
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.disAnySort<b.disAnySort
end)
end
return list
end