




mathHelper={}

_MATH_SQRT=math.sqrt
_MATH_POW=math.pow
_MATH_FLOOR=math.floor
local _lowInt32=CS.LuaHelper.LowInt32
local _highInt32=CS.LuaHelper.HighInt32
local _lowInt16=CS.LuaHelper.Low16
local _highInt16=CS.LuaHelper.High16
local _toInt64String=CS.LuaHelper.ToInt64String







function mathHelper.getBitValue(value,bIdx)
return bit.band(1,bit.rshift(value,bIdx))==1
end


function mathHelper.setbit(x,y)
return bit.bor(x,bit.lshift(1,y))
end


function mathHelper.clrbit(x,y)
return bit.band(x,bit.bnot(bit.lshift(1,y)))
end


function mathHelper.cntbit(value,bBegin,bNum)
local cnt=0
local bEnd=bBegin+bNum-1
for i=bBegin,bEnd do
if mathHelper.getBitValue(value,i)then
cnt=cnt+1
end
end
return cnt
end

function mathHelper.lShiftNum(value,cNum)
local num=cNum or 31
for i=0,num do
if mathHelper.getBitValue(value,i)then
return i
end
end
end




function mathHelper.decimal(decimal,num)
if type(decimal)~='number'then
return decimal
end

num=num or 2
num=math.floor(num)
if num<0 then
num=0
end
local ndecimal=10^(num)
local nextdecimal=10^(num+1)
local nTemp=math.floor(decimal*ndecimal)
local retNum=nTemp/ndecimal
local f=1/nextdecimal*5
local leftf=decimal-retNum
if leftf>=f then
return retNum+1/ndecimal
end
return retNum
end

function mathHelper.floor(val)
return math.floor(val+0.000001)
end






function mathHelper.formatNumber(num,toInt)
if pfwindowslController:checkAmericanNumberSystem()then
if toInt==nil then toInt=false end
local thousand=1000
local million=1000000
local billion=1000000000

if num<10*thousand then
return tostring(num)

elseif num>=10*thousand and num<million then
return math.floor(num/thousand)..'K'

elseif num>=million and num<thousand*million then
if toInt==true then
return string.format('%dTr',math.floor(num/million))
end
return string.format('%0.2fTr',math.floor(num/(million/100))/100)

elseif num>=thousand*million then
if toInt==true then
return string.format('%dTý',math.floor(num/billion))
end
return string.format('%0.2fTý',math.floor(num/(billion/100))/100)
end
else
if toInt==nil then toInt=false end
local wan=10000
local yi=100000000

if num<10*wan then
return tostring(num)

elseif num>=10*wan and num<yi then
return math.floor(num/wan)..'万'

elseif num>=yi and num<wan*yi then
if toInt==true then
return string.format('%d亿',math.floor(num/yi))
end
return string.format('%0.2f亿',math.floor(num/(yi/100))/100)
elseif num>=wan*yi then
if toInt==true then
return string.format('%d万亿',math.floor(num/wan/yi))
end
return string.format('%0.2f万亿',math.floor(num/yi/100)/100)
end
end
end

function mathHelper.formatNumber2(num)
if pfwindowslController:checkAmericanNumberSystem()then
if num>=10000 and num<1000000 then
local ret=math.floor(num/10)/100
return string.format('%sK',ret)
elseif num>=1000000 and num<1000000000 then
local ret=math.floor(num/10000)/100
return string.format('%sTr',ret)
elseif num>=1000000000 then
local ret=math.floor(num/10000000)/100
return string.format('%sTý',ret)
end
return tostring(num)
else
if num>=10000 and num<100000000 then


local ret=math.floor(num/100)/100
return string.format('%s万',ret)
elseif num>=100000000 then


local ret=math.floor(num/1000000)/100
return string.format('%s亿',ret)
end
return num
end
end


function mathHelper.formatBIGNumbereEx(n)
if pfwindowslController:checkAmericanNumberSystem()then
local ret=tostring(n)
if n>=1000 then
local n0=math.floor(n/1000)
ret=string.format('%dK',n0)
end
if n>=1000000 then
local n0=math.floor(n/1000000)
ret=string.format('%dTr',n0)
end
if n>=1000000000 then
local n0=math.floor(n/1000000000)
ret=string.format('%dTý',n0)
end
return ret
else
local ret=tostring(n)
if n>=10000 then
local n0=math.floor(n/10000)
ret=string.format('%d万',n0)
end
if n>=100000000 then
local n0=math.floor(n/100000000)
ret=string.format('%d亿',n0)
end
return ret
end
end


function mathHelper.formatNumber3(num,toInt)
if pfwindowslController:checkAmericanNumberSystem()then
if toInt==nil then toInt=false end
local thousand=1000
local million=1000000
local billion=1000000000

if num<100*thousand then
return tostring(num)

elseif num>=100*thousand and num<million then
return math.floor(num/thousand)..'K'

elseif num>=million and num<thousand*million then
if toInt==true then
return string.format('%dTr',math.floor(num/million))
end
return string.format('%0.2fTr',math.floor(num/(million/100))/100)

elseif num>=thousand*million then
if toInt==true then
return string.format('%dTý',math.floor(num/billion))
end
return string.format('%0.2fTý',math.floor(num/(billion/100))/100)
end
else
if toInt==nil then toInt=false end
local wan=10000
local yi=100000000

if num<100*wan then
return tostring(num)

elseif num>=100*wan and num<yi then
return math.floor(num/wan)..'万'

elseif num>=yi and num<wan*yi then
if toInt==true then
return string.format('%d亿',math.floor(num/yi))
end
return string.format('%0.2f亿',math.floor(num/(yi/100))/100)
elseif num>=wan*yi then
if toInt==true then
return string.format('%d万亿',math.floor(num/wan/yi))
end
return string.format('%0.2f万亿',math.floor(num/yi/100)/100)
end
end
end



function mathHelper.formatNumber4(num,keepDecimalNum)
if pfwindowslController:checkAmericanNumberSystem()then
local temp=math.pow(10,keepDecimalNum or 0)
if num>=1000 and num<1000000 then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/1000)
ret=tmpNum/temp
else
ret=math.floor(num/1000)
end
return string.format('%sK',ret)
elseif num>=1000000 and num<1000000000 then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/1000000)
ret=tmpNum/temp
else
ret=math.floor(num/1000000)
end
return string.format('%sTr',ret)
elseif num>=1000000000 then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/1000000000)
ret=tmpNum/temp
else
ret=math.floor(num/1000000000)
end
return string.format('%sTý',ret)
end
return num
else
local temp=math.pow(10,keepDecimalNum or 0)
if num>=10000 and num<100000000 then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/10000)
ret=tmpNum/temp
else
ret=math.floor(num/10000)
end
return string.format('%s万',ret)
elseif num>=100000000 then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/100000000)
ret=tmpNum/temp
else
ret=math.floor(num/100000000)
end
return string.format('%s亿',ret)
end
return num
end
end



function mathHelper.formatNumberCeil4(num,keepDecimalNum)
if pfwindowslController:checkAmericanNumberSystem()then
local temp=math.pow(10,keepDecimalNum or 0)
if num>=1000 and num<1000000 then
local ret
if keepDecimalNum then
local tmpNum=math.ceil(num*temp/1000)
ret=tmpNum/temp
else
ret=math.ceil(num/1000)
end
return string.format('%sK',ret)
elseif num>=1000000 and num<1000000000 then
local ret
if keepDecimalNum then
local tmpNum=math.ceil(num*temp/1000000)
ret=tmpNum/temp
else
ret=math.ceil(num/1000000)
end
return string.format('%sTr',ret)
elseif num>=1000000000 then
local ret
if keepDecimalNum then
local tmpNum=math.ceil(num*temp/1000000000)
ret=tmpNum/temp
else
ret=math.ceil(num/1000000000)
end
return string.format('%sTý',ret)
end
return num
else
local temp=math.pow(10,keepDecimalNum or 0)
if num>=10000 and num<100000000 then
local ret
if keepDecimalNum then
local tmpNum=math.ceil(num*temp/10000)
ret=tmpNum/temp
else
ret=math.ceil(num/10000)
end
return string.format('%s万',ret)
elseif num>=100000000 then
local ret
if keepDecimalNum then
local tmpNum=math.ceil(num*temp/100000000)
ret=tmpNum/temp
else
ret=math.ceil(num/100000000)
end
return string.format('%s亿',ret)
end
return num
end
end


function mathHelper.formatNumber5(num,keepDecimalNum)
if pfwindowslController:checkAmericanNumberSystem()then
local temp=math.pow(10,keepDecimalNum or 0)
local thousand=1000
local million=1000000
local billion=1000000000
if num<100*thousand then
return tostring(num)
elseif num>=100*thousand and num<million then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/thousand)
ret=tmpNum/temp
else
ret=math.floor(num/thousand)
end
return string.format('%sK',ret)
elseif num>=million and num<billion then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/million)
ret=tmpNum/temp
else
ret=math.floor(num/million)
end
return string.format('%sTr',ret)
elseif num>=billion then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/billion)
ret=tmpNum/temp
else
ret=math.floor(num/billion)
end
return string.format('%sTý',ret)
end
else
local temp=math.pow(10,keepDecimalNum)
local wan=10000
local yi=100000000
if num<100*wan then
return tostring(num)
elseif num>=100*wan and num<yi then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/wan)
ret=tmpNum/temp
else
ret=math.floor(num/wan)
end
return string.format('%s万',ret)
elseif num>=yi then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/yi)
ret=tmpNum/temp
else
ret=math.floor(num/yi)
end
return string.format('%s亿',ret)
end
end
end

function mathHelper.formatNumber6(num,toInt)
if pfwindowslController:checkAmericanNumberSystem()then
local million=1000000
local billion=1000000000
if num>=billion then
if toInt==true then
return string.format('%dTý',math.floor(num/billion))
end
return string.format('%0.2fTý',math.floor(num/(billion/100))/100)
elseif num>=million then
if toInt==true then
return string.format('%dTr',math.floor(num/million))
end
return string.format('%0.2fTr',math.floor(num/(million/100))/100)
else
return tostring(num)
end
else
local yi=100000000
if num>=yi then
if toInt==true then
return string.format('%d亿',math.floor(num/yi))
end
return string.format('%0.2f亿',math.floor(num/(yi/100))/100)
else
return tostring(num)
end
end
end




function mathHelper.formatNumber7(num,keepWanDecimalNum,keepYiDecimalNum)
if pfwindowslController:checkAmericanNumberSystem()then

local thousand=1000
local million=1000000
local billion=1000000000
local keepKDecimalNum=0
local keepTrDecimalNum=0
local keepTyDecimalNum=0
if keepWanDecimalNum then
keepKDecimalNum=keepWanDecimalNum-1
keepTrDecimalNum=keepWanDecimalNum+2
end
if keepYiDecimalNum then
keepTyDecimalNum=keepYiDecimalNum+1
end
if num>=thousand and num<million then
local temp=math.pow(10,keepKDecimalNum or 0)
local ret
if keepKDecimalNum then
local tmpNum=math.floor(num*temp/thousand)
ret=tmpNum/temp
else
ret=math.floor(num/thousand)
end
return string.format('%sK',ret)
elseif num>=million and num<billion then
local temp=math.pow(10,keepTrDecimalNum or 0)
local ret
if keepTrDecimalNum then
local tmpNum=math.floor(num*temp/million)
ret=tmpNum/temp
else
ret=math.floor(num/million)
end
return string.format('%sTr',ret)
elseif num>=billion then
local temp=math.pow(10,keepTyDecimalNum or 0)
local ret
if keepTyDecimalNum then
local tmpNum=math.floor(num*temp/billion)
ret=tmpNum/temp
else
ret=math.floor(num/billion)
end
return string.format('%sTý',ret)
end
return num
else
if num>=10000 and num<100000000 then
local temp=math.pow(10,keepWanDecimalNum or 0)
local ret
if keepWanDecimalNum then
local tmpNum=math.floor(num*temp/10000)
ret=tmpNum/temp
else
ret=math.floor(num/10000)
end
return string.format('%s万',ret)
elseif num>=100000000 then
local temp=math.pow(10,keepYiDecimalNum or 0)
local ret
if keepYiDecimalNum then
local tmpNum=math.floor(num*temp/100000000)
ret=tmpNum/temp
else
ret=math.floor(num/100000000)
end
return string.format('%s亿',ret)
end
return num
end
end




function mathHelper.formatNumber8(num,keepWanDecimalNum,keepYiDecimalNum)
if pfwindowslController:checkAmericanNumberSystem()then

local million=1000000
local billion=1000000000
local keepKDecimalNum=0
local keepTrDecimalNum=0
local keepTyDecimalNum=0
if keepWanDecimalNum then
keepKDecimalNum=keepWanDecimalNum-1
keepTrDecimalNum=keepWanDecimalNum+2
end
if keepYiDecimalNum then
keepTyDecimalNum=keepYiDecimalNum+1
end
if num>=10*million and num<billion then
local temp=math.pow(10,keepTrDecimalNum or 0)
local ret
if keepTrDecimalNum then
local tmpNum=math.floor(num*temp/million)
ret=tmpNum/temp
else
ret=math.floor(num/million)
end
return string.format('%sTr',ret)
elseif num>=billion then
local temp=math.pow(10,keepTyDecimalNum or 0)
local ret
if keepTyDecimalNum then
local tmpNum=math.floor(num*temp/billion)
ret=tmpNum/temp
else
ret=math.floor(num/billion)
end
return string.format('%sTý',ret)
end
return num
else
if num>=10000000 and num<100000000 then
local temp=math.pow(10,keepWanDecimalNum or 0)
local ret
if keepWanDecimalNum then
local tmpNum=math.floor(num*temp/10000000)
ret=tmpNum/temp
else
ret=math.floor(num/10000000)
end
return string.format('%s千万',ret)
elseif num>=100000000 then
local temp=math.pow(10,keepYiDecimalNum or 0)
local ret
if keepYiDecimalNum then
local tmpNum=math.floor(num*temp/100000000)
ret=tmpNum/temp
else
ret=math.floor(num/100000000)
end
return string.format('%s亿',ret)
end
return num
end
end



function mathHelper.formatNumber9(num,keepDecimalNum)
if pfwindowslController:checkAmericanNumberSystem()then
local temp=math.pow(10,keepDecimalNum or 0)

local thousand=1000
local million=1000000
local billion=1000000000

if num>=100*thousand and num<million then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/thousand)
ret=tmpNum/temp
else
ret=math.floor(num/thousand)
end
return string.format('%sK',ret)

elseif num>=million and num<billion then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/million)
ret=tmpNum/temp
else
ret=math.floor(num/million)
end
return string.format('%sTr',ret)

elseif num>=billion then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/billion)
ret=tmpNum/temp
else
ret=math.floor(num/billion)
end
return string.format('%sTý',ret)
end
return num
else
local temp=math.pow(10,keepDecimalNum or 0)
if num>=100000 and num<100000000 then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/10000)
ret=tmpNum/temp
else
ret=math.floor(num/10000)
end
return string.format('%s万',ret)
elseif num>=100000000 then
local ret
if keepDecimalNum then
local tmpNum=math.floor(num*temp/100000000)
ret=tmpNum/temp
else
ret=math.floor(num/100000000)
end
return string.format('%s亿',ret)
end
return num
end
end


function mathHelper.formatNumber10(num)
if pfwindowslController:checkAmericanNumberSystem()then
if num<1000 then
return num
end
local ret=math.floor(num/1000)
return string.format('%sK',ret)
else
if num<10000 then
return num
end
local ret=math.floor(num/10000)
return string.format('%s万',ret)
end
end




function mathHelper.convertBitToArray(value,count)
local array={}
for i=1,count do
table.insert(array,mathHelper.getBitValue(value,i-1))
end
return array
end


function mathHelper.convertArrayToBit(array,count)
local value=0
for i=1,count do
if array[i]then
value=mathHelper.setbit(value,i-1)
end
end
return value
end


function mathHelper.convertVectorToArray(vector)
if vector.w then
return{vector.x,vector.y,vector.z,vector.w}
elseif vector.z then
return{vector.x,vector.y,vector.z}
elseif vector.y then
return{vector.x,vector.y}
end
end


function mathHelper.convertArrayToVector(array)
local count=#array
if count==4 then
return Vector4.New(array[1],array[2],array[3],array[4])
elseif count==3 then
return Vector3.New(array[1],array[2],array[3])
elseif count==2 then
return Vector2.New(array[1],array[2])
end
end





function mathHelper.convertDecimalTo35System(num,minPosCount,turnStr)
local turnStr=turnStr or"123456789ABCDEFGHIJKLMNPQRSTUVWXYZ"
local turnStrList=string.toTable(turnStr)
turnStrList[0]='0'
local radix=35
local numStrList={}
while num>0 do
local posNum=num%radix
local numStr=turnStrList[posNum]
table.insert(numStrList,1,numStr)
num=math.floor(num/radix)
end

if minPosCount then
local posCount=#numStrList
if posCount<minPosCount then
local needRepairCount=minPosCount-posCount
for i=1,needRepairCount do
table.insert(numStrList,1,"0")
end
end
end

local finalNumStr=table.concat(numStrList)
return finalNumStr
end




function mathHelper.convert35SystemToDecimal(str,turnStr)
local turnStr=turnStr or"123456789ABCDEFGHIJKLMNPQRSTUVWXYZ"
local turnStrList=string.toTable(turnStr)
local turnNumList={}
for i,v in ipairs(turnStrList)do
turnNumList[v]=i
end
turnNumList['0']=0
turnNumList['O']=0
local radix=35

local decimalNum=0
local lowerStr=string.upper(str)
local originalNumStrList=string.toTable(lowerStr)
local count=#originalNumStrList
for i=count,1,-1 do
local numStr=originalNumStrList[i]
local tmpNum=turnNumList[numStr]
local numRank=count-i
decimalNum=decimalNum+tmpNum*(radix^numRank)
end
return decimalNum
end



function mathHelper.numberToChinese(szNum,isCapital)
szNum=math.floor(szNum)
local szChMoney=""
local iLen=0
local iNum=0
local iAddZero=0
local hzUnit={"","十","百","千","万","十","百","千","亿","十","百","千","万","十","百","千"}
local hzUnit_capital={"","拾","佰","仟","万","拾","佰","仟","亿","拾","佰","仟","万","拾","佰","仟"}
local hzNum={"零","一","二","三","四","五","六","七","八","九"}
local hzNum_capital={"零","壹","贰","叄","肆","伍","陆","柒","捌","玖"}
local useHzUnit=not isCapital and hzUnit or hzUnit_capital
local useHzNum=not isCapital and hzNum or hzNum_capital
if nil==tonumber(szNum)then
return tostring(szNum)
end
iLen=string.len(szNum)
if iLen>10 or iLen==0 or tonumber(szNum)<0 then
return tostring(szNum)
end
for i=1,iLen do
iNum=string.sub(szNum,i,i)
if iNum==0 and i~=iLen then
iAddZero=iAddZero+1
else
if iAddZero>0 then
szChMoney=szChMoney..useHzNum[1]
end
szChMoney=szChMoney..useHzNum[iNum+1]
iAddZero=0
end
if(iAddZero<4)and(0==(iLen-i)%4 or 0~=tonumber(iNum))then
szChMoney=szChMoney..useHzUnit[iLen-i+1]
end
end
local function removeZero(num)

num=tostring(num)
local szLen=string.len(num)
local zero_num=0
for i=szLen,1,-3 do
szNum=string.sub(num,i-2,i)
if szNum==useHzNum[1]then
zero_num=zero_num+1
else
break
end
end
num=string.sub(num,1,szLen-zero_num*3)
szNum=string.sub(num,1,6)

if szNum==useHzNum[2]..useHzUnit[2]then
num=string.sub(num,4,string.len(num))
end
return num
end
return removeZero(szChMoney)
end

function mathHelper.numberToPlusNumberStr(num)
local str=num>=0 and"+{0}"or"{0}"
return FMT.fmt(str,num)
end






function mathHelper.isInRadius(x1,y1,x2,y2,radius)
local dy=y2-y1
local dx=x2-x1
return(dx*dx+dy*dy)<(radius*radius)
end


function mathHelper.distance(x1,y1,x2,y2)
return _MATH_SQRT(_MATH_POW((y2-y1),2)+_MATH_POW((x2-x1),2))
end

function mathHelper.distanceEx(x1,y1,x2,y2)
local dx=x2-x1
local dy=y2-y1
return _MATH_SQRT(dx*dx+dy*dy),dx,dy
end

function mathHelper.distance2(x1,y1,x2,y2)
return math.abs(y2-y1)+math.abs(x2-x1)
end





function mathHelper.getPoint_OnBezierCurvePoint(points,t)
local point=nil
local nt=1-t
local pointCnt=#points
for i=1,pointCnt do
local temp=points[i]*math.pow(nt,pointCnt-i)*math.pow(t,i-1)*mathHelper.combinationNumber(pointCnt-1,i-1)
point=point~=nil and point+temp or temp
end
return point
end





function mathHelper.getPoint_OnBezierParam(points,t)
local ps=points[1]
local pst=points[2]
local pe=points[3]
local pet=points[4]
local u=1-t;
local uu=u*u;
local uuu=uu*u;
local tt=t*t;
local ttt=tt*t;
return ps*uuu+pst*3*uu*t+pet*3*u*tt+pe*ttt;
end






function mathHelper.getPointTangent_OnBezierParam(points,t)
local ps=points[1]
local pst=points[2]
local pe=points[3]
local pet=points[4]
local u=1-t;
local uu=u*u;
local tu=t*u;
local tt=t*t;
local p=ps*-1*uu+pst*(uu-2*tu)+pet*(2*tu-tt)+pe*tt;
return p
end

function mathHelper.lineCrashRect(x1,y1,x2,y2,bottomLeftX,bottomLeftY,topRightX,topRightY)


if mathHelper.posInRect(x1,y1,bottomLeftX,bottomLeftY,topRightX,topRightY)then
return true
elseif mathHelper.posInRect(x2,y2,bottomLeftX,bottomLeftY,topRightX,topRightY)then
return true
else
local dx=x2-x1
local dy=y2-y1
if dx==0 and dy==0 then return false end
if dx==0 then


if x2>=bottomLeftX and x2<=topRightX then
if mathHelper.numInRange(bottomLeftY,y1,y2)or mathHelper.numInRange(topRightY,y1,y2)then
return true
end
end
elseif dy==0 then


if y2>=bottomLeftY and y2<=topRightY then
if mathHelper.numInRange(bottomLeftX,x1,x2)or mathHelper.numInRange(topRightX,x1,x2)then
return true
end
end
else

local k=dy/dx
local b=y2-k*x2

local ax=(bottomLeftY-b)/k
local ay=bottomLeftY
if mathHelper.posInRect(ax,ay,bottomLeftX,bottomLeftY,topRightX,topRightY)
and mathHelper.numInRange(ax,x1,x2)and mathHelper.numInRange(ay,y1,y2)then
return true
end
local bx=(topRightY-b)/k
local by=topRightY
if mathHelper.posInRect(bx,by,bottomLeftX,bottomLeftY,topRightX,topRightY)
and mathHelper.numInRange(bx,x1,x2)and mathHelper.numInRange(by,y1,y2)then
return true
end

local cx=bottomLeftX
local cy=k*bottomLeftX+b
if mathHelper.posInRect(cx,cy,bottomLeftX,bottomLeftY,topRightX,topRightY)
and mathHelper.numInRange(cx,x1,x2)and mathHelper.numInRange(cy,y1,y2)then
return true
end
local ex=topRightX
local ey=k*topRightX+b
if mathHelper.posInRect(ex,ey,bottomLeftX,bottomLeftY,topRightX,topRightY)
and mathHelper.numInRange(ex,x1,x2)and mathHelper.numInRange(ey,y1,y2)then
return true
end
end
end
return false
end

function mathHelper.lineCrashRect2(x1,y1,x2,y2,x,y,w,h)
local hw=w/2
local hh=h/2
return mathHelper.rectCrashRect(x1,y1,x2,y2,x-hw,y-hh,x+hw,y+hh)
end



function mathHelper.posInLine(x,y,x1,y1,x2,y2,errVal)
if mathHelper.numInRange(x,x1,x2)and mathHelper.numInRange(y,y1,y2)then
local dx=x2-x1
local dy=y2-y1
if dx==0 or dy==0 then
return true,x,y
else

local k=dy/dx
local b=y2-k*x2
local y_=k*x+b
errVal=errVal or 0
local l=math.abs(y-y_)
if l<=errVal then
return true,x,y_
end
end
end
return false,nil,nil
end

function mathHelper.numInRange(a,b,c)
if b<=c then
return a>=b and a<=c
else
return a>=c and a<=b
end
end


function mathHelper.posInRect(x,y,bx,by,tx,ty)
if x>=bx and x<=tx and y>=by and y<=ty then
return true
end
return false
end


function mathHelper.circleCrashRect(rx,ry,r,x1,y1,x2,y2)

if mathHelper.posInRect(rx,ry,x1,y1,x2,y2)then
return true
end

if mathHelper.numInRange(rx,x1,x2)then

local tx=rx
local max=math.max(y1,y2)
local ty=ry>max and max or math.min(y1,y2)
if mathHelper.isInRadius(rx,ry,tx,ty,r)then
return true
end
end

if mathHelper.numInRange(ry,y1,y2)then

local max=math.max(x1,x2)
local tx=rx>max and max or math.min(x1,x2)
local ty=ry
if mathHelper.isInRadius(rx,ry,tx,ty,r)then
return true
end
end


local x3=x1
local y3=y2
local x4=x2
local y4=y1
if mathHelper.isInRadius(rx,ry,x1,y1,r)then
return true
elseif mathHelper.isInRadius(rx,ry,x2,y2,r)then
return true
elseif mathHelper.isInRadius(rx,ry,x3,y3,r)then
return true
elseif mathHelper.isInRadius(rx,ry,x4,y4,r)then
return true
end
return false
end


function mathHelper.rectCrashRect(x1,y1,x2,y2,x1_,y1_,x2_,y2_)

return mathHelper.twoLineIntersect2(x1,x2,x1_,x2_)and mathHelper.twoLineIntersect2(y1,y2,y1_,y2_)
end

function mathHelper.rectCrashRect2(x,y,w,h,x2,y2,w2,h2)
local hw=w/2
local hh=h/2
local hw2=w2/2
local hh2=h2/2
return mathHelper.rectCrashRect(x-hw,y-hh,x+hw,y+hh,x2-hw2,y2-hh2,x2+hw2,y2+hh2)
end


function mathHelper.rectInRect(x1,y1,x2,y2,x1_,y1_,x2_,y2_)

return mathHelper.posInRect(x1_,y1_,x1,y1,x2,y2)and
mathHelper.posInRect(x2_,y2_,x1,y1,x2,y2)
end




function mathHelper.factorial(number)
local temp=1
for i=1,number do
temp=temp*i
end
return temp
end


function mathHelper.combinationNumber(n,m)
return mathHelper.permutationsNumber(n,m)/mathHelper.factorial(m)
end


function mathHelper.permutationsNumber(n,m)
return mathHelper.factorial(n)/mathHelper.factorial(n-m)
end





function mathHelper.compareInt64(v1,v2)
return tostring(v1)==tostring(v2)
end

function mathHelper.validInt64(v)
return v~=nil and v~=int64.zero
end


function mathHelper.splitToInt16(num32)
return _highInt16(num32),_lowInt16(num32)
end


function mathHelper.splitToInt32(num64)
return _highInt32(num64),_lowInt32(num64)
end


function mathHelper.concatToInt64(hightInt32,lowInt32)
local str=_toInt64String(hightInt32,lowInt32)
return int64.new(str)
end


function mathHelper.concatToInt32(hightInt16,lowInt16)
return bit.lshift(hightInt16,16)+lowInt16
end

function mathHelper.equals(val1,val2)
if val1==nil and val2~=nil then return false end
if val2==nil and val1~=nil then return false end
local type1=type(val1)
local type2=type(val2)
if type1~=type2 then return false end
if type1=='table'then
return table.equals(val1,val2)
else
return val1==val2
end
end


function mathHelper.randomSeed()
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))
end

function mathHelper.weightRandom(weights,seed)
local sum=0
for i=1,#weights do
sum=sum+weights[i]
end
if seed then
mathHelper.randomSeed()
end
local compare=math.random(1,sum)
local index=1
while sum>0 do
sum=sum-weights[index]
if sum<compare then
return index
end
index=index+1
end
end









function mathHelper.sortWeightList(t,listkey,beginIndex,iscopy,sortOrderIdx,sortOrder,allsortOrder)
if t==nil or#t<=0 then return end
local v1=t[1]
listkey=listkey or'sorts'
local weights=v1[listkey]
if weights==nil then



return
end
local len=#weights
beginIndex=beginIndex or 1
if beginIndex>len then return end
sortOrder=sortOrder or eSortOrder.eDown
local func=function(a,b)
local va=a[listkey]
local vb=b[listkey]
for i=beginIndex,len do
local sortOrder_
if sortOrderIdx~=nil and i==sortOrderIdx then
sortOrder_=sortOrder
else
sortOrder_=allsortOrder or eSortOrder.eDown
end
if sortOrder_==eSortOrder.eDown then
if va[i]~=vb[i]then
return va[i]>vb[i]
end
else
if va[i]~=vb[i]then
return va[i]<vb[i]
end
end
end
return false
end
if iscopy==true then
local copy_t={}
for i,v in ipairs(t)do
copy_t[i]=v
end
table.sort(copy_t,func)
return copy_t
else
table.sort(t,func)
end
end






function mathHelper.sortWeightListEx(slist,list_key,sort_index,sortOrder)
sortOrder=sortOrder or eSortOrder.eDown
table.sort(slist,function(a,b)
local sortsA=a[list_key]
local sortsB=b[list_key]
for i,v in ipairs(sort_index)do
local c1=sortsA[v]
local c2=sortsB[v]
if sortOrder then
if c1<c2 then
return true
elseif c1>c2 then
return false
end
else
if c1>c2 then
return true
elseif c1<c2 then
return false
end
end

end
return false
end)
end






function mathHelper.twoLineIntersect(line1_a,line1_b,line2_a,line2_b)
local max_a=math.max(line1_a,line2_a)
local min_b=math.min(line1_b,line2_b)
local lerp=min_b-max_a
if lerp>0 then
return lerp,max_a,min_b
end
return nil,nil,nil
end
function mathHelper.twoLineIntersect2(line1_a,line1_b,line2_a,line2_b)
local max_a=math.max(line1_a,line2_a)
local min_b=math.min(line1_b,line2_b)
return min_b-max_a>0
end


function mathHelper.getAngleByPos(x1,y1,x2,y2)

return math.deg(math.atan2(y2-y1,x2-x1))
end


function mathHelper.getLeftHandleAngle(sx,sy,ex,ey)
return math.deg(math.atan2(sy-ey,ex-sx))
end


function mathHelper.getAngleByPos2(v,x1,y1,x2,y2)































return math.deg(math.atan2(y2-y1,x2-x1)-math.atan2(v[2],v[1]))
end

function mathHelper.int64_to_number(val_64)
local temp1=_lowInt32(val_64)
local temp2=_highInt32(val_64)
local str=_toInt64String(temp2,temp1)
return tonumber(str)
end

function mathHelper.int64_to_string(val_64)
local temp1=_lowInt32(val_64)
local temp2=_highInt32(val_64)
local str=_toInt64String(temp2,temp1)
return str
end

function mathHelper.number_to_int64(num)
local str=string.format('%.0f',num)
return int64.new(str)
end



function mathHelper.normalDistribution(rate,weight)
local rate_2_angle=180*rate
local n=math.sin(math.rad(rate_2_angle))
return n*weight
end

function mathHelper.getRandomNum_precent(num,pre,nx)
local p=-pre+(nx+pre)*math.random()
return math.floor(num*(1+p))
end

function mathHelper.getRandomNum_precent2(num,pre,nx)
local p=pre+(nx-pre)*math.random()
return math.floor(num*(1+p))
end

function mathHelper.clamp(val,min,max)
if val<min then
val=min
elseif val>max then
val=max
end
return val
end

function mathHelper.calculateMovePos(x1,y1,x2,y2,bTime,cTime,wayT)

local dis,dx,dy=mathHelper.distanceEx(x1,y1,x2,y2)
if dis==0 then
return x2,y2,dis,0,0
end

local ux=dx/dis
local uy=dy/dis

local arriveTime=bTime+wayT
local costT
if cTime>=arriveTime then
costT=wayT
else
if cTime>=bTime then
costT=cTime-bTime
else
costT=0
end
end
local rate=costT/wayT
local lerp_time=wayT-costT
local move=dis*rate

local m_x=x1+move*ux
local m_y=y1+move*uy
return m_x,m_y,lerp_time
end

function mathHelper.calculateMovePos2(x1,y1,x2,y2,dis,move)

if dis==nil then
dis=mathHelper.distance(x1,y1,x2,y2)
end

if move==0 then
return x1,y1
elseif move>=dis then
return x2,y2
end

local dx=x2-x1
local dy=y2-y1

local ux=dx/dis
local uy=dy/dis

local m_x=x1+move*ux
local m_y=y1+move*uy
return m_x,m_y
end

function mathHelper.calculateMovePos3(x1,y1,x2,y2,dis,rate)

if rate==0 then
return x1,y1
elseif rate>=1 then
return x2,y2
end

if dis==nil then
dis=mathHelper.distance(x1,y1,x2,y2)
end
local move=dis*rate

local dx=x2-x1
local dy=y2-y1

local ux=dx/dis
local uy=dy/dis

local m_x=x1+move*ux
local m_y=y1+move*uy
return m_x,m_y
end


function mathHelper.randomList(list)
local n=#list
for i=n,2,-1 do
local j=math.random(i)
list[i],list[j]=list[j],list[i]
end
end

function mathHelper.randomNumArray(startidx,endIdx)
local list=table.toTable(startidx,endIdx)
mathHelper.randomList(list)
return list
end

function mathHelper.randomLimit(min,max,limit)
local value=math.random(min,max)
return value<=limit
end

local _epsilon=1e-10

function mathHelper.safe_ceil(x)
local floor_x=math.floor(x)
if math.abs(x-floor_x)<_epsilon then
return floor_x
else
return math.ceil(x)
end
end

function mathHelper.safe_floor(x)
local ceil_x=math.ceil(x)
if math.abs(x-ceil_x)<_epsilon then
return ceil_x
else
return math.floor(x)
end
end
