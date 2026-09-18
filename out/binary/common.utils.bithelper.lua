
bitHelper={}

local _luaHelper=CS.LuaHelper


function bitHelper.check_pos(val,pos)
return bit.band(1,bit.rshift(val,pos))==1
end


function bitHelper.get(val,pos)
return bit.band(1,bit.rshift(val,pos))
end


function bitHelper.set_1(val,pos)
return bit.bor(val,bit.lshift(1,pos))
end


function bitHelper.set_0(val,pos)
return bit.band(val,bit.bnot(bit.lshift(1,pos)))
end


function bitHelper.byte_to_sbyte(val)
return _luaHelper.ByteToSbyte(val)
end


function bitHelper.ushort_to_short(val)
return _luaHelper.UShortToShort(val)
end


function bitHelper.uint_to_int(val)
return _luaHelper.UIntToInt(val)
end